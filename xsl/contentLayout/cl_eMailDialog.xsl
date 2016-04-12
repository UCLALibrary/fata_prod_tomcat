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
**          Product : WebVoyage :: myAccount
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

   <!-- External imports -->
   <xsl:include href="./cl_commonDialog.xsl"/>

<!-- ###################################################################### -->

   <xsl:template name="cl_eMailDialog.eMailDialogForm">
   
      <xsl:for-each  select="/page:page/page:pageBody" >
      
         <form id="eMailDialogForm" method="POST" action="sendMail.do" class="formBackround" >
         
            <xsl:call-template name="contentLayout.cl_commonDialog.hiddenSearchOrBib" />

            <div class="formTextPair" >			
               <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName"  select="'toString'"/>
                  <xsl:with-param name="reqField"  select="'true'"/>
                  <xsl:with-param name="accesskey"  select="'s'"/>
               </xsl:call-template>
            </div>

            <div class="formTextPair" >
               <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName"  select="'subjectString'"/>
               </xsl:call-template>
            </div>

            <div class="formTextPair" >
               <xsl:call-template name="buildFormTextArea">
                  <xsl:with-param name="eleName"  select="'bodyString'"/>
               </xsl:call-template>
            </div>

            <xsl:call-template name="renderButtons">
               <xsl:with-param name="submitBtn"     select="'page.searchResults.emailResults.page.email.email.button'"/>
               <xsl:with-param name="submitBtnName" select="'butEmail'"/>
               <xsl:with-param name="cancelBtn"     select="'page.return.button'"/>
               <xsl:with-param name="cancelBtnName" select="'butCancel'"/>
            </xsl:call-template>

         </form>

      </xsl:for-each>

   </xsl:template>

<!-- ###################################################################### -->
	
</xsl:stylesheet>



