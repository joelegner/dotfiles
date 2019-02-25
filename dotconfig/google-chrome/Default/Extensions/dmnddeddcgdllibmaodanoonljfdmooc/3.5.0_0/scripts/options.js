(function () {

  var WL = window.WL;
  var views = WL.views;
  var storage = chrome.storage.sync;

  function start () {

    storage.get('token', function (data) {

      var token = WL.token = data.token;
      var optionsView = new views.OptionsView({

        'el': document.querySelector('body'),
        'token': token
      });
    });
  }

  document.addEventListener('DOMContentLoaded', start, false);
})();