(function () {

  var WL = window.WL;
  var langData = WL.langData;
  WL.localization = {

    'getString': function (key) {

      var code = navigator.language;
      var shortCode = _.first(code.split('-'));
      var data = langData[code] || langData[shortCode] || langData['en'];

      return data[key] || 'NOT LOCALIZED';
    }
  };
})();