<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5 $ $Date: 2012/06/09 00:27:50 $ -->

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
**          Created : 13-NOV-2007
**      Orig Author : Mel Pemble
**    Last Modified : 18-AUG-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
    exclude-result-prefixes="xsl fo req page"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
    xmlns:req="http://www.endinfosys.com/Voyager/requests"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- External imports -->
<xsl:include href="./common/stdImports.xsl"/>

<!-- Specific Imports -->
<xsl:include href="./contentLayout/cl_requestForms.xsl"/>

<!-- Variable Declarations -->
<xsl:variable name="currPage">requestForms</xsl:variable>

<xsl:variable name="requestXML"    select="/page:page/page:pageBody/page:requestDefinition"/>
<xsl:variable name="requestCode"   select="$requestXML/req:requestIdentifier/@requestCode"/>
<xsl:variable name="requestName"   select="$requestXML/req:requestIdentifier/@requestName"/>
<xsl:variable name="requestType"   select="$requestXML/req:requestIdentifier/@requestType"/>
<xsl:variable name="requestSiteId" select="$requestXML/req:requestIdentifier/@requestSiteId"/>

<xsl:variable name="bibId" select="$requestXML/req:fields/req:field[@tag = 'bibId']"/>

<xsl:variable name="requestFormsCSS">
   <link href="{$css-loc}reset.css" media="all" type="text/css" rel="stylesheet"/>
   <link href="{$css-loc}requestForm.css" media="all" type="text/css" rel="stylesheet"/>
   <link href="{$css-loc}calendar.css" media="all" type="text/css" rel="stylesheet"/>
</xsl:variable>

<xsl:variable name="myJavascripts">
   <script type="text/javascript" src="{$jscript-loc}calendar.js"></script>
   <script type="text/javascript" src="{$jscript-loc}calendar-en.js"></script>
   <script type="text/javascript" src="{$jscript-loc}calendar-setup.js"></script>
   <xsl:if test="$requestCode = 'HOLD' or $requestCode='RECALL'">
      <xsl:call-template name="buildRequestGroupsData"/>
      <script type="text/javascript" src="{$jscript-loc}requestGroups.js"></script>
   </xsl:if>
</xsl:variable>

<!-- ######################### -->
<!-- ## begin Main Template ## -->
<!-- ######################################################### -->

<xsl:template match="/">
    <xsl:call-template name="buildHtmlPage">
        <xsl:with-param name="myCSS" select="$requestFormsCSS"/>
        <xsl:with-param name="myJavascripts" select="$myJavascripts"/>
    </xsl:call-template>
</xsl:template>

<!-- ################## -->
<!-- ## buildContent ## -->
<!-- ######################################################### -->

<xsl:template name="buildContent">
    <xsl:call-template name="buildDisplayRequestForms"/>
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>


