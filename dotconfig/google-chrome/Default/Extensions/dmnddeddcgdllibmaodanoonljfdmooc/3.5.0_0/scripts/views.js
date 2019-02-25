(function () {

  var WL = window.WL;
  var views = WL.views = {};
  var storage = chrome.storage.sync;
  var WB = wunderbits.core;
  var WBDeferred = WB.WBDeferred;
  var WBStateModel = WB.WBStateModel;
  var when = WB.lib.when;
  var apiActions = WL.apiActions;

  var _super = Backbone.View.prototype;
  var WLView = views.WLView = Backbone.View.extend({

    'initialize': function () {

      var self = this;
      _super.initialize.apply(self, arguments);

      // todo do any magic localization shabizzle
      self.localize();
    },

    'localize': function () {

      var self = this;
      requestAnimationFrame(function () {

        self.renderLabels();
        self.renderPlaceHolders();
        self.renderOptions();
        self.renderTitles();
      });
    },

    'renderLabels': function () {

      var self = this;

      var labels = self.$el && self.$el.find('localized[rel]');
      var label, key, value, data;

      if (labels.length) {
        for (var i = 0, len = labels.length; i < len; i++) {
          label = $(labels[i]);
          key = label.attr('rel');
          value = WL.localization.getString(key);

          if (!value) {
            continue;
          }

          // data = label.attr('data');
          // if (data && data.length) {
          //   // split by "snowman" unicode character
          //   data = data.split('\u2603');
          //   value = self.convertSymbols(value);
          //   data = WBLanguageManager.localizationception(data);
          //   value = self.replaceSymbols(value, data);
          // }

          label.html(value);
        }
      }
    },

    'renderAttributes': function (attributeName, selectorString, applyAsText) {

      var self = this;
      var elements = self.$el && self.$el.find(selectorString) || [];
      var element, key, extraData, args, value;

      // include self element!
      if (self.$el) {
        elements.push(self.$el);
      }

      if (elements.length) {
        for (var i = 0, len = elements.length; i < len; i++) {

          element = $(elements[i]);
          key = element.attr('data-key-' + attributeName);
          if (key) {
            args = [key];
            extraData = element.attr('data-' + attributeName);
            if (extraData) {
              extraData = extraData.split('\u2603');
              args.push(extraData);
            }

            value = WL.localization.getString(key);

            if (applyAsText) {
              element.text(value);
            }
            else {
              element.attr(attributeName, value);
            }
          }
        }
      }
    },

    'renderTitles': function () {

      var self = this;
      self.renderAttributes('title', '[data-key-title]');
    },

    'renderPlaceHolders': function () {

      var self = this;
      self.renderAttributes('placeholder', 'input[data-key-placeholder], textarea[data-key-placeholder], input[data-key-value]', false, true);
      self.renderAttributes('value',  'input[data-key-value], textarea[data-key-value]');
    },

    'renderOptions': function () {

      var self = this;
      var applyAsText = true;
      self.renderAttributes('text', 'option[data-key-text]', applyAsText);
    },

    'renderAriaAttributes': function () {

      var self = this;
      self.renderAttributes('aria-label', '[data-key-aria-label]');
    }
  });

  views.LoginView = WLView.extend({

    'events': {
      'click .login-button': 'onLogin'
    },

    'onLogin': function () {

      var self = this;

      var background = chrome.extension.getBackgroundPage();
      background.login();
    },

    'initialize': function (options) {

      var self = this;

      self.showAdd = options.showAdd;
      self.showLogin = options.showLogin;

      WLView.prototype.initialize.apply(self, arguments);
    }
  });

  views.AddView = WLView.extend({

    'listsReady': false,

    'events': {
      'click .add-button': 'onAdd',
      'click div.reminder': 'onAddReminder',
      'click .close-new-list': 'onCloseNewList',
      'click .rate-link': 'onRateLinkClicked',

      'keydown div.reminder': 'onReminderKeydown',

      'change .list-select': 'onListSelect',
      'change input[type=date]': 'onDateInputChange',
      'change input[type=time]': 'onDateInputChange',

      'click input[type=date], input[type=time]': function (e) {
        e.stopPropagation();
      }
    },

    'initialize': function () {

      var self = this;
      WLView.prototype.initialize.apply(self, arguments);

      self.state = new WBStateModel();
      self.listenTo(self.state, 'change:reminderTime change:reminderDate', self.onReminderChange);

      self.$editReminderDate = self.$('.edit-reminder .date-picker input');
      self.$editReminderTime = self.$('.edit-reminder .time-picker input');
    },

    'onReminderKeydown': function (e) {

      var self = this;
      if (e.which === 13) {
        self.onAddReminder();
      }
    },

    'onAddReminder': function () {

      var self = this;

      self.$('.add-reminder').addClass('hidden');
      self.$('.edit-reminder').removeClass('hidden');
      self.$editReminderDate.focus();
      self.setInitialReminder();
    },

    'setInitialReminder': function () {

      var self = this;

      if (!self.initialReminderSet) {
        var tomorrow = moment({'hour': 9}).add(1, 'day');
        var date = tomorrow.format('YYYY-MM-DD');
        var time = tomorrow.format('HH:mm');

        var today = moment().format('YYYY-MM-DD');
        var oneHundredYeards = moment().add(100, 'year').format('YYYY-MM-DD');

        self.$editReminderDate
          .attr('min', today)
          .attr('max', oneHundredYeards)
          .val(date).trigger('change');
        self.$editReminderTime.val(time).trigger('change');

        self.initialReminderSet = true;
      }
    },

    'onDateInputChange': function (e) {

      var self = this;

      var $dateInput = $(e.currentTarget);
      var value = $dateInput.val();
      value = value.length ? value : undefined;
      $dateInput.closest('div').toggleClass('valid', !!value);
      var key = $dateInput.data('key');

      self.state.set(key, value);
    },

    'onReminderChange': function () {

      var self = this;
      var attributes = self.state.attributes;
      var date = attributes.reminderDate;
      var time = attributes.reminderTime;
      var isValid = !!(date && time);
      var partiallyValid = !!(!isValid && (date || time));

      self.$('div.reminder')
        .toggleClass('valid', isValid)
        .toggleClass('partiallyValid', partiallyValid);
    },

    'onAdd': function () {

      var self = this;

      var list = self.$('.list-select option:selected')[0];

      var listID = list.value;
      var title = self.$('.title-input').val();
      var note = self.$('.note-input').val();

      title = title && $.trim(title);
      note = note && $.trim(note);

      if (!title || !self.listsReady) {
        return;
      }

      var attributes = self.state.attributes;

      var reminderDate;
      if (attributes.reminderDate && attributes.reminderTime) {
        var timeParts = attributes.reminderTime.split(':');
        var hours = parseInt(timeParts[0], 10);
        var minutes = parseInt(timeParts[1], 10);
        var date = moment(attributes.reminderDate);
        date.add(hours, 'hours').add(minutes, 'minutes');
        reminderDate = date.format();
      }

      function createTheTask (withListID) {

        self.updateLastUsedListID(withListID).done(function () {

          apiActions.createTask(withListID, title, note, attributes.dueDate, reminderDate)
            .done(window.close.bind(window))
            .fail(function () {

              console.error(arguments);
            });
        });
      }

      if (listID === 'new') {
        var listTitle = $.trim(self.$('.new-list-input').val());
        if (listTitle) {
          apiActions.createList(listTitle).done(function (listData) {

            createTheTask(listData.id);
          });
        }
      }
      else {
        createTheTask(listID);
      }

      self.$('.add-button .star').addClass('spinning');
    },

    'onListSelect': function (ev) {

      var self = this;
      var selected = self.$('.list-select option:selected')[0];
      var id = selected.value;

      var isNewList = id === 'new';
      self.$('.new-list-container').toggleClass('hidden', !isNewList);
      self.$('.list-select').toggleClass('hidden', isNewList);
      self.$('.list .wundercon.arrow').toggleClass('hidden', isNewList);

      isNewList && self.$('.new-list-input').focus();
    },

    'onCloseNewList': function (ev) {

      var self = this;
      var select = self.$('.list-select');
      self.$('.new-list-container').addClass('hidden');
      self.$('.new-list-input').val('');
      select.removeClass('hidden');
      select.find('[data-inbox=true]').attr('selected', 'selected');
      self.$('.list .wundercon.arrow').removeClass('hidden');
    },

    'onRateLinkClicked': function () {

      _gaq.push(['_trackEvent', 'UI', 'LinkClicked', 'rating']);
    },

    'updateLastUsedListID': function (listID) {

      var self = this;
      var deferred = new WBDeferred();

      storage.set({
        'lastUsedListID': parseInt(listID, 0)
      }, deferred.resolve.bind(deferred));

      return deferred.promise();
    },

    'getLastUsedListID': function () {

      var self = this;
      var deferred = new WBDeferred();

      storage.get('lastUsedListID', function (data) {

        deferred.resolve(data.lastUsedListID);
      });

      return deferred.promise();
    },

    'updateInputs': function (scrapedData) {

      var self = this;
      self.$('.title-input').val(scrapedData.title || '');
      self.$('.note-input').val(scrapedData.note || '');
    },

    'onSDKInitialized': function (sdk) {

      var self = this;
      apiActions.init(sdk);
      self.loadDropDown();
    },

    'loadDropDown': function () {

      var self = this;
      apiActions.fetchListsAndFoldersTree().done(function (lists) {

        self.getLastUsedListID().done(function (lastUsedListID) {

          self.renderDropDown(lists);
          self.selectListInDropDown(lastUsedListID);
          self.listsReady = true;
        });
      });
    },

    'selectListInDropDown': function(listId) {
      var self = this;
      var dropDown = self.el.querySelector('.list-select');
      var listOption = dropDown.querySelector('option[value="'+listId+'"]');

      if(listOption) {
        listOption.setAttribute('selected', 'selected');
      }
    },

    'mapListToOptionElement': function(list) {
      var opt = document.createElement('option');
      opt.textContent = list.title.substr(0, 30) + (list.title.length > 30 ? '...' : '');
      opt.value = list.id;

      var $opt = $(opt);
      if (list.list_type === 'inbox') {
        opt.textContent = WL.localization.getString('smart_list_inbox');
        $opt.attr('data-inbox', 'true');
      }

      return opt;
    },

    'renderListOrFolderInDropDown': function (frag, listOrFolder) {
      var self = this;
      var folder, list;
      var optgroupElement;
      var listOption;

      if(listOrFolder.type === 'folder') {

        folder = listOrFolder;
        optgroupElement = document.createElement('optgroup');
        optgroupElement.setAttribute('label', _.escape(folder.title));

        folder.lists.forEach(function(list) {
          var listInFolderOption = self.mapListToOptionElement(list);
          optgroupElement.appendChild(listInFolderOption);
        });

        frag.appendChild(optgroupElement);
      }
      else if(listOrFolder.type === 'list') {

        list = listOrFolder;
        listOption = self.mapListToOptionElement(list);
        frag.appendChild(listOption);
      }

      return frag;
    },

    'renderDropDown': function (listsAndFolders, lastUsedListID) {

      lastUsedListID = lastUsedListID || 'inbox';

      var self = this;
      var frag = document.createDocumentFragment();

      var newList = document.createElement('option');
      newList.textContent = WL.localization.getString('label_new_list');
      newList.value = 'new';
      frag.appendChild(newList);

      var separator = document.createElement('option');
      separator.textContent = '----';
      $(separator).attr('disabled', 'disabled');
      frag.appendChild(separator);

      frag = listsAndFolders.reduce(self.renderListOrFolderInDropDown.bind(self), frag);

      self.$('.list-select').append(frag);
    }
  });

  views.OptionsView = WLView.extend({

    'events': {
      'click .logout-button': 'onLogout',
      'click .login-button': 'onLogin'
    },

    'initialize': function (options) {

      var self = this;
      WLView.prototype.initialize.apply(self, arguments);

      self.token = options.token;
      self.renderVersion();
      self.renderAccountDetails();
      self.bindToStorage();
    },

    'bindToStorage': function () {

      var self = this;

      chrome.storage.onChanged.addListener(function (changes, namespace) {

        var storageChange, newValue;
        for (var key in changes) {
          storageChange = changes[key];
          newValue = storageChange.newValue;
          self.handleStorageChange(key, newValue);
        }
      });
    },

    'handleStorageChange': function (key, value) {

      var self = this;

      if (key === 'token') {
        self.token = WL.token = value;
        self.renderAccountDetails();
      }
    },

    'onLogout': function () {

      var self = this;

      self.renderLoading();

      chrome.identity.launchWebAuthFlow({
        'url': WL.authBaseDomain + '/logout',
        'interactive': false
      }, function (resp) {

        var err = chrome.runtime.lastError;
        err && console.error(err.message);

        storage.clear();
        self.renderLoggedOut();
      });
    },

    'onLogin': function () {

      var self = this;

      self.renderLoading();

      function done () {
        self.renderAccountDetails();
      }

      var background = chrome.extension.getBackgroundPage();
      background.login(done, done);
    },

    'renderAccountDetails': function () {

      var self = this;

      if (self.token) {
        var sdk = new wunderlist.sdk({
          'clientID': WL.clientID,
          'accessToken': WL.token
        });

        sdk.initialized.done(function () {

          sdk.getOutlet().user.all().done(function (userData) {

            self.$('.user-name').text(userData.name);
            self.$('.loading').addClass('hidden');
            self.$('.logged-out').addClass('hidden');
            self.$('.login-details .details').removeClass('hidden');
          });
        });
      }
      else {
        self.renderLoggedOut();
      }
    },

    'renderVersion': function () {

      var appDetails = chrome.app.getDetails();
      self.$('.version-number').text(appDetails.version);
    },

    'renderLoggedOut': function () {

      var self = this;
      self.$('.loading').addClass('hidden');
      self.$('.login-details .details').addClass('hidden');
      self.$('.logged-out').removeClass('hidden');
    },

    'renderLoading': function () {

      var self = this;
      self.$('.loading').removeClass('hidden');
      self.$('.logged-out').addClass('hidden');
      self.$('.login-details .details').addClass('hidden');
    }
  });
})();