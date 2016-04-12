/* $Revision: 1.5.2.2.2.1 $ $Date: 2013/01/10 18:56:00 $ */
/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================

**          Product : WebVoyage :: highLight js
**          Version : 8.2.0
**          Created : 13-MAY-2008
**      Orig Author : Mel Pemble
**    Last Modified : 24-OCT-2012
** Last Modified By : Mel Pemble
**
*/

/******************************************************************************
 * Compares search terms to a list of words we do not want highlighted.
 * Words must be enclosed in single quotes.
 * Commas must appear between words. Do not put a comma after the last word!
 ******************************************************************************/

var stop_words = new Array('and','in','is','for','from','not','of','or','the','to','with','&amp','nbsp');

Array.prototype.array_contains = function(searchTerm) {
   var i=this.length-1;
   if(i>=0) {
      do {
         if(this[i].toLowerCase() === searchTerm.toLowerCase()) { return true; }
      } while(i--);
   }
   return false;
}

/****************************************************************************************/

function highlightNodes(htmlBlock, searchTerms) {
   // No need to highight if there are no search terms
   if(!searchTerms.length) { return htmlBlock; }


   var newHtmlBlock = "";
   var iIndexPtr = -1;

   // Easier to match if search terms and data are the same case
   var lc_searchTerms = searchTerms.toLowerCase();
   var lc_htmlBlock = htmlBlock.toLowerCase();

   // Basiclly this is our wrapper around the text to highlight
   // you can control the color in css
   var startHighlight = "<span class='highlight'>";
   var endHighlight = "</span>";

   // Loop thru the main block of text looking for search terms
   while (htmlBlock.length > 0) {

      // Set the position in the text where we find the search term, if any
      iIndexPtr = lc_htmlBlock.indexOf(lc_searchTerms, iIndexPtr+1);

      // if we didnt find anything then just copy the orig in ( I suppose we could just return htmlBlock at this point rather then copy )
      if (iIndexPtr < 0) {
         newHtmlBlock += htmlBlock;
         htmlBlock = "";
      } else {
         // We found a match, but lets make sure we aren't highlighting something we've already highlighted
         if (htmlBlock.lastIndexOf(">", iIndexPtr) >= htmlBlock.lastIndexOf("<", iIndexPtr)) {

            var before = htmlBlock.substring(0, iIndexPtr);
            // we need to handle cases when the term is at the beginning or end of the block
            if (iIndexPtr == 0){ before += " "; }
            var after = htmlBlock.substr(lc_htmlBlock.indexOf(lc_searchTerms));   // Grab all the way to the end of the block
                after = after.split(" ",1);                                       // Then chop off at the 1st space
                after[0] += " ";                                                  // Then add a single space for our next logic

            if ((!isAlphaNumeric(before.substr(before.length-1,1)))
                && ((!isAlphaNumeric(htmlBlock.substr(iIndexPtr+searchTerms.length, 1)))
                || htmlBlock.substr(iIndexPtr+searchTerms.length, 1)==''
                || after[0].substr(after[0].length-2)=='s '
                || after[0].substr(after[0].length-3)=='es '
              )){

              // We may need to rethink the plural logic
              // a title like "Civil War Sutlers and Their Wares" and highlighting a search term like "War"
              // would hilight Wares

               if (lc_htmlBlock.lastIndexOf("/script>", iIndexPtr) >= lc_htmlBlock.lastIndexOf("<script", iIndexPtr)) {
                  newHtmlBlock += htmlBlock.substring(0, iIndexPtr)
                               + startHighlight
                               +  htmlBlock.substr(iIndexPtr, searchTerms.length)
                               + endHighlight;
                  htmlBlock = htmlBlock.substr(iIndexPtr + searchTerms.length);
                  lc_htmlBlock = htmlBlock.toLowerCase();
                  iIndexPtr = -1;
               }
            }
         }
      }
   }
   return newHtmlBlock;
}

/******************************************************************************/
function getResultList(){

   var resList =  document.getElementById('resultList');
   if (resList == null) { resList = document.getElementById('resultListAuth') }

   return resList;
}

/******************************************************************************/

