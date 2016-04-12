<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5 $ $Date: 2012/06/09 00:27:52 $ -->
<!-- 
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: marcDisplay
**          Version : 7.2.0
**          Created : 22-FEB-2007
**      Orig Author : Mel Pemble
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

<xsl:template name="buildMarcRecord">

   <div class="marcRecord" id="divbib">
   	<xsl:for-each select="//hol:marcRecord">
   	   <h2 class="nav">Bibliographic Record</h2>
   		<ul>
   			<li class="row">
   				<label class="tagLabel"><xsl:value-of select="$constStr_Field000Leader"/></label>
   				<span class="fieldText">
   					<xsl:value-of select="slim:leader"/>
   				</span>
   			</li>
   			<xsl:call-template name="buildControlField"/>
   			<xsl:call-template name="buildDataField"/>
   		</ul>
   		<p>&#160;</p>
   	</xsl:for-each>
   </div>

</xsl:template>

<!-- ############################################################## -->

<xsl:template name="buildControlField">

	<xsl:for-each select="slim:controlfield">
		<li class="controlField">
			<label class="tagLabel">
				<xsl:value-of select="@tag"/>
			</label>
			<span class="fieldText">
				<xsl:value-of select="."/>
			</span>
		</li>
	</xsl:for-each>

</xsl:template>

<!-- ############################################################## -->

<xsl:template name="buildDataField">

	<xsl:for-each select="slim:datafield">
		<li class="dataField">
			<label class="tagLabel">
				<xsl:value-of select="@tag"/>
			</label>
			<!--div class="fieldLabel">&#160;</div-->

			<label class="tagLabel2">			
				<xsl:choose>
					<xsl:when test="not(@ind1 = ' ')">
						<xsl:value-of select="@ind1"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$constStr_SpacingUnderline"/></xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="not(@ind2 = ' ')">
						<xsl:value-of select="@ind2"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$constStr_SpacingUnderline"/></xsl:otherwise>
				</xsl:choose>
			</label>
			
			<span class="fieldText">
				<xsl:call-template name="buildSubfield"/>
			</span>
		</li>
	</xsl:for-each>

</xsl:template>

<!-- ############################################################## -->

<xsl:template name="buildSubfield">
	<xsl:for-each select="slim:subfield">
		&#160;<xsl:value-of select="$constStr_SubfieldPipe"/><span class="boldit"><xsl:value-of select="@code"/></span>&#160;<span class="subfieldMarcData"><xsl:value-of select="."/></span>
	</xsl:for-each>
</xsl:template>

<!-- ############################################################## -->

</xsl:stylesheet>




