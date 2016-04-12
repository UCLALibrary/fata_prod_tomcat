/* $Revision: 1.4.2.1 $ $Date: 2012/06/12 14:59:03 $ */
/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
   
**          Product : WebVoyage :: requestGroups js
**          Version : 7.1.0
**          Created : 07-JUN-2007
**      Orig Author : Bob Hochfellner
**    Last Modified : 09-MAR-2009
** Last Modified By : Mel Pemble
*/

function SetPickupLocs(requestGroupId) {
	document.forms[1].PICK.options.length = 0;
	
	var pickupIndex = 0
	for (var groupIndex = 0; groupIndex < arrGroupIds.length; groupIndex++) {
 		if (arrGroupIds[groupIndex] == requestGroupId) {
 			pickupIndex = groupIndex;
 			break;
 		}
 	}
	
	for (var iIndex = 0; iIndex < arrPickupIds[pickupIndex].length; iIndex++) {
		var i = document.forms[1].PICK.options.length;
		document.forms[1].PICK.options[i] = new Option(arrPickupNames[pickupIndex][iIndex], arrPickupIds[pickupIndex][iIndex] + "|" + arrPickupNames[pickupIndex][iIndex]);
		if ((requestGroupId == 0 && i == defaultPickup) || (requestGroupId != 0 && i == 0)) {
			document.forms[1].PICK.options[i].selected = true;
			document.forms[1].PICK.options[i].defaultSelected = true;
		}
	}
}



