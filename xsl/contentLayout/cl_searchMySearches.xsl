<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.6.6.1 $ $Date: 2015/03/15 18:14:25 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#		All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: cl_searchMySearches
**          Version : 8.2.1
**          Created : 19-NOV-2007
**      Orig Author : David Sellers
**    Last Modified : 23-JAN-2013
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
	<xsl:variable name="pageNameId">
		<xsl:value-of select="/page:page/@nameId"/>
	</xsl:variable>
	
	<xsl:variable name="ableToCombine">
	    <xsl:if test="count(//page:element[@nameId='combine']) > 1">Y</xsl:if>
    </xsl:variable>
    
	<xsl:for-each select="/page:page/page:pageBody">
		<div class="searchHistoryForm">
	
			<form action="mySearchFormSubmit.do" method="GET" accept-charset="UTF-8"  name="searchmySearches">

	
			<!--xsl:for-each select="page:element[@nameId='page.searchMySearches.recordSet.status']"-->
				<div class="searchMySearches">
<!-- ## table summary coded here or grabbed from xml ##-->

			
					<table class="searchMySearchesTable" cellspacing="0" summary="This table displays the search history." >
							<!--caption><xsl:value-of select="$searchStatusCaption"/></caption-->
<!-- ## table caption needed ##-->

							<xsl:for-each select="page:element[@nameId='page.searchMySearches.heading']">
								<tr>
								    <xsl:if test="$ableToCombine='Y'">
    									<xsl:for-each select="page:element[@nameId='page.searchMySearches.heading.combine']">
    										<th id="headerCombine" class="tableCellHeading">
    											<xsl:value-of select="page:label"/>
    										</th>
    									</xsl:for-each>
    							    </xsl:if>
									<xsl:for-each select="page:element[@nameId='page.searchMySearches.heading.search']">
										<th id="headerSearch" class="tableCellHeading">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>
									<xsl:for-each select="page:element[@nameId='page.searchMySearches.heading.searchType']">
										<th id="headerType" class="tableCellHeading">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>

									<xsl:for-each select="page:element[@nameId='page.searchMySearches.heading.date']">
										<th id="headerDate" class="tableCellHeading">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>
									
									<xsl:for-each select="page:element[@nameId='page.searchMySearches.heading.alertfrequency']">
										<th id="headerAlertFrequency'" class="tableCellHeadingCenter">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>

									<xsl:for-each select="page:element[@nameId='page.searchMySearches.heading.newhits']">
										<th id="headerNewHits" class="tableCellHeadingCenter">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>																		

									<xsl:for-each select="page:element[@nameId='page.searchMySearches.heading.action']">
										<th id="headerAction" class="tableCellHeadingCenter">
											<xsl:value-of select="page:label"/>
										</th>
									</xsl:for-each>
								</tr>
							</xsl:for-each>
				
							<xsl:for-each select="page:element[@nameId='page.searchMySearches.data']">
	
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
										<xsl:for-each select="page:element[@nameId='page.searchMySearches.data.search']"><xsl:value-of select="page:label"/></xsl:for-each>&#160;
									


      								<xsl:for-each select="page:element[@nameId='searchId']">
      							   		   <input type="hidden">
      							   		      <xsl:attribute name="id"><xsl:value-of select="@nameId"/></xsl:attribute>
      							   				<xsl:attribute name="name"><xsl:value-of select="@nameId"/></xsl:attribute>
      							   				<xsl:attribute name="value"><xsl:value-of select="page:label"/></xsl:attribute>
      							   		   </input>
      								</xsl:for-each>
									</td>

									<td headers="headerType" class="tableCell">
										<xsl:for-each select="page:element[@nameId='page.searchMySearches.data.searchType']"><xsl:value-of select="page:label"/></xsl:for-each>&#160;
									</td>
									
									<xsl:for-each select="page:element[@nameId='page.searchMySearches.data.date']">
										<td headers="headerDate" class="tableCell">
											<xsl:value-of select="page:label"/>&#160;
										</td>
									</xsl:for-each>
									
									<xsl:for-each select="page:element[@nameId='alert_frequency']">
										<td headers="headerAlertFrequency'" class="tableCellCenter">
												<xsl:call-template name="buildSelectionSetDropDownMySearch">
													<xsl:with-param name="selName"  select="@nameId"/>
												</xsl:call-template>
											&#160;
										</td>
									</xsl:for-each>
									
									<xsl:for-each select="page:element[@nameId='new_hits']">
										<td headers="headerNewHits" class="tableCellCenter">
												<xsl:call-template name="buildSelectionSetDropDownMySearch">
													<xsl:with-param name="selName"  select="@nameId"/>
												</xsl:call-template>
											&#160;
										</td>
									</xsl:for-each>
									
									<td headers="headerAction" class="tableCellCenter">
										<xsl:for-each select="page:element[@xsi:type='page:linkType']">

											<xsl:variable name="linkSeparator">
												<xsl:choose>
													<xsl:when test="position() = last()"></xsl:when> 
													<xsl:otherwise>&#160;|&#160;</xsl:otherwise> 
												</xsl:choose>
											</xsl:variable>
									
									               <a href="{page:URL}">
									               <!-- <xsl:value-of select="page:linkText"/-->
									               <xsl:call-template name="url-encode">
                                                        <xsl:with-param name="str" select="page:linkText"/>
                                                   </xsl:call-template>
									               </a><xsl:value-of select="$linkSeparator"/>

										</xsl:for-each>
									</td>																		
								</tr>
							</xsl:for-each>
					</table>
				</div>
				<div class="searchButtons">
				   
					<span class="mySearchesSave">
						<xsl:for-each select="/page:page//page:element[@nameId='page.searchMySearches.save.button']">
							
							<span class="btnLeft">&#160;</span>
							<input class="btnCenter"  name="butSave" id="{@nameId}" type="submit">
								<xsl:attribute name="value">
									<xsl:value-of select="page:buttonText"/>
								</xsl:attribute>
							</input>
							<span class="btnRight">&#160;</span>
							
						</xsl:for-each>
					</span>
					
					<xsl:if test="$ableToCombine='Y'">
       					<span class="CombineSearchesButton">
       						<xsl:for-each select="/page:page//page:element[@nameId='page.searchMySearches.combineSearches.button']">
       							<span class="btnLeft">&#160;</span>
       							<input class="btnCenter"  name="butCombineSearch" id="{@nameId}" type="submit">
       								<xsl:attribute name="value">
       									<xsl:value-of select="page:buttonText"/>
       								</xsl:attribute>
       							</input>
       							<span class="btnRight">&#160;</span>
       						</xsl:for-each>
       					</span>
					</xsl:if>
			    </div>
			</form>				
			<!--/xsl:for-each-->
		</div>
	</xsl:for-each>		

