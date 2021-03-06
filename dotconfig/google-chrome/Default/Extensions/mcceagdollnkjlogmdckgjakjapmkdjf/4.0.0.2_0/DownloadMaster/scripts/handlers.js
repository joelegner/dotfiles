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


////////////////////////////////////////////////////////////////////
/// On link checkbox check
////////////////////////////////////////////////////////////////////
function onLinkCheck() {

    // Link checked
    if (window.event.srcElement.checked == true) {
        selectLink(window.event.srcElement.id);
    }
    else { // Link unchecked
        unselectLink(window.event.srcElement.id);
    }
}


////////////////////////////////////////////////////////////////////
/// Change link checkbox state
////////////////////////////////////////////////////////////////////
function selectLink(linkId) {
    $('#' + linkId).attr('checked', true); // check the link    
    changeLinkColor(linkId, SELECTED_LINK_COLOR);
    moveLinkToTop(linkId);
}
function unselectLink(linkId) {
    $('#' + linkId).attr('checked',false); // uncheck link
    changeLinkColor(linkId, UNSELECTED_LINK_COLOR);
    moveLinkToBottom(linkId);
}
function changeLinkColor(linkId, color) {
    $('#' + LINK_ROW_ELEM_ID_PREFIX + linkId).css('backgroundColor', color);
}
function moveLinkToTop(linkId) {
    var link = $('#' + LINK_ROW_ELEM_ID_PREFIX + linkId); 
    $(link).remove();    
    $(link).insertAfter($('#' + LINKS_TBL_HDR_ROW_ID));
}
function moveLinkToBottom(linkId) {
    var link = $('#'+LINK_ROW_ELEM_ID_PREFIX + linkId);
    $(link).remove();
    $('#'+LINKS_TABLE_ID).append(link);
}
function unselectAllLinks() {
    var allIds = gLinksStorage.getAllIds();
    for (var i = 0; i < allIds.length; ++i) {
        unselectLink(allIds[i]);
    }
}


////////////////////////////////////////////////////////////////////
/// Hide irelevant links on filter activation
////////////////////////////////////////////////////////////////////
var onFilterCheck = function () {
    try {

        clearCustomFilter();

        var filteredLinksIds = gLinksStorage.getIds(window.event.srcElement.name);

        // For all ids of current filter
        for (var i = 0; i < filteredLinksIds.length; ++i) {

            // Filter checked
            if (window.event.srcElement.checked == true) {
                selectLink(filteredLinksIds[i]);
            }
            else { // Filter unchecked                
                unselectLink(filteredLinksIds[i]);
            }
        }
    }
    catch (exc) {
        utils.alertExceptionDetails(exc);
    }
}

////////////////////////////////////////////////////////////////////
/// Master filter sets\unsets all other filters
////////////////////////////////////////////////////////////////////
var onMasterFilterCheck = function () {
    try {

        var extArr = gLinksStorage.getExtensions();

        for (var i = 0; i < extArr.length; ++i) {
            document.getElementsByName(extArr[i])[0].checked = window.event.srcElement.checked;

            window.event.srcElement.name = extArr[i];
            onFilterCheck();
        }

    } catch (e) { utils.alertExceptionDetails(e); }
}

////////////////////////////////////////////////////////////////////
/// Handle hide irrelevant
////////////////////////////////////////////////////////////////////
var onShowAllLinksClick = function () {

    if (window.event.srcElement.checked == true) {
        // checked
        displayAllLinks();        
        utils.trackCheckbox(GA_ON_CHK_DISPLAY_ALL_LINKS);
    }
    else {
        // unchecked
        hideIrelevantLinks();        
        utils.trackCheckbox(GA_ON_UNCHK_DISPLAY_ALL_LINKS);
    }
}
function displayAllLinks() {
    var allLinks = gLinksStorage.getAllLinks();
    for (var id in allLinks) {

        if (utils.isSuspectGoodLink(id) == false) {
            // TODO: need a way to identify the source of this function (file, namespace, prototype) , use namespace e.g. var builder = {};
            // the [0] is conversion from jquery selector to DOM elelment
            buildLinkRow($('#' + LINKS_TBL_BODY_ID)[0], id);
        }
    }

    // TODO: need a way to identify the source of this function (file, namespace, prototype)  , use namespace e.g. var builder = {};
    setExtensionPageHeight(document.body);
}
function hideIrelevantLinks() {
    var allLinks = gLinksStorage.getAllLinks();
    for (var id in allLinks) {
        if (utils.isSuspectGoodLink(id) == false) {
            $('#' + LINK_ROW_ELEM_ID_PREFIX + id).remove();            
        }
    }
}

