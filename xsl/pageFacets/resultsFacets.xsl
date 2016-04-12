<!-- $Revision: 1.7.2.1.2.1 $ $Date: 2013/01/10 18:57:54 $ -->
<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: resultsFacets
**          Version : 7.2.0
**          Created : 15-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- VYG-612: renamed because of a naming conflict: -->
<xsl:variable name="bibFormats2" select="$Configs/pageConfigs/bibFormats"/>


<!-- ###################### -->
<!-- ## buildResultsList ## -->
<!-- ######################################################### -->

<xsl:template name="buildResultsList">

   <xsl:variable name="buttonCount" select="count($pageBodyXML//page:element[@nameId='page.searchResults.browseBar.buttons']/page:element)"/>

    <xsl:for-each select="page:element[@nameId='titles']">
        <xsl:for-each select="page:option">

            <!-- ## variable used for alternating color ## -->
            <xsl:variable name="classPosition">
                <xsl:choose>
                    <xsl:when test="(position() mod 2) = 0">
                        <xsl:choose>
                            <xsl:when test="$buttonCount = 0">evenRowNoBox</xsl:when>
                            <xsl:otherwise>evenRow</xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$buttonCount = 0">oddRowNoBox</xsl:when>
                            <xsl:otherwise>oddRow</xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <!-- ## result record ## -->
            <div class="{$classPosition}">
                <xsl:if test="$buttonCount > 0">
                    <xsl:variable name="checkBoxId">
                        <xsl:value-of select="page:value"/>
                    </xsl:variable>
                    <!-- ## checkbox ## -->
                    <div class="resultListCheckBox">
                        <input type="checkbox" name="titles" value="{page:value}" id="bib_{$checkBoxId}" onClick="selectTitleChkBx(document.getElementById('resultsForm'))">
                           <xsl:if test="@selected='true'">
                              <xsl:attribute name="checked">checked</xsl:attribute>
                           </xsl:if>
                        </input>
                        <xsl:if test="string-length(//page:element[@nameId='recPointer']/page:value)">
                            <label for="bib_{$checkBoxId}">
                                <xsl:value-of select="position() + //page:element[@nameId='recPointer']"/>
                            </label>
                        </xsl:if>
                    </div>
                </xsl:if>


                <!--xsl:call-template name="buildBibIcon"/-->

                <!-- ## link & text ## -->
                <div class="resultListCellBlock">
                    <div class="resultListTextCell">
                        <xsl:if test="page:option/page:element[@nameId='crSearch']">
                            <div class="crSearch">
                                <xsl:for-each select="page:option/page:element[@nameId='crSearch']">
                                    <span class="label">
                                        <xsl:value-of select="page:label"/>
                                    </span> &#160;<span class="value">
                                        <xsl:value-of select="page:value"/>
                                    </span>
                                </xsl:for-each>
                            </div>
                        </xsl:if>
                        <!-- ## each of these options is a result record ## -->
                        <xsl:for-each select="page:option">
                            <!-- ## find the 1st content line with a label having a value
                         ## we need this so in cases where linkText isn't populated
                    -->
                            <xsl:variable name="firstBibTextWithLabel">
                                <xsl:for-each select="page:element[(contains(@nameId,'page.searchResults.contents.line'))]">
                                    <xsl:if test="string-length(page:label)">
                                        <xsl:value-of select="position()"/>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:variable>
                            <!-- ## assign the URL and linkText ## -->
                            <xsl:variable name="linkURL">
                              <xsl:for-each select="page:element[@nameId='page.searchResults.contents.line1']/page:URL">
                                 <xsl:value-of select="."/>
                              </xsl:for-each>
                            </xsl:variable>
                            <xsl:variable name="linkText">
                                <xsl:value-of select="page:element[@nameId='page.searchResults.contents.line1']/page:linkText"/>
                            </xsl:variable>
                            <!-- ## link & text ## -->
                            <!-- ## Loop thru the content lines ## -->
                            <xsl:for-each select="page:element[contains(@nameId,'page.searchResults.contents.line')]">
                                <div class="line{position()}Link">
                                    <!-- ## Special handling of the 5th line ## -->
                                    <!--xsl:if test="@nameId='page.searchResults.contents.line5'">
                                        <xsl:variable name="classAvailable">
                                            <xsl:choose>
                                                <xsl:when test="page:value = 'avail'">available</xsl:when>
                                                <xsl:when test="page:value = 'notAvail'">notAvailable</xsl:when>
                                                <xsl:when test="page:value = 'multiItem'">multiItem</xsl:when>
                                                <xsl:when test="page:value = 'noItem'">noItem</xsl:when>
                                                <xsl:when test="page:value = 'multiHold'">multiHoldings</xsl:when>
                                                <xsl:when test="page:value = 'noHold'">noHoldings</xsl:when>
                                                <xsl:otherwise>noStatus</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>
                                        <span class="{$classAvailable}">&#160;</span>
                                    </xsl:if-->

                                    <!-- ## Figure out where to put the link ## -->
                                    <xsl:choose>
                                        <!-- ## Normally we expect to have a URL and linkText on the 1st line ## -->
                                        <xsl:when test="position()='1' and string-length($linkText)">
                                           <a href="{$linkURL}">
                                              <xsl:value-of select="page:linkText"/>
                                           </a>
                                        </xsl:when>
                                        <!-- ## In cases we dont have a linkText defined in the 1st line, link to the 1st label that had a value ## -->
                                        <!-- ## this way we can still click something ## -->
                                        <xsl:when test="position()=substring($firstBibTextWithLabel,1,1) and not(string-length($linkText))">

                                                <a href="{$linkURL}">
                                                   <xsl:value-of select="page:label"/>&#160;<xsl:value-of select="page:value"/>
                                                </a>

                                        </xsl:when>
                                        <!-- ## Otherwise the URL has been assigned to a label or link, so just output the text ## -->
                                        <xsl:otherwise>
                                            <xsl:choose>
                                                <xsl:when test="@nameId='page.searchResults.contents.line5'">
                                                   <xsl:value-of select="page:label"/>
                                                </xsl:when>
                                                <xsl:otherwise>
