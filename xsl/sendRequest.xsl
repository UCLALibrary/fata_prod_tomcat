<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.6 $ $Date: 2013/07/23 22:22:21 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: sendRequests
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

<!-- Variable Declarations -->
<xsl:variable name="currPage">requestForms</xsl:variable>

<xsl:variable name="requestFormsCSS">
	<link href="{$css-loc}requestConfirmation.css" media="all" type="text/css" rel="stylesheet"/>
</xsl:variable>

<xsl:variable name="myJavascripts">
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
	<xsl:if test="//page:requestDefinition/req:fields/req:field">
		 <xsl:call-template name="showConfirmation"/>
    </xsl:if>
   <xsl:copy-of select="$backToRecord"/>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="showConfirmation">

   <fieldset id="confirmation">
      <legend>Confirmation</legend>
      <ol>
         <xsl:for-each select="//page:requestDefinition/req:fields/req:field">
            <xsl:variable name="nestedFields">
               <xsl:call-template name="buildFieldLinks"/>
            </xsl:variable>
            <xsl:choose>
               <xsl:when test="string-length($nestedFields)">
                  <li>
                     <fieldset>
                        <legend><xsl:value-of select="@label"/></legend>
                        <ol>
                           <xsl:copy-of select="$nestedFields"/>
                        </ol>
                     </fieldset>
                  </li>               
               </xsl:when>
               <xsl:otherwise>
                  <li>
                     <label for=""><xsl:value-of select="@label"/></label>
                     <span><xsl:value-of select="req:text"/></span>
                  </li>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </ol>
   </fieldset>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="buildFieldLinks">
   <xsl:for-each select="req:field">
      <li>
         <label for=""><xsl:value-of select="@label"/></label>

         <xsl:for-each select="req:text">
            <xsl:choose>
               <xsl:when test="$timeFormat='12' and contains(text(),':')">
                  <xsl:call-template name="formatTime">
                     <xsl:with-param name="time" select="text()"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <span><xsl:value-of select="text()"/></span>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </li>
   </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="formatTime">
<xsl:param name="time"/>

   <xsl:variable name="hour24" select="substring($time, 1, 2)" />
   <xsl:variable name="minute" select="substring($time, 4, 2)" />

   <xsl:variable name="hour12">
      <xsl:choose>
         <xsl:when test="$hour24 = 0">
            <xsl:value-of select="12" />
         </xsl:when>
         <xsl:when test="$hour24 = 12">
            <xsl:value-of select="$hour24" />
         </xsl:when>
         <xsl:when test="$hour24 > 12">
            <xsl:value-of select="$hour24 - 12" />
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$hour24" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="meridiem">
      <xsl:choose>
         <xsl:when test="$hour24 >= 12">p.m.</xsl:when>
         <xsl:otherwise>a.m.</xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

    <span><xsl:value-of select="concat($hour12, ':', $minute,' ',$meridiem)" /></span>

</xsl:template>

<!-- ###################################################################### -->

</xsl:stylesheet>


