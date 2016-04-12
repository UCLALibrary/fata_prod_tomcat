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
**          Product : WebVoyage :: cl_searchGeoPolygon
**          Version : 7.2.0
**          Created : 20-NOV-2007
**      Orig Author : Mel Pemble
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ##################### -->
<!-- ## buildSearchForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildGeoSearch">

   <div id="geosearchForm">
      <div id="geoForm">
         <xsl:call-template name="buildGeoNavTabs">
            <xsl:with-param name="selectedTab" select="'map.search.buttons.polygonSearch.button'"/>
         </xsl:call-template>
         
         <div id="geoSearchForm">
            <div id="searchParams">
               <xsl:call-template name="buildGeoDisplayLogic"/>
               <xsl:call-template name="buildGeoSearchBar"/>
            </div>
         </div>
      </div>
   </div>
         
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>