<xsl:if test="string-length(page:label) or string-length(page:value)">
                                                   <xsl:value-of select="page:label"/>&#160;<xsl:value-of select="page:value"/>
</xsl:if>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </xsl:for-each>

                            <div class="databaseName">
                                <xsl:for-each select="page:element[contains(@nameId,'page.searchResults.contents.database')]">
                                       <xsl:value-of select="page:label"/>
                                </xsl:for-each>
                            </div>
                        </xsl:for-each>
                    </div>
                    <xsl:for-each select="page:option/page:element[contains(@nameId,'elink.url.link')]">
                            <div id="linkFloater">
                               <div id="linkContent">
                                  <img src="{$image-loc}/linksAvail.png" alt="Elinks are available" title="Elinks are available"/>
                               </div>
                            </div>
                    </xsl:for-each>
                    <!-- ## cover image ## -->
                    <xsl:choose>
                        <xsl:when test="string-length(page:option/page:element[@nameId='page.searchResults.item.type.isbn']/page:value)">
                            <!-- ## cover image from isbn ## -->
                            <xsl:call-template name="buildResultsCoverImage">
                                <xsl:with-param name="tag">
                           <xsl:call-template name="trimData">
                              <xsl:with-param name="sData" select="page:option/page:element[@nameId='page.searchResults.item.type.isbn']/page:value"/>
                           </xsl:call-template>
                        </xsl:with-param>
                                <xsl:with-param name="tagType" select="'page.searchResults.item.type.isbn'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="string-length(page:option/page:element[@nameId='page.searchResults.item.type.issn']/page:value)">
                            <!-- ## cover image from issn ## -->
                            <xsl:call-template name="buildResultsCoverImage">
                                <xsl:with-param name="tag">
                           <xsl:call-template name="trimData">
                              <xsl:with-param name="sData" select="page:option/page:element[@nameId='page.searchResults.item.type.issn']/page:value"/>
                           </xsl:call-template>
                        </xsl:with-param>
                                <xsl:with-param name="tagType" select="'page.searchResults.item.type.isbn'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="string-length(page:option/page:element[@nameId='imageServer.link']/page:URL)">
                            <div class="imageLink">
                                 <xsl:variable name="imageLink"><xsl:value-of select="page:option/page:element[@nameId='imageServer.link']/page:URL" /></xsl:variable>
                                 <xsl:variable name="imageText"><xsl:value-of select="page:option/page:element[@nameId='imageServer.link']/page:linkText" /></xsl:variable>
                                 <div class="thumbnail">
                                     <img src="{$imageLink}" alt="{$imageText}" title="{$imageText}"/>
                                 </div>
                            </div>
                        </xsl:when>
                    </xsl:choose>
                </div>
            </div>
            <!-- ## result record ## -->
        </xsl:for-each>
    </xsl:for-each>

