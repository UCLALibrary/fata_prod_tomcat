<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.6 $ $Date: 2012/06/09 00:27:50 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: resultsTitles
**          Version : 7.2.0
**          Created : 15-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 29-SEP-2009
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
<xsl:include href="./contentLayout/cl_resultsTitles.xsl"/>
<xsl:include href="./pageFacets/resultsFacets.xsl"/>

<!-- Variable Declarations -->
<xsl:variable name="currPage">resultsTitles</xsl:variable>
<xsl:variable name="resultsTitlesCSS">
   <link href="{$css-loc}resultsFacets.css" media="all" type="text/css" rel="stylesheet"/>
   <link href="{$css-loc}resultsTitles.css" media="all" type="text/css" rel="stylesheet"/>
   <link href="{$css-loc}highlight.css"     media="all" type="text/css" rel="stylesheet"/>
</xsl:variable>

<xsl:variable name="myJavascripts">
   <script type="text/javascript" src="{$jscript-loc}imageUtils.js"></script>
</xsl:variable>

<!-- ######################### -->
<!-- ## begin Main Template ## -->
<!-- ######################################################### -->

<xsl:template match="/">
    <xsl:call-template name="buildHtmlPage">
        <xsl:with-param name="myCSS"  select="$resultsTitlesCSS"/>
        <xsl:with-param name="myJavascripts" select="$myJavascripts"/>
    </xsl:call-template>
</xsl:template>

<!-- ################## -->
<!-- ## buildContent ## -->
<!-- ######################################################### -->

<xsl:template name="buildContent">
   <form action="{//page:element[@nameId='page.form.action']/page:value}" method="GET" id="resultsForm">
       <xsl:call-template name="buildResultsForm"/>
       <!-- ## Remove Update Button ## -->
      <script type="text/javascript">removeUpdateBtn();</script>
   </form>
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>


