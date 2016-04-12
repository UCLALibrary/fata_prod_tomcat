/* $Revision: 1.9 $ $Date: 2014/07/18 20:41:43 $ */
/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================

**          Product : WebVoyage :: ajaxUtils js
**          Version : 8.0.0
**          Created : 26-MAR-2007
**      Orig Author : Mel Pemble
**    Last Modified : 24-MAR-2010
** Last Modified By : Mel Pemble
*/

var scheduleChecked = 'false';
var httpRequest = null;
var validForm ="false";
var validationErrorMsg ="";
var state = 'none';

//////////////////////////////////////////////////////////////////////
function createXMLHttpRequest()
{
   /* In most browsers, XMLHttpRequest is a standard Javascript class,
   ** so you just create a new instance XMLHttpRequest. However, Microsoft
   ** were the inventors of XMLHttpRequest, and until IE7, IE only offered
   ** as an ActiveX object. To make things even more fun, there are different
   ** versions of that object. The following code shows a factory function
   ** that works on all browsers that support XMLHttpRequest.
   */

    if (typeof XMLHttpRequest === "undefined") {
        XMLHttpRequest = function () {
            try { return new ActiveXObject("Msxml2.XMLHTTP.6.0"); } catch (e) {}
            try { return new ActiveXObject("Msxml2.XMLHTTP.3.0"); } catch (e) {}
            try { return new ActiveXObject("Msxml2.XMLHTTP");     } catch (e) {}
            try { return new ActiveXObject("Microsoft.XMLHTTP");  } catch (e) {}
            throw new Error("This browser does not support XMLHttpRequest.");
        };
    }
    try { return new XMLHttpRequest(); } catch (e) {}
    return null;
}
//////////////////////////////////////////////////////////////////////

function handleDivTag(divtag) {
   return divtag;
}

//////////////////////////////////////////////////////////////////////

// Create the Divtag Handler -- Mainly an IE 6 Fix
var divhandler = new handleDivTag(null);

//////////////////////////////////////////////////////////////////////

function handleRequestsResponse() {
   if(httpRequest.readyState == 4) {
      if(httpRequest.status == 200) {
         // Text returned FROM the servlet
         var response = httpRequest.responseText;
         if(response) {
            // UPDATE content
            document.getElementById(divhandler.divtag).innerHTML = response;
         }
      }
      else if(httpRequest.status == 500) {
         document.getElementById(divhandler.divtag).innerHTML = '<a href="#" onclick="errorWindow.show();">!!! Error !!!</a>';
         errorWindow = new Window({id: "errWin",className: "alphacube", title: "!!! Error !!!", width:200, height:150, top:70, left:100});
         errorWindow.getContent().innerHTML = httpRequest.responseText;
         WindowStore.init();
      }
      else {
         document.getElementById(divhandler.divtag).innerHTML = '!!! Communications Error !!!';
      }
   }
}

//////////////////////////////////////////////////////////////////////

function getRequests(bibId,mfhdAttrs,bibDbCode,divtag) {

   var send = "getRequests?bibId="+bibId;
   if(mfhdAttrs) {send += '&mfhds='+mfhdAttrs;}
   if(bibDbCode) {send += '&bibDbCode='+bibDbCode;}

   divhandler.divtag = divtag;

   httpRequest = createXMLHttpRequest();
   if (httpRequest != null) {
        if (httpRequest.overrideMimeType) {
            httpRequest.overrideMimeType('text/xml');
        }
        httpRequest.open("GET", send, true);
        httpRequest.onreadystatechange = handleRequestsResponse;
        httpRequest.send(null);
    }
}

///////////////////////////////////////////////////////////////////////

function populateEndTimes()
{
   var resDateDropDown   = document.getElementById('SL_Res_Date');
   var startTimeDropDown = document.getElementById('SL_Start_Time');
   var endTimeDropDown   = document.getElementById('endtimes');
   endTimeDropDown.options.length = 0;

   if(startTimeDropDown.options.selectedIndex < 0) { return false; }
   var xml = httpRequest.responseXML;       // grab the xml from the DOM
   var startDates=getTagName(xml,"startDate");

   for (var iEle=0;iEle<startDates.length;iEle++) {
      var node = startDates[iEle];
      var dateServerTime = matchAttribute(node,'serverTime');
      if (dateServerTime == resDateDropDown.options[resDateDropDown.options.selectedIndex].value) {
         for (iStartTimes=0;iStartTimes<startDates[iEle].childNodes.length;++iStartTimes) {
            var startTimeNode   = startDates[iEle].childNodes[iStartTimes];
            var startServerTime = matchAttribute(startTimeNode,'serverTime');
            if(startServerTime == startTimeDropDown.options[startTimeDropDown.options.selectedIndex].value) {
               for (iEndTimes=0;iEndTimes<startDates[iEle].childNodes[iStartTimes].childNodes.length;++iEndTimes) {
                  var endTimeNode = startDates[iEle].childNodes[iStartTimes].childNodes[iEndTimes];
                  var isSelected = matchAttribute(endTimeNode,'isSelected');
                  var displayTime= matchAttribute(endTimeNode,'displayTime');
                  var serverTime = matchAttribute(endTimeNode,'serverTime');
                  endTimeDropDown.options[endTimeDropDown.options.length] = new Option(displayTime,serverTime);
                  if(isSelected=="Y") {
                     endTimeDropDown.options[endTimeDropDown.options.length-1].selected = "selected";
                  }
               }
            }
         }
      }
   }
   return false;
}

