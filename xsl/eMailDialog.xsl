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
**          Product : WebVoyage :: emailDialog
**          Version : 7.2.0
**          Created : 25-Oct-2007
**      Orig Author : Scott Morgan
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
	<xsl:include href="./contentLayout/cl_eMailDialog.xsl"/>
	
	<!-- Variable Declarations -->
	<xsl:variable name="currPage">Email Dialog</xsl:variable>
	<xsl:variable name="eMailDialogCSS">
		<link href="{$css-loc}commonForm.css" media="all" type="text/css" rel="stylesheet"/>
	</xsl:variable>
	
	
	<!-- ######################### -->
	<!-- ## begin Main Template ## -->
	<!-- ######################################################### -->
	
	<xsl:template match="/">
		<xsl:call-template name="buildHtmlPage">
			<xsl:with-param name="myCSS" select="$eMailDialogCSS" />
		</xsl:call-template>
	</xsl:template>
	
	<!-- ############### -->
	<!-- ## buildContent ## -->
	<!-- ######################################################### -->
	
	<xsl:template name="buildContent">
		<xsl:call-template name="cl_eMailDialog.eMailDialogForm"/>	
	</xsl:template>
	
</xsl:stylesheet>


