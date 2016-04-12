<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.6 $ $Date: 2013/01/10 21:48:02 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: cl_personalInfo.xsl
**          Version : 9.0.0
**          Created : AUG-2007
**      Orig Author : David Sellers
**    Last Modified : 08-AUG-2012
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ####################### -->
<!-- ## buildPersonalInfo ## -->
<!-- ######################################################### -->

<xsl:template name="buildPersonalInfo">

	<div id="preferences">

		<div id="pageLinks">
			<xsl:call-template name="buildMyAccountLinks">
				<xsl:with-param name="displayType" select="'personalinfo'"/>
			</xsl:call-template>
		</div>

		<div id="personalInfoBody">

			<xsl:call-template name="buildLabelValuePair">
				<xsl:with-param name="eleName"  select="'page.myAccount.viewPersonalInfo.fullname.label'"/>
			</xsl:call-template>

			<xsl:call-template name="buildLabelValuePairWithLink">
				<xsl:with-param name="eleName"  select="'page.myAccount.viewPersonalInfo.email.label'"/>
			</xsl:call-template>

			<div id="dataActiveAddress">
				<xsl:call-template name="buildAddressData">
					<xsl:with-param name="eleName"  select="'page.myAccount.viewPersonalInfo.activeAddress'"/>
				</xsl:call-template>
			</div>

			<div id="dataPermanentAddress">
				<xsl:call-template name="buildAddressData">
					<xsl:with-param name="eleName"  select="'page.myAccount.viewPersonalInfo.permanentAddress'"/>
				</xsl:call-template>
			</div>

			<xsl:if test="//page:element[@nameId='smsNumber']" >
			    <xsl:variable name="disabled">
			        <xsl:value-of select="//page:element[@nameId='smsNumber']/@disabled"/>
			    </xsl:variable>
			    <div id="input">
				    <xsl:if test="$Configs/pageConfigs/pageHTML/page[@name='page.myAccount.viewPersonalInfo.smsInstruction'][@position='aboveContent']">
                         <div class="pageHTMLSnippet">
                              <xsl:copy-of select="$Configs/pageConfigs/pageHTML/page[@name='page.myAccount.viewPersonalInfo.smsInstruction'][@position='aboveContent']/node()"/>
                         </div>
                    </xsl:if>
                  <span class="fieldLabel">
                     <xsl:value-of select="//page:element[@nameId='smsNumber']/page:label"/>
                  </span>
                    <xsl:call-template name="buildSingleInput">
                        <xsl:with-param name="eleName"  select="'smsNumber'"/>
                        <xsl:with-param name="size"  select="'50'"/>
                        <xsl:with-param name="disabled" select="$disabled"/>
                    </xsl:call-template>
					<xsl:call-template name="createHiddenField">
                        <xsl:with-param name="eleName"  select="'patronId'"/>
					</xsl:call-template>
					<xsl:call-template name="createHiddenField">
                        <xsl:with-param name="eleName"  select="'patronHomeUbId'"/>
					</xsl:call-template>
					<xsl:if test="string-length($disabled) and ($disabled = 'disabled')">
					    <xsl:if test="$Configs/pageConfigs/pageHTML/page[@name='page.myAccount.viewPersonalInfo.smsNonLocalInstruction'][@position='belowContent']">
                             <div class="pageHTMLSnippet">
                                 <xsl:copy-of select="$Configs/pageConfigs/pageHTML/page[@name='page.myAccount.viewPersonalInfo.smsNonLocalInstruction'][@position='belowContent']/node()"/>
                             </div>
                        </xsl:if>
                    </xsl:if>
                </div>
				<div id="buttons">
				    <xsl:choose>
				       <xsl:when test="string-length($disabled) and ($disabled = 'disabled')">
                          <input id="saveBtn" type="submit" disabled="disabled" value="{//page:element[@nameId='page.myAccount.viewPersonalInfo.smsNumber.save.button']/page:buttonText}" class="submit" />
                       </xsl:when>
                       <xsl:otherwise>
                          <input id="saveBtn" type="submit" value="{//page:element[@nameId='page.myAccount.viewPersonalInfo.smsNumber.save.button']/page:buttonText}" class="submit" />
                       </xsl:otherwise>
                    </xsl:choose>
                </div>
			</xsl:if>
            <xsl:if test="//page:element[@nameId='page.myAccount.patronExpireDate']">
               <div class="patronExpireDateMessage">
                  <xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.patronExpireDate']/page:value"/>
               </div>
            </xsl:if>
		</div>
	</div>