</xsl:template>


<!-- ################################################################################## -->

<xsl:template name="buildSelectionSetDropDownMySearch">

<!-- ## selectionSet name to build the drop down from ## -->
<xsl:param name="selName"/>

<!-- ## pass in a cascading stylesheet class ## -->
<xsl:param name="cssClass"/>

<!-- ## If we want to call a special javascript function ##
     ## when the form dropdown changes then pass it in   ## -->
<xsl:param name="onChangeCallJSFunction"/>


<xsl:param name="size"/>
<xsl:param name="multiple"/>

<xsl:variable name="numOptions" select="count(page:option)"/>
   
   <label for="{$selName}"/>
   
   <xsl:choose>
      <xsl:when test="$numOptions=0">
         <!-- Nothing to do -->
      </xsl:when>
      <xsl:when test="$numOptions=1">
         <input>
            <xsl:attribute name="name"><xsl:value-of select="$selName"/></xsl:attribute>
            <xsl:attribute name="id"><xsl:value-of select="$selName"/></xsl:attribute>
            <xsl:attribute name="type"><xsl:value-of select="'hidden'"/></xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select="page:option/page:value"/></xsl:attribute>
         </input>
         <span><xsl:value-of select="page:option/page:text"/></span>
      </xsl:when>
      <xsl:otherwise>
      
         <select>       
         
            <!-- ## External stylesheet Reference ## -->
            <xsl:attribute name="class"><xsl:value-of select="$cssClass"/></xsl:attribute>
            <!-- ## Need to give the element a name and ID so that we can access it specifically with say.. javascript ## -->
            <xsl:attribute name="name"><xsl:value-of select="$selName"/></xsl:attribute>
            <xsl:attribute name="id">
               <xsl:value-of select="$selName"/>
            </xsl:attribute>
				 
            <xsl:choose>
               <!-- ## special javascript function to call when the form dropdown changes ## -->
               <xsl:when test="string-length($onChangeCallJSFunction)">
                  <xsl:attribute name="onchange"><xsl:value-of select="$onChangeCallJSFunction"/></xsl:attribute>
               </xsl:when>
               <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
	
            <!-- ## Size ## -->
            <xsl:if test="string-length($size)">
               <xsl:attribute name="size">
                  <xsl:value-of select="$size"/>
               </xsl:attribute>
            </xsl:if>
            
            <!-- ## Multiple ## -->
            <xsl:if test="string-length($multiple)">
               <xsl:attribute name="multiple">
                  <xsl:value-of select="'multiple'"/>
               </xsl:attribute>
            </xsl:if>
            
            <!-- ## Now build all the option values ## -->
            <xsl:for-each select="page:option">
               <option>
               
                  <!-- ## The XML selected attribute tells us to select the option ## -->
                  <xsl:if test="@selected = 'true'">
                     <xsl:attribute name="selected">selected</xsl:attribute>
                  </xsl:if>
                  
                  <!-- ## this is the value that gets sent back to the server if the option is selected ## -->
                  <xsl:attribute name="value"><xsl:value-of select="page:value"/></xsl:attribute>
                  
                  <!-- ## This is the text to display ## -->
                  <xsl:choose>
                     <xsl:when test="contains(page:text,'|')">
                        <!-- ## Handle Multiples ## -->
                        <xsl:call-template name="replace-chars-with-space">
                           <xsl:with-param name="text" select="page:text" />
                           <xsl:with-param name="replace" select="'|'" />
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise><xsl:value-of select="page:text"/></xsl:otherwise>
                  </xsl:choose>
               </option>
            </xsl:for-each>
         </select>
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

</xsl:stylesheet>




