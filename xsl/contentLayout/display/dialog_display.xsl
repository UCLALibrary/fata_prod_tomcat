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
**          Product : WebVoyage :: display
**          Version : 7.2.0
**          Created : 26-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page ser hol slim mfhd item"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ser="http://www.endinfosys.com/Voyager/serviceParameters"
	xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
	xmlns:slim="http://www.loc.gov/MARC21/slim"
	xmlns:mfhd="http://www.endinfosys.com/Voyager/mfhd"
	xmlns:item="http://www.endinfosys.com/Voyager/item">



<!-- ###################################################################### -->

<xsl:template name="display_dialogDisplay_buildRecord">
    <xsl:variable name="marcXml" select="current()"/>

    <xsl:call-template name="buildTitle" >
        <xsl:with-param name="marcXml" select="$marcXml" />
    </xsl:call-template>
    <div class="bibDetail">
        <xsl:call-template name="buildDataLines" >
            <xsl:with-param name="marcXml" select="$marcXml" />
        </xsl:call-template>
    </div>
    <br/>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="buildTitle">
    <xsl:param name="marcXml"/>
    <!--
    <xsl:for-each select="$marcXml/slim:datafield/slim:subfield" >
        <xsl:value-of select="@code" />
    </xsl:for-each>
     -->
    <xsl:for-each select="$Config/display/titleTags">
        <div class="bibTitle">
            <xsl:variable name="displayData">
                <xsl:call-template name="processDisplayTags">
                    <xsl:with-param name="marcXml" select="$marcXml"/>
                    <xsl:with-param name="displayTag" select="''"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:copy-of select="$displayData"/>
        </div>
    </xsl:for-each>
</xsl:template>

<xsl:template name="buildDataLines">
    <xsl:param name="marcXml"/>
    <!--
    <xsl:for-each select="$marcXml/slim:datafield/slim:subfield" >
        <xsl:value-of select="@code" />
    </xsl:for-each>
     -->
    <xsl:for-each select="$Config/display/displayTags">
        <div>
            <span class="bibFieldLabel">
                <xsl:value-of select="@label" />
            </span>
            <xsl:variable name="displayData">
                <xsl:call-template name="processDisplayTags">
                    <xsl:with-param name="marcXml" select="$marcXml"/>
                    <xsl:with-param name="displayTag" select="''"/>
                </xsl:call-template>
            </xsl:variable>
            <span class="bibFieldData" >
                <xsl:copy-of select="$displayData"/>
            </span>
        </div>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="processDisplayTags">
<xsl:param name="marcXml"/>
<xsl:param name="displayLabel"/>

    <xsl:for-each select="displayTag">
        <xsl:variable name="field" ><xsl:value-of select="@field"/></xsl:variable>
        <xsl:variable name="indicator1" ><xsl:value-of select="@indicator1"/></xsl:variable>
        <xsl:variable name="indicator2" ><xsl:value-of select="@indicator2"/></xsl:variable>
        <xsl:variable name="subfield" ><xsl:value-of select="@subfield"/></xsl:variable>

        <xsl:choose>
            <xsl:when test="@field &lt; '1000'">
                <xsl:call-template name="BMDProcessMarcTags">
                    <xsl:with-param name="field" select="$field"/>
                    <xsl:with-param name="indicator1" select="$indicator1"/>
                    <xsl:with-param name="indicator2" select="$indicator2"/>
                    <xsl:with-param name="subfield" select="$subfield"/>
                    <xsl:with-param name="displayLabel" select="$displayLabel"/>
                    <xsl:with-param name="marcXml" select="$marcXml" />
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:for-each>



</xsl:template>


<!-- ###################################################################### -->

<xsl:template name="BMDProcessMarcTags">
<xsl:param name="field"/>
<xsl:param name="indicator1"/>
<xsl:param name="indicator2"/>
<xsl:param name="subfield"/>
<xsl:param name="displayLabel"/>
<xsl:param name="marcXml"/>

    <xsl:variable name="displayData">


           <xsl:for-each select="$marcXml/slim:datafield[@tag=$field]">
            <xsl:if test="($indicator1 = @ind1 or $indicator1 = 'X' or (@ind1 = ' ' and $indicator1 = '|')) and ($indicator2 = @ind2 or $indicator2 = 'X' or (@ind2 = ' ' and $indicator2 = '|'))">

                 <xsl:variable name="subfieldData">
                     <xsl:call-template name="BMDDisplaySubfield">
                         <xsl:with-param name="subfield" select="$subfield"/>
                         <xsl:with-param name="displayTag" select="$marcXml"/>
                     </xsl:call-template>
                 </xsl:variable>

                <xsl:copy-of select="$subfieldData"/>

             </xsl:if>
         </xsl:for-each>
    </xsl:variable>

    <xsl:if test="string-length($displayData)">
        <xsl:copy-of select="$displayData"/>
    </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMDDisplaySubfield">
<xsl:param name="subfield"/>
<xsl:param name="displayTag"/>

    <xsl:for-each select="slim:subfield">
        <xsl:choose>
            <xsl:when test="contains($subfield,@code)">
                <xsl:value-of select="."/>
            </xsl:when>
        </xsl:choose>
    </xsl:for-each>

</xsl:template>










<!-- ###################################################################### -->

<xsl:template name="BMD2000">
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>

    <xsl:variable name="tocData">
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'505'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'atrg'"/>
            <xsl:with-param name="mfhdID" select="$mfhdID"/>
            <xsl:with-param name="recordType" select="$recordType"/>
        </xsl:call-template>
    </xsl:variable>


    <xsl:variable name="tocDataWithBreaks">
        <xsl:call-template name="replaceStringWithBreak">
            <xsl:with-param name="string" select="$tocData"/>
            <xsl:with-param name="target" select="'--'"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:copy-of select="$tocDataWithBreaks"/>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="replaceStringWithBreak">
<xsl:param name="string"/>
<xsl:param name="target"/>

    <xsl:choose>
        <xsl:when test="contains($string, $target)">
            <xsl:variable name="output">
                <xsl:copy-of select="substring-before($string, $target)"/>
            </xsl:variable>
            <xsl:variable name="outputAfter">
                <xsl:copy-of select="substring-after($string, $target)"/>
            </xsl:variable>

            <xsl:copy-of select="$output"/><br/>

            <xsl:choose>
                <xsl:when test="contains($outputAfter, $target)">
                    <xsl:variable name="outputAfterWithBreaks">
                        <xsl:call-template name="replaceStringWithBreak">
                            <xsl:with-param name="string" select="$outputAfter"/>
                            <xsl:with-param name="target" select="$target"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:copy-of select="$outputAfterWithBreaks"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="$outputAfter"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>

        <xsl:otherwise>
            <xsl:copy-of select="$string"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="replaceString">

<xsl:param name="string"/>
<xsl:param name="target"/>
<xsl:param name="replacement"/>

    <xsl:choose>
        <xsl:when test="contains($string, $target)">
            <xsl:variable name="output">
                <xsl:copy-of select="substring-before($string, $target)"/>
                <xsl:copy-of select="$replacement"/>
                <xsl:copy-of select="substring-after($string, $target)"/>
            </xsl:variable>

            <xsl:if test="contains($output, $target)">

            </xsl:if>

            <xsl:copy-of select="$output"/>    output!
        </xsl:when>
        <xsl:otherwise>
            <xsl:copy-of select="$string"/>    string!
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>




<!-- ###################################################################### -->

</xsl:stylesheet>



