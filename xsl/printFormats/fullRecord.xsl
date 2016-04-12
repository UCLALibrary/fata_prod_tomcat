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
**          Product : WebVoyage :: fullRecord
**          Version : 7.1.0
**          Created : 31-OCT-2007
**      Orig Author : Scott Morgan
**    Last Modified : 09-MAR-2009
** Last Modified By : Mel Pemble
**
-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<!-- ## Our Document Holders ## -->
	<xsl:variable name="Config" select="document('../contentLayout/configs/print/fullRecordConfig.xml')"/>
	<xsl:variable name="holdingsConfig" select="document('../contentLayout/configs/print/printConfigHoldings.xml')"/>	
    

	<!-- External imports -->
	<xsl:include href="../common/stdImports.xsl"/>
	<xsl:include href="../contentLayout/display/display.xsl"/>
	
	<xsl:variable name="currPage">Full Record Print Format</xsl:variable>
	<xsl:variable name="recordTypeRecord" select="//hol:bibRecord"/>

	
	<!-- ##################### -->
	<!-- ## begin Main Template ## -->
	<!-- ######################################################### -->
	<xsl:template match="/">
		<xsl:for-each select="$Config">
			<div class="bibliographicData">
				<xsl:call-template name="buildMarcDisplay">
					<xsl:with-param name="recordType" select="'bib'"/>
				</xsl:call-template>
			</div>
		</xsl:for-each>
		<xsl:for-each select="$Config">
			<div class="holdingsData">
				<xsl:call-template name="buildMarcDisplay">
					<xsl:with-param name="recordType" select="'mfhd'"/>
				</xsl:call-template>
			</div>			   			
   		</xsl:for-each>

	</xsl:template>
	
	<xsl:template name="buildContent">
		<!--  do nothing makes framework.xsl happy -->
	</xsl:template>
	
</xsl:stylesheet>


