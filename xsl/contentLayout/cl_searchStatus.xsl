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
**          Product : WebVoyage :: cl_searchStatus
**          Version : 7.2.0
**          Created : 09-OCT-2007
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
        <div class="searchStatusForm">
            
            <xsl:for-each select="page:element[@nameId='page.searchStatus.page.label']">
                <xsl:variable name="searchStatusCaption">
                    <xsl:value-of select="page:label"/>
                </xsl:variable>
            </xsl:for-each>						
		
            <xsl:for-each select="page:element[@nameId='page.searchStatus.recordSet.status']">
                <div class="searchStatus">
                    <table class="searchStatusTable" cellspacing="0" summary="This table displays the current search status of databases being searched." >
                        <!--caption><xsl:value-of select="$searchStatusCaption"/></caption-->
                        <tr>
                            <th id="headerDatabase" class="tableCellHeading">
                                <xsl:for-each select="page:heading[@nameId='page.searchStatus.database']">
                                    <xsl:value-of select="page:heading"/>
                                </xsl:for-each>&#160;
                            </th>
                            <th id="headerStatus" class="tableCellHeading">
                                <xsl:for-each select="page:heading[@nameId='page.searchStatus.status']">
                                    <xsl:value-of select="page:heading"/>
                                </xsl:for-each>&#160;
                            </th>
                        </tr>
            
                        <xsl:for-each select="page:item[@nameId='page.searchStatus.item']">
                            <xsl:variable name="classAlternate">
                                <xsl:choose>
                                    <xsl:when test="(position() mod 2) = 0">rowHighlight </xsl:when> 
                                    <xsl:otherwise>row</xsl:otherwise> 
                                </xsl:choose>
                            </xsl:variable>
                        
                            <tr class="{$classAlternate}">
                                <td headers="headerDatabase" class="tableCell">
                                    <xsl:for-each select="page:element[@nameId='page.searchStatus.database']">
                                        <xsl:value-of select="page:label"/>
                                    </xsl:for-each>&#160;
                                </td>
                                <td headers="headerStatus" class="tableCell"> 
                                    <xsl:for-each select="page:element[@nameId='page.searchStatus.status']">
                                        <xsl:value-of select="page:label"/>
                                    </xsl:for-each>&#160;
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </xsl:for-each>

            <div class="searchStatusButtons">
                <xsl:for-each select="page:element[@nameId='page.search.stop.button']">
                    <form name="searchStatusStop" accept-charset="UTF-8" method="GET" action="{page:buttonAction}">
                        <input class="stopBtn" type="submit">
                        <xsl:attribute name="value">
                        <xsl:value-of select="page:buttonText"/>
                        </xsl:attribute>
                        </input>			
                    </form>			
                </xsl:for-each>
            
                <xsl:for-each select="page:element[@nameId='page.searchStatus.show.button']">
                    <form name="searchStatusClearShow" accept-charset="UTF-8" method="GET" action="{page:buttonAction}">
                        <input class="showBtn" type="submit">
                            <xsl:attribute name="value">
                                <xsl:value-of select="page:buttonText"/>
                            </xsl:attribute>
                        </input>			
                    </form>						
                </xsl:for-each>
            </div>
        </div>
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>


