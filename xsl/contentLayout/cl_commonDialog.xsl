<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5 $ $Date: 2012/06/09 00:27:51 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage
**          Version : 7.2.0
**          Created : 25-Oct-2007
**      Orig Author : Scott Morgan
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ###################################################################### -->

<xsl:template name="contentLayout.cl_commonDialog.hiddenSearchOrBib">

   <xsl:call-template name="createHiddenField">
      <xsl:with-param name="eleName" select="'searchId'"/>
   </xsl:call-template>
   <xsl:call-template name="createHiddenField">
      <xsl:with-param name="eleName" select="'cbxAll'"/>
   </xsl:call-template>
   <xsl:call-template name="createHiddenField">
      <xsl:with-param name="eleName" select="'bibId'"/>
   </xsl:call-template>
   <xsl:call-template name="createHiddenField">
      <xsl:with-param name="eleName" select="'authId'"/>
   </xsl:call-template>
   <xsl:call-template name="createHiddenField">
      <xsl:with-param name="eleName" select="'titles'"/>
   </xsl:call-template>
   <xsl:call-template name="createHiddenField">
      <xsl:with-param name="eleName" select="'returnUrl'"/>
   </xsl:call-template>

 </xsl:template>

<!-- ###################################################################### -->
  
<xsl:template name="renderButtons" >
<xsl:param name="submitBtn"/>
<xsl:param name="submitBtnName"/>
<xsl:param name="cancelBtn"/>
<xsl:param name="cancelBtnName"/>
	
   <div class="formButtons">
      <xsl:for-each  select="page:element[@nameId=$submitBtn]">
         <input type="submit" value="{page:buttonText}" class="btn" alt="{page:buttonMessage}">
            <xsl:attribute name="name">
               <xsl:value-of select="$submitBtnName"/>
            </xsl:attribute>
         </input>
      </xsl:for-each>
      
      <xsl:call-template name="formHorizontalSpacer"/>
          
      <xsl:for-each  select="page:element[@nameId=$cancelBtn]">
         <!--
         <input type="submit" value="{page:buttonText}" class="btn" alt="{page:buttonMessage}">
            <xsl:attribute name="name">
               <xsl:value-of select="$cancelBtnName"/>
            </xsl:attribute>
         </input>
         -->
         <input>
	   		<xsl:attribute name="type">
	             <xsl:value-of select="'hidden'"/>
	        </xsl:attribute>
	        <xsl:attribute name="name">
	             <xsl:value-of select="'returnUrl'"/>
	        </xsl:attribute>
	        <xsl:attribute name="value">
	             <xsl:value-of select="page:buttonAction"/>
	        </xsl:attribute>
		  </input>
      </xsl:for-each>
      
	</div>
</xsl:template>
	
</xsl:stylesheet>


