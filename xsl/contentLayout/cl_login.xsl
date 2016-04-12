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
**          Product : WebVoyage :: cl_login
**          Version : 7.2.0
**          Created : 23-AUG-2007
**      Orig Author : Mel Pemble
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- #################### -->
<!-- ## buildLoginPage ## -->
<!-- ##################################################################################################### -->

<xsl:template name="buildLoginPage">

   <xsl:for-each select="/page:page/page:pageBody">
         

      <div id="extPatAuth">
         <xsl:call-template name="buildLinkType">
            <xsl:with-param name="eleName" select="'page.logIn.actions.extAuth.link'"/>
            <xsl:with-param name="spanId" select="'_extPatAuth'"/>
         </xsl:call-template>
      </div>
      
      <div id="loginForm">
      
         <!-- ## Login Type ## -->
         <xsl:choose>
            <xsl:when test="string(page:element[@nameId='loginType'])">
               <div id="barcodeDivDropdown">
                  <xsl:call-template name="buildFormDropDown">
                     <xsl:with-param name="eleName" select="'loginType'"/>
                     <xsl:with-param name="defaultLabelText" select="'Log in using my'"/>
                  </xsl:call-template>
               </div>
               <div id="barcodeDiv">
                  <xsl:call-template name="buildFormInput">
                     <xsl:with-param name="eleName" select="'loginId'"/>
                     <xsl:with-param name="type" select="'password'"/>
                     <xsl:with-param name="defaultLabelText" select="'Id:'"/>
                  </xsl:call-template>
               </div>
            </xsl:when>
            <xsl:when test="string(page:element[@nameId='loginId'])">
               <div id="barcodeDiv">
                  <input class="hidden" value="BRIEF" name="loginType" type="hidden"/>
                  <xsl:call-template name="buildFormInput">
                     <xsl:with-param name="eleName" select="'loginId'"/>
                     <xsl:with-param name="type" select="'password'"/>
                     <xsl:with-param name="defaultLabelText" select="'Id:'"/>
                  </xsl:call-template>
               </div>
            </xsl:when>
         </xsl:choose>

         <!-- ## Last Name ## -->
         <xsl:if test="string(page:element[@nameId='lastName'])">
            <div id="lastNameDiv">
               <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName" select="'lastName'"/>
               </xsl:call-template>
            </div>
         </xsl:if>
         
         <!-- ## Pin ## -->
         <xsl:if test="string(page:element[@nameId='pin'])">
            <div id="pinDiv">
               <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName" select="'pin'"/>
                  <xsl:with-param name="type" select="'password'"/>
               </xsl:call-template>
            </div>
         </xsl:if>
         
         <!-- ## Home Library ## -->
         <xsl:if test="string(page:element[@nameId='page.logIn.library'])">
             <div id="homeLibraryDropdown">
                <xsl:call-template name="buildFormDropDown">
                   <xsl:with-param name="eleName" select="'page.logIn.library'"/>
                </xsl:call-template>
             </div>
          </xsl:if>

         <div id="loginBtns">
            <label for="loginBtn"> <button id="loginBtn"  type="submit" class="submit"><xsl:value-of select="page:element[@nameId='page.logIn.logIn.button']/page:buttonText"/></button></label>
         </div>

      </div>

   </xsl:for-each>

</xsl:template>

<!-- ##################################################################################################### -->

</xsl:stylesheet>



