/* $Revision: 1.3.2.1 $ $Date: 2012/06/12 14:59:03 $ */
/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================

**          Product : WebVoyage :: page input focus js
**          Version : 7.1.0
**          Created : 02-JAN-2008
**      Orig Author : Mel Pemble
**    Last Modified : 09-MAR-2009
** Last Modified By : Mel Pemble
*/


//////////////////////////////////////////////////////////////////////

function setFocus(pageName)
{
   /*
   ** A pageName will get passed in , which we will use to set the focus.
   ** to add support for a new page use the /page:page/@nameId (from the XML)
   ** value for the case match, and call the focusElement() function with the
   ** id of the form element to set focus to
   ** 
   */

   switch(pageName)
   {
      case 'page.searchBasic':
      case 'page.searchSubject':
      case 'page.searchAuthor':
         focusElement('searchArg');
         break;
         
      case 'page.searchAdvanced':
         focusElement('searchArg1');
         break;
         
      case 'page.logIn':
         focusElement('loginId');
         break;

   }
}

//////////////////////////////////////////////////////////////////////
function focusElement(eleName)
{
   if(document.getElementById(eleName))
   {
      document.getElementById(eleName).focus();
   }
}
//////////////////////////////////////////////////////////////////////