///////////////////////////////////////////////////////////////////////

function populateStartTimes()
{
   var resDateDropDown = document.getElementById('SL_Res_Date');
   var timeDropDown = document.getElementById('SL_Start_Time');
   timeDropDown.options.length = 0;
   var xml = httpRequest.responseXML;       // grab the xml from the DOM
   var startDates=getTagName(xml,"startDate");

   for (iEle=0;iEle<startDates.length;iEle++) {
      node = startDates[iEle];
      serverTime = matchAttribute(node,'serverTime');

      if (serverTime == resDateDropDown.options[resDateDropDown.options.selectedIndex].value) {
         for (iTimes=0;iTimes<startDates[iEle].childNodes.length;++iTimes) {
            timeNode = startDates[iEle].childNodes[iTimes];
            isSelected = matchAttribute(timeNode,'isSelected');
            displayTime= matchAttribute(timeNode,'displayTime');
            serverTime = matchAttribute(timeNode,'serverTime');
            timeDropDown.options[timeDropDown.options.length] = new Option(displayTime,serverTime);
            if(isSelected=="Y") {
               timeDropDown.options[timeDropDown.options.length-1].selected = "selected";
            }
         }
      }
   }
   populateEndTimes();
}

///////////////////////////////////////////////////////////////////////

function populateReservationDates()
{
   var resDateDropDown = document.getElementById('SL_Res_Date');
       resDateDropDown.options.length = 0;

   var xml = httpRequest.responseXML;       // grab the xml from the DOM

   var startDates=getTagName(xml,"startDate");

   for (iEle=0;iEle<startDates.length;iEle++) {
      node = startDates[iEle];
      isSelected = matchAttribute(node,'isSelected');
      displayTime= matchAttribute(node,'displayTime');
      serverTime = matchAttribute(node,'serverTime');
      resDateDropDown.options[resDateDropDown.options.length] = new Option(displayTime,serverTime);
      if(isSelected=="Y") {
         resDateDropDown.options[resDateDropDown.options.length-1].selected = "selected";
      }
   }
   populateStartTimes();
}

///////////////////////////////////////////////////////////////////////

function handleSLDateResponse() {
   if(httpRequest.readyState == 4 && httpRequest.status == 200) {
      // Text returned FROM the servlet
      var response = httpRequest.responseXML;

      if(response) {
         // UPDATE content
         populateReservationDates();
      }
   }
}

//////////////////////////////////////////////////////////////////////

function getSLDates(requestSiteId,bibId,itemId,SL_Res_Date) {

   var send = "getShortLoanDates?requestSiteId="+requestSiteId;
   if(bibId)  {send += '&bibId=' +bibId;}
   if(itemId) {send += '&itemId='+itemId;}
   if(SL_Res_Date) {send += '&SL_Res_Date='+SL_Res_Date;}

    httpRequest = createXMLHttpRequest();

    if (httpRequest != null) {
        if (httpRequest.overrideMimeType) {
            httpRequest.overrideMimeType('text/xml');
        }
        httpRequest.open("GET", send, true);
        httpRequest.onreadystatechange = handleSLDateResponse;
        httpRequest.send(null);
    }
}

///////////////////////////////////////////////////////////////////////

function slLoad(requestSiteId,bibId)
{
   var copy = document.getElementById('itemId').options[document.getElementById('itemId').options.selectedIndex].value;
   var serverTime = document.getElementById('SL_Res_Date').options[document.getElementById('SL_Res_Date').options.selectedIndex].value;
   getSLDates(requestSiteId,bibId,copy,serverTime);
}

///////////////////////////////////////////////////////////////////////

function getRequestPage(urlStr,bibID,mfhdAttrs,bibDbCode,bibDbName)
{
    var reqURL = "getRequest?"+urlStr;
    reqURL += "&bibId="+bibID;
    reqURL += "&mfhds="+mfhdAttrs;
    if(bibDbCode) {reqURL += '&bibDbCode='+bibDbCode;}
    if(bibDbName) {reqURL += '&bibDbName='+bibDbName;}

    window.location.href=reqURL;
}

///////////////////////////////////////////////////////////////////////

