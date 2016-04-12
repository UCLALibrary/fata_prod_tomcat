<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.4 $ $Date: 2012/06/09 00:27:51 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: cl_searchSubject
**          Version : 7.2.0
**          Created : 25-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ##################### -->
<!-- ## buildSearchForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildSubjectSearch">

   <!-- search subject form -->
   <div id="searchParams">
   
      <div id="searchInputs">
         <xsl:call-template name="buildFormInput">
            <xsl:with-param name="eleName"  select="'searchArg'"/>
            <xsl:with-param name="size"  select="'51'"/>
            <xsl:with-param name="accesskey"  select="'s'"/>
         </xsl:call-template>
         <input type="hidden" name="searchCode" value="{//page:element[@nameId='searchCode']/page:value}"/>
      </div>
           
      <xsl:call-template name="buildSearchButtons"/>
   
   </div>
</xsl:template>
   
<!-- ######################################################### -->
   
</xsl:stylesheet>



