/* $Revision: 1.5.2.1 $ $Date: 2012/06/12 14:59:02 $ */
/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================

**          Product : WebVoyage :: imageUtils js
**          Version : 7.1.0
**          Created : 28-APR-2008
**      Orig Author : Mel Pemble
**    Last Modified : 07-MAY-2009
** Last Modified By : Mel Pemble
*/

   var setDefaultErrImg=""; // Default image to be displayed on error
   var setDefaultErrTxt=""; // Default text to be displayed on error

//////////////////////////////////////////////////////////////////////

function checkImage(obj)
{

      if(obj.complete==true)
      {
         if(obj.width < 2)
         {
            if (setDefaultErrImg)
            {
                obj.src=setDefaultErrImg;
            }
            obj.setAttribute("alt",setDefaultErrTxt);
            obj.setAttribute("style","display:none");
         }
         else
         {
            obj.setAttribute("style","display:block");
         }
      }

}

//////////////////////////////////////////////////////////////////////



