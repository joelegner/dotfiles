// ################################################################################################
// ####### This script runs in the context of the active page.
// ####### It sends back to the extension a list of all links present in the hosting DOM.
// ####### It receives from the extension a list of links to download
// ################################################################################################

// ################################################
// ###### FOR INTELLISENSE
// ######
/// <reference path="utils.js" />
/// <reference path="externals/jquery-1.7.2.min.js" />
/// <reference path="..\..\..\..\APIs\chrome_extensions.js" />
/// <reference path="..\..\..\..\APIs\webkit_console.js" />
/// <reference path="..\..\..\..\APIs\w3c_dom1.js" />
/// <reference path="..\..\..\..\APIs\w3c_dom2.js" />
/// <reference path="..\..\..\..\APIs\w3c_dom3.js" />
/// <reference path="..\..\..\..\APIs\w3c_xml.js" />
// ################################################

///////////////////////////////////////////////////////////
/// Open connection with extension script
///////////////////////////////////////////////////////////
var port = chrome.extension.connect({ name: "content-extension" });

///////////////////////////////////////////////////////////
/// Assign listener to messages from extension
///////////////////////////////////////////////////////////
port.onMessage.addListener(downloadFiles);

///////////////////////////////////////////////////////////
/// Get download file name from link
///////////////////////////////////////////////////////////
function getDownloadFileName(link) {
    var downloadFileName = utils.getFileName(link);
    if (downloadFileName == "") {
        downloadFileName = "download.download";
    }

    return downloadFileName;
}

///////////////////////////////////////////////////////////
/// Handle download file link hides in html
///////////////////////////////////////////////////////////
function getDownloadFileLink(link) {
    var downloadFileName = utils.getFileName(link);
    
    // Same link in case of no file
    if (downloadFileName == "") {
        return link;
    }
    
    // Same link in case of requested file is html
    if (utils.getExtensionFromName(downloadFileName) == 'html') {
        return link;
    }

    // In case file extension does not match HTTP response content type
    // retreive the link from the response
    var finalLink = link;
    $.ajax({
        type: "HEAD",
        async: false,
        url: link,
        success: function (message, text, response) {

            // Link leads to real file                        
            if (response.getResponseHeader('Content-type') == null || response.getResponseHeader('Content-type').indexOf('text/html') == -1) {
                return;
            }

            // Link leads to html, get the real link from the html
            $.ajax({
                type: "GET",
                async: false,
                url: link,
                success: function (result) {
                    var startStr = "url=";
                    var urlLocation = result.lastIndexOf(startStr);
                    if (urlLocation == -1) { // Handle different redirection methods
                        startStr = "src=\"";
                        urlLocation = result.lastIndexOf(startStr);
                    }

                    // Can't recognise redirection
                    if (urlLocation == -1) {
                        return;
                    }

                    // Look for file name in the rest of the text
                    var restOfTheText = result.substr(urlLocation + startStr.length);
                    var fileNameLocation = restOfTheText.lastIndexOf(downloadFileName);
                    if (fileNameLocation == -1) {
                        // TODO: use dedicated javascript function for that
                        if (downloadFileName.indexOf("%20") != -1) { // Handle space characters encoding
                            fileNameLocation = restOfTheText.lastIndexOf(downloadFileName.replace(/%20/g, " ")) - (downloadFileName.length - downloadFileName.replace(/%20/g, " ").length);
                        }
                        if (fileNameLocation == -1) { // Handle bad file name                            
                            fileNameLocation = restOfTheText.indexOf("\"");
                        }
                    }
                    
                    // Redirected link found
                    if (fileNameLocation > -1) {
                        finalLink = restOfTheText.substr(0, fileNameLocation) + "/" + downloadFileName;
                    }
                }
            });
        }
    });

    return finalLink;
}

///////////////////////////////////////////////////////////
/// Extension messages handler
///////////////////////////////////////////////////////////
function downloadFiles(msg) {

    // Download files
    for (var i = 0; i < msg.downloadFilesArrLen; i++) {
        try {

            // Create hidden download hyperlink
            var downloadFileHyperLink = document.createElementNS("http://www.w3.org/1999/xhtml", "a");
            downloadFileHyperLink.href = getDownloadFileLink(msg.downloadFilesArr[i]);
            downloadFileHyperLink.download = getDownloadFileName(decodeURI(downloadFileHyperLink.href)); // thanks Hohwan Park :)            
            
            // Create mouse click event 
            var event = document.createEvent("MouseEvents");
            event.initMouseEvent(
				"click", true, false, self, 0, 0, 0, 0, 0
				, false, false, false, false, 0, null
			);

            // Trigger mouse click event on download hyperlink
            downloadFileHyperLink.dispatchEvent(event);
        }
        catch (exc) {
            utils.alertExceptionDetails(exc);
        }
    }
}

///////////////////////////////////////////////////////////
/// Get all links on the active page
///////////////////////////////////////////////////////////
function retreiveDownloadableFiles() {
    try {
        var downlaodableFilesList = [];

        // Retrive all links
        var linkCnt = document.links.length;
        var linkTxt = undefined;
        for (var i = 0; i < linkCnt; ++i) {

            // Don't add empty links
            if ($.trim(document.links[i].toString()) == "") {
                continue;
            }
            
            downlaodableFilesList.push({ link: document.links[i].toString(), linkName: $.trim($(document.links[i]).text()) });                
        }

        // Retrive all images
        var imagesCnt = document.images.length;
        for (var j = 0; j < imagesCnt; ++j) {

            // Don't add empty links
            if ($.trim(document.images[j].src.toString()) != "") {
                downlaodableFilesList.push({ link: document.images[j].src.toString() });
            }
        }

        // Send links list to whom listens e.g. extension page
        port.postMessage({ links: downlaodableFilesList});
    }
    catch (exc) {
        utils.alertExceptionDetails(exc);
    }
}


///////////////////////////////////////////////////////////
/// Call the retreive function on script load
///////////////////////////////////////////////////////////
retreiveDownloadableFiles();
