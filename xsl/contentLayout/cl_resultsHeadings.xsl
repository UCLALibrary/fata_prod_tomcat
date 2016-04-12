<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5 $ $Date: 2012/06/09 00:27:51 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: cl_resultsHeadings
**          Version : 7.2.0
**          Created : 15-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:sear="http://www.endinfosys.com/Voyager/search"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ################## -->
<!-- ## buildResultsForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildResultsForm">
    <xsl:for-each select="/page:page/page:pageBody">

        <div class="resultsHeadingsForm">

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

            <!-- ## records ## -->
            <xsl:call-template name="buildAuthResultsList"/>
            <xsl:call-template name="buildResultsHeadingsList"/>
            

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
<xsl:template name="buildAuthResultsList">

<xsl:variable name="searchCommand" select="'search'"/>
<xsl:variable name="searchType" select="'7'"/>

<xsl:variable name="searchId"><xsl:value-of select="/page:page//page:element[@nameId='searchId']/page:value"/></xsl:variable>
<xsl:variable name="maxResultsPerPage" select="'10'"/>
<xsl:variable name="recCount" select="'10'"/>
<xsl:variable name="recPointer" select="'0'"/>




    <xsl:for-each select="page:element/results">
    <div id="resultListAuth">
    <table class="authTable">
       <tr>
          <th width="1%">Bib Records</th>
          <th width="auto">Heading</th>
          <th>Authority Headings/References</th>
       </tr>
    
       <xsl:for-each select="sear:result">
          <xsl:variable name="resultPointer"><xsl:value-of select="position()+$recPointer -1"/></xsl:variable>
          <xsl:variable name="headingId" select="sear:headingId"/>
            <!-- ## variable used for alternating color ## -->
            <xsl:variable name="classPosition">
                <xsl:choose>
                    <xsl:when test="(position() mod 2) = 0">evenRow</xsl:when>
                    <xsl:otherwise>oddRow</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
<tr>
            <!-- ## headings result record ## -->
            <td class="{$classPosition}HeadingCount">
                  <xsl:value-of select="sear:headingCount"/>
            </td>
            <td class="{$classPosition}HeadingCount">
	        <xsl:choose>
		    <xsl:when test="sear:headingCount='0'">
                        <xsl:value-of select="sear:headingText"/>
		    </xsl:when>
		    <xsl:otherwise>
		        <a>
			    <xsl:attribute name="href">
			       <xsl:value-of select="concat($searchCommand,'?')"/>
                               <xsl:value-of select="concat('searchType=',$searchType,'&amp;')"/>
			       <xsl:value-of select="concat('searchId=',$searchId,'&amp;')"/>
			       <xsl:value-of select="concat('maxResultsPerPage=',$maxResultsPerPage,'&amp;')"/>
			       <xsl:value-of select="concat('recCount=',$recCount,'&amp;')"/>
			       <xsl:value-of select="concat('recPointer=',$recPointer,'&amp;')"/>
			       <xsl:value-of select="concat('resultPointer=',$resultPointer)"/>
			    </xsl:attribute>
		        <xsl:value-of select="sear:headingText"/>
			</a>
		    </xsl:otherwise> 
		</xsl:choose>   
            </td>
            <td>
            <div class="{$classPosition}">
               <div class="resultListTextCell">
                  <div class="resultHeading">
                     <div class="resultType">
                      <div class="resultTypeLabel">
                        <label><xsl:value-of select="$Configs/pageConfigs/authorityRecords/labels/label[@id='headingType']"/></label>
                      </div>

                      <div class="resultTypeValue">
                        <span><xsl:value-of select="sear:headingType"/>&#160;</span>
                      </div>
                    </div>
                    <!-- 
                    <div class="resultTitle">
                      <div class="resultTitleLabel">
                        <label><xsl:value-of select="$Configs/pageConfigs/authorityRecords/labels/label[@id='headingText']"/></label>
                      </div>
                      <div class="resultTitleValue">
                        <span><xsl:value-of select="sear:headingText"/>&#160;</span>
                      </div>
                    </div>
                     -->
                    <!--
                    <div class="resultTitle">
                      <div class="resultTitleLabel"><label><xsl:value-of select="$Configs/pageConfigs/authorityRecords/labels/label[@id='headingCount']"/></label></div>
                      <div class="resultTitleValue"><span><xsl:value-of select="sear:headingCount"/>&#160;</span></div>
                    </div>
                    -->
                  </div>
                  
                  <!-- ## References ## -->
                  <xsl:variable name="indexCode" select="sear:indexCode"/>
                  <xsl:for-each select="sear:references">
                     <xsl:call-template name="doScopeNote"/>
                     <xsl:call-template name="doAuthRecordRefs">
                        <xsl:with-param name="headingId" select="$headingId"/>
                     </xsl:call-template>                   
                     <xsl:call-template name="doAuthCrossRef">
                        <xsl:with-param name="idxCode" select="$indexCode"/>
                     </xsl:call-template>
                  </xsl:for-each>
                  
                  
               </div>
            </div>
            </td>
            </tr>
       </xsl:for-each>
       </table>
       </div>
    </xsl:for-each>