function handleChangeUBHoldingsLibResponse()
{
   if(httpRequest.readyState == 4 && httpRequest.status == 200) {
      // Text returned FROM the servlet
      var response = httpRequest.responseXML;
      if(response) {
         // UPDATE content
         populateUBDropDown('copies','itemId');
         populateUBDropDown('pickUpLibraries','Select_Pickup_Lib');
         populateUBDropDown('pickUpLocations','PICK');
      }
      var disableUI = document.getElementById('disablingDiv');
      var disableMsg = document.getElementById('waitmsg');
      disableMsg.style.display='none';
      disableUI.style.display='none';

   }
}

///////////////////////////////////////////////////////////////////////

function handleChangePickupLibResponse() {
   if(httpRequest.readyState == 4 && httpRequest.status == 200) {
      // Text returned FROM the servlet
      var response = httpRequest.responseXML;
      if(response) {
         // UPDATE content
         populateUBDropDown('pickUpLocations','PICK');
      }
      var disableUI = document.getElementById('disablingDiv');
      var disableMsg = document.getElementById('waitmsg');
      disableMsg.style.display='none';
      disableUI.style.display='none';
   }
}

////////////////////////////////////////////////////////////////////////

function changeUBHoldingsLib(selLib,bibId)
{
   httpRequest = createXMLHttpRequest();

   if (httpRequest != null) {
      var disableUI = document.getElementById('disablingDiv');
      var disableMsg = document.getElementById('waitmsg');
      disableUI.style.display='block';
      disableMsg.style.display='block';

      var send = "changeUBHoldingsLib?Select_Library="+selLib;
      if(bibId)  {send += '&bibId=' +bibId;}

      if (httpRequest.overrideMimeType) {
         httpRequest.overrideMimeType('text/xml');
      }
      httpRequest.open("GET", send, true);
      httpRequest.onreadystatechange = handleChangeUBHoldingsLibResponse;
      httpRequest.send(null);
    }
}

////////////////////////////////////////////////////////////////////////

function changeUBPickUpLib(selPuLib)
{
   var selLib = document.getElementById('Select_Library').options[document.getElementById('Select_Library').options.selectedIndex].value;
   var send = "changeUBPickupLib?Select_Pickup_Lib="+selPuLib;
   if(selLib)  {send += "&Select_Library="+selLib}

    httpRequest = createXMLHttpRequest();

    if (httpRequest != null) {
        var disableUI = document.getElementById('disablingDiv');
        var disableMsg = document.getElementById('waitmsg');
        disableUI.style.display='block';
        disableMsg.style.display='block';

        if (httpRequest.overrideMimeType) {
            httpRequest.overrideMimeType('text/xml');
        }
        httpRequest.open("GET", send, true);
        httpRequest.onreadystatechange = handleChangePickupLibResponse;
        httpRequest.send(null);
    }
}

////////////////////////////////////////////////////////////////////////
// reqNodeName - this is the name of the node in the responseText XML //
//               in which to grab the data from                       //
// ddId        - this is the id of the dropDown in html where to put  //
//               the new values found in the XML                      //
////////////////////////////////////////////////////////////////////////

function populateUBDropDown(reqNodeName,ddId) {
   var myDropDown = document.getElementById(ddId);    // use DOM to get to our dropdown
       myDropDown.options.length = 0;                 // clear out the old values

   var xml = httpRequest.responseXML;                 // grab the xml from the xml response

   var eleNode=getTagName(xml,reqNodeName);           // parse thru the responseXML to the requested node name

   // Loop thru the child elements of the parent node and build our dropDown data
   for (iEle=0;iEle<eleNode[0].childNodes.length;iEle++) {
      node = eleNode[0].childNodes[iEle];             // copy the node structure

      // assign the values
       isDefault = matchAttribute(node,'isDefault');
           idVal = matchAttribute(node,'id');
      displayVal = eleNode[0].childNodes[iEle].firstChild.nodeValue;

      // insert the values into the dropdown
      myDropDown.options[myDropDown.options.length] = new Option(displayVal,idVal);

      // default selection check
      if(isDefault=="Y") {
         myDropDown.options[myDropDown.options.length-1].selected = "selected";
      }
   }
}

////////////////////////////////////////////////////////////////////////

function matchAttribute(node,matchtext)
{
   for(iAttr=0;iAttr<node.attributes.length;iAttr++) {
      if (node.attributes[iAttr].nodeName == matchtext) {
         var nodVal = node.attributes[iAttr].nodeValue;
         return nodVal;
      }
   }
   return false;
}

////////////////////////////////////////////////////////////////////////

function changeMediaItem()
{
   validForm ="true";
   validationErrorMsg = "";

   var send = "changeMediaItem?";
       send += buildItems();

   if (validForm == "true") {
       httpRequest = createXMLHttpRequest();

       if (httpRequest != null) {
           if (httpRequest.overrideMimeType) {
               httpRequest.overrideMimeType('text/xml');
           }
           httpRequest.open("GET", send, true);
           httpRequest.onreadystatechange = handleChangeMediaItem;
           httpRequest.send(null);
       }
   }
   else if (validForm == "false") {
      alert(validationErrorMsg);
   }

}

