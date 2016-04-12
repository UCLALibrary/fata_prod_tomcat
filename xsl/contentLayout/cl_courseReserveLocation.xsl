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
**          Created : 19-SEP-2007
**      Orig Author : David Sellers
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

<xsl:template name="buildSearchForm">
	<xsl:for-each select="/page:page/page:pageBody">
   
		<xsl:variable name="formAction">
		    <xsl:value-of select="/page:page//page:element[@nameId='page.search.selectLocation.submit.button']/page:buttonAction"/>
		</xsl:variable>
	
		<div id="courseReserveLocation">	

			<div id="courseReserveLocationForm">
				<form name="selectCourseReserveLocation" accept-charset="UTF-8" method="GET" action="{$formAction}">
					<xsl:call-template name="buildLocationRadio">
						<xsl:with-param name="locationType" select="'setCluster'"/>
					</xsl:call-template>
	
					<xsl:call-template name="buildLocationRadio">
						<xsl:with-param name="locationType" select="'setLocation'"/>
					</xsl:call-template>
	
					<div id="crLocationButton">
			       		<xsl:for-each select="page:element[@nameId='page.search.selectLocation.submit.button']">
				                    <input id="submitBtn" type="submit">
				                        <xsl:attribute name="value">
				                            <xsl:value-of select="page:buttonText"/>
				                           </xsl:attribute>
				                    </input>
						</xsl:for-each>
					</div>
				 </form>				
			</div>
		</div>		
		
	</xsl:for-each>		
	
</xsl:template>

<!-- ##################### -->
<!-- ## buildSearchForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildLocationRadio">
<xsl:param name="locationType"/>
 
	<div id="crLocationText">	
		<xsl:for-each  select="page:element[@nameId=$locationType]">
			<label id="fieldLabel"><xsl:value-of select="page:label"/></label>
		</xsl:for-each>
	</div> 
	
	<div id="crLocations">	
		<xsl:for-each  select="page:element[@nameId=$locationType]">
			<xsl:for-each select="page:option">
			<div id="crLocationRadio">	
				<input type="radio" name="{../@nameId}" value="{page:value}">
					<xsl:if test="@selected = 'true'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>						
					<xsl:value-of select="page:text"/>
				</input>
			</div> 
			</xsl:for-each>
		</xsl:for-each>	
	</div> 
</xsl:template>

</xsl:stylesheet>


