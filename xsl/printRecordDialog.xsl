<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5.2.1 $ $Date: 2012/06/19 16:24:56 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: printRecordDialog
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
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:hol="http://www.endinfosys.com/Voyager/holdings">

    <!-- External imports -->
    <xsl:include href="./common/stdImports.xsl"/>
    <xsl:include href="./contentLayout/cl_printRecordDialog.xsl"/>

    <!-- Variable Declarations -->
    <xsl:variable name="currPage">Print Record Dialog</xsl:variable>
    <xsl:variable name="recordTypeRecord" select="//hol:bibRecord"/>
    <xsl:variable name="printRecordDialogCSS">
       <link href="{$css-loc}commonForm.css" media="all" type="text/css" rel="stylesheet"/>
       <link href="{$css-loc}printRecordDialog.css" media="all" type="text/css" rel="stylesheet"/>
    </xsl:variable>

    <!-- ######################### -->
    <!-- ## begin Main Template ## -->
    <!-- ######################################################### -->

    <xsl:template match="/">
        <xsl:call-template name="buildHtmlPage">
            <xsl:with-param name="myCSS" select="$printRecordDialogCSS" />
        </xsl:call-template>
    </xsl:template>

    <!-- ################## -->
    <!-- ## buildContent ## -->
    <!-- ######################################################### -->

    <xsl:template name="buildContent">
        <xsl:call-template name="cl_printRecordDialog.printRecordDialogForm"/>
    </xsl:template>

</xsl:stylesheet>