////////////////////////////////////////////////////////////////////////

function validateItemReq()
{
   validForm ="true";
   validationErrorMsg = "";

   var send = "validateMediaItem?";
       send += buildItems();
       send += buildCheckoutTimes();
       send += buildMediaPickOrDeliver();
       send += "&";
       send += buildEquipTypes();
       send += validateHiddenProps();

   if (validForm == "true") {
       httpRequest = createXMLHttpRequest();

       if (httpRequest != null) {
           if (httpRequest.overrideMimeType) {
               httpRequest.overrideMimeType('text/xml');
           }
           httpRequest.open("GET", send, true);
           httpRequest.onreadystatechange = handleValidateMediaEquip;
           httpRequest.send(null);
       }
   }
   else if (validForm == "false") {
      alert(validationErrorMsg);
   }
}

////////////////////////////////////////////////////////////////////////

function validateMediaEquip()
{
   validForm ="true";
   validationErrorMsg = "";

   var send = "validateMediaEquipment?";
       send += buildEquipTypes();
       send += buildCheckoutTimes();
       send += buildMediaPickOrDeliver();

   if (validForm == "true") {
       httpRequest = createXMLHttpRequest();

       if (httpRequest != null) {
           if (httpRequest.overrideMimeType) {
               httpRequest.overrideMimeType('text/xml');
           }
           httpRequest.open("GET", send, true);
           httpRequest.onreadystatechange = handleValidateMediaEquipForMediaEquipRequest;
           httpRequest.send(null);
       }
   }
   else if (validForm == "false") {
      alert(validationErrorMsg);
   }
}

///////////////////////////////////////////////////////////////////////

function handleChangeMediaItem()
{
   ///alert(httpRequest.readyState);
   if(httpRequest.readyState == 4) {
      if (httpRequest.status == 200) {
         // Text returned FROM the servlet
         var response = httpRequest.responseXML;

         if(response) {
            // UPDATE content
            populateBasicDD('equipment','equipTypes');
            populateBasicDD('pickUpLocations','PICK');
         }
      }
      else {
         document.getElementById("messageArea").innerHTML = 'Error Recieving Data....'+ httpRequest.status +":"+ httpRequest.statusText;
      }
   }
}

////////////////////////////////////////////////////////////////////////
// reqNodeName - this is the name of the node in the responseText XML //
//               in which to grab the data from                       //
// ddId        - this is the id of the dropDown in html where to put  //
//               the new values found in the XML                      //
////////////////////////////////////////////////////////////////////////

function populateBasicDD(reqNodeName,ddId)
{
   var myDropDown = document.getElementById(ddId);    // use DOM to get to our dropdown
       myDropDown.options.length = 0;                 // clear out the old values

   var xml = httpRequest.responseXML;                 // grab the xml from the xml response

   var eleNode=getTagName(xml,reqNodeName);           // parse thru the responseXML to the requested node name

   // Loop thru the child elements of the parent node and build our dropDown data
   for (iEle=0;iEle<eleNode[0].childNodes.length;iEle++) {
      node = eleNode[0].childNodes[iEle];             // copy the node structure

      // assign the values
       isDefault = matchAttribute(node,'isDefault');
           idVal = matchAttribute(node,'id');
      displayVal = eleNode[0].childNodes[iEle].firstChild.nodeValue;

      // insert the values into the dropdown
      myDropDown.options[myDropDown.options.length] = new Option(displayVal,idVal);

      // default selection check
      if(isDefault=="Y") {
         myDropDown.options[myDropDown.options.length-1].selected = "selected";
      }
   }
}

///////////////////////////////////////////////////////////////////////

function handleValidateMediaEquip()
{
   if(httpRequest.readyState == 4) {
      if (httpRequest.status == 200) {
         // Text returned FROM the servlet
         var response = httpRequest.responseXML;

         if(response) {
            // UPDATE content
            if (isRequestBlocked(response)) {
               validForm = "false";
               document.getElementById("messageArea").style.display = "block";
            }
            else {
               // Booking Avail
               document.getElementById("messageArea").innerHTML = 'Booking is Available';
               document.getElementById("messageArea").style.display = "block";
               x = document.getElementById("bookingButton");
               x.style.visibility = "";
               scheduleChecked = 'true';
            }
         }
      }
      else {
         document.getElementById("messageArea").innerHTML = 'Error Recieving Data....'+ httpRequest.status +":"+ httpRequest.statusText;
         document.getElementById("messageArea").style.display = "block";
         scheduleChecked = 'false';
      }
   }
}

///////////////////////////////////////////////////////////////////////

