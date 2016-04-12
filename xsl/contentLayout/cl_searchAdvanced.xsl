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
**          Product : WebVoyage :: cl_searchAdvanced
**          Version : 7.2.0
**          Created : 25-July-2007
**      Orig Author : Jack Peiser
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

 <!-- ##################### -->
 <!-- ## buildSearchForm ## -->
 <!-- ################################################################################ -->

<xsl:template name="buildAdvancedSearch">

   <!-- search advanced form - begin -->
   <div id="buildAdvancedSearch">

      <!-- ## Build the search Args ## -->
      <xsl:call-template name="advSearchArgs"/>

      <!-- year label, radio button & selection box -->
      <xsl:for-each select="/page:page//page:element[@nameId='yearOption']">

         <div class="searchAdvancedInputs">
            <label for="yearSpan"><xsl:value-of select="/page:page//page:element[@nameId='page.search.advanced.year.selection.label']/page:label" /></label>
            <span id="yearSpan">
               <xsl:call-template name="buildSingleRadio">
                  <xsl:with-param name="eleName"    select="'yearOption'"/>
                  <xsl:with-param name="idOverride" select="'defined'"/>
                  <xsl:with-param name="optName"    select="'defined'"/>
                  <xsl:with-param name="cssClass"   select="'searchAdvancedYearMargin'"/>
               </xsl:call-template>
                  <xsl:call-template name="buildFormDropDown">
                  <xsl:with-param name="eleName"  select="'year'"/>
                  <xsl:with-param name="cssClass"  select="'searchAdvancedToMargin'"/>
               </xsl:call-template>
            </span>
         </div>

         <div class="searchAdvancedInputs">
            <xsl:call-template name="buildSingleRadio">
               <xsl:with-param name="eleName"    select="'yearOption'"/>
               <xsl:with-param name="idOverride" select="'range'"/>
               <xsl:with-param name="optName"    select="'range'"/>
               <xsl:with-param name="cssClass"   select="'searchAdvancedBlankMargin'"/>
            </xsl:call-template>
            <xsl:call-template name="buildFormInput">
               <xsl:with-param name="eleName" select="'fromYear'"/>
               <xsl:with-param name="size"  select="'7'"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedToMargin'"/>
               </xsl:call-template>
            <xsl:call-template name="buildFormInput">
               <xsl:with-param name="eleName"  select="'toYear'"/>
               <xsl:with-param name="size"  select="'7'"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedToMargin'"/>
            </xsl:call-template>
         </div>

      </xsl:for-each>


      <!-- location line -->
      <xsl:for-each select="/page:page//page:element[@nameId='location']">
         <div class="limitDiv">
            <xsl:call-template name="buildFormDropDown">
               <xsl:with-param name="eleName"  select="'location'"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedLocationMargin'"/>
            </xsl:call-template>
         </div>
        </xsl:for-each>

      <!-- place line -->
      <xsl:for-each select="/page:page//page:element[@nameId='place']">
         <div class="limitDiv">
            <xsl:call-template name="buildLimitSetDropDown">
               <xsl:with-param name="limitType"  select="'place'"/>
               <xsl:with-param name="selectedLimit"  select="''"/>
               <xsl:with-param name="limitData"  select="$Limits"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedPlaceMargin'"/>
            </xsl:call-template>
         </div>
      </xsl:for-each>

      <!-- material type line 
      <xsl:for-each select="/page:page//page:element[@nameId='type']">
         <div class="limitDiv">
            <xsl:call-template name="buildLimitSetDropDown">
               <xsl:with-param name="limitType"  select="'type'"/>
               <xsl:with-param name="selectedLimit"  select="''"/>
               <xsl:with-param name="limitData"  select="$Limits"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedMaterialMargin'"/>
            </xsl:call-template>
         </div>
      </xsl:for-each>-->

      <!-- ## Status ## 
      <xsl:for-each select="/page:page//page:element[@nameId='status']">
         <div class="limitDiv">
            <xsl:call-template name="buildLimitSetDropDown">
               <xsl:with-param name="limitType"  select="'status'"/>
               <xsl:with-param name="selectedLimit"  select="''"/>
               <xsl:with-param name="limitData"  select="$Limits"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedStatusMargin'"/>
            </xsl:call-template>
         </div>
      </xsl:for-each>-->

      <!-- format line 
      <xsl:for-each select="/page:page//page:element[@nameId='medium']">
         <div class="limitDiv">
            <xsl:call-template name="buildLimitSetDropDown">
               <xsl:with-param name="limitType"  select="'medium'"/>
               <xsl:with-param name="selectedLimit"  select="''"/>
               <xsl:with-param name="limitData"  select="$Limits"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedFormatMargin'"/>
            </xsl:call-template>
         </div>
      </xsl:for-each>-->

      <!-- language line -->
      <xsl:for-each select="/page:page//page:element[@nameId='language']">
         <div class="limitDiv">
            <xsl:call-template name="buildLimitSetDropDown">
               <xsl:with-param name="limitType"  select="'language'"/>
               <xsl:with-param name="limitData"  select="$Limits"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedLanguageMargin'"/>
            </xsl:call-template>
         </div>
      </xsl:for-each>

      <!-- RDA Types 
      <xsl:for-each select="/page:page//page:element[@nameId='content']">
         <div class="limitDiv">
            <xsl:call-template name="buildLimitSetDropDown">
               <xsl:with-param name="limitType"  select="'content'"/>
               <xsl:with-param name="limitData"  select="$Limits"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedContentMargin'"/>
            </xsl:call-template>
         </div>
      </xsl:for-each>
      <xsl:for-each select="/page:page//page:element[@nameId='media']">
         <div class="limitDiv">
            <xsl:call-template name="buildLimitSetDropDown">
               <xsl:with-param name="limitType"  select="'media'"/>
               <xsl:with-param name="limitData"  select="$Limits"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedMediaMargin'"/>
            </xsl:call-template>
         </div>
      </xsl:for-each>
      <xsl:for-each select="/page:page//page:element[@nameId='carrier']">
         <div class="limitDiv">
            <xsl:call-template name="buildLimitSetDropDown">
               <xsl:with-param name="limitType"  select="'carrier'"/>
               <xsl:with-param name="limitData"  select="$Limits"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedCarrierMargin'"/>
            </xsl:call-template>
         </div>
      </xsl:for-each>-->

      <xsl:call-template name="buildSearchButtons"/>

   </div>
   <!-- search advanced form - end -->
