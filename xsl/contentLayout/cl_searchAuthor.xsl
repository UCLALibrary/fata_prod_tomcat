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
**          Product : WebVoyage :: cl_searchAuthor
**          Version : 7.2.0
**          Created : 25-JUL-2007
**      Orig Author : Jack Peiser
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ####################### -->
<!-- ## buildAuthorSearch ## -->
<!-- ######################################################### -->

<xsl:template name="buildAuthorSearch">

<div id="searchAuthorForm">

   <div id="searchParams">
      <div id="searchAuthorLabel">
          <xsl:for-each select="/page:page//page:element[@nameId='page.search.author.label']">
              <xsl:call-template name="diplayLabel">
                  <xsl:with-param name="eleName" select="'page.search.author.label'"/>
                  <xsl:with-param name="idOverride" select="'searchInputs'"/>
              </xsl:call-template>
          </xsl:for-each>
      </div>
      <div id="searchInputs">
          <div id="inputLastName">
              <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName"  select="'searchArg'"/>
                  <xsl:with-param name="size"  select="'40'"/>
                  <xsl:with-param name="accesskey"  select="'s'"/>
              </xsl:call-template>
          </div>
          <div id="inputFirstName">
              <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName"  select="'searchArgt2'"/>
                  <xsl:with-param name="size"  select="'33'"/>
              </xsl:call-template>
          </div>

          <xsl:call-template name="createHiddenField">
            <xsl:with-param name="eleName" select="'searchCode'"/>
          </xsl:call-template>

      </div>
   </div>

    <xsl:call-template name="buildSearchButtons"/>

</div>

</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>