function handleValidateMediaEquipForMediaEquipRequest()
{
   if(httpRequest.readyState == 4) {
      if (httpRequest.status == 200) {
         // Text returned FROM the servlet
         var response = httpRequest.responseXML;

         if(response) {
            // UPDATE content
            if (isRequestBlocked(response)) {
               validForm = "false";
               document.getElementById("messageArea").style.display = "block";
            }
            else {
               // Booking Avail
               var Msg = "Booking is Available.";
               var NoEquipSelectedMsg = "NOTE: there is no equipment associated with this booking.";
               if (!isEquipTypeSelected()) {
                  Msg = Msg + '<br/>' + NoEquipSelectedMsg;
               }
               document.getElementById("messageArea").innerHTML = Msg;
               document.getElementById("messageArea").style.display = "block";
               x = document.getElementById("bookingButton");
               x.style.visibility = "";
               scheduleChecked = 'true';
            }
         }
      }
      else {
         document.getElementById("messageArea").innerHTML = 'Error Recieving Data....'+ httpRequest.status +":"+ httpRequest.statusText;
         document.getElementById("messageArea").style.display = "block";
         scheduleChecked = 'false';
      }
   }
}

////////////////////////////////////////////////////////////////////////

function isEquipTypeSelected()
{
   var x=document.getElementById("equipTypes");

   for(i=0;i<x.options.length;++i) {
       if(x.options[i].selected) {
      return true;
       }
   }
   return false;
}

////////////////////////////////////////////////////////////////////////

function isRequestBlocked(response)
{
   var messageBlock = getTagName(response,"messages");
   var messageNode = messageBlock[0].childNodes[0];
   var requestType = matchAttribute(messageNode,'type');

   if (requestType == "requestBlocked" || requestType == "blocked") {
      if (messageNode.textContent) {
         document.getElementById("messageArea").innerHTML = messageNode.textContent;
      }
      else if (messageNode.text) {
         document.getElementById("messageArea").innerHTML = messageNode.text;
      }
      else {
         document.getElementById("messageArea").innerHTML = "Blocked";
      }
      return true;
   }
   if (requestType == "error") {
      if (messageNode.textContent) {
         document.getElementById("messageArea").innerHTML = messageNode.textContent;
      }
      else if (messageNode.text) {
         document.getElementById("messageArea").innerHTML = messageNode.text;
      }
      return true;
   }
   else { return false; }
}

////////////////////////////////////////////////////////////////////////

function buildEquipTypes()
{
   var urlData = "";
   var x=document.getElementById("equipTypes");

   for(i=0;i<x.options.length;++i) {
       if(x.options[i].selected) {
          if (urlData) { urlData += "&";}
          urlData += "equipTypes=" + x.options[i].value;
       }
   }
   return urlData;
}

////////////////////////////////////////////////////////////////////////

function buildItems()
{
   var urlData = "";
   var x=document.getElementById("itemId");

   for(i=0;i<x.options.length;++i) {
       if(x.options[i].selected) {
          if (urlData) { urlData += "&";}
          urlData += "itemId=" + x.options[i].value
       }
   }

   if (!urlData) { validForm = "false"; validationErrorMsg += "["+ document.getElementById("itemId_label").textContent+"] is a required Field\n"; }

   return urlData;
}
////////////////////////////////////////////////////////////////////////

function buildCheckoutTimes()
{
    var urlData = "";
    var startTime=document.getElementById("startTime");
    var endTime=document.getElementById("endTime");

    if (startTime) { urlData += "&startTime="+convertTo1224(startTime,24); }
    if (!urlData)  { validForm = "false"; validationErrorMsg += "["+ document.getElementById("startTime_label").textContent+"] is a required Field\n"; }
    if (endTime)   { urlData += "&endTime="+convertTo1224(endTime,24); }
    if (!urlData)  { validForm = "false"; validationErrorMsg += "["+ document.getElementById("endTime_label").textContent+"] is a required Field\n"; }
    return urlData;
}

////////////////////////////////////////////////////////////////////////

function buildMediaPickOrDeliver()
{

   var x=document.forms[1].mediaPickOrDel;

   var urlData = "";

   for(i=0;i<x.length;++i) {
      if(x[i].checked) {
         urlData += "&mediaPickOrDel="+x[i].value;
         urlData += buildPickOrDeliverDDData(x[i].value);
      }
   }
   if (!urlData)  { validForm = "false"; validationErrorMsg += "\nYou must choose a delivery method either ["+document.getElementById("PICK_label").textContent+"] or ["+document.getElementById("deliverLocId_label").textContent+"] as it is a required Field\n"; }
   return urlData;

}

////////////////////////////////////////////////////////////////////////

