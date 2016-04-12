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
**          Product : WebVoyage :: printCommon
**          Version : 7.1.0
**          Created : 31-OCT-2007
**      Orig Author : Scott Morgan
**    Last Modified : 09-MAR-2009
** Last Modified By : Mel Pemble
-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<!-- External imports -->
	<xsl:include href="../common/stdImports.xsl"/>
	<xsl:include href="../contentLayout/display/display.xsl"/>

	<xsl:variable name="currPage">Brief Print Format</xsl:variable>
	<xsl:variable name="recordTypeRecord" select="//hol:bibRecord"/>
    <xsl:variable name="holdingsConfig" select="document('../contentLayout/configs/print/printConfigHoldings.xml')"/>	
		
	<xsl:template match="/">
		<html>
			<head>
<!-- ## All pages need a title ## -->
<title>
<xsl:call-template name="buildPageTitle">
<xsl:with-param name="nameId" select="'page.title'"/>
</xsl:call-template>
</title>

				<script>
					<xsl:attribute name="type">
			             <xsl:value-of select="'text/javascript'"/>
			        </xsl:attribute>
			        <xsl:attribute name="src">
			        	<xsl:value-of select="$jscript-loc" />
			            <xsl:value-of select="'autoPrint.js'"/>
			        </xsl:attribute>
				</script>
				<style type="text/css" media="screen,print">@import "<xsl:value-of select="$css-loc"/>print/printBriefRecord.css";</style>
				<style type="text/css" media="screen,print">@import "<xsl:value-of select="$css-loc"/>print/printFullRecord.css";</style>
			</head>
		    <body onload="printPage()">
				<img>
					<xsl:attribute name="src">
			             <xsl:value-of select="$image-loc"/>
                                     <xsl:value-of select="'UCLA_Library_Catalog_banner_graphic.gif'"/>
			             <!--<xsl:value-of select="'webVoyageLogo.jpg'"/>-->
			        </xsl:attribute>
			        <xsl:attribute name="class">
			             <xsl:value-of select="'logo'"/>
			        </xsl:attribute>
			        <xsl:attribute name="alt">
                                     <xsl:value-of select="'UCLA Library Catalog'"/>
			             <!--<xsl:value-of select="'WebVoyage'"/>-->
			        </xsl:attribute>
				</img>  
<!-- ## Display the Page Heading ## -->
<h2>
<xsl:call-template name="buildPageHeading">
<xsl:with-param name="nameId" select="'page.heading'"/>
</xsl:call-template>
</h2>
				 <!--  the actual html for the record will
				 	get placed here buffered by the servlet -->
				 <xsl:value-of select="'html_for_records_replacement_token'" />
		    	 <div id="printFooter">
		    	 	<div class="customContent">
		    	 		<label>Institution Name: UCLA Library</label>
		    	 	</div>
		    	 	<!--<div class="customContent">
						<label>Institution Address:</label>
		    	 	</div>-->
					<div class="customContent">
						<label>Institution Web Site: http://catalog.library.ucla.edu</label>
		    	 	</div>
					<div class="customContent">
						<!--<label>Institution Phone:</label>-->
                                                <label>Questions:  http://www.library.ucla.edu/questions </label>
		    	 	</div>
		    	 </div>
		    </body>
		</html>
	</xsl:template>
	
	
	<xsl:template name="buildContent">
		<!--  do nothing -->
	</xsl:template>
	
</xsl:stylesheet>


