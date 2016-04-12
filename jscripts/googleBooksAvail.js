/* $Revision: 1.1.1.1.10.1 $ $Date: 2012/06/12 14:59:02 $ */
/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2008 ExLibris Group
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================

**          Product : WebVoyage :: googleBooksAvail js
**          Version : 2007.0.1
**          Created : 05-MAR-2008
**      Orig Author : Mel Pemble  (code based on examples from Google)
**    Last Modified : 09-MAR-2009
** Last Modified By : Mel Pemble
*/

/**
* This function is the call-back function for the JSON scripts which
* executes a Google book search response.
*
* @param {JSON} booksInfo is the JSON object pulled from the Google books service.
*/
var dataArrived="false";

function listBookEntries(booksInfo)
{
   var bookPreviewFull = 'Full text available';
   var bookPreviewPartial = 'Limited Preview';
   var bookPreviewNoView = '"About This Book"';

   // Hide the google books row until we can determine that we have something to display 
   document.getElementById('googleBooksRow').style.display = 'none'; 
   
   // Clear any old data
   var div = document.getElementById("data");
   if (div.firstChild)
   {
      div.removeChild(div.firstChild);
   }
   
   var mainDiv = document.createElement("div");
   
   for (i in booksInfo)
   {
      // Create a DIV for each book
      var book = booksInfo[i];
      if (book.bib_key)
      {
         document.getElementById('googleBooksRow').style.display = '';  
         document.getElementById('googleBooks').style.display = 'block';  
         var thumbnailDiv = document.createElement("div");
         thumbnailDiv.className = "bookInfo";

         // Display a thumbnail of the book's cover (if it exists)
         // here you could add logic to see if we had grabbed an image from somewhere else
         if(book.thumbnail_url)
         {
            var img = document.createElement("img");
            img.src = book.thumbnail_url;
            img.id = 'googleImage';
            img.className = "googleImage";
            thumbnailDiv.appendChild(img);
         }
         
         // Creates a link directly into the book preview
         if(book.preview_url && book.preview != "noview")
         {
            var infoUrl = document.createElement("a");
            infoUrl.href = book.preview_url;
            infoUrl.setAttribute("target","_googleBooksPreview");  // opens in a new window
            thumbnailDiv.appendChild(infoUrl);
            
            var infoTxt = document.createElement("p");
            if (book.preview == "full")
            {
               infoTxt.innerHTML = bookPreviewFull;
            }
            if (book.preview == "partial")
            {
               infoTxt.innerHTML = bookPreviewPartial;
            }
            infoUrl.appendChild(infoTxt);
         }

         // Add a link to the book's information page
         // We could add logic here to create diff links based on book.preview,book.info_url, and book.preview_url
         if(book.info_url)
         {
            var infoUrl = document.createElement("a");
            infoUrl.href = book.info_url;
            infoUrl.setAttribute("target","_googleBooksInfo");   // opens in a new window
            thumbnailDiv.appendChild(infoUrl);
            
            var infoTxt = document.createElement("p");
            infoTxt.innerHTML = bookPreviewNoView;
            infoUrl.appendChild(infoTxt);
         }
         
         mainDiv.appendChild(thumbnailDiv);
      }
   }
   div.appendChild(mainDiv);
}

/**
*
* @param {DOM object} query The form element containing the
* input parameters "isbn","lccn", etc  it's all in the 'isbns' element
*/

function googleBookSearch()
{
   var gbDiv = document.getElementById('data');

   // Show a "Loading..." indicator.
   var paragraph = document.createElement('p');
   paragraph.appendChild(document.createTextNode('Loading...'));
   gbDiv.appendChild(paragraph);
   
   // Delete any previous Google Book Search JavaScript Object Notation queries.
   var jsonScript = document.getElementById("googleBooksScript");
   if (jsonScript)
   {
      jsonScript.parentNode.removeChild(jsonScript);
   }
   
   if(document.getElementById('gisbn'))
   {
      doBookScripts('gisbn','isbnHandler');
   }
   else if(document.getElementById('goclc'))
   {
      doBookScripts('goclc','oclcHandler');
   }
   else if(document.getElementById('glccn'))
   {
      doBookScripts('glccn','lccnHandler');
   }
}

function doBookScripts(bibKey,handler)
{
   
   // Add a script element with the src as the user's Google Booksearch query.
   // JSON output is specified by including the alt=json-in-script argument
   // and the callback funtion is also specified as a URI argument.
   var scriptElement = document.createElement("script");
   scriptElement.setAttribute("id", "googleBooksScript");
   scriptElement.setAttribute("src", "http://books.google.com/books?bibkeys=" + escape(document.getElementById(bibKey).value) + "&jscmd=viewapi&callback="+handler);
   scriptElement.setAttribute("type", "text/javascript");
  
   // make the request to Google booksearcsh
   document.documentElement.firstChild.appendChild(scriptElement);
}

function isbnHandler(booksInfo)
{
   for (i in booksInfo)
   {
      var book = booksInfo[i];
      if (book.bib_key)
      {
         dataArrived="true";
         listBookEntries(booksInfo);
      }
   }
   
   if(dataArrived=='false')
   {
      if(document.getElementById('goclc'))
      {
         doBookScripts('goclc','oclcHandler');
      }
      else if(document.getElementById('glccn'))
      {
         doBookScripts('glccn','lccnHandler');
      }
   }
}

function lccnHandler(booksInfo)
{
   for (i in booksInfo)
   {
      var book = booksInfo[i];
      if (book.bib_key)
      {
         dataArrived="true";
         listBookEntries(booksInfo);
      }
   }
}

function oclcHandler(booksInfo)
{
   for (i in booksInfo)
   {
      var book = booksInfo[i];
      if (book.bib_key)
      {
         dataArrived="true";
         listBookEntries(booksInfo);
      }
   }
   if(dataArrived=='false')
   {
      if(document.getElementById('glccn'))
      {
         doBookScripts('glccn','lccnHandler');
      }
   }
}