////////////////////////////////////////////////////////////////////
/// Custom filter
////////////////////////////////////////////////////////////////////
function applyCustomFilter() {

    var filterStr = window.event.srcElement.value.toLowerCase();   

    // uncheck all file extensions filters
    var extFilters = document.getElementById(EXT_FILTERS_DIV_ID).getElementsByTagName('input');
    for (var i = 0; i < extFilters.length; ++i) {
        extFilters[i].checked = false;
    }

    // Uncheck on empty filter string 
    if ($.trim(filterStr) == "") {
        unselectAllLinks();
        return;
    }

    // search string might be a regular expression
    var match = undefined, regex = undefined;
    try{
        match = filterStr.match(new RegExp('^/(.*?)/(g?i?m?y?)$'));
        if (match != null) {
            regex = new RegExp(match[1], match[2]);
        }
    }
    catch (exc) {
        utils.alertExceptionDetails(exc);
    }

    // apply filter string
    for (var i = 0; i < gLinksStorage.length(); ++i) {

        if (
                (
                    gLinksStorage.getLink(i).toLowerCase().indexOf(filterStr) != -1 // found search string in the full link 
                ||
                    (match != undefined && regex != undefined && regex.test(gLinksStorage.getLink(i).toLowerCase())) // full link matched regular expression
                )
            ||
                (
                    gLinksStorage.getName(i) != undefined
                &&
                    (
                        gLinksStorage.getName(i).toLowerCase().indexOf(filterStr) != -1 // found search string in link name if exists    
                    ||
                        (match != undefined && regex != undefined && regex.test(gLinksStorage.getName(i).toLowerCase())) // link name matched regular expression 
                    )
                )
            )
            {
            selectLink(i);          
        }
        else {
            unselectLink(i);
        }
    }
}
function clearCustomFilter() {

    // Check if custom filter exists
    if (document.getElementById(CUSTOM_FILTER_INPUT_ID) == undefined) {
        return;
    }

    if (document.getElementById(CUSTOM_FILTER_INPUT_ID).value != "") {
        unselectAllLinks();
    }
    document.getElementById(CUSTOM_FILTER_INPUT_ID).value = "";
}

////////////////////////////////////////////////////////////////////
/// On feedback link click, open blog in new tab
////////////////////////////////////////////////////////////////////
function onClickFeedback() {
    chrome.tabs.create({ "url": "http://monadownloadmaster.blogspot.com", "selected": true });    
    
    // Google Analytic event
    utils.trackButton("blog_button");
}

////////////////////////////////////////////////////////////////////
/// On donate link click, open donation page
////////////////////////////////////////////////////////////////////
function onDonateClick() {
    chrome.tabs.create({ "url": "DownloadMaster/donation/donate.html", "selected": true });

    // Google Analytic event
    utils.trackButton("donation_button");
};

function onDownloadClick() {

    try {

        // Google Analytic event
        utils.trackButton("download_button");

        // Get all checked links
        var checkedLinks = new Array();

        var inputTags = document.getElementsByTagName('input');
        for (var i = 0; i < inputTags.length; i++) {
            if (inputTags[i].type == "checkbox" && inputTags[i].id != "" && inputTags[i].checked) {
                var linkId = inputTags[i].id.toString().replace(LINK_ROW_ELEM_ID_PREFIX, '');
                checkedLinks.push(gLinksStorage.getLink(linkId));
            }
        }

        // Don't send message with empty list
        if (checkedLinks.length < 1) {
            return;
        }

        // Send checked links to content script
        gContentConnectionPort.postMessage({
            downloadFilesArr: checkedLinks,
            downloadFilesArrLen: checkedLinks.length
        });

    } catch (exc) {
        utils.alertExceptionDetails(exc);
    }
}