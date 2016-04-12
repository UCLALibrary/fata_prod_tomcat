<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.4 $ $Date: 2012/06/09 00:27:51 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: cl_resultsTitles
**          Version : 7.2.0
**          Created : 15-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 14-MAR-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ###################### -->
<!-- ## buildResultsForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildResultsForm">
	<xsl:for-each select="/page:page/page:pageBody">

		<div class="resultsTitleForm">
	
			<!-- ## results header ## -->
			<div class="resultsHeader">
				<xsl:call-template name="buildResultsHeader"/>
			</div>
	
			<!-- ## jump nav top ## -->
			<div id="jumpBarNavTop">
				<xsl:call-template name="buildJumpBar"/>
			</div>
	
			<!-- ## browse header top ## -->
			<div id="browseHeaderTop">
				<xsl:call-template name="buildBrowseHeader">
					<xsl:with-param name="location" select="'top'"/>
				</xsl:call-template>
			</div>

         <div id="theResults">
   			<!-- ## filters ## -->
   			<!--xsl:call-template name="buildFiltersBlock"/-->
   
   			<!-- ## records ## -->
   			<div id="resultList">
   				<xsl:call-template name="buildResultsList"/>
   			</div>
         </div>
         
			<!-- ## browse header bottom ## -->
			<div id="browseHeaderbottom">
				<xsl:call-template name="buildBrowseHeader">
					<xsl:with-param name="location" select="'bottom'"/>
				</xsl:call-template>
			</div>
	
			<!-- ## jump nav bottom ## -->
			<div id="jumpBarNavBottom">
				<xsl:call-template name="buildJumpBar"/>
			</div>
	
		</div>			
	</xsl:for-each>		

</xsl:template>

<!-- ####################### -->
<!-- ## buildFiltersBlock ## -->
<!-- ######################################################### -->

<xsl:template name="buildFiltersBlock">
	<xsl:for-each select="page:element[@nameId='page.searchResults.filtersBlock']">

   <xsl:variable name="filtersON">
   	<xsl:for-each select="page:element[@nameId='page.searchResults.filtersBlock.applied.group']">
   		<xsl:for-each select="page:element[@nameId='page.searchResults.filtersBlock.applied']">
   			<li>
   			   <a href="{page:element[@nameId='page.searchResults.filtersBlock.remove.link']/page:URL}"><xsl:value-of select="page:element[@nameId='page.searchResults.filtersBlock.remove.link']/page:linkText"/>: <xsl:value-of select="page:element[@nameId='page.searchResults.filters.label']/page:label"/></a>
   			</li>
   		</xsl:for-each>
   	</xsl:for-each>
   </xsl:variable>
   
   <xsl:variable name="filtersOFF">
   	<xsl:for-each select="page:element[@nameId='page.searchResults.filtersBlock.filters.link']">
   		<li><a href="{page:URL}">add filter: <xsl:value-of select="page:linkText"/></a></li>
   	</xsl:for-each>
   </xsl:variable>
   
		<div class="filters">
			<a id="filtersQuickLink" name="filtersQuickLink"></a>
			
			<xsl:for-each select="page:label">
				<span class="filterBox"><xsl:value-of select="."/></span>
			</xsl:for-each>
	
         <xsl:if test="string-length($filtersON)">
            <h3 class="nav">These links can be selected to remove a selected filter from your search results</h3>
            <ul><xsl:copy-of select="$filtersON"/></ul>
         </xsl:if>
         <xsl:if test="string-length($filtersOFF)">
            <h3 class="nav">These links can be selected to filter search results</h3>
            <ul><xsl:copy-of select="$filtersOFF"/></ul>
         </xsl:if>

		</div>
	
	</xsl:for-each>
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>