function buildPickOrDeliverDDData(radOpt)
{
   var x = "";
   var urlData = "";

   if (radOpt == '2') {
      urlData += "&deliverLocId=";
      x=document.getElementById("deliverLocId");
   }
   else if (radOpt == '3') {
      urlData += "&PICK=";
      x=document.getElementById("PICK");
   }
   else { return false; }

   for(i=0;i<x.options.length;++i) {
       if(x.options[i].selected) {
          urlData += x.options[i].value
       }
   }
   return urlData;
}

////////////////////////////////////////////////////////////////////////

function hideEle(eleID)
{
   var x = document.getElementById(eleID);
   x.style.visibility = "hidden";
}

////////////////////////////////////////////////////////////////////////
function updateMedia()
{
   if (scheduleChecked == 'true') {
      updMsgArea('messageArea','The booking form has changed. <br/> Please re-check the booking schedule.');
   }
}

////////////////////////////////////////////////////////////////////////

function updMsgArea(eleID,msgText)
{
   document.getElementById(eleID).innerHTML = msgText;
}

//////////////////////////////////////////////////////////////////////
function getTagName(xml,eleName)
{
    var xmlObj="";

    xmlObj=xml.getElementsByTagName("req:"+eleName);

    if (xmlObj.length > 0) { return xmlObj; }
    else {
        xmlObj=xml.getElementsByTagName(eleName);
    }
    return xmlObj;
}
//////////////////////////////////////////////////////////////////////

function showhide(layer_ref)
{

   if (state == 'block') { state = 'none'; }
   else { state = 'block'; }
   if (document.all) { //IS IE 4 or 5 (or 6 beta)
      eval( "document.all." + layer_ref + ".style.display = state");
   }
   if (document.layers) { //IS NETSCAPE 4 or below
      document.layers[layer_ref].display = state;
   }
   if (document.getElementById &&!document.all) {
      hza = document.getElementById(layer_ref);
      hza.style.display = state;
   }
}


//////////////////////////////////////////////////////////////////////

function changeMediaDeliveryLoc()
{
   validForm ="true";
   validationErrorMsg = "";

   var send = "changeMediaDeliveryLoc?";
       send += "deliverLocId=";
       send += document.getElementById("deliverLocId").value;

   if (validForm == "true") {
       httpRequest = createXMLHttpRequest();

       if (httpRequest != null) {
           if (httpRequest.overrideMimeType) {
               httpRequest.overrideMimeType('text/xml');
           }
           httpRequest.open("GET", send, true);
           httpRequest.onreadystatechange = handleChangeDeliveryLoc;
           httpRequest.send(null);
       }
   }
   else if (validForm == "false") {
      alert(validationErrorMsg);
   }

}

//////////////////////////////////////////////////////////////////////

function handleChangeDeliveryLoc()
{
   if(httpRequest.readyState == 4) {
      if (httpRequest.status == 200) {
         // Text returned FROM the servlet
         var response = httpRequest.responseXML;
         // UPDATE content
         if(response) { populateEquip(); }
      }
      else {
         document.getElementById("messageArea").innerHTML = 'Error Recieving Data....'+ httpRequest.status +":"+ httpRequest.statusText;
      }
   }
}

//////////////////////////////////////////////////////////////////////

function populateEquip()
{
   var mySpan = document.getElementById('equipInRoom');    // use DOM to get to our dropdown
   mySpan.innerHTML = '&nbsp;';                            // clear out the old values

   var xml = httpRequest.responseXML;                      // grab the xml from the xml response

   var eleNode=getTagName(xml,"equipment");                // parse thru the responseXML to the requested node name
   if (eleNode.length == 0) { return false; }
   var htmlChunk = '';

   for (var iEle=0;iEle<eleNode[0].childNodes.length;iEle++) {
      // Loop thru the child elements of the parent node and build our dropDown data
      node = eleNode[0].childNodes[iEle];                 // copy the node structure
      displayVal = eleNode[0].childNodes[iEle].firstChild.nodeValue; // assign the values
      htmlChunk += displayVal + '<br/>';                  // insert the values into the dropdown
   }
   mySpan.innerHTML = htmlChunk;
   return true;
}

//////////////////////////////////////////////////////////////////////

function removeUpdateBtn()
{
    var myObj;
    myObj = document.getElementById('top_link_page.searchResults.browseBar.update.button');
    removeUpdateBtnLogic(myObj);
    myObj = document.getElementById('bottom_link_page.searchResults.browseBar.update.button');
    removeUpdateBtnLogic(myObj);
}

//////////////////////////////////////////////////////////////////////

function removeUpdateBtnLogic(myObj)
{
    if(myObj) {
        myObj.innerHTML='';  // wipe out the button
        // We need to loop since mozilla finds whitespace and IE doesn't , so we need a node type of 1
        do { myObj = myObj.previousSibling; } while (myObj && myObj.nodeType != 1);
        // basically change the class from horizontal to endLine
        myObj.lastChild.previousSibling.className="endLine";
    }
}

//////////////////////////////////////////////////////////////////////

