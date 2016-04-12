<!-- $Revision: 1.4 $ $Date: 2012/06/11 14:46:57 $ -->
<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: geosearchFacets
**          Version : 7.2.0
**          Created : 20-NOV-2007
**      Orig Author : Mel Pemble
**    Last Modified : 21-AUG-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page xsi"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:xsi="http://www.exlibrisgroup.com/voyager/WebVoyage/xsi"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ##################### -->
<!-- ## buildGeoNavTabs ## -->
<!-- ######################################################### -->

<xsl:template name="buildGeoNavTabs">
<xsl:param name="selectedTab"/>
   
   <a name="geoNav"></a>
	<div id="geoNav">
		<h2 class="nav">Geospatial Search Tab Navigation Bar</h2>
		<ul class="navbar" title="Geospatial Search Tab Navigation Bar">

			<xsl:for-each select="$Configs/pageConfigs/geosearchTabDisplayOrder/tab">
				<xsl:variable name="tabName" select="@name"/>
				<xsl:for-each select="$pageBodyXML//page:element[@nameId='map.search.buttons']/page:button[@nameId=$tabName]">
					<xsl:variable name="tabOn">
						<xsl:choose>
							<xsl:when test="$selectedTab = ./@nameId">on</xsl:when>
							<xsl:otherwise>off</xsl:otherwise>		
						</xsl:choose>
					</xsl:variable>
					<li id="{$tabOn}"><a href="{page:buttonAction}" name="{./@nameId}"><span><xsl:value-of select="page:buttonText"/></span></a></li>
				</xsl:for-each>	
			</xsl:for-each>		
		</ul>
	</div> 

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoSearchBar">
<xsl:call-template name="buildGeoLimitsLogic"/>

   <div id="geoSearchBar">
      <div id="geosearchBarTop">
      
         <xsl:call-template name="buildGeoFormatType"/>
         
         <div id="geoFormatSize">
            <xsl:call-template name="buildFormDropDown">
               <xsl:with-param name="eleName"  select="'footPrint'"/>
            </xsl:call-template>
         </div>

         <div id="geosearchRecs">
            <xsl:call-template name="buildFormDropDown">
               <xsl:with-param name="eleName"  select="'recCount'"/>
            </xsl:call-template>
         </div>
  
         <div id="searchBarTopEmpty">&#160;</div>
      </div>
      
      <div id="geosearchBarBottom">
   
         <div id="geoSearchSubmit">
            <!-- ## Search Type Input ## -->
            <xsl:for-each select="/page:page//page:element[@nameId='searchType']">
         		<input type="hidden">
         			<xsl:attribute name="name"><xsl:value-of select="@nameId"/></xsl:attribute>
         			<xsl:attribute name="value"><xsl:value-of select="page:value"/></xsl:attribute>
         		</input>
            </xsl:for-each>   
            <label for="submit"></label><input id="submit" class="submit" value="Search Map" type="submit"/>
            <!--
            <label for="reset"></label><input value="Reset Map" type="reset" class="reset" id="reset"/>
            -->
         </div>
      </div>
      
   </div>
                     
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoFormatType">

   <xsl:variable name="mapServletName">
      '<xsl:choose>
         <xsl:when test="/page:page[@nameId='page.map.rectangleSearch']">rectangleSearch</xsl:when>
         <xsl:when test="/page:page[@nameId='page.map.rangeSearch']">rangeSearch</xsl:when>
         <xsl:when test="/page:page[@nameId='page.map.corridorSearch']">corridorSearch</xsl:when>
         <xsl:when test="/page:page[@nameId='page.map.polygonSearch']">polygonSearch</xsl:when>
         <xsl:when test="/page:page[@nameId='page.map.radiusSearch']">radiusSearch</xsl:when>   
      </xsl:choose>'
   </xsl:variable>
   
   <xsl:variable name="switchFormat">switchMapFormat('<xsl:value-of select="//page:element[@nameId='mapFormat']/page:option[@selected='true']/page:value"/>',<xsl:value-of select="$mapServletName"/>)</xsl:variable>
   
   <div id="geoFormatType">
      <xsl:call-template name="buildFormDropDown">
         <xsl:with-param name="eleName"  select="'mapFormat'"/>
         <xsl:with-param name="onChangeCallJSFunction"  select="$switchFormat"/>
      </xsl:call-template>
   </div>
   
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoDisplayLogic">

   <xsl:if test="/page:page[@nameId='page.map.corridorSearch']">
      <fieldset class="radius">
         <legend><xsl:value-of select="//page:element[@nameId='map.search.radius.group']/page:label"/></legend>
          <xsl:for-each select="//page:element[@nameId='map.search.radius.group']">
            <label for="{@nameId}"><xsl:value-of select="page:label"/></label>
            <xsl:call-template name="buildSingleInput">
               <xsl:with-param name="eleName" select="'radius'"/>
            </xsl:call-template>
            <xsl:call-template name="buildSelectionSetDropDown">
               <xsl:with-param name="selName" select="'unit'"/>
            </xsl:call-template>
          </xsl:for-each>
      </fieldset>
   </xsl:if>
                  
   <div id="displayFields">
      <xsl:for-each select="//page:element[@nameId='map.search.group']">
         <xsl:for-each select="page:element">
            <fieldset>
               <legend><xsl:value-of select="page:label"/></legend>
               <xsl:for-each select="page:element">
                  <label for="{@nameId}"><xsl:value-of select="page:label"/></label>
                  <input type="text" name="{@nameId}" id="{@nameId}" value="{page:value}"/>
               </xsl:for-each>
            </fieldset>
         </xsl:for-each>
         
      </xsl:for-each>
   </div>
   
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoRadiusDisplayLogic">

   <fieldset class="radius">
      <legend><xsl:value-of select="//page:element[@nameId='map.search.pointRadius.page.label']/page:label"/></legend>
      <xsl:for-each select="//page:element[@nameId='map.search.group']">
         <xsl:for-each select="page:element">
            <label for="{@nameId}"><xsl:value-of select="page:label"/></label>
            <input type="text" name="{@nameId}" id="{@nameId}" value="{page:value}"/>
         </xsl:for-each>
       </xsl:for-each>
       <xsl:for-each select="//page:element[@nameId='map.search.radius.group']">
         <label for="{@nameId}"><xsl:value-of select="page:label"/></label>
         <xsl:call-template name="buildSingleInput">
            <xsl:with-param name="eleName" select="'radius'"/>
         </xsl:call-template>
         <xsl:call-template name="buildSelectionSetDropDown">
            <xsl:with-param name="selName" select="'unit'"/>
         </xsl:call-template>
       </xsl:for-each>
   </fieldset>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoLimitsLogic">

   <xsl:for-each select="//page:element[@nameId='map.search.limit']">
           
      <div id="mapLimits">
      <p><span id="toggleLimits" onclick="showhide('mainLimitGroup');">Toggle Limits</span></p>
         <fieldset id="mainLimitGroup" style="display: none;">
            <legend><xsl:value-of select="page:label"/></legend>
            <div class="limitGroup"><xsl:call-template name="buildGeoLimitsScaleLogic"/></div>
            <div class="limitGroup"><xsl:call-template name="buildGeoLimitsProjectionLogic"/></div>
            <div class="limitGroup"><xsl:call-template name="buildGeoLimitsDatesLogic"/></div>
            <div class="limitGroup"><xsl:call-template name="buildGeoLimitsControlledLogic"/></div>
            <div class="limitGroup"><xsl:call-template name="buildGeoLimitsClassificationLogic"/></div>
         </fieldset>
      </div>
           
   </xsl:for-each>
  
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoLimitsScaleLogic">
   <xsl:for-each select="page:element[@nameId='map.search.limit.scaleDenominator']">

      <div class="limitFieldLabel">
         <xsl:value-of select="page:label"/>
      </div>
      <div class="limitFieldData">
         <xsl:call-template name="buildFormInput">
            <xsl:with-param name="eleName"  select="'scale'"/>
            <xsl:with-param name="size"  select="'10'"/>
         </xsl:call-template>
         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="'scaleComparison'"/>
         </xsl:call-template>
         <xsl:call-template name="buildFormInput">
            <xsl:with-param name="eleName"  select="'scaleRange'"/>
            <xsl:with-param name="size"  select="'15'"/>
         </xsl:call-template>
      </div>

   </xsl:for-each>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoLimitsProjectionLogic">
   <xsl:for-each select="page:element[@nameId='map.search.limit.projection']">

      <div class="limitFieldLabel">
         <xsl:value-of select="page:label"/>
      </div>
      <div class="limitFieldData">
         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="'projection'"/>
            <xsl:with-param name="size"  select="'10'"/>
            <xsl:with-param name="multiple"  select="'true'"/>
         </xsl:call-template>
      </div>

   </xsl:for-each>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoLimitsDatesLogic">
   <xsl:for-each select="page:element[@nameId='map.search.limit.mapDates']">
      <div class="limitFieldLabel">
         <xsl:value-of select="page:label"/>
      </div>
      <div class="limitFieldData">
         <div class="mapDates">
            <div class="mapDateComponent">
               <xsl:call-template name="buildFormDropDown">
                  <xsl:with-param name="eleName"  select="'dates'"/>
                  <xsl:with-param name="size"  select="'4'"/>
                  <xsl:with-param name="multiple"  select="'true'"/>
               </xsl:call-template>
            </div>
            <div class="mapDateComponent">
               <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName"  select="'mapDate'"/>
                  <xsl:with-param name="size"  select="'10'"/>
               </xsl:call-template>
               <xsl:call-template name="buildFormDropDown">
                  <xsl:with-param name="eleName"  select="'dateComparison'"/>
               </xsl:call-template>
               <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName"  select="'dateRange'"/>
                  <xsl:with-param name="size"  select="'15'"/>
               </xsl:call-template> 
            </div>
            <div class="mapDateComponent">
               <xsl:call-template name="buildFormDropDown">
                  <xsl:with-param name="eleName"  select="'dateType'"/>
                  <xsl:with-param name="optGroupLabel"  select="page:element[@nameId='map.search.limit.dateType']/page:label"/>
                  <xsl:with-param name="size"  select="'4'"/>
                  <xsl:with-param name="multiple"  select="'true'"/>
               </xsl:call-template>
            </div>
         </div>
      </div>
   </xsl:for-each>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoLimitsControlledLogic">
   <xsl:for-each select="page:element[@nameId='map.search.limit.controlledElement']">
      <div class="limitFieldLabel">
         <xsl:value-of select="page:label"/>&#160;
      </div>
      <div class="limitFieldData">
         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="'controlledElement'"/>
            <xsl:with-param name="optGroupLabel"  select="'Controlled Element:'"/>
            <xsl:with-param name="size"  select="'3'"/>
            <xsl:with-param name="multiple"  select="'true'"/>
         </xsl:call-template>
      </div>
   </xsl:for-each>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildGeoLimitsClassificationLogic">
   <xsl:for-each select="page:element[@nameId='map.search.limit.classification.selected']">
      <div class="limitFieldLabel">
         <xsl:value-of select="page:label"/>
      </div>
      <div class="limitFieldData">
         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="'docClass'"/>
            <xsl:with-param name="optGroupLabel"  select="page:element[@nameId='map.search.limit.docClass']/page:label"/>
            <xsl:with-param name="size"  select="'6'"/>
            <xsl:with-param name="multiple"  select="'true'"/>
         </xsl:call-template>
         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="'docRelease'"/>
            <xsl:with-param name="optGroupLabel"  select="page:element[@nameId='map.search.limit.docRelease']/page:label"/>
            <xsl:with-param name="size"  select="'6'"/>
            <xsl:with-param name="multiple"  select="'true'"/>
         </xsl:call-template>
         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="'reproType'"/>
            <xsl:with-param name="optGroupLabel"  select="page:element[@nameId='map.search.limit.reproType']/page:label"/>
            <xsl:with-param name="size"  select="'6'"/>
            <xsl:with-param name="multiple"  select="'true'"/>
         </xsl:call-template>
      </div>
   </xsl:for-each>
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>