</xsl:template>

<xsl:template name="doAuthRecordRefs">
<xsl:param name="headingId"/>
   <!-- ## Authority Records ## -->
   <xsl:for-each select="sear:authorityRecords">
      <div class="resultAuthorityRecords">
                          <div class="resultTitle">
                      <div class="resultTitleLabel">
                        <label>Authorized Heading</label>
                      </div>
                      
                    </div><br/>

         <div class="resultAuthorityRecord">
         <span class="referenceTypeCode"><i>Select a Link to View the Authority Record</i></span>
            <xsl:for-each select="sear:authorities/sear:authority">
               <div class="resultAuthority">
                  <xsl:variable name="refTypeCode" select="sear:referenceTypeCode"/>
                  <xsl:variable name="searchID" select="//page:element[@nameId='searchId']/page:value"/>
                  <span class="referenceTypeCode"><xsl:value-of select="$Configs/pageConfigs/authorityRecords/labels/label[@id=$refTypeCode]"/></span>
		  <!--
                  <span class="headingText"><a href="authorityInfo?searchId={$searchID}&amp;authId={sear:authorityId}&amp;headingId={$headingId}"><xsl:value-of select="sear:headingText"/></a></span>
		  -->
		  <span class="headingText"><a href="staffViewAuthority?searchId={$searchID}&amp;authId={sear:authorityId}&amp;headingId={$headingId}"><xsl:value-of select="sear:headingText"/></a></span>
               </div>
            </xsl:for-each>
         </div>
      </div>
   </xsl:for-each>
</xsl:template>

<xsl:template name="doScopeNote">
   <!-- ## Scope Notes ## -->
   <xsl:for-each select="sear:scopeNotes">
      <div class="resultReferance">
         <div id="scopenotes" class="resultTitleLabel">
            <label><xsl:value-of select="$Configs/pageConfigs/authorityRecords/labels/label[@id='scopeNote']"/></label>
         </div>
         <xsl:for-each select="sear:scopeNote">
         
            <div class="resultReferanceValue">
               <span><xsl:value-of select="sear:data"/></span>
            </div>
         </xsl:for-each>
   
      </div>
   </xsl:for-each>
</xsl:template>

<xsl:template name="doAuthCrossRef">
<xsl:param name="idxCode"/>
<!-- ## Cross-Reference Searches ## -->


   <xsl:variable name="crossRefs">
   <xsl:for-each select="sear:referenceRecords">
      <div class="resultReferanceRecords">
      <span class="referenceTypeCode"><i>Select a Link to search the reference as a <xsl:value-of select="$Configs/pageConfigs/authorityRecords/crossRefSearchCodes/searchIndex[@code=$idxCode]/@desc"/></i></span>
         <div class="resultReferanceRecord">
            <xsl:for-each select="sear:references/sear:reference">
               <xsl:variable name="subdivisionCode" select="sear:subdivisionCode"/>
               <div class="resultReferance">
                  <span class="subdivisionCode"><xsl:value-of select="$Configs/pageConfigs/authorityRecords/subdivisionCodeMap/subdivisionCode[@code=$subdivisionCode]"/>:   </span>
                 <xsl:call-template name="doCrossReferenceDescription"/>
               </div>
            </xsl:for-each>
         </div>
      </div>
   </xsl:for-each>
   </xsl:variable>

   <xsl:if test="string-length($crossRefs)">
      <div class="resultTitle">
         <div class="resultTitleLabel">
            <label>Cross References</label>
         </div>
      </div>
      <br/>
      <xsl:copy-of select="$crossRefs"/>
   </xsl:if>
    