function sortBySubmit(obj)
{
    // Drop down selected
    // Point at the form
    var resultsForm = document.getElementById('resultsForm');

    // pretend we clicked the Update Button
    updButton=document.createElement("input");
    updButton.setAttribute("type","hidden");
    updButton.setAttribute("name","update");
    updButton.setAttribute("value","Update");

    resultsForm.appendChild(updButton);

    // Now submit the form
    obj.form.submit();
}

//////////////////////////////////////////////////////////////////////

function alertContents()
{
   if (httpRequest.readyState == 4) {
      if (httpRequest.status == 200) {
         return httpRequest;
      }
      else { return false; }
   }
   return false;
}

//////////////////////////////////////////////////////////////////////

function makeRequest(url, parameters)
{
   httpRequest = createXMLHttpRequest();
   httpRequest.open("POST",  url + parameters, true);
   httpRequest.onreadystatechange = alertContents;
   httpRequest.send(null);
}

//////////////////////////////////////////////////////////////////////

function deselectAllCheckboxes(obj)
{
   if (typeof(obj) == 'undefined') { return; }
   if (typeof(obj.length) == 'undefined')
   {
      // Single Item
      obj.checked=false;
   }
   // Loop thru them all
   for (var i=0;i<obj.length;i++) {
      // and deselect them
      obj[i].checked=false;
   }
}

//////////////////////////////////////////////////////////////////////

function selectAllCheckboxes(obj,val)
{
   if (typeof(obj) == 'undefined') { return; }
   if (typeof(obj.length) == 'undefined')
   {
      // Single Item
      obj.checked=val;
   }
   // Loop thru them all
   for (var i=0;i<obj.length;i++) {
      // and toggle them
      obj[i].checked=val;
   }
}

//////////////////////////////////////////////////////////////////////

function _getElementsByClassName (className,tag,elm)
{

   tag = tag || "*";
   elm = elm || document;
    var allElements = (tag == "*" && elm.all)? elm.all : elm.getElementsByTagName(tag);

   //var allElements = document.all ? document.all : document.getElementsByTagName('*');
   var elementArray = new Array();
   for (var element = 0; element < allElements.length; element++) {
      if (allElements[element].className == className) {
         elementArray[elementArray.length] = allElements[element];
      }
   }
   return elementArray;
}

//////////////////////////////////////////////////////////////////////

function retainSelection(obj)
{
   var getstr = "?";
   // Loop
   for (var i=0; i<obj.elements.length; i++) {
      if (obj.elements[i].tagName == "INPUT") {
         if (obj.elements[i].type == "text") {
            getstr += obj.elements[i].name + "=" + obj.elements[i].value + "&";
         }
         if (obj.elements[i].type == "hidden") {
            getstr += obj.elements[i].name + "=" + obj.elements[i].value + "&";
         }
         if (obj.elements[i].type == "checkbox") {
            if (obj.elements[i].checked) {
               getstr += obj.elements[i].name + "=" + obj.elements[i].value + "&";
            }
            else {
               getstr += obj.elements[i].name + "=&";
            }
         }
         if (obj.elements[i].type == "radio") {
            if (obj.elements[i].checked) {
               getstr += obj.elements[i].name + "=" + obj.elements[i].value + "&";
            }
         }
      }
      if (obj.elements[i].tagName == "SELECT") {
         var sel = obj.elements[i];
         getstr += sel.name + "=" + sel.options[sel.selectedIndex].value + "&";
      }
   }
   makeRequest('savSelChkBx', getstr);
}

//////////////////////////////////////////////////////////////////////

function updateTitleCheckboxs(obj, currSel)
{
   if (typeof(obj) == 'undefined') { return; }

   // point at the titles array of checkboxes
   var titleChkBxs=obj.titles;

   // If we don't have obj.page then get out of here.
   if (typeof(obj.page_top) == 'undefined') { return; }

   // Loop thru them all
   for (var i=0;i<titleChkBxs.length;i++)
   {
      // and select them
      titleChkBxs[i].checked=document.getElementById('page_top').checked;
   }

   // then via XmlHttpRequest update the current selections
   retainSelection(obj);
}

//////////////////////////////////////////////////////////////////////

function selectPageCheckbox(obj,currSel)
{
    if (typeof(obj) == 'undefined') { return; }
   //document.getElementById('all').checked=false;
   deselectAllCheckboxes(obj.cbxAll_top);
   deselectAllCheckboxes(obj.cbxAll_bottom);
   selectAllCheckboxes(obj.page_top,currSel.checked);
   selectAllCheckboxes(obj.page_bottom,currSel.checked);
   updateTitleCheckboxs(obj)
}

//////////////////////////////////////////////////////////////////////

