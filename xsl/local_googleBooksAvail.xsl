<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.2 $ $Date: 2012/06/09 00:27:50 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2008 ExLibris Group
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**		      Product : WebVoyage :: googleBooksAvail
**          Version : 7.2.0
**          Created : 05-MAR-2008
**      Orig Author : Mel Pemble
**    Last Modified : 18-AUG-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ###################################################################### -->

<xsl:template name="googleBooksAvail">

   <!-- Setup the ISBN -->
	<xsl:variable name="ISBN">
      <xsl:call-template name="trimData">
         <xsl:with-param name="sData">
            <xsl:call-template name="BMDProcessMarcTags">
               <xsl:with-param name="field" select="'020'"/>
               <xsl:with-param name="indicator1" select="'X'"/>
               <xsl:with-param name="indicator2" select="'X'"/>
               <xsl:with-param name="subfield" select="'a'"/>
               <xsl:with-param name="mfhdID" select="$bibID"/>
               <xsl:with-param name="recordType" select="'bib'"/>
            </xsl:call-template>
          </xsl:with-param>
       </xsl:call-template>
	</xsl:variable>
	
	<!-- Setup the LCCN -->
   <xsl:variable name="LCCN">
      <xsl:call-template name="trimLCCN">
         <xsl:with-param name="sData">
      		 <xsl:call-template name="BMDProcessMarcTags">
                 <xsl:with-param name="field" select="'010'"/>
                 <xsl:with-param name="indicator1" select="'X'"/>
                 <xsl:with-param name="indicator2" select="'X'"/>
                 <xsl:with-param name="subfield" select="'a'"/>
                 <xsl:with-param name="mfhdID" select="$bibID"/>
                 <xsl:with-param name="recordType" select="'bib'"/>
             </xsl:call-template>
          </xsl:with-param>
       </xsl:call-template>
	</xsl:variable>

 	<!-- Setup the OCLC -->
   <xsl:variable name="OCLC">
      <xsl:call-template name="trimData">
         <xsl:with-param name="sData">
      
      		 <xsl:call-template name="BMDProcessMarcTags">
                 <xsl:with-param name="field" select="'035'"/>
                 <xsl:with-param name="indicator1" select="'X'"/>
                 <xsl:with-param name="indicator2" select="'X'"/>
                 <xsl:with-param name="subfield" select="'a'"/>
                 <xsl:with-param name="mfhdID" select="$bibID"/>
                 <xsl:with-param name="recordType" select="'bib'"/>
             </xsl:call-template>
          </xsl:with-param>
       </xsl:call-template>
	</xsl:variable>
     
   <xsl:variable name="BIBKEYS"><xsl:value-of select="$ISBN"/><xsl:value-of select="$LCCN"/><xsl:value-of select="$OCLC"/></xsl:variable>

   <!-- Don't do anything unless there is we have a BIBKEY -->
   <xsl:if test="string-length($BIBKEYS)">
   	<script type="text/javascript" src="{$jscript-loc}googleBooksAvail.js"/>
   	
      <!-- Hide the visibility, we will turn it on in js if we get an object back from the JSON call -->
      <!-- We do this because there is no gaurantee google will return any data to us -->
      <div id="googleBooks" class="googleBooks" style="display:none">Google Books:
         <form action="googleBk" name="googleBk" onSubmit="return false">
            <xsl:if test="string-length($ISBN)"><input type="hidden" name="gisbn" id="gisbn" value="ISBN:{$ISBN}"/></xsl:if>
            <xsl:if test="string-length($LCCN)"><input type="hidden" name="glccn" id="glccn" value="LCCN:{normalize-space($LCCN)}"/></xsl:if>
            <xsl:if test="string-length($OCLC)"><input type="hidden" name="goclc" id="goclc" value="OCLC:{translate($OCLC,'OCLClcocm//r()','')}"/></xsl:if>
         </form>
         <div id="data"></div>
      </div>
      
      <!-- We need to make the function call after we render the div.data -->
      <script type="text/javascript">googleBookSearch(document.googleBk);</script>
      
   </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="trimLCCN">
<xsl:param name="sData"/>

   <xsl:choose>
      <xsl:when test="string-length($sData) &gt; 8">
         <xsl:choose>
            <!-- ## Google doesn't like spaces ## -->
            <xsl:when test="contains($sData,' ')">
               <xsl:choose>
                  <xsl:when test="string-length(substring-before($sData,' ')) &lt; 8">
                     <xsl:value-of select="substring-before($sData,' ')"/>
                     <xsl:call-template name="trimData">
                        <xsl:with-param name="sData" select="substring-after($sData,' ')"/>
                     </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise><xsl:value-of select="substring-before($sData,' ')"/></xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="normalize-space($sData)"/></xsl:otherwise>
         </xsl:choose>
      </xsl:when>
   </xsl:choose>

</xsl:template>
<!-- ###################################################################### -->

</xsl:stylesheet>

