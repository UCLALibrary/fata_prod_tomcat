<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.6.2.1 $ $Date: 2012/06/11 22:17:13 $ -->
<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc. 
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: displayRecord
**          Version : 7.2.0
**          Created : 11-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 18-AUG-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet
	version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<!-- External imports -->
	<xsl:include href="./common/stdImports.xsl"/>
	
	<!-- Specific Imports -->
	<xsl:include href="./contentLayout/cl_displayRecord.xsl"/>
	<xsl:include href="./contentLayout/display/display.xsl"/>
	<xsl:include href="./pageFacets/displayFacets.xsl"/>
	<xsl:include href="./pageFacets/resultsFacets.xsl"/>
	
	<!-- Variable Declarations -->
	<xsl:variable name="currPage">displayRecord</xsl:variable>
	<xsl:variable name="recordTypeRecord" select="//hol:bibRecord"/>
	<xsl:variable name="displayRecordCSS">
		<link href="{$css-loc}resultsFacets.css" media="all" type="text/css" rel="stylesheet"/>
		<link href="{$css-loc}displayCommon.css" media="all" type="text/css" rel="stylesheet"/>
		<link href="{$css-loc}highlight.css"     media="all" type="text/css" rel="stylesheet"/>		
	</xsl:variable>
	
	<!-- ######################### -->
	<!-- ## begin Main Template ## -->
	<!-- ######################################################### -->
	
	<xsl:template match="/">
		<xsl:call-template name="buildHtmlPage">
			<xsl:with-param name="myCSS" select="$displayRecordCSS"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- ################## -->
	<!-- ## buildContent ## -->
	<!-- ######################################################### -->
	
	<xsl:template name="buildContent">
		<xsl:call-template name="buildRecordForm"/>
	</xsl:template>
	
	<!-- ######################################################### -->
	
</xsl:stylesheet>


