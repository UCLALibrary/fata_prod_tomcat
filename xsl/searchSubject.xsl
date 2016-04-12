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
**          Product : WebVoyage :: searchSubject
**          Version : 7.2.0
**          Created : 25-JUL-2007
**      Orig Author : Jack Peiser
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

<!-- Page specific imports -->
<xsl:include href="./contentLayout/cl_searchSubject.xsl"/>
<xsl:include href="./pageFacets/searchFacets.xsl"/>

<!-- Variable Declarations -->
<xsl:variable name="currPage">searchSubject</xsl:variable>
<xsl:variable name="searchCSSSubject">
   <link href="{$css-loc}searchPages.css" media="all" type="text/css" rel="stylesheet"/>
   <link href="{$css-loc}searchSubject.css" media="all" type="text/css" rel="stylesheet"/>
</xsl:variable>

<!-- ######################### -->
<!-- ## begin main template ## -->
<!-- ######################################################### -->

<xsl:template match="/">
	<xsl:call-template name="buildHtmlPage">
		<xsl:with-param name="myCSS"  select="$searchCSSSubject"/>
	</xsl:call-template>		
</xsl:template>

<!-- ################## -->
<!-- ## buildContent ## -->
<!-- ######################################################### -->

<xsl:template name="buildContent">
  
   <xsl:variable name="formData">
      <xsl:call-template name="buildSubjectSearch"/>
   </xsl:variable>
   
	<xsl:call-template name="buildTheSearchForm">
		<xsl:with-param name="formName" select="'searchSubject'"/>
		<xsl:with-param name="formData" select="$formData"/>
		<xsl:with-param name="selectedTab" select="'page.search.buttons.subjectHeading.button'"/>
	</xsl:call-template>
	
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>


