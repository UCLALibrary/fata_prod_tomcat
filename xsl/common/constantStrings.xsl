<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5.2.1 $ $Date: 2012/06/11 22:12:06 $ -->
<!-- 
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: constantStrings
**          Version : 7.2.0
**          Created : 06-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!--
   This file gets import/included in the stdImports.xsl
-->

<!-- ######################################################### -->

	<xsl:variable name="constStr_SingleSpace">&#160;</xsl:variable>
	<xsl:variable name="constStr_ReqField"   ><span class="formRequired">*</span></xsl:variable>	   <!-- Required Field HTML  -->
	<xsl:variable name="labelEndChar">:</xsl:variable>
	
<!-- ######################################################### -->	

	<!-- ############################################################## -->
	<!-- ## temp - parameters to be coming from xml when complete    ## -->
	<!-- ## temp - need to know what the parameter names will be     ## -->
	<!-- ## temp - value of the parameters need to be modifiable for ## -->
	<!-- ##           customization and internationalization         ## -->
	<!-- ############################################################## -->
	
	<!-- ## searchSubject ## -->
	<xsl:param name="searchSubjectInstruction" select="'Enter a subject to search the Subject Headings Index.'"></xsl:param>
	<xsl:param name="searchSubjectHeading" select="'Subject Heading:&#160;'"></xsl:param>

	<!-- ## searchAdvanced ## -->
	<xsl:param name="searchAdvancedPrimary" select="'Search:'"></xsl:param>
	<xsl:param name="searchYear" select="'Year:'"></xsl:param>
	<xsl:param name="searchLocation" select="'Location:'"></xsl:param>
	<xsl:param name="searchMatType" select="'Material Type:'"></xsl:param>
	<xsl:param name="searchFormat" select="'Format:'"></xsl:param>
	<xsl:param name="searchLanguage" select="'Language:'"></xsl:param>
	<xsl:param name="searchConnector" select="'within:'"></xsl:param>

</xsl:stylesheet>


