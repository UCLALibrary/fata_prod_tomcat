<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.8 $ $Date: 2013/07/23 22:22:20 $ -->
<!-- 
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: constants
**          Version : 7.2.0
**          Created : 06-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<!--
   This file gets import/included in the stdImports.xsl
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!--
	## A Place to put Constants used in the interface ##
-->
   <xsl:variable name="skinPath"><xsl:value-of select="/page:page/page:skinPath"/></xsl:variable>
	
	<!-- ## This is where we will put cascading style sheets ## -->
	<xsl:variable name="css-loc"><xsl:value-of select="$skinPath"/>/css/</xsl:variable>
	
	<!-- ## This is where we will put help files doc is in URL already ## -->
	<xsl:variable name="help-loc"><xsl:value-of select="$skinPath"/>/htdocs</xsl:variable>

	<!-- ## This is where we will pull images from ## -->
	<xsl:variable name="image-loc"><xsl:value-of select="$skinPath"/>/images/</xsl:variable>

	<!-- ## This is where we will pull Bibliographic images from ## -->
	<xsl:variable name="imageBibFormat-loc"><xsl:value-of select="$skinPath"/>/images/bibFormat/</xsl:variable>

	<!-- ## This is where we keep our external javascripts ## -->
	<xsl:variable name="jscript-loc"><xsl:value-of select="$skinPath"/>/jscripts/</xsl:variable>
	
	<!-- ## This is where we will configure the time format used on the Media Scheduling 
	     ## request forms as well as the Media Request Confirmation Page
	     ## Set the value to 12 or 24
	     ## 12   :  12 Hour format, uses AM / PM
	     ## 24   :  24 Hour format
	     ## any other value will default to 24 hour format
	-->
	<xsl:variable name="timeFormat" select="'24'"/>
	
	<!-- ## The server send the backToRecord link in different elements depending on where it came from ## -->
	<xsl:variable name="backToRecord">
      <div id="backToRecord">
         <xsl:call-template name="buildLinkType">
            <xsl:with-param name="eleName" select="'page.patronRequest.actions.returnToRequests.link'"/>
         </xsl:call-template>
         <xsl:call-template name="buildLinkType">
            <xsl:with-param name="eleName" select="'page.patronRequests.actions.returnToRequests.link'"/>
         </xsl:call-template>
         <xsl:call-template name="buildLinkType">
            <xsl:with-param name="eleName" select="'page.patronRequest.actions.returnToHoldings.link'"/>
         </xsl:call-template>
         <xsl:call-template name="buildLinkType">
            <xsl:with-param name="eleName" select="'page.patronRequests.actions.returnToHoldings.link'"/>
         </xsl:call-template>
      </div>
   </xsl:variable>
<!-- ############################################################ -->

</xsl:stylesheet>


