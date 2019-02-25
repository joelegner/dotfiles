(function () {

  var sdk;
  var WL = window.WL;
  var storage = chrome.storage.sync;
  var WB = wunderbits.core;
  var WBDeferred = WB.WBDeferred;
  var when = WB.lib.when;

  var $addPage, $loadingPage, $loginPage;
  var addPageView, loadingPageView, loginPageView;

  var tokenDeferred = new WBDeferred();
  storage.get('token', function (data) {

    WL.token = data.token;
    tokenDeferred.resolve(WL.token);
  });

  function scrape () {

    chrome.tabs.query({
      'active': true,
      'currentWindow': true
    }, function (tabs){

      var tab = tabs[0];
      var port = PortWrapper(chrome.tabs.connect(tab.id), {
        'name': 'wunderlist'
      });
      port.emit('wunderlist_scrape', {
        'tab': tab
      });
      port.on('wunderlist_scraped_data', function (scrapeData) {

        console.debug('popup.js', scrapeData);
        addPageView.updateInputs(scrapeData);
      });
    });
  }

  function initializeSDK () {

    sdk = new wunderlist.sdk({
      'clientID': WL.clientID,
      'accessToken': WL.token,
      'product': 'add to wunderlist chrome'
    });

    sdk.initialized.done(function () {

      addPageView.onSDKInitialized(sdk);
    });

    sdk.on('unauthorized', function () {

      storage.clear(function () {

        var err = chrome.runtime.lastError;
        err && console.error(err);
        showLogin();
      });
    });
  }

  function showAdd (token) {

    token && (WL.token = token);

    $addPage.classList.remove('hidden');
    $loadingPage.classList.add('hidden');
    $loginPage.classList.add('hidden');
    initializeSDK();
  }

  function showLogin () {

    $addPage.classList.add('hidden');
    $loadingPage.classList.add('hidden');
    $loginPage.classList.remove('hidden');
  }

  function cacheElements () {

    $addPage = document.querySelector('.add-page');
    $loadingPage = document.querySelector('.loading-page');
    $loginPage = document.querySelector('.login-page');
  }

  function attachViews () {

    var views = WL.views;
    var WLView = WL.views.WLView;

    // expose addPageView ...
    WL.addPageView = addPageView = new views.AddView({
      'el': $addPage
    });

    loadingPageView = new WLView({
      'el': $loadingPage
    });

    loginPageView = new views.LoginView({
      'el': $loginPage,
      'showAdd': showAdd,
      'showLogin': showLogin
    });
  }

  function start () {

    cacheElements();
    attachViews();
    scrape();

    tokenDeferred.done(function (token) {

      if (token) {
        showAdd();
      }
      else {
        showLogin();
      }
    });
  }

  document.addEventListener('DOMContentLoaded', start, false);

  chrome.runtime.onMessage.addListener(function (message, sender, callback) {

    console.debug(message);

    if (message.event === 'wunderlist_scraped_data') {
      addPageView.updateInputs(message.data);
    }
  });
})();