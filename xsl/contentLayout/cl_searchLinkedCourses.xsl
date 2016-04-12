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
**          Product : WebVoyage :: cl_searchCourseReserveAlpha
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

<xsl:template name="buildLinkedCourses">
	<xsl:variable name="pageNameId">
		<xsl:value-of select="/page:page/@nameId"/>
	</xsl:variable>

	<xsl:for-each select="/page:page/page:pageBody">
		<div id="searchLinkedCoursesForm">

			<div id="searchCRlocationInfo">
				<xsl:for-each  select="page:element[@nameId='page.search.selectLocation.label']">
					<label id="fieldLabel"><xsl:value-of select="page:label"/></label>
					<label id="fieldText"><xsl:value-of select="page:value"/></label>
				</xsl:for-each>
				
				<xsl:for-each select="page:element[@nameId='page.search.selectLocation.link']">
					<a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
				</xsl:for-each>
			</div>
			

			<xsl:if test="$Configs/pageConfigs/pageHTML/page[@name=$pageNameId]">
				<div id="searchHTML">
					<label id="fieldText"><xsl:value-of select="$Configs/pageConfigs/pageHTML/page[@name=$pageNameId]"/></label>
				</div>
			</xsl:if>                


			<xsl:for-each select="page:element[@nameId='page.search.courseReserve.instructor']">
				<div class="instructorLinks">
					<xsl:call-template name="buildLinkedCoursesList"/>
				</div>
			</xsl:for-each>

			<xsl:for-each select="page:element[@nameId='page.search.courseReserve.department']">
				<div class="deparmentLinks">
					<xsl:call-template name="buildLinkedCoursesList"/>
				</div>
			</xsl:for-each>

			<xsl:for-each select="page:element[@nameId='page.search.courseReserve.course']">
				<div class="courseLinks">
					<xsl:call-template name="buildLinkedCoursesList"/>
				</div>
			</xsl:for-each>

		</div>
	</xsl:for-each>
</xsl:template>

<!-- ############################ -->
<!-- ## buildLinkedCourseLinks ## -->
<!-- ######################################################### -->

<xsl:template name="buildLinkedCoursesList">

   <div class="linkedCoursesList">
      <xsl:for-each select="page:element[@nameId='page.search.courseReserve.data.label']">
         <span><xsl:value-of select="page:label"/></span>
      </xsl:for-each>
      <h2 class="nav">Linked Course List</h2>
      <ul>
         <xsl:for-each select="page:element[@nameId='page.search.courseReserve.data.link']">
            <li>
               <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
            </li>
         </xsl:for-each>			
      </ul>
   </div>			
</xsl:template>

</xsl:stylesheet>