</xsl:template>
    
<xsl:template name="doCrossReferenceDescription">
    
   <span class="crossReferenceDescription">
      <xsl:variable name="indexType" select="sear:indexType"/>
      <xsl:variable name="searchCode" select="$Configs/pageConfigs/authorityRecords/crossRefSearchCodes/searchIndex[@code=$indexType]"/>
      <xsl:variable name="searchURL">search?searchArg=<xsl:value-of select="sear:crossReferenceDescription"/>&amp;searchCode=<xsl:value-of select="$searchCode"/>&amp;searchType=1</xsl:variable>
      <xsl:variable name="crossReferenceDescription" select="sear:crossReferenceDescription"/>
      <a href="{$searchURL}" title="CrossRef Search for {$crossReferenceDescription}"><xsl:value-of select="$crossReferenceDescription"/></a>
   </span>


</xsl:template>


<xsl:template name="buildResultsHeadingsList">

    
    <xsl:for-each select="page:element[@nameId='headings']">
        <div id="resultListAuth">
        <xsl:for-each select="page:option">

            <!-- ## variable used for alternating color ## -->
            <xsl:variable name="classPosition">
                <xsl:choose>
                    <xsl:when test="(position() mod 2) = 0">evenRow</xsl:when>
                    <xsl:otherwise>oddRow</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <!-- ## headings result record ## -->
            <div class="{$classPosition}">


                <!-- ## link & text ## -->
                <div class="resultListTextCell">

                    <!-- ## headings results heading ## -->
                    <div class="resultHeading">
                        <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.heading.link']">
                            <a href="{page:URL}">
                                <xsl:value-of select="page:linkText"/>
                            </a>
                        </xsl:for-each>
                        <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.heading.label']">
                            <label><xsl:value-of select="page:label"/><xsl:value-of select="page:value"/></label>
                        </xsl:for-each>

                        <!-- ## headings results title data ## -->
                        <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.title']">
                            <div class="resultTitle">
                                <div class="resultTitleLabel"><label><xsl:value-of select="page:label"/></label></div>
                                <div class="resultTitleValue"><span><xsl:value-of select="page:value"/></span></div>
                            </div>
                        </xsl:for-each>

                        <!-- ## headings results title data ## -->
                        <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.type']">
                            <div class="resultType">
                                <div class="resultTypeLabel"><label><xsl:value-of select="page:label"/></label></div>
                                <div class="resultTypeValue"><span><xsl:value-of select="page:value"/></span></div>
                            </div>
                        </xsl:for-each>
                    </div>

                    <!-- ## headings results referance info ## -->
                    <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.authority']">
                        <div class="resultAuthority">
                            <xsl:for-each select="page:element[@nameId='page.searchResults.authority.label']">
                                <div class="resultAuthorityLabel"><label><xsl:value-of select="page:label"/></label></div>
                            </xsl:for-each>
                            <xsl:for-each select="page:element[@nameId='page.searchResults.authority.link']">
                                <div class="resultAuthorityLink">
                                    <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.note']">
                        <div class="resultReferance">
                            <div class="resultReferanceLabel"><label><xsl:value-of select="page:label"/></label></div>
                            <div class="resultReferanceValue"><span><xsl:value-of select="page:value"/></span></div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.reference']">
                        <div class="resultReferance">
                            <xsl:for-each select="page:element[@nameId='page.searchResults.reference.label']">
                                <div class="resultReferanceLabel"><label><xsl:value-of select="page:label"/></label></div>
                            </xsl:for-each>
                            <xsl:for-each select="page:element[@nameId='page.searchResults.reference.link']">
                                <div class="resultReferanceLink">
                                    <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:for-each>
                    <!-- ## headings results referance info ## -->

                </div>
                <!-- ## link & text ## -->

            </div>
            <!-- ## headings result record ## -->

        </xsl:for-each>
	</div>
    </xsl:for-each>
</xsl:template>


</xsl:stylesheet>


