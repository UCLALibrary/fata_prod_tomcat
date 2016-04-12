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
**          Product : WebVoyage :: getAvailRequests
**          Version : 7.2.0
**          Created : 07-NOV-2007
**      Orig Author : Mel Pemble
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
<xsl:include href="./contentLayout/cl_getAvailRequests.xsl"/>

<!-- Variable Declarations -->
<xsl:variable name="currPage">getAvailRequests</xsl:variable>
<xsl:variable name="getAvailRequestsCSS">
	<link href="{$css-loc}getAvailRequests.css" media="all" type="text/css" rel="stylesheet"/>
</xsl:variable>

<!-- ######################### -->
<!-- ## begin Main Template ## -->
<!-- ######################################################### -->

<xsl:template match="/">
	<xsl:call-template name="buildHtmlPage">
		<xsl:with-param name="myCSS"  select="$getAvailRequestsCSS"/>
	</xsl:call-template>		
</xsl:template>

<!-- ################## -->
<!-- ## buildContent ## -->
<!-- ######################################################### -->

<xsl:template name="buildContent">
	<xsl:call-template name="buildGetAvailRequestsForm"/>
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>


