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
**          Product : WebVoyage :: cl_searchHistory
**          Version : 7.2.0
**          Created : 09-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page xsi"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<!-- ##################### -->
<!-- ## buildSearchForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildSearchForm">

	<xsl:variable name="ableToCombine">
	    <xsl:if test="count(//page:element[@nameId='combine']) > 1">Y</xsl:if>
    </xsl:variable>
    
	<xsl:for-each select="/page:page/page:pageBody">
		<form class="searchHistoryForm" action="combineSearches.do" method="GET" >
	
	
			<!--xsl:for-each select="page:element[@nameId='page.searchHistory.page.label']">
				<xsl:variable name="searchHistoryCaption">
					<xsl:value-of select="page:label"/>
				</xsl:variable>
			</xsl:for-each-->						
	
			<!--xsl:for-each select="page:element[@nameId='page.searchHistory.recordSet.status']"-->
				<div class="searchHistory">
<!-- ## table summary coded here or grabbed from xml ##-->
			

					<table class="searchHistoryTable" cellspacing="0" summary="This table displays the search history." >
							<!--caption><xsl:value-of select="$searchStatusCaption"/></caption-->
<!-- ## table caption needed ##-->

							<xsl:for-each select="page:element[@nameId='page.searchHistory.heading']">
								<tr>
								    <xsl:if test="$ableToCombine='Y'">
    									<xsl:for-each select="page:element[@nameId='page.searchHistory.heading.combine']">
    										<th id="headerCombine" class="tableCellHeading">
    											<xsl:value-of select="page:label"/>
    										</th>
    									</xsl:for-each>
    								</xsl:if>
									<xsl:for-each select="page:element[@nameId='page.searchHistory.heading.search']">
										<th id="headerSearch" class="tableCellHeading">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>
									<xsl:for-each select="page:element[@nameId='page.searchHistory.heading.searchType']">
										<th id="headerType" class="tableCellHeading">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>
									<xsl:for-each select="page:element[@nameId='page.searchHistory.heading.results']">
										<th id="headerResults" class="tableCellHeadingCenter">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>
									<xsl:for-each select="page:element[@nameId='page.searchHistory.heading.action']">
										<th id="headerAction" class="tableCellHeadingCenter">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>
								</tr>
							</xsl:for-each>
				
							<xsl:for-each select="page:element[@nameId='page.searchHistory.data']">
	
								<xsl:variable name="classAlternate">
									<xsl:choose>
										<xsl:when test="(position() mod 2) = 0">rowHighlight </xsl:when> 
										<xsl:otherwise>row</xsl:otherwise> 
									</xsl:choose>
								</xsl:variable>
							
								<tr class="{$classAlternate}">
								    <xsl:if test="$ableToCombine='Y'">
    									<td headers="headerCombine" class="tableCell">
    										<xsl:for-each select="page:element[@nameId='combine']">
    											<input type="checkbox" name="combine" value="{page:value}" />
    										</xsl:for-each>
    									</td>
									</xsl:if>
									<td headers="headerSearch" class="tableCell">
										<xsl:for-each select="page:element[@nameId='page.searchHistory.data.search']"><xsl:value-of select="page:label"/></xsl:for-each>
									</td>
									<td headers="headerType" class="tableCell">
										<xsl:for-each select="page:element[@nameId='page.searchHistory.data.searchType']"><xsl:value-of select="page:label"/></xsl:for-each>
									</td>
									<td headers="headerResults" class="tableCellCenter">
										<xsl:for-each select="page:element[@nameId='page.searchHistory.data.results']"><xsl:value-of select="page:label"/></xsl:for-each>
									</td>
									<td headers="headerAction" class="tableCellCenter">
										<xsl:for-each select="page:element[@xsi:type='page:linkType']">

											<xsl:variable name="linkSeparator">
												<xsl:choose>
													<xsl:when test="position() = last()"></xsl:when> 
													<xsl:otherwise>&#160;|&#160;</xsl:otherwise> 
												</xsl:choose>
											</xsl:variable>
									
									               <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a><xsl:value-of select="$linkSeparator"/>

										</xsl:for-each>
									</td>																		
								</tr>
							</xsl:for-each>
					</table>
					<xsl:if test="$ableToCombine='Y'">
       					<span class="CombineSearchesButton">
       						<xsl:for-each select="/page:page//page:element[@nameId='page.searchHistory.button.combine']">
       							<span class="btnLeft">&#160;</span>
       							<input class="btnCenter"  name="butCombineSearch" id="{@nameId}" type="submit" alt="{page:buttonMessage}" title="{page:buttonMessage}">
       								<xsl:attribute name="value">
       									<xsl:value-of select="page:buttonText"/>
       								</xsl:attribute>
       							</input>
       							<span class="btnRight">&#160;</span>
       						</xsl:for-each>
       					</span>
					</xsl:if>

				</div>
			<!--/xsl:for-each-->
			
		</form>
	</xsl:for-each>		

</xsl:template>

</xsl:stylesheet>