</xsl:template>

 <!-- ################################################################################ -->

<xsl:template name="advSearchArgs">


   <xsl:variable name="label">
      <label for='searchArg1'><xsl:value-of select="/page:page//page:element[@nameId='page.search.advanced.search.label']/page:label"/></label>
   </xsl:variable>

   <xsl:for-each select="/page:page//page:element[@nameId='page.search.advanced.searchArgument.group']">

       <xsl:variable name="accessKey">
         <xsl:choose>
            <xsl:when test="position()=1">s</xsl:when>
            <xsl:otherwise></xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="Margin">
         <xsl:choose>
            <xsl:when test="position()=1">searchAdvancedSearchMargin</xsl:when>
            <xsl:otherwise>searchAdvancedBlankMargin</xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="string-length(page:element[contains(@nameId,'combine')]/@nameId)">
         <div class="searchAdvancedInputs">
            <span class="argument">
               <xsl:call-template name="buildFormDropDown">
                  <xsl:with-param name="eleName"  select="page:element[contains(@nameId,'combine')]/@nameId"/>
                  <xsl:with-param name="cssClass"  select="'searchAdvancedBlankMargin'"/>
               </xsl:call-template>
            </span>
         </div>
      </xsl:if>
      <div class="searchAdvancedInputs">
         <xsl:if test="position()=1"><xsl:copy-of select="$label"/></xsl:if>
         <span class="argument">
            <xsl:call-template name="buildFormInput">
               <xsl:with-param name="eleName"  select="page:element[contains(@nameId,'searchArg')]/@nameId"/>
               <xsl:with-param name="size"  select="'50'"/>
               <xsl:with-param name="accesskey"  select="$accessKey"/>
               <xsl:with-param name="cssClass"  select="$Margin"/>
            </xsl:call-template>
         </span>

         <span class="argument">
            <xsl:call-template name="buildFormDropDown">
               <xsl:with-param name="eleName"  select="page:element[contains(@nameId,'argType')]/@nameId"/>
               <xsl:with-param name="cssClass"  select="'searchAdvancedCriteriaMargin'"/>
            </xsl:call-template>
         </span>

         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="page:element[contains(@nameId,'searchCode')]/@nameId"/>
            <xsl:with-param name="cssClass"  select="'searchAdvancedWithinMargin'"/>
         </xsl:call-template>

      </div>
   </xsl:for-each>

</xsl:template>

 <!-- ################################################################################ -->

</xsl:stylesheet>


