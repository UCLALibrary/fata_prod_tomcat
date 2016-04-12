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
**          Product : WebVoyage :: cl_searchCourseReserves
**          Version : 7.2.0
**          Created : 25-July-2007
**      Orig Author : Jack Peiser
**    Last Modified : 29-SEP-2009
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

<xsl:template name="buildCourseReservesSearch">
	<xsl:variable name="pageNameId">
		<xsl:value-of select="/page:page/@nameId"/>
	</xsl:variable>

	<xsl:for-each select="/page:page/page:pageBody">
	
		<div id="searchCRForm">
			
			<xsl:for-each select="page:element[@nameId='browseFlag']">
				<input type="hidden">
					<xsl:attribute name="name"><xsl:value-of select="@nameId"/></xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="page:value"/></xsl:attribute>
				</input>
			</xsl:for-each>
			
			<div id="searchCRlocationInfo">
				<xsl:for-each  select="page:element[@nameId='page.search.selectLocation.label']">
					<label id="fieldLabel"><xsl:value-of select="page:label"/></label>
					<label id="fieldText"><xsl:value-of select="page:value"/></label>
				</xsl:for-each>
				
				<xsl:for-each select="page:element[@nameId='page.search.selectLocation.link']">
					<a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
				</xsl:for-each>
			</div>
					
			<div id="searchCRDropDowns">
				<div class="searchCRDropDown">
					<xsl:call-template name="buildFormDropDown">
						<xsl:with-param name="eleName"  select="'instructorId'"/>
					</xsl:call-template>
				</div>

				<div class="searchCRDropDown">
					<xsl:call-template name="buildFormDropDown">
						<xsl:with-param name="eleName"  select="'departmentId'"/>
					</xsl:call-template>
				</div>
									
				<div class="searchCRDropDown">
					<xsl:call-template name="buildFormDropDown">
						<xsl:with-param name="eleName"  select="'courseId'"/>
					</xsl:call-template>
				</div>
								
				<div class="searchCRDropDown">
					<xsl:call-template name="buildFormDropDown">
						<xsl:with-param name="eleName"  select="'sectionId'"/>
					</xsl:call-template>
				</div>
			</div>

			<xsl:call-template name="buildSearchButtons"/>

		</div>
	</xsl:for-each>

</xsl:template>
</xsl:stylesheet>