</xsl:template>

<!-- ############################ -->
<!-- ## buildResultsCoverImage ## -->
<!-- ######################################################### -->

<xsl:template name="buildResultsCoverImage">
<xsl:param name="tag"/>
<xsl:param name="tagType"/>

    <xsl:for-each select="$Configs/pageConfigs/resultsCoverTag[@nameIdMatch=$tagType]">
        <div class="resultListCoverImageCell">
            <img src="{@linkPRE_TEXT}{$tag}{@linkPOST_TEXT}" class="resultListCoverImage" alt="{@altText}" onload="checkImage(this)"/>
        </div>
    </xsl:for-each>
</xsl:template>

<!-- ######################## -->
<!-- ## buildResultsHeader ## -->
<!-- ######################################################### -->

<xsl:template name="buildResultsHeader">

    <xsl:call-template name="createHiddenField">
       <xsl:with-param name="eleName" select="'wasSelected'"/>
    </xsl:call-template>
    <xsl:call-template name="createHiddenField">
       <xsl:with-param name="eleName" select="'returnUrl'"/>
    </xsl:call-template>
    <xsl:call-template name="createHiddenField">
       <xsl:with-param name="eleName" select="'searchId'"/>
    </xsl:call-template>


    <xsl:call-template name="createHiddenField">
       <xsl:with-param name="eleName" select="'recPointer'"/>
    </xsl:call-template>
    <xsl:call-template name="createHiddenField">
       <xsl:with-param name="eleName" select="'searchType'"/>
    </xsl:call-template>
    <xsl:call-template name="createHiddenField">
       <xsl:with-param name="eleName" select="'recCount'"/>
    </xsl:call-template>
    <xsl:call-template name="createHiddenField">
       <xsl:with-param name="eleName" select="'resultPointer'"/>
    </xsl:call-template>
    <xsl:call-template name="createHiddenField">
       <xsl:with-param name="eleName" select="'maxResultsPerPage'"/>
    </xsl:call-template>

    <xsl:for-each select="page:element[@nameId='page.searchResults.header']">
        <xsl:call-template name="buildDatabaseInfo">
            <xsl:with-param name="databaseEleName"  select="'page.search.database.label'"/>
        </xsl:call-template>

        <!-- ## Heading Label ## -->
        <div class="resultsHeaderHeader">
            <span>
               <xsl:for-each select="page:element[@nameId='page.searchResults.recordsFound.label']">
                  <!-- Removing space
                    <xsl:value-of select="page:label"/>&#160;
                    -->
                    <xsl:value-of select="page:value"/>&#160;<xsl:value-of select="page:postText"/>
                </xsl:for-each>
            </span>
        </div>
        <!-- ## Search Terms Label ## -->
        <div class="searchTerms">
            <span>
