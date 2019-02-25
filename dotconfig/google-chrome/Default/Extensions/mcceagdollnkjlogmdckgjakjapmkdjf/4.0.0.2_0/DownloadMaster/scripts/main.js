// ################################################
// ###### FOR INTELLISENSE
// ######
/// <reference path="..\..\..\..\APIs\chrome_extensions.js" />
/// <reference path="..\..\..\..\APIs\webkit_console.js" />
/// <reference path="..\..\..\..\APIs\w3c_dom1.js" />
/// <reference path="..\..\..\..\APIs\w3c_dom2.js" />
/// <reference path="..\..\..\..\APIs\w3c_dom3.js" />
/// <reference path="..\..\..\..\APIs\w3c_xml.js" />
/// <reference path="externals/jquery-1.7.2.min.js" />
/// <reference path="globals.js" />
/// <reference path="utils.js" />
/// <reference path="links_storage.js" />
// ################################################


///////////////////////////////////////////////////////////
/// Execute the content script on extension window load
///////////////////////////////////////////////////////////
window.onload = function windowLoaded() {

    try {
     
        // Set extension page body size
        $(document.body).width(PAGE_DEFAULT_WIDTH);
        $(document.body).height(PAGE_DEFAULT_HEIGHT);
        $(document.body).css("overflow", PAGE_DEFAULT_SCROLL_STYLE);

        // Display pending message
        buildMessageDiv(PENDING_LOAD_MSG);

        // Action depends on the page URL     
        chrome.tabs.getSelected(null, function (tab) {
            if (tab.url.match("^ftp") == null && tab.url.match("^http") == null) {
                buildMessageDiv(NON_WEBSITE_PAGE);
                return;
            }

            if (tab.url.match("^https://chrome.google.com/webstore") != null) {
                buildMessageDiv(CHROME_WEBSTORE_SITE);
                return;
            }

            // Inject the scripts to hosting page
            chrome.tabs.executeScript(null, { file: "DownloadMaster/scripts/utils.js" });
            chrome.tabs.executeScript(null, { file: "DownloadMaster/scripts/externals/jquery-1.7.2.min.js" });
            chrome.tabs.executeScript(null, { file: "DownloadMaster/scripts/content.js" });
        });

    } catch (exc) { utils.alertExceptionDetails(exc); }
}

////////////////////////////////////////////////////////////////////
/// Assign listener for messages from content script
////////////////////////////////////////////////////////////////////
chrome.extension.onConnect.addListener(
    function (port) {
        
        // Listen to messages only on the right connection
        if (port.name == "content-extension") {
            gContentConnectionPort = port;
            port.onMessage.addListener(buildThePage);
        }
    });
