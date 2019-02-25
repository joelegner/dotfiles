(function () {

  var WL = window.WL;
  var storage = chrome.storage.sync;
  var reloadFiles = chrome.app.getDetails().content_scripts[0].js;

  // track daily usage, if the app is still running track a daily page view
  setInterval(function () {

    _gaq.push(['_trackPageview']);
    console.log("It's a new day!");
  }, 1000 * 60 * 60 * 24);

  function onTokenSet (token) {

    console.debug('token set to', token);
  }

  function onLoginFailed (err) {

    console.error('login failed:', err && err.message, err);
  }

  var authBaseUrl = WL.authBaseDomain + '/oauth/authorize';

  function authParams (state) {

    return {
      'client_id': WL.clientID,
      'response_type' : 'token',
      'redirect_uri': 'https://' + chrome.app.getDetails().id + '.chromiumapp.org/provider_cb'
    };
  }

  function getAuthUrl (state) {

    var url = authBaseUrl;
    var params = authParams(state);

    Object.keys(params).forEach(function (key, index) {

      url += (index === 0 ? '?' : '&') + key + '=' + params[key];
    });

    return url;
  }

  function login (success, failure) {

    chrome.identity.launchWebAuthFlow({
      'url': getAuthUrl(),
      'interactive': true
    }, function (resp) {

      var err = chrome.runtime.lastError;

      var respParts = resp && resp.split(/\#access_token\=/);
      var token = respParts && respParts[1];
      token = token && token.replace(/\?.+/, '');

      if (token) {
        console.debug('token');
        storage.set({
          'token': token
        }, function () {

          success && success(token);
          onTokenSet(token);
        });
      }
      else {
        failure && failure(err);
        onLoginFailed(err);
      }
    });
  }

  window.login = login;

  // RE-INJECT CONTENT SCRIPTS ON UPGRADE/INSTALL
  chrome.runtime.onInstalled.addListener(function () {

    console.debug('A2WL installed or upgraded ...');

    chrome.windows.getAll({'populate': true}, function (windows){

      windows.forEach(function (win) {

        win.tabs.forEach(function (tab) {

          console.debug('Reloading contenct scripts for', tab.url);

          reloadFiles.forEach(function (file) {

            chrome.tabs.executeScript(tab.id, {
              'file': file
            }, function (result) {

              var err = chrome.runtime.lastError;
              err && console.error(err);
            });
          });
        });
      });
    });
  });

  console.debug('Add to Wunderlist running');
})();