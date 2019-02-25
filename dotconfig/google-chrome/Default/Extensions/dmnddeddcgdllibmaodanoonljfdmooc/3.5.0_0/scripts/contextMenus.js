(function () {

  var WL = window.WL;
  var storage = chrome.storage.sync;
  var apiActions = WL.apiActions;
  var inboxTitle = WL.localization.getString('smart_list_inbox');
  var _inboxID;

  storage.get(null, function (data) {

    console.debug(data);
    var token = data.token;
    if (token !== undefined) {
      intializeSDK(token).done(renderExtraMenus);
    }
  });

  chrome.storage.onChanged.addListener(function (changes, namespace) {

    if ('token' in changes && namespace === 'sync') {
      var token = changes['token'].newValue;
      if (token) {
        intializeSDK(token).done(renderExtraMenus);
      }
      else {
        removeExtraMenus();
      }
    }
  });

  function intializeSDK (token) {

    var sdk = new wunderlist.sdk({
      'clientID': WL.clientID,
      'accessToken': token,
      'product': 'add to wunderlist chrome'
    });

    apiActions.init(sdk);
    bindToRealtime(sdk);

    return sdk.initialized;
  }

  function destroySDK () {

    apiActions.destroySDK();
  }

  function bindToRealtime (sdk) {

    var handler = _.debounce(function () {

      sdk.initialized.done(function () {

        removeExtraMenus();
        renderExtraMenus();
      });
    }, 1000);

    sdk.on('event', function (data) {

      if (data.operation === 'touch') {
        handler();
      }
    });
  }

  var scrapeTab = function (data, callback) {

    console.debug('background scrape request');

    var tab = data.tab;
    var port = PortWrapper(chrome.tabs.connect(tab.id), {name: 'wunderlist'});

    port.emit('wunderlist_scrape', data);
    port.on('wunderlist_scraped_data', function (scrapeData) {

      console.debug('background recieved', scrapeData);
      callback(scrapeData);
    });
  };

  // FLOATING POPOVER
  function openFloatingPopover (currentPageTab) {

    chrome.windows.get(currentPageTab.windowId, function (currentTabWindow) {

      chrome.tabs.create({
        'url': chrome.extension.getURL('html/popup.html'),
        'active': false
      }, function (tab) {

        chrome.windows.create({
          'tabId': tab.id,
          'type': 'popup',
          'focused': true,
          'width': 300,
          'height': 417,
          'left': Math.round(currentTabWindow.left + (currentTabWindow.width/2) - 130),
          'top': Math.round(currentTabWindow.top + (currentTabWindow.height/2) - 180)
        }, function (popup) {

            scrapeTab({'tab': currentPageTab}, function (scrapeData) {

              var message = {
                'event': 'wunderlist_scraped_data',
                'data': scrapeData
              };

              chrome.tabs.sendMessage(tab.id, message);
            });
        });
      });
    });
  }

  // CONTEXT MENUS

  // MAIN MENU ITEM (always present)
  chrome.contextMenus.create({

    'id': 'A2WL',
    'title': WL.localization.getString('label_add_to_wunderlist'),
    'contexts': ['page', 'selection', 'audio', 'image', 'video', 'link'],
    'onclick': function (info, currentPageTab) {

      _gaq.push(['_trackEvent', 'ContextMenus', 'Clicked', 'A2WL']);
      openFloatingPopover(currentPageTab);
    }
  });

  function renderExtraMenus () {

    apiActions.fetchListsAndFoldersTree().done(function (listsAndFolders) {

      var inbox = _.findWhere(listsAndFolders, {'list_type': 'inbox'});
      _inboxID = inbox.id;

      createSeparator('instant-separator', ['page', 'selection', 'audio', 'image', 'video', 'link']);
      renderInstantMenu(listsAndFolders);
      createSeparator('link-separator', ['link', 'audio', 'image', 'video']);
      renderLinkMenu(listsAndFolders);
      renderMediaLinkMenuItems(listsAndFolders);
    });
  }

  function createSeparator (id, contexts) {

    chrome.contextMenus.create({
      'id': id,
      'contexts': contexts,
      'type': 'separator'
    });
  }

  // ADD INSTANTLY
  function renderInstantMenu (listsAndFolders) {

    var contexts = ['page', 'selection', 'audio', 'image', 'video', 'link'];

    // straight to inbox menu item
    chrome.contextMenus.create({

      'id': 'instant-inbox',
      'title': WL.localization.getString('label_add_instantly_to_inbox'),
      'contexts': contexts,
      'onclick': function (info, currentPageTab) {

        _gaq.push(['_trackEvent', 'ContextMenus', 'Clicked', 'instant-inbox']);

        scrapeTab({'tab': currentPageTab}, function (scrapeData) {

          var taskTitle = scrapeData.title || currentPageTab.url;
          var taskNote = scrapeData.note;
          apiActions.createTask(_inboxID, taskTitle, taskNote);
        });
      }
    });

    // add to ... menu item
    chrome.contextMenus.create({
      'id': 'instant',
      'title': WL.localization.getString('label_add_instantly_to'),
      'contexts': contexts
    });

    function onClickCallback (ionfo, currentPageTab) {

      _gaq.push(['_trackEvent', 'ContextMenus', 'Clicked', 'instant']);

      scrapeTab({'tab': currentPageTab}, function (scrapeData) {

        var taskTitle = scrapeData.title || currentPageTab.url;
        var taskNote = scrapeData.note;
        apiActions.createTask(item.id, taskTitle, taskNote);
      });
    }

    listsAndFolders.forEach(function (item) {

      if (item.type === 'list') {
        var listTitle = item.list_type === 'inbox' ? inboxTitle : item.title;
        chrome.contextMenus.create({
          'title': listTitle,
          'parentId': 'instant',
          'contexts': contexts,
          'onclick': onClickCallback
        });
      }
      else if (item.type === 'folder') {
        chrome.contextMenus.create({
          'type': 'separator',
          'parentId': 'instant',
          'contexts': contexts
        });

        chrome.contextMenus.create({
          'title': item.title,
          'enabled': false,
          'parentId': 'instant',
          'contexts': contexts
        });

        item.lists.forEach(function (list) {

          var listTitle = list.list_type === 'inbox' ? inboxTitle : list.title;
          chrome.contextMenus.create({
            'title': listTitle,
            'parentId': 'instant',
            'contexts': contexts,
            'onclick': onClickCallback
          });
        });

        chrome.contextMenus.create({
          'type': 'separator',
          'parentId': 'instant',
          'contexts': contexts
        });
      }
    });
  }

  function renderLinkMenu (listsAndFolders) {

    var contexts = ['link'];

    // to inbox
    chrome.contextMenus.create({

      'id': 'link-inbox',
      'title': WL.localization.getString('label_add_link_url_to_inbox'),
      'contexts': contexts,
      'onclick': function (info, currentPageTab) {

        _gaq.push(['_trackEvent', 'ContextMenus', 'Clicked', 'link-inbox']);

        scrapeTab({'tab': currentPageTab}, function (scrapeData) {

          var taskTitle = info.linkUrl;
          apiActions.createTask(_inboxID, taskTitle);
        });
      }
    });

    // add to ...
    chrome.contextMenus.create({

      'id': 'link',
      'title': WL.localization.getString('label_add_link_url_to'),
      'contexts': contexts
    });

    function onClickCallback (info, currentPageTab) {

      _gaq.push(['_trackEvent', 'ContextMenus', 'Clicked', 'link']);

      var taskTitle = info.linkUrl;
      apiActions.createTask(list.id, taskTitle);
    }

    listsAndFolders.forEach(function (item) {

      if (item.type === 'list') {
        var listTitle = item.list_type === 'inbox' ? inboxTitle : item.title;
        chrome.contextMenus.create({
          'title': listTitle,
          'parentId': 'link',
          'contexts': contexts,
          'onclick': onClickCallback
        });
      }
      else if (item.type === 'folder') {
        chrome.contextMenus.create({
          'type': 'separator',
          'parentId': 'link',
          'contexts': contexts
        });

        chrome.contextMenus.create({
          'title': item.title,
          'parentId': 'link',
          'contexts': contexts,
          'enabled': false
        });

        item.lists.forEach(function (list) {

          var listTitle = list.list_type === 'inbox' ? inboxTitle : list.title;
          chrome.contextMenus.create({
            'title': listTitle,
            'parentId': 'link',
            'contexts': contexts,
            'onclick': onClickCallback
          });
        });

        chrome.contextMenus.create({
          'type': 'separator',
          'parentId': 'link',
          'contexts': contexts
        });
      }
    });
  }

  function renderMediaLinkMenuItems (listsAndFolders) {

    var media = ['audio', 'image', 'video'];

    var titles = {
      'audio': WL.localization.getString('label_add_audio_url_to'),
      'image': WL.localization.getString('label_add_image_url_to'),
      'video': WL.localization.getString('label_add_video_url_to'),
      'audio-inbox': WL.localization.getString('label_add_audio_url_to_inbox'),
      'image-inbox': WL.localization.getString('label_add_image_url_to_inbox'),
      'video-inbox': WL.localization.getString('label_add_video_url_to_inbox')
    };

    media.forEach(function (type) {

      // to inbox
      chrome.contextMenus.create({

        'id': type + '-link-inbox',
        'title': titles[type + '-inbox'],
        'contexts': [type],
        'onclick': function (info, currentPageTab) {

          _gaq.push(['_trackEvent', 'ContextMenus', 'Clicked', type + '-link-inbox']);

          scrapeTab({'tab': currentPageTab}, function (scrapeData) {

            var taskTitle = info.srcUrl;
            apiActions.createTask(_inboxID, taskTitle);
          });
        }
      });

      var options = {
        'id': type + '-link',
        'contexts': [type],
        'title': titles[type]
      };

      renderMediaLinkMenuItem(options, listsAndFolders);
    });
  }

  function renderMediaLinkMenuItem (options, listsAndFolders) {

    chrome.contextMenus.create({

      'id': options.id,
      'title': options.title,
      'contexts': options.contexts
    });

    function onClickCallback (info, currentPageTab) {

      _gaq.push(['_trackEvent', 'ContextMenus', 'Clicked', options.id]);

      var taskTitle = info.srcUrl;
      apiActions.createTask(list.id, taskTitle);
    }

    listsAndFolders.forEach(function (item) {

      if (item.type === 'list') {
        var listTitle = item.list_type === 'inbox' ? inboxTitle : item.title;
        chrome.contextMenus.create({
          'title': listTitle,
          'parentId': options.id,
          'contexts': options.contexts,
          'onclick': onClickCallback
        });
      }
      else if (item.type === 'folder') {
        chrome.contextMenus.create({
          'type': 'separator',
          'parentId': options.id,
          'contexts': options.contexts
        });

        chrome.contextMenus.create({
          'type': 'separator',
          'title': item.title,
          'parentId': options.id,
          'contexts': options.contexts
        });

        item.lists.forEach(function (list) {

          var listTitle = list.list_type === 'inbox' ? inboxTitle : list.title;
          chrome.contextMenus.create({
            'title': listTitle,
            'parentId': options.id,
            'contexts': options.contexts,
            'onclick': onClickCallback
          });
        });

        chrome.contextMenus.create({
          'type': 'separator',
          'parentId': options.id,
          'contexts': options.contexts
        });
      }
    });
  }

  function removeExtraMenus () {

    var extraMenuIDs = [
      'audio-link',
      'audio-link-inbox',
      'image-link',
      'image-link-inbox',
      'instant',
      'instant-inbox',
      'instant-separator',
      'link',
      'link-inbox',
      'link-separator',
      'video-link',
      'video-link-inbox'
    ];

    extraMenuIDs.forEach(function (id) {

      chrome.contextMenus.remove(id);
    });
  }
})();