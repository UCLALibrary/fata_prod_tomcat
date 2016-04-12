<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.4 $ $Date: 2012/06/09 00:27:50 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: myAccount
**          Version : 7.2.0
**          Created : 06-AUG-2007
**      Orig Author : David Sellers
**    Last Modified : 18-AUG-2009 
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0" 
   exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<!-- External imports -->
	<xsl:include href="./common/stdImports.xsl"/>
	
	<!-- Specific Imports -->
	<xsl:include href="./contentLayout/cl_myAccount.xsl"/>
	<xsl:include href="./pageFacets/myAccountLinks.xsl"/>
	
	<!-- Variable Declarations -->
	<xsl:variable name="currPage">myAccount</xsl:variable>
	<xsl:variable name="myAccountCSS">
		<link href="{$css-loc}myAccount.css" media="all" type="text/css" rel="stylesheet"/>
	</xsl:variable>
	
	<!-- ######################### -->
	<!-- ## begin Main Template ## -->
	<!-- ######################################################### -->
	
	<xsl:template match="/">
		<xsl:call-template name="buildHtmlPage">
			<xsl:with-param name="myCSS" select="$myAccountCSS"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- ################## -->
	<!-- ## buildContent ## -->
	<!-- ######################################################### -->

	<xsl:template name="buildContent">
		<xsl:call-template name="buildMyAccountForm"/>
	</xsl:template>

	<!-- ######################################################### -->
</xsl:stylesheet>