</xsl:template>

<!-- ###################### -->
<!-- ## buildAddressData ## -->
<!-- ######################################################### -->

<xsl:template name="buildAddressData">
<xsl:param name="eleName"/>

	<xsl:for-each  select="/page:page//page:element[@nameId=$eleName]">

		<div class="addressLabel">
			<span class="fieldLabel"><xsl:value-of select="page:label"/></span>
		</div>

		<div class="addressValue">
			<span class="fieldText">
				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.addressLine1.label']/page:value"/><br/>
				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.addressLine2.label']/page:value"/><br/>
				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.addressLine3.label']/page:value"/><br/>
				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.addressLine4.label']/page:value"/><br/>
				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.addressLine5.label']/page:value"/><br/>

				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.city.label']/page:value"/>&#160;
				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.state.label']/page:value"/>&#160;
				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.zipCode.label']/page:value"/>&#160;
				<xsl:value-of select="page:element[@nameId='page.myAccount.viewPersonalInfo.country.label']/page:value"/><br/>
			</span>

			<br/>
			<xsl:for-each  select="page:element[@nameId='page.myAccount.viewPersonalInfo.phone.label']">
				<span class="fieldLabel"><xsl:value-of select="page:label"/></span>
				<span class="fieldText"><xsl:value-of select="page:value"/></span>
				<br/>
			</xsl:for-each>

			<xsl:for-each  select="page:element[@nameId='page.myAccount.viewPersonalInfo.mobile.label']">
				<span class="fieldLabel"><xsl:value-of select="page:label"/></span>
				<span class="fieldText"><xsl:value-of select="page:value"/></span>
				<br/>
			</xsl:for-each>

			<xsl:for-each  select="page:element[@nameId='page.myAccount.viewPersonalInfo.fax.label']">
				<span class="fieldLabel"><xsl:value-of select="page:label"/></span>
				<span class="fieldText"><xsl:value-of select="page:value"/></span>
				<br/>
			</xsl:for-each>

			<xsl:for-each  select="page:element[@nameId='page.myAccount.viewPersonalInfo.otherPhone.label']">
				<span class="fieldLabel"><xsl:value-of select="page:label"/></span>
				<span class="fieldText"><xsl:value-of select="page:value"/></span>
				<br/>
			</xsl:for-each>

		</div>

	</xsl:for-each>


</xsl:template>


<!-- ######################### -->
<!-- ## buildLabelValuePair ## -->
<!-- ######################################################### -->

<xsl:template name="buildLabelValuePair">
<xsl:param name="eleName"/>
	<div class="lableValuePair">
		<xsl:for-each  select="/page:page//page:element[@nameId=$eleName]">
			<span class="fieldLabel"><xsl:value-of select="page:label"/></span>
			<span class="fieldText"><xsl:value-of select="page:value"/></span>
		</xsl:for-each>
	</div>
</xsl:template>

<!-- ################################# -->
<!-- ## buildLabelValuePairWithLink ## -->
<!-- ######################################################### -->

<xsl:template name="buildLabelValuePairWithLink">
<xsl:param name="eleName"/>

<div class="lableValuePair">
	<xsl:for-each  select="/page:page//page:element[@nameId=$eleName]">
		<span class="fieldLabel"><xsl:value-of select="page:label"/></span>
		<a class="fieldLink">
			<xsl:attribute name="href">mailto:<xsl:value-of select="page:value"/></xsl:attribute>
			<xsl:value-of select="page:value"/>
		</a>
	</xsl:for-each>
</div>
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>