function selectAllCheckbox(obj,currSel)
{
   if (typeof(obj) == 'undefined') { return; }
   deselectAllCheckboxes(obj.page_top);
   deselectAllCheckboxes(obj.page_bottom);
   selectAllCheckboxes(obj.cbxAll_top,currSel.checked);
   selectAllCheckboxes(obj.cbxAll_bottom,currSel.checked);
   updateTitleCheckboxs(obj);
}

//////////////////////////////////////////////////////////////////////

function selectTitleChkBx(obj)
{
   var i = 0;
   if (typeof(obj) == 'undefined') { return; }

   // this function unchecks the 'all' & the 'page' checkboxs (top & bottom) when a title checkbox is checked
   if (typeof(obj.cbxAll_top) != 'undefined')    { obj.cbxAll_top.checked=false; }
   if (typeof(obj.cbxAll_bottom) != 'undefined') { obj.cbxAll_bottom.checked=false; }
   if (typeof(obj.page_top) != 'undefined')      { obj.page_top.checked=false; }
   if (typeof(obj.page_bottom) != 'undefined')   { obj.page_bottom.checked=false; }

   // then update the current selections
   retainSelection(obj);
}

//////////////////////////////////////////////////////////////////////


function timeConvert(time,pAMPM,fmt){
    var tSplit = time.split(":");
    var tHour = tSplit[0];
    var tMin = tSplit[1].split(" ")[0];
    var tSec = tSplit[2].split(" ")[0];
    var tAmPm =  pAMPM;
    var newhr = 0;
    var ampm = '';
    var newtime = '';

    // 12 Hour Format
    if (fmt == "12") {
        if (tHour == 12){
           ampm = ((pAMPM != undefined) && (pAMPM != "")) ? pAMPM : "PM";
           newhr = 12;
        }
        else if (tHour == 00){
           ampm = "AM";
           newmin = tMin;
           newhr = 12;
        }
        else if (tHour > 12){
           newhr = tHour - 12;
           ampm = "PM";
        }
        else {
           newhr = tHour;
           ampm = ((pAMPM != undefined) ? pAMPM : "AM");
        }
        newtime = newhr+":"+tMin+":"+tSec+" "+ampm;
    }
    // 24 Hour Format
    else if (fmt == "24"){
       if ((tAmPm == "pm") || (tAmPm == "PM")){
          if (tHour < 12) {
             newhr = (tHour*1)+(1*12); //goes to 13
          }
          else { //means is 12:30 PM
             newhr = 12;
          }
       }
       else{
          newhr = tHour;
       }
       newtime = newhr+":"+tMin+":"+"00";
    }
    else {
       alert("Unsupported Time Date Format.\nPlease use in the format of 2013-07-15 14:00:00  or 2013-07-15 2:00:00 PM");
    }
    return newtime;
}

//////////////////////////////////////////////////////////////////////

function convertTo1224(dateTime,fmt){
   dateSplit = dateTime.value.split(" ");

   dsDate = dateSplit[0];
   dsTtime = dateSplit[1];
   dsAMPM = dateSplit[2];

   newTime = dsDate + " " + timeConvert(dsTtime,dsAMPM,fmt);
   return newTime;
}


//////////////////////////////////////////////////////////////////////

function convertMediaTimes() {

    var startTime=document.getElementById("startTime");
    var endTime=document.getElementById("endTime");

    if (startTime) { startTime.value = convertTo1224(startTime,24); }
    if (endTime)   { endTime.value = convertTo1224(endTime,24); }
}

//////////////////////////////////////////////////////////////////////

function selectAllChargedCheckbox(obj,currSel)
{
   if (typeof(obj) == 'undefined') { return; }
   selectAllCheckboxes(obj.selectChargedTop,currSel.checked);
   selectAllCheckboxes(obj.selectChargedBottom,currSel.checked);
   updateChargedItemsCheckboxs(obj)
}

//////////////////////////////////////////////////////////////////////

function selectChargedItemChkBx(obj)
{
   var i = 0;
   if (typeof(obj) == 'undefined') { return; }

   // this function unchecks the 'Select all' checkboxs (top & bottom) when a charged item checkbox is checked for renewal
   if (typeof(obj.selectChargedTop) != 'undefined')    { obj.selectChargedTop.checked=false; }
   if (typeof(obj.selectChargedBottom) != 'undefined') { obj.selectChargedBottom.checked=false; }
}

//////////////////////////////////////////////////////////////////////

function updateChargedItemsCheckboxs(obj, currSel)
{
   if (typeof(obj) == 'undefined') { return; }

   // point at the charged items array of checkboxes
   var chargedItemChkBxs=obj.selectCharged;

   // If we don't have obj.selectChargedTop then get out of here.
   if (typeof(obj.selectChargedTop) == 'undefined') { return; }

   // Loop thru them all
   for (var i=0;i<chargedItemChkBxs.length;i++)
   {
      // and select them
      chargedItemChkBxs[i].checked=document.getElementById('selectChargedTop').checked;
   }
}

//////////////////////////////////////////////////////////////////////