Search Request: 
                <xsl:for-each select="page:element[@nameId='page.searchResults.query.label']">
                    <xsl:value-of select="page:label"/>
                    <xsl:value-of select="page:value"/>
                    <xsl:value-of select="page:postText"/>
                </xsl:for-each>
            </span>
        </div>
        <!-- ## Action Buttons ## -->
        <div class="actions">
           <h2 class="nav">Search Action Navigation</h2>
            <ul class="navbar">
                <xsl:for-each select="page:element[@nameId='page.searchResults.editSearch.link']">
                    <li>
                        <span class="yellowBtnLeft">&#160;</span>
                        <input id="{page:buttonAction}" class="yellowBtn" type="submit" name="{page:buttonAction}" value="{page:buttonText}" />
                        <span class="yellowBtnRight">&#160;</span>
                    </li>
                </xsl:for-each>
                <xsl:for-each select="page:element[@nameId='page.searchResults.saveSearch.link']">
                    <li>
                        <span class="yellowBtnLeft">&#160;</span>
                        <input id="{page:buttonAction}" class="yellowBtn" type="submit" name="{page:buttonAction}" value="{page:buttonText}" />
                           <span class="yellowBtnRight">&#160;</span>
                   </li>
                </xsl:for-each>
                <xsl:for-each select="page:element[@nameId='page.searchResults.saveSearchAsAlert.link']">
                    <li>
                        <span class="yellowBtnLeft">&#160;</span>
                        <input id="{page:buttonAction}" class="yellowBtn" type="submit" name="{page:buttonAction}" value="{page:buttonText}" />
                        <span class="yellowBtnRight">&#160;</span>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:for-each>
</xsl:template>

<!-- ################## -->
<!-- ## buildJumpBar ## -->
<!-- ######################################################### -->

<xsl:template name="buildJumpBar">

   <xsl:for-each select="page:element[@nameId='jumpBar']">
      <!--div class="jumpBarContent"-->
      <div id="jumpBarContent">
         <h2 class="nav">Jumpbar Result Navigation</h2>
           <ul class="jumpBar">
            <xsl:for-each select="page:element">
                <xsl:choose>
                    <xsl:when test="@nameId='jumpBar.prev'"/>
                    <xsl:when test="@nameId='jumpBar.first'"/>
                    <xsl:when test="@nameId='jumpBar.last'"/>
                    <xsl:when test="@nameId='jumpBar.next'"/>
                    <xsl:when test="@nameId='jumpBar.current'"/>
                    <xsl:when test="@nameId='jumpBar.recsOf.separator'"/>
                    <xsl:when test="@nameId='jumpBar.totalHits'"/>
                    <xsl:when test="@nameId='jumpBar.discontinuity'"/>
                    <xsl:otherwise>
                        <li class="jumpBarTab">
                            <a class="jumpBarTabLink" href="{page:URL}">
                                <span class="jumpBarLeft">&#160;</span>
                                <span class="jumpBarButton">
                                    <xsl:value-of select="page:linkText"/>
                                </span>
                                <span class="jumpBarRight">&#160;</span>
                            </a>
                        </li>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            <xsl:for-each select="page:element[@nameId='jumpBar.prev']">
                <li class="jumpBarTabLeft">
                    <a class="jumpBarPrevious" href="{page:URL}">
                        <span class="jumpBarLeft">&#160;</span>
                        <span class="jumpBarArrowLeft">&#160;</span>
                        <span class="jumpBarButton">
                            <xsl:value-of select="page:linkText"/>
                        </span>
                        <span class="jumpBarEndCap">&#160;</span>
                    </a>
                </li>
            </xsl:for-each>
            <xsl:for-each select="page:element[@nameId='jumpBar.first']">
                <li class="jumpBarMiddle">
                    <a class="jumpBarLink" href="{page:URL}">
                        <span>
                            <xsl:value-of select="page:linkText"/>
                        </span>
                    </a>
                </li>
                <xsl:for-each select="../page:element[@nameId='jumpBar.discontinuity']">
                    <li class="jumpBarMiddle">
                        <span class="jumpBarLabel">
                            <xsl:value-of select="page:label"/>
                        </span>
                    </li>
                </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="page:jumps[@nameId='jumpBar.jumps']">
                <li class="jumpBarMiddle">
                    <xsl:for-each select="page:element">
                        <xsl:choose>
                            <xsl:when test="@nameId='jumpBar.jump'">
                                <a class="jumpBarLink" href="{page:URL}">
                                    <span>
                                        <xsl:value-of select="page:linkText"/>
                                    </span>
                                </a>
                            </xsl:when>
                            <xsl:when test="@nameId='jumpBar.current'">
                                <span class="jumpBarLabelSelected">
                                    <xsl:value-of select="page:linkText"/>
                                </span>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </li>
            </xsl:for-each>
            <xsl:for-each select="page:element[@nameId='jumpBar.last']">
                <xsl:for-each select="../page:element[@nameId='jumpBar.discontinuity']">
                    <li class="jumpBarMiddle">
                        <span class="jumpBarLabel">
                            <xsl:value-of select="page:label"/>
                        </span>
                    </li>
                </xsl:for-each>
                <li class="jumpBarMiddle">
                    <a class="jumpBarLink" href="{page:URL}">
                        <span>
                            <xsl:value-of select="page:linkText"/>
                        </span>
                    </a>
                </li>
            </xsl:for-each>
            <xsl:for-each select="page:element[@nameId='jumpBar.current']">
                <li class="jumpBarMiddle">
                    <span class="current">
                        <xsl:value-of select="page:label"/>
                    </span>
                </li>
            </xsl:for-each>
            <xsl:for-each select="page:element[@nameId='jumpBar.recsOf.separator']">
                <li class="jumpBarMiddle">
                    <span class="separator">
                        <xsl:value-of select="page:label"/>
                    </span>
                </li>
            </xsl:for-each>
            <xsl:for-each select="page:element[@nameId='jumpBar.totalHits']">
                <li class="jumpBarMiddle">
                    <span class="totalHits">
                        <xsl:value-of select="page:label"/>
                    </span>
                </li>
            </xsl:for-each>
            <xsl:for-each select="page:element[@nameId='jumpBar.next']">
                <li class="jumpBarTabRight">
                    <a class="jumpBarNext" href="{page:URL}">
                        <span class="jumpBarEndCap">&#160;</span>
                        <span class="jumpBarButton">
                            <xsl:value-of select="page:linkText"/>
                        </span>
                        <span class="jumpBarArrowRight">&#160;</span>
                        <span class="jumpBarRight">&#160;</span>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
      </div>
      <!--
      <div id="jumpBarFooter"></div>
      -->
   </xsl:for-each>
