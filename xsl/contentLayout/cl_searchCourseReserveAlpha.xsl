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

<xsl:template name="buildSearchForm">
	<xsl:variable name="pageNameId">
		<xsl:value-of select="/page:page/@nameId"/>
	</xsl:variable>
	


	<xsl:for-each select="/page:page/page:pageBody">

        <div id="searchCRAlphaForm">

            <div id="locationInfo">
                <xsl:for-each  select="page:element[@nameId='page.search.selectLocation.label']">
                    <label id="fieldLabel"><xsl:value-of select="page:label"/></label>
                    <label id="fieldText"><xsl:value-of select="page:value"/></label>
                </xsl:for-each>

                <xsl:for-each select="page:element[@nameId='page.search.selectLocation.link']">
                    <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
                </xsl:for-each>
            </div>

            <div id="searchCRAlphaText">
			<xsl:if test="$Configs/pageConfigs/pageHTML/page[@name=$pageNameId]">
				<label id="fieldText"><xsl:value-of select="$Configs/pageConfigs/pageHTML/page[@name=$pageNameId]"/></label>
			</xsl:if>                
            </div>

            <div id="searchCRAlphaInstructor">
                <xsl:for-each  select="page:element[@nameId='instructorId']">
                    <xsl:call-template name="buildAlphaList"/>
                </xsl:for-each>
            </div>

            <div id="searchCRAlphaDepartment">
                <xsl:for-each  select="page:element[@nameId='departmentId']">
                    <xsl:call-template name="buildAlphaList"/>
                </xsl:for-each>
            </div>

            <div id="searchCRAlphaCourse">
                <xsl:for-each  select="page:element[@nameId='courseId']">
                    <xsl:call-template name="buildAlphaList"/>
                </xsl:for-each>
            </div>

        </div>
    </xsl:for-each>

</xsl:template>

<!-- #################### -->
<!-- ## buildAlphaList ## -->
<!-- ######################################################### -->

<xsl:template name="buildAlphaList">
    <label id="fieldLabel"><xsl:value-of select="page:label"/></label>
    <xsl:for-each  select="page:element">
        <xsl:choose>
            <xsl:when test="page:linkText">
                <a id="alphaLink">
                    <xsl:attribute name="href">
                        <xsl:value-of select="page:URL"/>
                    </xsl:attribute>
                    <xsl:value-of select="page:linkText"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <label id="fieldAlphaLabel"><xsl:value-of select="page:label"/></label>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>

</xsl:template>

</xsl:stylesheet>



