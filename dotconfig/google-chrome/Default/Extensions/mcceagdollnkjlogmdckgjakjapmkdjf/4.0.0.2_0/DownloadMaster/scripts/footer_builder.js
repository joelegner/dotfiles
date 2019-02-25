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
/// Append download button and path input to given element
////////////////////////////////////////////////////////////////////
function appendDownloadElements(parentElement) {
    try {

        var downloadElemsDiv = document.createElement('div');

        // Add download button        
        var buttonElm = document.createElement('button');
        buttonElm.setAttribute('class', DM_FONT_CLASS);
        buttonElm.type = 'button';
        buttonElm.innerHTML = 'Download';        
        buttonElm.onclick = function () { onDownloadClick(this) };
        downloadElemsDiv.appendChild(buttonElm);

        parentElement.appendChild(downloadElemsDiv);

    } catch (e) {
        utils.alertExceptionDetails(e);
    }
}

////////////////////////////////////////////////////////////////////
/// Append feedback link to given element
////////////////////////////////////////////////////////////////////
function appendFeedbackLink(parentElement) {
    try {
        // Create feedback link        
        var linkElm = document.createElement('a');
        linkElm.onclick = function () { onClickFeedback(this) };       

        var feedbackImg = document.createElement("img");
        feedbackImg.setAttribute("src", BLOG_LINK_IMAGE);
        feedbackImg.setAttribute("height", BLOG_LINK_HEIGHT);
        feedbackImg.setAttribute("width", BLOG_LINK_WIDTH);

        $(linkElm).hover(function () {            
            $(this).css("cursor", "pointer");
        });        

        linkElm.appendChild(feedbackImg);

        parentElement.appendChild(linkElm);

    } catch (e) {
        utils.alertExceptionDetails(e);
    }
}

////////////////////////////////////////////////////////////////////
/// Append donation link to given element
////////////////////////////////////////////////////////////////////
function appendDonateLink(parentElement){
    try {
        // Create feedback link        
        var linkElm = document.createElement('a');
        linkElm.onclick = function () { onDonateClick(this) };       

        var donateImg = document.createElement("img");
        donateImg.setAttribute("src", DONATE_LINK_IMAGE);
        donateImg.setAttribute("height", DONATE_LINK_HEIGHT);
        donateImg.setAttribute("width", DONATE_LINK_WIDTH);

        $(linkElm).hover(function () {
            $(this).css("cursor", "pointer");
        });

        linkElm.appendChild(donateImg);

        parentElement.appendChild(linkElm);

    } catch (e) {
        utils.alertExceptionDetails(e);
    }
}

////////////////////////////////////////////////////////////////////
/// Build footer
////////////////////////////////////////////////////////////////////
function buildFooter(parentElem) {

    var footerDiv = document.createElement('div');
    footerDiv.id = FOOTER_DIV_ID;        

    var btnDiv = document.createElement('div');
    btnDiv.align = 'left';
    appendDownloadElements(btnDiv);

    var leftClm = document.createElement('td');
    leftClm.appendChild(btnDiv);

    var feedDiv = document.createElement('div');
    feedDiv.align = 'right';
    appendFeedbackLink(feedDiv);
    var feedClm = document.createElement('td');
    feedClm.appendChild(feedDiv);

    var dntDiv = document.createElement('div');
    dntDiv.align = 'right';
    appendDonateLink(dntDiv);
    var dntClm = document.createElement('td');
    dntClm.style.width = DONATE_CLMN_WIDTH;
    dntClm.appendChild(dntDiv);
    
    var row = document.createElement('tr');
    row.appendChild(leftClm);
    row.appendChild(feedClm);
    row.appendChild(dntClm);

    var table = document.createElement('table');    
    table.width = "100%";
    table.cellspacing = "0";
    table.cellpadding = "0";
    table.border = "0";
    table.appendChild(row);
  
    footerDiv.appendChild(table);

    parentElem.appendChild(footerDiv);
}