function highlightResultSet(searchTerms) {

   /* No need to do anything if there are no terms to highlight */
   if (searchTerms == null || searchTerms.length < 1)
   {
       return false;
   }

   /* Check the DOM to see if exists */
   if (!document.body) {
      return false;
   }

   var resultList = getResultList();

   if ( resultList == null || typeof(resultList.innerHTML) == "undefined"){
       return false;
   }

   /* Separate search Terms */
   var searchTermsArray;
   // If the search criteria is a quoted phrase...
   if(searchTerms != null && searchTerms.charAt(0)=='"' && searchTerms.charAt(searchTerms.length-1)=='"') {
       searchTerms = searchTerms.replace(/"/g,''); // remove quotes
       searchTermsArray = [searchTerms]; // add the phrase to array to be checked
   } else {
       // remove any quotes anyway
       searchTerms=searchTerms != null?searchTerms.replace(/"/g,''):searchTerms;
       searchTermsArray = searchTerms.split(" "); // break down the search words
   }
   searchTermsArray.sort().reverse();
   sortByLength(searchTermsArray);

   /* Grab a chunk of HTML */
   var htmlChunk = document.getElementById('resultList').innerHTML;

   /* Loop thru the html by searchterm */
   for (var iCount = 0; iCount < searchTermsArray.length; iCount++) { // only highlight words with more that 1 character
       if(searchTermsArray[iCount].length > 1 && !stop_words.array_contains(searchTermsArray[iCount])) {
            htmlChunk = highlightNodes(htmlChunk, searchTermsArray[iCount]);
         }
   }

  /* reassign the innerHTML to the newly highlighted chunk */
  document.getElementById('resultList').innerHTML = htmlChunk;

  return true;
}

/******************************************************************************/
function highlightRecordDisplay(searchTerms) {

   /* No need to do anything if there are no terms to highlight */
   if (searchTerms == null || searchTerms.length < 1)
   {
       return false;
   }

    /* remove quotes from quoted search criteria like "foreign policy" */
    //searchTerms = searchTerms != null ? searchTerms.replace(/"/g,'') : searchTerms;

   var myNodes = new Array();
   myNodes = _getElementsByClassName ('subfieldData','',document.getElementById('divbib'));
   myNodes = myNodes.concat(_getElementsByClassName ('subfieldMarcData','',document.getElementById('divbib')));
   myNodes = myNodes.concat(document.getElementById('divBibTitle'));
   /* Separate search Terms */
   var searchTermsArray;

   // If the search criteria is a quoted phrase...
   if(searchTerms != null && searchTerms.charAt(0)=='"' && searchTerms.charAt(searchTerms.length-1)=='"') {
       searchTerms = searchTerms.replace(/"/g,''); // remove quotes
       searchTermsArray = [searchTerms]; // add the phrase to the array to be checked
   } else {
       // remove any quotes anyway
       searchTerms=searchTerms!=null?searchTerms.replace(/"/g,'') : searchTerms;
       searchTermsArray = searchTerms.split(" "); // break down the search words
   }

    for (var arrCount = 0; arrCount < myNodes.length; arrCount++ ) {
        var htmlChunk = myNodes[arrCount].innerHTML;

        /* Loop thru the html by searchterm */
        for (var iCount = 0; iCount < searchTermsArray.length; iCount++) {    // only highlight words with more that 1 character
            if(searchTermsArray[iCount].length > 1 && !stop_words.array_contains(searchTermsArray[iCount])) {
                htmlChunk = highlightNodes(htmlChunk, searchTermsArray[iCount]);
            }
        }

        /* reassign the innerHTML to the newly highlighted chunk */
        myNodes[arrCount].innerHTML = htmlChunk;
    }
   return true;
}

/******************************************************************************/
function sortByLength(arrayName) {
   var length = arrayName.length;

   for (var i=0; i<(length-1); i++) {
      for (var j=i+1; j<length; j++) {
         if (arrayName[j].length > arrayName[i].length) {
            var temp = arrayName[i];
            arrayName[i] = arrayName[j];
            arrayName[j] = temp;
         }
      }
   }
}

/******************************************************************************/
function isAlphaNumeric(str) {
    if (str == "") { return false }
    var re = new RegExp(/[^a-zA-Z0-9]/g);
    return re.test(str) ? false : true;
}



