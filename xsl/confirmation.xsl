<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5.2.1 $ $Date: 2012/06/11 22:17:13 $ -->
<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: confirmation
**          Version : 7.2.0
**          Created : 25-OCT-2007
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
   <xsl:include href="./contentLayout/cl_confirmation.xsl"/>
   
   <!-- Variable Declarations -->
   <xsl:variable name="currPage">Confirmation</xsl:variable>
   <xsl:variable name="confirmationCSS">
      <link href="{$css-loc}commonForm.css"   media="all" type="text/css" rel="stylesheet"/>
      <link href="{$css-loc}confirmation.css" media="all" type="text/css" rel="stylesheet"/>
   </xsl:variable>
   
<!-- ######################### -->
<!-- ## begin Main Template ## -->
<!-- ######################################################### -->

   <xsl:template match="/">
      <xsl:call-template name="buildHtmlPage">
         <xsl:with-param name="myCSS" select="$confirmationCSS" />
      </xsl:call-template>
   </xsl:template>
   
<!-- ################## -->
<!-- ## buildContent ## -->
<!-- ######################################################### -->

   <xsl:template name="buildContent">
      <xsl:call-template name="cl_confirmation.confirmationPanel"/>  
   </xsl:template>

</xsl:stylesheet>