</xsl:template>

<!-- ####################### -->
<!-- ## buildBrowseHeader ## -->
<!-- ######################################################### -->

<xsl:template name="buildBrowseHeader">
<xsl:param name="location"/>


   <xsl:for-each  select="page:element[@nameId='page.searchResults.browseBar']">

    <xsl:variable name="buttonCount" select="count($pageBodyXML//page:element[@nameId='page.searchResults.browseBar.buttons']/page:element)"/>

    <xsl:call-template name="createHiddenField">
        <xsl:with-param name="eleName" select="'list'"/>
    </xsl:call-template>

    <xsl:variable name="classPosition">
        <xsl:choose>
            <xsl:when test="$buttonCount = 0">browseHeaderNoImage</xsl:when>
            <xsl:otherwise>browseHeader</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

      <div class="{$classPosition}">
         <h2 class="nav">Results action navigation bar</h2>
         <ul>
            <!-- ## browse bar buttons ## -->
            <xsl:for-each select="$Configs/pageConfigs/browseBarButtonOrder/button">

               <!-- ## variable :: button ID ## -->
               <xsl:variable name="buttonId" select="@name"/>

               <!-- ## variable :: last button ## -->
               <xsl:variable name="lastButton">
                  <xsl:choose>
                     <xsl:when test="position() = last()">Y</xsl:when>
                     <xsl:otherwise>N</xsl:otherwise>
                  </xsl:choose>
               </xsl:variable>

               <xsl:for-each select="$pageBodyXML//page:element[@nameId='page.searchResults.browseBar.buttons']/page:element[@nameId=$buttonId]">
                  <li id="{$location}_link_{$buttonId}">
                     <span class="yellowBtnLeft">&#160;</span>
                     <input id="{$location}_{$buttonId}" class="yellowBtn" type="submit" name="{page:buttonAction}" value="{page:buttonText}" />
                     <span class="yellowBtnRight">&#160;</span>
                     <xsl:choose>
                        <xsl:when test="$lastButton = 'Y'">
                           <span class="endLine">&#160;</span>
                        </xsl:when>
                        <xsl:otherwise>
                           <span class="horzLine">&#160;</span>
                        </xsl:otherwise>
                     </xsl:choose>
                  </li>
               </xsl:for-each>
            </xsl:for-each>
            <!-- ## browse buttons ## -->


            <!-- ## selection set ## -->
            <xsl:for-each select="page:element[@nameId='selectPage']">
               <li>
                  <div class="selectChkBox">
                     <span class="fieldBold"><xsl:value-of select="page:label"/></span>
                     <xsl:for-each select="page:option[@nameId='page']">
                        <input id="{@nameId}_{$location}" type="checkbox" name="{@nameId}" value="page" onClick="selectPageCheckbox(document.getElementById('resultsForm'),this)"/>
                        <label for="{@nameId}_{$location}"><xsl:value-of select="page:text"/></label>
                         <input name="pageIds" type="hidden" value="{page:value}" />
                     </xsl:for-each>
                     <xsl:for-each select="page:option[@nameId='cbxAll']">
                        <input id="{@nameId}_{$location}" type="checkbox" name="{@nameId}" value="{page:value}" onClick="selectAllCheckbox(document.getElementById('resultsForm'),this)"/>
                        <label for="{@nameId}_{$location}"><xsl:value-of select="page:text"/></label>
                     </xsl:for-each>
                  </div>
               </li>
            </xsl:for-each>
         </ul>

         <!-- ## sort by ## -->
         <xsl:if test="$location='top'">

            <xsl:for-each select="page:element[@nameId='sortBy']">
               <div class="browseBarSortBy">
                  <xsl:call-template name="buildFormDropDown">
                     <xsl:with-param name="eleName"  select="'sortBy'"/>
                     <xsl:with-param name="onChangeCallJSFunction"  select="'sortBySubmit(this)'"/>
                  </xsl:call-template>
                  <!--
                  <label><xsl:value-of select="page:labelEnd"/></label><label for="sortSubmit"><input id="sortSubmit" type="submit" name="submit" value="Sort"/></label>
                  -->
               </div>

            </xsl:for-each>

         </xsl:if>
        <!-- -->

         <!-- ## record count ## -->
         <!--
         <xsl:if test="$location='bottom'">
            <xsl:for-each select="page:element[@nameId='recCount']">
               <div class="browseBarRecCount">
                  <xsl:call-template name="buildFormDropDown">
                     <xsl:with-param name="eleName"  select="'recCount'"/>
                  </xsl:call-template>
                  <label><xsl:value-of select="page:labelEnd"/></label>
               </div>
            </xsl:for-each>
         </xsl:if>
         -->

      </div>
   </xsl:for-each>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildBibIcon">

   <!-- ## bibliographic icon ## -->
   <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.item.type.bibFormat']">
      <xsl:variable name="bibType" select="page:value"/>
       <xsl:if test="$bibType">

           <xsl:if test="string-length($bibFormats2/bibFormat[@type=$bibType]/@icon)">
              <div class="resultListIcon">
                  <img src="{$imageBibFormat-loc}{$bibFormats2/bibFormat[@type=$bibType]/@icon}" alt="{$bibFormats2/bibFormat[@type=$bibType]} Icon" title="{$bibFormats2/bibFormat[@type=$bibType]}"/>
              </div>
           </xsl:if>
       </xsl:if>
   </xsl:for-each>

</xsl:template>

<!-- ####################### -->
<!-- ## buildDatabaseInfo ## -->
<!-- ######################################################### -->

<xsl:template name="buildDatabaseInfo">
<xsl:param name="databaseEleName"/>

    <div id="databaseInfo" title="{$bodyText/databaseInfo}">
        <xsl:for-each select="/page:page//page:element[@nameId=$databaseEleName]">
         <span id="dbSelLabel">
            <xsl:value-of select="/page:page//page:element[@nameId=$databaseEleName]/page:label" />
         </span>
            <span id="{$databaseEleName}">
                <xsl:call-template name="replace-chars-with-comma-space">
                    <xsl:with-param name="text"  select="/page:page//page:element[@nameId=$databaseEleName]/page:value"/>
                    <xsl:with-param name="replace"  select="'|'"/>
                </xsl:call-template>
            </span>
        </xsl:for-each>

    </div>

</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>




