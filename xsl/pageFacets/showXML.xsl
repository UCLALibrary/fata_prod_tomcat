<!-- $Revision: 1.4 $ $Date: 2012/06/11 14:46:57 $ -->
<!-- 
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage
**          Version : 7.2.0
**          Created : 22-AUG-2007
**    Last Modified : 29-SEP-2009
**      Orig Author : Mel Pemble
-->

<xsl:stylesheet version="1.0" 
	exclude-result-prefixes="xsl fo page xalan"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:xalan="http://xml.apache.org/xslt">

	<xsl:output method="html" encoding="UTF-8" indent="yes" xalan:indent-amount="2"/>
	<xsl:strip-space elements="*"/>
	
<!-- ######################################################### -->

<xsl:template name="showXML" match="*">

	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates/>
	</xsl:copy>
	
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="showNode" match="*[node() or not(node())]">

	<div class="indent">
		<span class="markup">&#160;&#160;&#160;&lt;</span>
		<span class="start-tag"><xsl:value-of select="name(.)"/></span>
		
		<xsl:apply-templates select="@*"/>
		
		<span class="markup">&gt;</span>
		
		<xsl:if test="string-length(.)">
			<span class="text"><xsl:value-of select="."/></span>
		</xsl:if>
		
		<span class="markup">&lt;/</span>
		<span class="end-tag"><xsl:value-of select="name(.)"/></span>
		<span class="markup">&gt;</span>
	</div>
	
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="showLots" match="*[* or processing-instruction() or comment() or string-length(.) &gt; 130]">

<table>
  <tr>
	  <td>&#160;&#160;&#160;</td>
	<td>
	  <span class="markup">&lt;</span>
	  <span class="start-tag"><xsl:value-of select="name(.)"/></span>
	  
	  <xsl:apply-templates select="@*"/>

	  <span class="markup">&gt;</span>

	  <div class="expander-content"><xsl:apply-templates/></div>

	  <span class="markup">&lt;/</span>
	  <span class="end-tag"><xsl:value-of select="name(.)"/></span>
	  <span class="markup">&gt;</span>
	</td>
  </tr>
</table>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="showMore" match="@*">

	<!-- ## this controls the space for the attrubutes of XML elements ## -->
	<xsl:text> </xsl:text>
	<span class="attribute-name"><xsl:value-of select="name(.)"/></span>
	<span class="markup">=</span>
	<span class="attribute-value">"<xsl:value-of select="."/>"</span>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="Showtext" match="text()">

	<xsl:if test="normalize-space(.)">
	  <div class="indent text"><xsl:value-of select="."/></div>
	</xsl:if>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="showPI" match="processing-instruction()">

	<div class="indent pi">
	  <xsl:text>&lt;?</xsl:text>
	  <xsl:value-of select="name(.)"/>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="."/>
	  <xsl:text>?&gt;</xsl:text>
	</div>
	
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="showComment" match="comment()">

	<div class="comment indent">
	  <xsl:text>&lt;!--</xsl:text>
	  <xsl:value-of select="."/>
	  <xsl:text>--&gt;</xsl:text>
	</div>

</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>




