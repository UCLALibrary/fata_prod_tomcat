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
**          Product : WebVoyage :: Personal Info
**          Version : 7.2.0
**          Created : 29-AUG-2007
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
	<xsl:include href="./contentLayout/cl_personalInfo.xsl"/>
	<xsl:include href="./pageFacets/myAccountLinks.xsl"/>

	<!-- Variable Declarations -->
	<xsl:variable name="currPage">Personal Info</xsl:variable>
	<xsl:variable name="personalInfoCSS">
	   <link href="{$css-loc}personalInfo.css" media="all" type="text/css" rel="stylesheet"/>
	</xsl:variable>

	<!-- ######################### -->
	<!-- ## begin Main Template ## -->
	<!-- ######################################################### -->

	<xsl:template match="/">
		<xsl:call-template name="buildHtmlPage">
			<xsl:with-param name="myCSS" select="$personalInfoCSS"/>
		</xsl:call-template>
	</xsl:template>

	<!-- ################## -->
	<!-- ## buildContent ## -->
	<!-- ######################################################### -->

	<xsl:template name="buildContent">
	    <xsl:choose>
	         <xsl:when test="//page:element[@nameId='smsNumber']">
		          <form action="{/page:page//page:element[@nameId='page.myAccount.viewPersonalInfo.smsNumber.save.button']/page:buttonAction}" method="GET" accept-charset="UTF-8"  name="saveSMSNumber">
		               <xsl:call-template name="buildPersonalInfo">
			                 <!--xsl:with-param name="eleName" select="$eleAvail"/-->
		               </xsl:call-template>
		          </form>
	         </xsl:when>
	         <xsl:otherwise>
		          <xsl:call-template name="buildPersonalInfo">
			           <!--xsl:with-param name="eleName" select="$eleAvail"/-->
		          </xsl:call-template>
		     </xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ######################################################### -->
</xsl:stylesheet>


