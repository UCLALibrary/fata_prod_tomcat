/* $Revision: 1.3.2.1 $ $Date: 2012/06/12 14:59:02 $ */
/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
   
**          Product : WebVoyage :: mapUtils js
**          Version : 7.1.0
**          Created : 06-DEC-2007
**      Orig Author : Mel Pemble
**    Last Modified : 09-MAR-2009
** Last Modified By : Mel Pemble
*/

var state = 'none';

function switchMapFormat(currFormatType,servletName)
{
   var formatType = document.getElementById('mapFormat');
   var idxVal = formatType.options[formatType.selectedIndex].value;
    
   if (getFormatType(currFormatType) == getFormatType(idxVal))
   {
      // Do Nothing
   }
   else
   {
       newUrl = "";
       newUrl += servletName;
       newUrl += '?mapFormat='+idxVal;
       window.location.href=newUrl;
   }
}

//////////////////////////////////////////////////////////////////////

function getFormatType(idxVal)
{

   switch (idxVal)
   {
      case '1':
      case '2':
      case '3':
         return("lat");
         break;
      case '4':
      case '5':
      case '6':
         return("utm");
         break;
    }
   
}

//////////////////////////////////////////////////////////////////////

function showhide(layer_ref)
{

   if (state == 'block')
   {
      state = 'none';
   }
   else
   {
      state = 'block';
   }
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



