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
**          Product : WebVoyage :: emailRecord
**          Version : 7.2.0
**          Created : 01-NOV-2007
**      Orig Author : Scott Morgan
**    Last Modified : 18-AUG-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
   >

    <xsl:output method="text" version="4.0" encoding="UTF-8"/>

    <xsl:include href="./contentLayout/display/display_text.xsl"/>

    <!--  since we don't have html and text all emails will be
          text so that we cover both types of clients
          (html clients will read text email) -->

    <!-- VYG-612: inherited from display_text.xsl
    <xsl:variable name="new_line" select="'&#xA;'" />
    <xsl:variable name="tab" select="'&#09;'" />
     -->
    <xsl:variable name="recordTypeRecord" select="//hol:bibRecord"/>

    <xsl:variable name="Config" select="document('./contentLayout/configs/emailcfg.xml')"/>
   <xsl:variable name="holdingsConfig" select="document('./contentLayout/configs/emailcfgHoldings.xml')"/>

    <xsl:template match="/">
        <!--  this just creates one text record -->
        <xsl:for-each select="$Config">
            <xsl:call-template name="buildMarcDisplay">
                <xsl:with-param name="recordType" select="'bib'"/>
            </xsl:call-template>
        </xsl:for-each>

        <xsl:for-each select="$Config">
            <xsl:call-template name="buildMarcDisplay">
                <xsl:with-param name="recordType" select="'mfhd'"/>
            </xsl:call-template>
        </xsl:for-each>

    </xsl:template>


</xsl:stylesheet>


