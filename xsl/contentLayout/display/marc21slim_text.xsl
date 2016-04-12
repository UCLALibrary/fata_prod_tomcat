<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.4 $ $Date: 2012/06/09 00:27:52 $ -->
<!-- 
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: marc21 text based display
**          Version : 7.2.0
**          Created : 2-NOV-2007
**      Orig Author : Scott Morgan
**    Last Modified : 16-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo slim hol ns"
	xmlns:slim="http://www.loc.gov/MARC21/slim"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
	xmlns:ns="http://www.endinfosys.com/Meridian/xml">

<!-- ############################################################## -->
	<xsl:variable name="constStr_Field000Leader" select="'~'"/>
	<xsl:variable name="constStr_SpacingUnderline" select="'_'"/>
	<xsl:variable name="constStr_SubfieldPipe" select="'|'"/>
	<xsl:variable name="new_line" select="'&#xA;'" />
	
	<xsl:template name="buildMarcRecord">
		<xsl:for-each select="//hol:marcRecord">
				<xsl:value-of select="normalize-space(slim:leader)"/>
				<xsl:value-of select="$new_line" />
				<xsl:call-template name="buildControlField"/>
				<xsl:call-template name="buildDataField"/>
		</xsl:for-each>
	</xsl:template>

<!-- ############################################################## -->

<xsl:template name="buildControlField">

	<xsl:for-each select="slim:controlfield">
		<xsl:value-of select="@tag"/>
		<xsl:value-of select="normalize-space(.)"/>
		<xsl:value-of select="$new_line" />
	</xsl:for-each>

</xsl:template>

<!-- ############################################################## -->

<xsl:template name="buildDataField">

	<xsl:for-each select="slim:datafield">
		<xsl:value-of select="@tag"/>
		<xsl:choose>
			<xsl:when test="not(@ind1 = ' ')">
				<xsl:value-of select="@ind1"/>
			</xsl:when>
		

		</xsl:choose>
		<xsl:choose>
			<xsl:when test="not(@ind2 = ' ')">
				<xsl:value-of select="@ind2"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$constStr_SpacingUnderline"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="buildSubfield"/>
		<xsl:value-of select="$new_line" />
	</xsl:for-each>

</xsl:template>

<!-- ############################################################## -->

<xsl:template name="buildSubfield">
	<xsl:for-each select="slim:subfield">
		<xsl:if test="position() != 1" >
			<xsl:value-of select="$constStr_SubfieldPipe"/>
		</xsl:if>
		<xsl:value-of select="@code"/>
		<xsl:value-of select="normalize-space(.)"/>
	</xsl:for-each>
</xsl:template>

<!-- ############################################################## -->

</xsl:stylesheet>




