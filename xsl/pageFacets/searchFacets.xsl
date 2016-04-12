<!-- $Revision: 1.5 $ $Date: 2012/06/11 14:46:57 $ -->
<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: searchFacets
**          Version : 7.2.0
**          Created : 17-JUL-2007
**      Orig Author : David Sellers
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
    exclude-result-prefixes="xsl fo page"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

   <xsl:variable name="formAction">
      <xsl:value-of select="/page:page//page:element[@nameId='page.search.search.button']/page:buttonAction"/>
   </xsl:variable>

<!-- ######################## -->
<!-- ## buildTheSearchForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildTheSearchForm">
<xsl:param name="formName"/>
<xsl:param name="formData"/>
<xsl:param name="selectedTab"/>


    <xsl:call-template name="buildDatabaseInfo">
        <xsl:with-param name="databaseEleName"  select="'page.search.database.label'"/>
        <xsl:with-param name="changeLinkEleName"  select="'page.search.change.link'"/>
    </xsl:call-template>

    <xsl:call-template name="buildNavTabs">
        <xsl:with-param name="divID" select="'searchNav'"/>
        <xsl:with-param name="selectedTab" select="$selectedTab"/>
    </xsl:call-template>

    <xsl:call-template name="buildSearchHistoryLink">
        <xsl:with-param name="eleName"  select="'page.search.searchHistory.link'"/>
    </xsl:call-template>

    <div id="searchForm">
      <form action="{$formAction}" method="GET" accept-charset="UTF-8" id="{$formName}">
         <xsl:copy-of select="$formData"/>
      </form>
   </div>

</xsl:template>

<!-- ######################## -->
<!-- ## buildSearchButtons ## -->
<!-- ######################################################### -->

<xsl:template name="buildSearchButtons">

   <div id="searchRecs" title="{$bodyText/recordCount}">
      <!-- ## Records Per Page Drop Down ## -->
      <xsl:call-template name="buildFormDropDown">
         <xsl:with-param name="eleName"  select="'recCount'"/>
      </xsl:call-template>
   </div>

   <div id="searchLinks">


      <!-- ## Search Type Input ## -->
      <xsl:for-each select="/page:page//page:element[@nameId='searchType']">
        <input type="hidden">
            <xsl:attribute name="name"><xsl:value-of select="@nameId"/></xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select="page:value"/></xsl:attribute>
        </input>
      </xsl:for-each>

      <!-- ## Submit Button ## -->
      <xsl:for-each select="/page:page//page:element[@nameId='page.search.search.button']">
         <input id="page.search.search.button" name="page.search.search.button" type="submit" title="{page:buttonMessage}">
            <xsl:attribute name="value">
               <xsl:value-of select="/page:page//page:element[@nameId='page.search.search.button']/page:buttonText"/>
            </xsl:attribute>
         </input>
          <span class="formHorizontalSpacer">&#160;</span>
      </xsl:for-each>

      <!-- ## Clear Button ## -->
      <xsl:for-each select="/page:page//page:element[@nameId='page.search.clear.button']">
         <input id="page.search.clear.button" type="reset" >
            <xsl:attribute name="value">
               <xsl:value-of select="/page:page//page:element[@nameId='page.search.clear.button']/page:buttonText"/>
            </xsl:attribute>
         </input>
      </xsl:for-each>

      <!-- ## hidden redirect DbCode ## -->
    <xsl:for-each select="/page:page//page:element[@nameId='redirectDbCode']">
        <input type="hidden">
            <xsl:attribute name="name"><xsl:value-of select="@nameId"/></xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select="page:value"/></xsl:attribute>
        </input>
    </xsl:for-each>

      <!-- ## re-Search Submit Button ## -->
    <xsl:for-each select="/page:page//page:element[@nameId='page.search.reSearch.button']">
        <input type="submit" name="{@nameId}" value="{page:buttonText}"/>
    </xsl:for-each>

   </div>
</xsl:template>

<!-- ############################ -->
<!-- ## buildSearchHistoryLink ## -->
<!-- ######################################################### -->

<xsl:template name="buildSearchHistoryLink">
<xsl:param name="eleName"/>

   <div id="searchHistoryLink" title="{$bodyText/searchHistory}">
      <xsl:for-each select="/page:page//page:element[@nameId=$eleName]">
         <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
      </xsl:for-each>
   </div>

</xsl:template>

<!-- ####################### -->
<!-- ## buildDatabaseInfo ## -->
<!-- ######################################################### -->

<xsl:template name="buildDatabaseInfo">
<xsl:param name="databaseEleName"/>
<xsl:param name="changeLinkEleName"/>

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

        <xsl:for-each select="/page:page//page:element[@nameId=$changeLinkEleName]">
            <a href="{page:URL}" title="{$bodyText/changeDatabaseLink}"><xsl:value-of select="page:linkText"/></a>
        </xsl:for-each>
    </div>

</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>



