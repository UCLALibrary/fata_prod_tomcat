<!-- $Revision: 1.4 $ $Date: 2012/06/11 14:46:57 $ -->
<!-- 
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : : WebVoyage :: myAccountLinks.xsl
**          Version : 7.2.0
**          Created : 07-AUG-2007
**      Orig Author : David Sellers
**    Last Modified : 15-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page">

<!-- ###################### -->
<!-- ## buildMyAccountLinks ## -->
<!-- ######################################################################################################################## -->

<xsl:template name="buildMyAccountLinks">
<xsl:param name="displayType"/>

	<div id="myAccountLinks">
	
	<!--
		<xsl:for-each select="$Configs/pageConfigs/accessibilityHeader[@nameId='myAccountLinks']">
			<div class="accessibilityHeader"><h2><xsl:value-of select="."/></h2></div>
		</xsl:for-each>
	-->
	   <h2 class="nav">My Account Links Bar</h2>
		<ul title="My Account Links Bar">
			<!-- ##### My Account Link ##### -->
			<xsl:if test="$displayType != 'myaccount'">
				<xsl:for-each select="/page:page//page:element[@nameId='page.myAccount.myAccount.link']">
					<li>
						<a class="btnltbluelink" href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a>
					</li>
				</xsl:for-each>
			</xsl:if>			
	
			<!-- ##### Personal Info Link ##### -->
			<xsl:if test="$displayType != 'personalinfo'">
				<xsl:for-each select="/page:page//page:element[@nameId='page.myAccount.viewPersonalInfo.link']">
					<li>
						<a class="btnltbluelink" href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a>
					</li>
				</xsl:for-each>
			</xsl:if>
	
			<!-- ##### Search Preferences Link ##### -->
			<xsl:if test="$displayType != 'searchpreferences'">
				<xsl:for-each select="/page:page//page:element[@nameId='page.myAccount.editPreferences.link']">
					<li>
						<a class="btnltbluelink" href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a>
					</li>
				</xsl:for-each>
			</xsl:if>
	
			<!-- ##### Change Pin Link ##### -->
			<xsl:if test="$displayType != 'changepin'">
				<xsl:for-each select="/page:page//page:element[@nameId='page.myAccount.changePin.link']">
					<li>
						<a class="btnltbluelink" href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a>
					</li>
				</xsl:for-each>
			</xsl:if>
		</ul>
	</div>
	
</xsl:template>

<!-- ######################################################################################################################## -->

</xsl:stylesheet>



