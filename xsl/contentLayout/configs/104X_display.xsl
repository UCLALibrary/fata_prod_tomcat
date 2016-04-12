<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.6.4.2.2.1 $ $Date: 2013/05/10 15:27:46 $ -->
<!--
**========================================================================
**
**          Copyright 2007-2013 Ex Libris (USA) Inc.
**                          All Rights Reserved
**
**========================================================================
-->
<!--
**        Product : Webvoyage :: 104X displays
**        Version : 7.1.0
**        Created : 22-FEB-2007
**  Last Modified : 09-MAR-2009
**    Orig Author : Mel Pemble
-->
<!--
**        This file is based upon XSL coding created by the University of Kansas
-->

<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:ser="http://www.endinfosys.com/Voyager/serviceParameters"
   xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
   xmlns:slim="http://www.loc.gov/MARC21/slim" exclude-result-prefixes="slim"
   xmlns:mfhd="http://www.endinfosys.com/Voyager/mfhd"
   xmlns:item="http://www.endinfosys.com/Voyager/item">




<!-- VYG-1113: rename these two variables, since under some conditions
     they are in the same scope as other .xsl files, but not always. -->
<xsl:variable name="lowercase1D" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase1D" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<!-- GET PUNCTUATION CONSTANTS FROM 104Xconfig.xsl -->

<xsl:variable name="v104Xconfig" select="document('./104X_config.xml')"/>

<xsl:variable name="displayFormat" select="translate($v104Xconfig//Config/displayFormat, $lowercase1D, $uppercase1D)"/>

<xsl:variable name="enumLevelSeparator">
    <xsl:choose>
        <xsl:when test="$displayFormat='STANDARD'">
            <xsl:value-of select="$v104Xconfig//Config/StandardEnumLevelSeparator"/>
        </xsl:when>
        <xsl:when test="$displayFormat='NISO'">
            <xsl:value-of select="$v104Xconfig//Config/NISOEnumLevelSeparator"/>
        </xsl:when>
    </xsl:choose>
</xsl:variable>

<xsl:variable name="enumLabelDataSeparator">
    <xsl:choose>
        <xsl:when test="$displayFormat='STANDARD'">
            <xsl:value-of select="$v104Xconfig//Config/StandardEnumLabelDataSeparator"/>
        </xsl:when>
        <xsl:when test="translate($displayFormat, $lowercase1D, $uppercase1D)='NISO'">
            <xsl:value-of select="$v104Xconfig//Config/NISOEnumLabelDataSeparator"/>
        </xsl:when>
    </xsl:choose>
</xsl:variable>

<xsl:variable name="chronLabelDataSeparator">
    <xsl:choose>
        <xsl:when test="$displayFormat='STANDARD'">
            <xsl:value-of select="$v104Xconfig//Config/StandardChronLabelDataSeparator"/>
        </xsl:when>
        <xsl:when test="translate($displayFormat, $lowercase1D, $uppercase1D)='NISO'">
            <xsl:value-of select="$v104Xconfig//Config/NISOChronLabelDataSeparator"/>
        </xsl:when>
    </xsl:choose>
</xsl:variable>

<xsl:variable name="chronologyLevelSeparator">
    <xsl:choose>
        <xsl:when test="$displayFormat='STANDARD'">
            <xsl:value-of select="$v104Xconfig//Config/StandardChronologyLevelSeparator"/>
        </xsl:when>
        <xsl:when test="translate($displayFormat, $lowercase1D, $uppercase1D)='NISO'">
            <xsl:value-of select="$v104Xconfig//Config/NISOChronologyLevelSeparator"/>
        </xsl:when>
    </xsl:choose>
</xsl:variable>

<xsl:variable name="chronologyRangeSeparator">
    <xsl:choose>
        <xsl:when test="$displayFormat='STANDARD'">
            <xsl:value-of select="$v104Xconfig//Config/StandardChronologyRangeSeparator"/>
        </xsl:when>
        <xsl:when test="translate($displayFormat, $lowercase1D, $uppercase1D)='NISO'">
            <xsl:value-of select="$v104Xconfig//Config/NISOChronologyRangeSeparator"/>
        </xsl:when>
    </xsl:choose>
</xsl:variable>

<!-- GET CAPTION PREFIXES FROM 104Xconfig.xsl -->

<xsl:variable name="supplementCaption">
    <xsl:value-of select="$v104Xconfig//Config/SupplementCaption"/>
</xsl:variable>

<xsl:variable name="indexCaption">
    <xsl:value-of select="$v104Xconfig//Config/IndexCaption"/>
</xsl:variable>

<!-- GET INDICATOR FILTERS FROM 104Xconfig.xsl -->

<xsl:variable name="Valid863Indicators_1" select="$v104Xconfig//Config/Valid863Indicators_1"/>
<xsl:variable name="Valid863Indicators_2" select="$v104Xconfig//Config/Valid863Indicators_2"/>

<xsl:variable name="Valid864Indicators_1" select="$v104Xconfig//Config/Valid864Indicators_1"/>
<xsl:variable name="Valid864Indicators_2" select="$v104Xconfig//Config/Valid864Indicators_2"/>

<xsl:variable name="Valid865Indicators_1" select="$v104Xconfig//Config/Valid865Indicators_1"/>
<xsl:variable name="Valid865Indicators_2" select="$v104Xconfig//Config/Valid865Indicators_2"/>

<!-- ************************************************ -->

<xsl:template name="display1041">
    <xsl:call-template name="parseAndDisplayConciseHoldings">
        <xsl:with-param name="whichPair" select="'3'"/>    <!-- display 853 / 863 pairs -->
    </xsl:call-template>
</xsl:template>

<!-- ************************************************ -->

<xsl:template name="display1043">
    <xsl:call-template name="parseAndDisplayConciseHoldings">
        <xsl:with-param name="whichPair" select="'4'"/>    <!-- display 854 / 864 pairs -->
    </xsl:call-template>
</xsl:template>

<!-- ************************************************ -->

<xsl:template name="display1045">
    <xsl:call-template name="parseAndDisplayConciseHoldings">
        <xsl:with-param name="whichPair" select="'5'"/>    <!-- display 855 / 865 pairs -->
    </xsl:call-template>
</xsl:template>

<!-- ************************************************ -->

<xsl:template name="parseAndDisplayConciseHoldings">
    <xsl:param name="whichPair"/>    <!-- send 3 or 4 or 5 -->

    <!-- Validate whichPair value -->
    <xsl:if test="string-length($whichPair) = 1 and  contains('345', $whichPair)">

        <!-- get and save language code from 008 -->
        <xsl:variable name="languageCode" select="substring(slim:controlfield[@tag='008'], 23, 3)"/>

        <!-- Select [853|854|855] tag identifier -->
        <xsl:variable name="captionFieldsTag">
            <xsl:value-of select="concat('85', $whichPair)"/>
        </xsl:variable>

        <!-- Select [863|864|865] tag identifier -->
        <xsl:variable name="optionalDataFieldsTag">
            <xsl:value-of select="concat('86', $whichPair)"/>
        </xsl:variable>

        <!-- Select [866|867|868] tag identifier that over-rides [863|864|865] in some instances -->
        <xsl:variable name="preferredDataFieldsTag">
            <xsl:value-of select="concat('86', string((number($whichPair)+3)))"/>
        </xsl:variable>

        <!-- Get count of [866|867|868] nodes that have a linking value of zero -->
        <xsl:variable name="countPreferredDataFieldsWithLinkValueIs0">
                <xsl:value-of select="count(slim:datafield[@tag=$preferredDataFieldsTag and slim:subfield='0' and slim:subfield[@code='8']])"/>
        </xsl:variable>

        <!-- Parse and display [866|867|868] fields that have a linking value of zero -->
        <xsl:if test="$countPreferredDataFieldsWithLinkValueIs0 != 0">
            <xsl:call-template name="parseAndDisplayAllPreferredDataFields">
                <xsl:with-param name="preferredDataFieldsTag" select="$preferredDataFieldsTag"/>
            </xsl:call-template>
        </xsl:if>

        <!--    Parse and display all linked pairs of 85X/86X fields, and unlinked [866|867|868] fields, but only if
                NONE of the [866|867|868] have linking values of zero -->
        <xsl:if test="$countPreferredDataFieldsWithLinkValueIs0 = 0">
            <xsl:call-template name="parseAndDisplay85Xand86XPairs">
                <xsl:with-param name="languageCode" select="$languageCode"/>
                <xsl:with-param name="captionFieldsTag" select="$captionFieldsTag"/>
                <xsl:with-param name="optionalDataFieldsTag" select="$optionalDataFieldsTag"/>
                <xsl:with-param name="preferredDataFieldsTag" select="$preferredDataFieldsTag"/>
                <xsl:with-param name="whichPair" select="$whichPair"/>
            </xsl:call-template>
        </xsl:if>

    </xsl:if>
</xsl:template>

<!-- ************************************************ -->
<xsl:template name="parseAndDisplayAllPreferredDataFields">
    <xsl:param name="preferredDataFieldsTag"/>
    <xsl:for-each select="slim:datafield[@tag=$preferredDataFieldsTag and slim:subfield='0' and slim:subfield[@code='8']]">
        <xsl:choose>
            <xsl:when test="position()=1"><xsl:value-of select="'&#09;'"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="'&#09;&#09;&#09;'"/></xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="buildPreferredDataFields">
            <xsl:with-param name="subfieldA" select="slim:subfield[@code='a']"/>
            <xsl:with-param name="subfieldZ" select="slim:subfield[@code='z']"/>
        </xsl:call-template>
        <br/><xsl:value-of select="'&#xA;'"/>
    </xsl:for-each>
</xsl:template>

<!-- ************************************************ -->
<xsl:template name="buildOnePreferredDataFields">
    <xsl:param name="preferredDataFieldsTag"/>
    <xsl:call-template name="buildPreferredDataFields">
        <xsl:with-param name="subfieldA" select="slim:subfield[@code='a']"/>
        <xsl:with-param name="subfieldZ" select="slim:subfield[@code='z']"/>
    </xsl:call-template>
</xsl:template>

<!-- ************************************************ -->
<xsl:template name="parseAndDisplay85Xand86XPairs">
    <xsl:param name="languageCode"/>
    <xsl:param name="captionFieldsTag"/>
    <xsl:param name="optionalDataFieldsTag"/>
    <xsl:param name="preferredDataFieldsTag"/>
    <xsl:param name="whichPair"/>

    <!-- For each matching caption -->
    <xsl:for-each select="slim:datafield[@tag=$captionFieldsTag]">

        <!-- sort by 85X [853|854|855] linking numbers -->
        <xsl:sort
            select="slim:subfield[@code='8']"
            order="ascending"
            data-type="number"/>

        <!-- Get linking number from 85X $8 subfield -->
        <xsl:variable name="linking_number">
            <xsl:value-of select="slim:subfield[@code='8']"/>
        </xsl:variable>

        <!-- get all the captions -->
        <xsl:variable name="captionA"><xsl:value-of select="slim:subfield[@code='a']"/></xsl:variable>
        <xsl:variable name="captionB"><xsl:value-of select="slim:subfield[@code='b']"/></xsl:variable>
        <xsl:variable name="captionC"><xsl:value-of select="slim:subfield[@code='c']"/></xsl:variable>
        <xsl:variable name="captionD"><xsl:value-of select="slim:subfield[@code='d']"/></xsl:variable>
        <xsl:variable name="captionE"><xsl:value-of select="slim:subfield[@code='e']"/></xsl:variable>
        <xsl:variable name="captionF"><xsl:value-of select="slim:subfield[@code='f']"/></xsl:variable>
        <xsl:variable name="captionG"><xsl:value-of select="slim:subfield[@code='g']"/></xsl:variable>
        <xsl:variable name="captionH"><xsl:value-of select="slim:subfield[@code='h']"/></xsl:variable>
        <xsl:variable name="captionI"><xsl:value-of select="slim:subfield[@code='i']"/></xsl:variable>
        <xsl:variable name="captionJ"><xsl:value-of select="slim:subfield[@code='j']"/></xsl:variable>
        <xsl:variable name="captionK"><xsl:value-of select="slim:subfield[@code='k']"/></xsl:variable>
        <xsl:variable name="captionL"><xsl:value-of select="slim:subfield[@code='l']"/></xsl:variable>
        <xsl:variable name="captionM"><xsl:value-of select="slim:subfield[@code='m']"/></xsl:variable>
        <xsl:variable name="captionO"><xsl:value-of select="slim:subfield[@code='o']"/></xsl:variable>
        <xsl:variable name="captionW"><xsl:value-of select="slim:subfield[@code='w']"/></xsl:variable>

        <!-- Determine if rogue cataloger put chronological fields in enumerative fields. -->
        <xsl:variable name="areChronValuesInEnumerativeSubfields">
            <xsl:call-template name="chronValuesInEnumerativeSubfields">
                <xsl:with-param name="subfield5a" select="$captionA"/>
                <xsl:with-param name="subfield5b" select="$captionB"/>
                <xsl:with-param name="subfield5c" select="$captionC"/>
                <xsl:with-param name="subfield5d" select="$captionD"/>
                <xsl:with-param name="subfield5e" select="$captionE"/>
                <xsl:with-param name="subfield5f" select="$captionF"/>
                <xsl:with-param name="subfield5i" select="$captionI"/>
                <xsl:with-param name="subfield5j" select="$captionJ"/>
                <xsl:with-param name="subfield5k" select="$captionK"/>
                <xsl:with-param name="subfield5l" select="$captionL"/>
                <xsl:with-param name="subfield5m" select="$captionM"/>
            </xsl:call-template>
        </xsl:variable>

        <!-- Get number of instances where [866|867|888] $8<linking number> == 85X $8<linking number> -->
        <xsl:variable name="countPreferredDataFieldsWithMatchingLink" select="count(slim:datafield[@tag=$preferredDataFieldsTag and floor(slim:subfield[@code='8'])=$linking_number])"/>

        <!-- For each matching optional data field -->
        <xsl:for-each select="../slim:datafield[@tag=$optionalDataFieldsTag]">
            <!-- Sort by sequence numbers -->
            <xsl:sort
                select="floor(slim:subfield[@code='8'])"
                order="ascending"
                data-type="number"/>
            <xsl:sort
                select="substring-after(slim:subfield[@code='8'], '.')"
                order="ascending"
                data-type="number"/>

            <!-- 1st test to display 85X/86X pairs:  The linking numbers must match. -->
            <xsl:if test="(@tag=$optionalDataFieldsTag) and (floor(slim:subfield[@code='8']) = $linking_number)">

                <!--    2nd test to display 85X/86X pairs:  None of the 866|867|868 fields may have a link value
                        of zero. -->
                <xsl:if test="$countPreferredDataFieldsWithMatchingLink=0">

                    <xsl:variable name="indicatorTest">
                        <xsl:call-template name="checkIndicators">
                            <xsl:with-param name="whichPair" select="$whichPair"/>
                        </xsl:call-template>
                    </xsl:variable>

                    <xsl:if test="$indicatorTest='true'">
                        <xsl:variable name="optionalHoldings">
                            <xsl:call-template name="buildHoldingsVariableForOptionalDataFields">
                                <xsl:with-param name="areChronValuesInEnumerativeSubfields" select="$areChronValuesInEnumerativeSubfields"/>
                                <xsl:with-param name="lang" select="$languageCode"/>
                                <xsl:with-param name="whichPair" select="$whichPair"/>
                                <xsl:with-param name="subfield5a" select="$captionA"/>
                                <xsl:with-param name="subfield5b" select="$captionB"/>
                                <xsl:with-param name="subfield5c" select="$captionC"/>
                                <xsl:with-param name="subfield5d" select="$captionD"/>
                                <xsl:with-param name="subfield5e" select="$captionE"/>
                                <xsl:with-param name="subfield5f" select="$captionF"/>
                                <xsl:with-param name="subfield5g" select="$captionG"/>
                                <xsl:with-param name="subfield5h" select="$captionH"/>
                                <xsl:with-param name="subfield5i" select="$captionI"/>
                                <xsl:with-param name="subfield5j" select="$captionJ"/>
                                <xsl:with-param name="subfield5k" select="$captionK"/>
                                <xsl:with-param name="subfield5l" select="$captionL"/>
                                <xsl:with-param name="subfield5m" select="$captionM"/>
                                <xsl:with-param name="subfield5o" select="$captionO"/>
                                <xsl:with-param name="subfield5w" select="$captionW"/>
                                <xsl:with-param name="subfield6a" select="slim:subfield[@code='a']"/>
                                <xsl:with-param name="subfield6b" select="slim:subfield[@code='b']"/>
                                <xsl:with-param name="subfield6c" select="slim:subfield[@code='c']"/>
                                <xsl:with-param name="subfield6d" select="slim:subfield[@code='d']"/>
                                <xsl:with-param name="subfield6e" select="slim:subfield[@code='e']"/>
                                <xsl:with-param name="subfield6f" select="slim:subfield[@code='f']"/>
                                <xsl:with-param name="subfield6g" select="slim:subfield[@code='g']"/>
                                <xsl:with-param name="subfield6h" select="slim:subfield[@code='h']"/>
                                <xsl:with-param name="subfield6i" select="slim:subfield[@code='i']"/>
                                <xsl:with-param name="subfield6j" select="slim:subfield[@code='j']"/>
                                <xsl:with-param name="subfield6k" select="slim:subfield[@code='k']"/>
                                <xsl:with-param name="subfield6l" select="slim:subfield[@code='l']"/>
                                <xsl:with-param name="subfield6m" select="slim:subfield[@code='m']"/>
                                <xsl:with-param name="subfield6o" select="slim:subfield[@code='o']"/>
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:if test="string-length($optionalHoldings)>0">
                             <xsl:choose>
                                <xsl:when test="position()=1"><xsl:value-of select="'&#09;'"/></xsl:when>
                                 <xsl:otherwise><xsl:value-of select="'&#09;&#09;&#09;'"/></xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="$optionalHoldings"/><br/><xsl:value-of select="'&#xA;'"/>
                        </xsl:if>
                    </xsl:if>    <!-- <xsl:if test="$indicatorTest='true'"> -->
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:for-each>

    <!-- Display preferred [866|867|868] data fields if they exist -->
    <xsl:for-each select="slim:datafield[@tag=$preferredDataFieldsTag]">

        <!-- Sort by sequence numbers -->
        <xsl:sort
            select="floor(slim:subfield[@code='8'])"
            order="ascending"
            data-type="number"/>
        <xsl:sort
            select="substring-after(slim:subfield[@code='8'], '.')"
            order="ascending"
            data-type="number"/>

        <xsl:variable name="preferredHoldings">
            <xsl:call-template name="buildPreferredDataFields">
                <xsl:with-param name="subfieldA" select="slim:subfield[@code='a']"/>
                <xsl:with-param name="subfieldZ" select="slim:subfield[@code='z']"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="string-length($preferredHoldings)>0">
            <xsl:value-of select="$preferredHoldings"/><br/><xsl:value-of select="'&#xA;'"/>
        </xsl:if>
    </xsl:for-each>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="checkIndicators">
    <xsl:param name="whichPair"/>

    <xsl:variable name="ind1">
        <xsl:value-of select="@ind1"/>
    </xsl:variable>
    <xsl:variable name="ind2">
        <xsl:value-of select="@ind2"/>
    </xsl:variable>

    <xsl:variable name="ind1MustBe">
        <xsl:choose>
            <xsl:when test="$whichPair='3'">
                <xsl:value-of select="$Valid863Indicators_1"/>
            </xsl:when>
            <xsl:when test="$whichPair='4'">
                <xsl:value-of select="$Valid864Indicators_1"/>
            </xsl:when>
            <xsl:when test="$whichPair='5'">
                <xsl:value-of select="$Valid865Indicators_1"/>
            </xsl:when>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="ind2MustBe">
        <xsl:choose>
            <xsl:when test="$whichPair='3'">
                <xsl:value-of select="$Valid863Indicators_2"/>
            </xsl:when>
            <xsl:when test="$whichPair='4'">
                <xsl:value-of select="$Valid864Indicators_2"/>
            </xsl:when>
            <xsl:when test="$whichPair='5'">
                <xsl:value-of select="$Valid865Indicators_2"/>
            </xsl:when>
        </xsl:choose>
    </xsl:variable>

    <xsl:choose>
        <xsl:when test="contains($ind1MustBe, $ind1) and contains($ind2MustBe, $ind2)">
            <xsl:value-of select="'true'"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="'false'"/>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<!-- ************************************************ -->
<xsl:template name="buildPreferredDataFields">
    <xsl:param name="subfieldA"/>
    <xsl:param name="subfieldZ"/>
    <xsl:value-of select="$subfieldA"/>
    <xsl:if test="string-length($subfieldA)>0 and string-length($subfieldZ)>0">
        <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:value-of select="$subfieldZ"/>
</xsl:template>

<!-- ************************************************ -->
<xsl:template name="chronValuesInEnumerativeSubfields">
    <xsl:param name="subfield5a"/>
    <xsl:param name="subfield5b"/>
    <xsl:param name="subfield5c"/>
    <xsl:param name="subfield5d"/>
    <xsl:param name="subfield5e"/>
    <xsl:param name="subfield5f"/>
    <xsl:param name="subfield5i"/>
    <xsl:param name="subfield5j"/>
    <xsl:param name="subfield5k"/>
    <xsl:param name="subfield5l"/>
    <xsl:param name="subfield5m"/>

    <xsl:variable name="subfield5aIsEnum">
        <xsl:choose>
            <xsl:when test="string-length($subfield5a)=0">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:when test="(starts-with($subfield5a, '(')) and (substring($subfield5a, string-length($subfield5a)) = ')')">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'true'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="subfield5bIsEnum">
        <xsl:choose>
            <xsl:when test="string-length($subfield5b)=0">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:when test="(starts-with($subfield5b, '(')) and (substring($subfield5b, string-length($subfield5b)) = ')')">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'true'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="subfield5cIsEnum">
        <xsl:choose>
            <xsl:when test="string-length($subfield5c)=0">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:when test="(starts-with($subfield5c, '(')) and (substring($subfield5c, string-length($subfield5c)) = ')')">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'true'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="subfield5dIsEnum">
        <xsl:choose>
            <xsl:when test="string-length($subfield5d)=0">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:when test="(starts-with($subfield5d, '(')) and (substring($subfield5d, string-length($subfield5d)) = ')')">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'true'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="subfield5eIsEnum">
        <xsl:choose>
            <xsl:when test="string-length($subfield5e)=0">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:when test="(starts-with($subfield5e, '(')) and (substring($subfield5e, string-length($subfield5e)) = ')')">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'true'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="subfield5fIsEnum">
        <xsl:choose>
            <xsl:when test="string-length($subfield5f)=0">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:when test="(starts-with($subfield5f, '(')) and (substring($subfield5f, string-length($subfield5f)) = ')')">
                <xsl:value-of select="'false'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'true'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="lengthOfSubfieldIJKL" select="string-length(concat($subfield5i, $subfield5j, $subfield5k, $subfield5l, $subfield5m))"/>

    <xsl:choose>
        <xsl:when test="contains(concat($subfield5aIsEnum, $subfield5bIsEnum, $subfield5cIsEnum,$subfield5dIsEnum,$subfield5eIsEnum, $subfield5fIsEnum), 'true')">
            <xsl:value-of select = "'false'"/>
        </xsl:when>
        <xsl:when test="$lengthOfSubfieldIJKL!=0">
            <xsl:value-of select = "'false'"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select = "'true'"/>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="buildHoldingsVariableForOptionalDataFields">
    <xsl:param name="areChronValuesInEnumerativeSubfields"/>
    <xsl:param name="lang"/>
    <xsl:param name="whichPair"/>        <!-- send '3' or '4' or '5' -->
    <xsl:param name="subfield5a"/>        <!-- s85*a -->
    <xsl:param name="subfield5b"/>        <!-- s85*b -->
    <xsl:param name="subfield5c"/>        <!-- s85*c -->
    <xsl:param name="subfield5d"/>        <!-- s85*d -->
    <xsl:param name="subfield5e"/>        <!-- s85*e -->
    <xsl:param name="subfield5f"/>        <!-- s85*f -->
    <xsl:param name="subfield5g"/>        <!-- s85*g -->
    <xsl:param name="subfield5h"/>        <!-- s85*h -->
    <xsl:param name="subfield5i"/>        <!-- s85*i -->
    <xsl:param name="subfield5j"/>        <!-- s85*j -->
    <xsl:param name="subfield5k"/>        <!-- s85*k -->
    <xsl:param name="subfield5l"/>        <!-- s85*l -->
    <xsl:param name="subfield5m"/>        <!-- s85*m -->
    <xsl:param name="subfield5o"/>        <!-- s85*o -->
    <xsl:param name="subfield5w"/>        <!-- s85*w -->
    <xsl:param name="subfield6a"/>        <!-- s86*a -->
    <xsl:param name="subfield6b"/>        <!-- s86*b -->
    <xsl:param name="subfield6c"/>        <!-- s86*c -->
    <xsl:param name="subfield6d"/>        <!-- s86*d -->
    <xsl:param name="subfield6e"/>        <!-- s86*e -->
    <xsl:param name="subfield6f"/>        <!-- s86*f -->
    <xsl:param name="subfield6g"/>        <!-- s86*g -->
    <xsl:param name="subfield6h"/>        <!-- s86*h -->
    <xsl:param name="subfield6i"/>        <!-- s86*i -->
    <xsl:param name="subfield6j"/>        <!-- s86*j -->
    <xsl:param name="subfield6k"/>        <!-- s86*k -->
    <xsl:param name="subfield6l"/>        <!-- s86*l -->
    <xsl:param name="subfield6m"/>        <!-- s86*m -->
    <xsl:param name="subfield6o"/>        <!-- s86*o -->

    <xsl:variable name="enum1">
        <xsl:choose>
            <xsl:when test="$areChronValuesInEnumerativeSubfields='false'">
                <xsl:call-template name="buildEnum1Variable">
                    <xsl:with-param name="subfield5a" select="$subfield5a"/>
                    <xsl:with-param name="subfield5b" select="$subfield5b"/>
                    <xsl:with-param name="subfield5c" select="$subfield5c"/>
                    <xsl:with-param name="subfield5d" select="$subfield5d"/>
                    <xsl:with-param name="subfield5e" select="$subfield5e"/>
                    <xsl:with-param name="subfield5f" select="$subfield5f"/>
                    <xsl:with-param name="subfield6a" select="$subfield6a"/>
                    <xsl:with-param name="subfield6b" select="$subfield6b"/>
                    <xsl:with-param name="subfield6c" select="$subfield6c"/>
                    <xsl:with-param name="subfield6d" select="$subfield6d"/>
                    <xsl:with-param name="subfield6e" select="$subfield6e"/>
                    <xsl:with-param name="subfield6f" select="$subfield6f"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="enum2">
        <xsl:choose>
            <xsl:when test="$areChronValuesInEnumerativeSubfields='false'">
                <xsl:call-template name="buildEnum2Variable">
                    <xsl:with-param name="subfield5a" select="$subfield5a"/>
                    <xsl:with-param name="subfield5b" select="$subfield5b"/>
                    <xsl:with-param name="subfield5c" select="$subfield5c"/>
                    <xsl:with-param name="subfield5d" select="$subfield5d"/>
                    <xsl:with-param name="subfield5e" select="$subfield5e"/>
                    <xsl:with-param name="subfield5f" select="$subfield5f"/>
                    <xsl:with-param name="subfield6a" select="$subfield6a"/>
                    <xsl:with-param name="subfield6b" select="$subfield6b"/>
                    <xsl:with-param name="subfield6c" select="$subfield6c"/>
                    <xsl:with-param name="subfield6d" select="$subfield6d"/>
                    <xsl:with-param name="subfield6e" select="$subfield6e"/>
                    <xsl:with-param name="subfield6f" select="$subfield6f"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="chron1">
        <xsl:choose>
            <xsl:when test="$areChronValuesInEnumerativeSubfields='false'">
                <xsl:call-template name="buildChron1Variable">
                    <xsl:with-param name="lang" select="$lang"/>
                    <xsl:with-param name="subfield5i" select="$subfield5i"/>
                    <xsl:with-param name="subfield5j" select="$subfield5j"/>
                    <xsl:with-param name="subfield5k" select="$subfield5k"/>
                    <xsl:with-param name="subfield5l" select="$subfield5l"/>
                    <xsl:with-param name="subfield5w" select="$subfield5w"/>
                    <xsl:with-param name="subfield6i" select="$subfield6i"/>
                    <xsl:with-param name="subfield6j" select="$subfield6j"/>
                    <xsl:with-param name="subfield6k" select="$subfield6k"/>
                    <xsl:with-param name="subfield6l" select="$subfield6l"/>

                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="buildChron1Variable">
                    <xsl:with-param name="lang" select="$lang"/>
                    <xsl:with-param name="subfield5i" select="$subfield5a"/>
                    <xsl:with-param name="subfield5j" select="$subfield5b"/>
                    <xsl:with-param name="subfield5k" select="$subfield5c"/>
                    <xsl:with-param name="subfield5l" select="$subfield5d"/>
                    <xsl:with-param name="subfield5w" select="$subfield5w"/>
                    <xsl:with-param name="subfield6i" select="$subfield6a"/>
                    <xsl:with-param name="subfield6j" select="$subfield6b"/>
                    <xsl:with-param name="subfield6k" select="$subfield6c"/>
                    <xsl:with-param name="subfield6l" select="$subfield6d"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="chron2">
        <xsl:choose>
            <xsl:when test="$areChronValuesInEnumerativeSubfields='false'">
                <xsl:call-template name="buildChron2Variable">
                    <xsl:with-param name="lang" select="$lang"/>
                    <xsl:with-param name="subfield5i" select="$subfield5i"/>
                    <xsl:with-param name="subfield5j" select="$subfield5j"/>
                    <xsl:with-param name="subfield5k" select="$subfield5k"/>
                    <xsl:with-param name="subfield5l" select="$subfield5l"/>
                    <xsl:with-param name="subfield5w" select="$subfield5w"/>
                    <xsl:with-param name="subfield6i" select="$subfield6i"/>
                    <xsl:with-param name="subfield6j" select="$subfield6j"/>
                    <xsl:with-param name="subfield6k" select="$subfield6k"/>
                    <xsl:with-param name="subfield6l" select="$subfield6l"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="buildChron2Variable">
                    <xsl:with-param name="lang" select="$lang"/>
                    <xsl:with-param name="subfield5i" select="$subfield5a"/>
                    <xsl:with-param name="subfield5j" select="$subfield5b"/>
                    <xsl:with-param name="subfield5k" select="$subfield5c"/>
                    <xsl:with-param name="subfield5l" select="$subfield5d"/>
                    <xsl:with-param name="subfield5w" select="$subfield5w"/>
                    <xsl:with-param name="subfield6i" select="$subfield6a"/>
                    <xsl:with-param name="subfield6j" select="$subfield6b"/>
                    <xsl:with-param name="subfield6k" select="$subfield6c"/>
                    <xsl:with-param name="subfield6l" select="$subfield6d"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="altEnum">
        <xsl:choose>
            <xsl:when test="$areChronValuesInEnumerativeSubfields='false'">
                <xsl:call-template name="buildAltEnumVariable">
                    <xsl:with-param name="subfield5g" select="$subfield5g"/>
                    <xsl:with-param name="subfield5h" select="$subfield5h"/>
                    <xsl:with-param name="subfield6g" select="$subfield6g"/>
                    <xsl:with-param name="subfield6h" select="$subfield6h"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="altChron">
        <xsl:choose>
            <xsl:when test="$areChronValuesInEnumerativeSubfields='false'">
                <xsl:call-template name="buildAltChronVariable">
                    <xsl:with-param name="subfield5m" select="$subfield5m"/>
                    <xsl:with-param name="subfield6m" select="$subfield6m"/>
                    <xsl:with-param name="lang" select="$lang"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="buildAltChronVariable">
                    <xsl:with-param name="subfield5m" select="$subfield5e"/>
                    <xsl:with-param name="subfield6m" select="$subfield6e"/>
                    <xsl:with-param name="lang" select="$lang"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="caption">
        <xsl:call-template name="buildCaptionVariable">
            <xsl:with-param name="whichPair" select="$whichPair"/>
            <xsl:with-param name="subfield5o" select="$subfield5o"/>
        </xsl:call-template>
    </xsl:variable>

    <!-- Build the Basic Unit (85*/86*) display  -->

    <xsl:choose>
        <xsl:when test="translate($displayFormat, $lowercase1D, $uppercase1D)='STANDARD'">
            <xsl:call-template name="standardFormat">
                <xsl:with-param name="enum1" select="$enum1"/>
                <xsl:with-param name="enum2" select="$enum2"/>
                <xsl:with-param name="chron1" select="$chron1"/>
                <xsl:with-param name="chron2" select="$chron2"/>
                <xsl:with-param name="altEnum" select="$altEnum"/>
                <xsl:with-param name="altChron" select="$altChron"/>
                <xsl:with-param name="lineCaption" select="$caption"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="translate($displayFormat, $lowercase1D, $uppercase1D)='NISO'">
            <xsl:call-template name="NISOFormat">
                <xsl:with-param name="enum1" select="$enum1"/>
                <xsl:with-param name="enum2" select="$enum2"/>
                <xsl:with-param name="chron1" select="$chron1"/>
                <xsl:with-param name="chron2" select="$chron2"/>
                <xsl:with-param name="altEnum" select="$altEnum"/>
                <xsl:with-param name="altChron" select="$altChron"/>
                <xsl:with-param name="lineCaption" select="$caption"/>
            </xsl:call-template>
        </xsl:when>
    </xsl:choose>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="buildAltEnumVariable">

    <xsl:param name="subfield5g"/>
    <xsl:param name="subfield5h"/>
    <xsl:param name="subfield6g"/>
    <xsl:param name="subfield6h"/>

    <!-- there is no collapsing of alternative enumerations -->

    <xsl:if test="string-length($subfield5g) and string-length($subfield6g)">
        <xsl:value-of select="$subfield5g"/>
        <xsl:if test="substring($subfield5g, (string-length($subfield5g) - string-length($enumLabelDataSeparator)) + 1) != $enumLabelDataSeparator">
            <xsl:value-of select="$enumLabelDataSeparator"/>
        </xsl:if>
        <xsl:value-of select="$subfield6g"/>
    </xsl:if>

    <xsl:if test="string-length($subfield5g) and string-length($subfield6g) and string-length($subfield5h) and string-length($subfield6h)">
        <xsl:value-of select="$enumLevelSeparator"/>
    </xsl:if>

    <xsl:if test="string-length($subfield5h) and string-length($subfield6h)">
        <xsl:value-of select="$subfield5h"/>
        <xsl:if test="substring($subfield5h, (string-length($subfield5h) - string-length($enumLabelDataSeparator)) + 1) != $enumLabelDataSeparator">
            <xsl:value-of select="$enumLabelDataSeparator"/>
        </xsl:if>
        <xsl:value-of select="$subfield6h"/>
    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="buildAltChronVariable">
    <xsl:param name="subfield5m"/>
    <xsl:param name="subfield6m"/>
    <xsl:param name="lang"/>

    <xsl:if test="string-length($subfield5m) and string-length($subfield6m)">
        <xsl:variable name="prefix">
            <xsl:call-template name="hyphenPrefix">
                <xsl:with-param name="text" select="$subfield6m"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="suffix">
            <xsl:call-template name="hyphenSuffixDedupe">
                <xsl:with-param name="text" select="$subfield6m"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="string-length($prefix)">
            <xsl:call-template name="displayChronCaption">
                <xsl:with-param name="caption" select="$subfield5m"/>
            </xsl:call-template>
            <xsl:call-template name="getChron">
                <xsl:with-param name="caption" select="$subfield5m"/>
                <xsl:with-param name="text" select="$prefix"/>
                <xsl:with-param name="lang" select="$lang"/>
                <xsl:with-param name="frequency" select="0"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="string-length($suffix)">
            <xsl:value-of select="$chronologyRangeSeparator"/>
            <xsl:call-template name="displayChronCaption">
                <xsl:with-param name="caption" select="$subfield5m"/>
            </xsl:call-template>
            <xsl:call-template name="getChron">
                <xsl:with-param name="caption" select="$subfield5m"/>
                <xsl:with-param name="text" select="$suffix"/>
                <xsl:with-param name="lang" select="$lang"/>
                <xsl:with-param name="frequency" select="0"/>
            </xsl:call-template>
        </xsl:if>

    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="buildCaptionVariable">
    <xsl:param name="whichPair"/>
    <xsl:param name="subfield5o"/>

    <xsl:if test="$whichPair != '3'">
        <xsl:choose>
            <xsl:when test="$whichPair = '4'">
                <xsl:value-of select="$supplementCaption"/>
            </xsl:when>
            <xsl:when test="$whichPair = '5'">
                <xsl:value-of select="$indexCaption"/>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="string-length($subfield5o)">
            <xsl:value-of select="concat(' - ', $subfield5o)"/>
        </xsl:if>
    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="buildEnum1Variable">
    <xsl:param name="subfield5a"/>
    <xsl:param name="subfield5b"/>
    <xsl:param name="subfield5c"/>
    <xsl:param name="subfield5d"/>
    <xsl:param name="subfield5e"/>
    <xsl:param name="subfield5f"/>
    <xsl:param name="subfield6a"/>
    <xsl:param name="subfield6b"/>
    <xsl:param name="subfield6c"/>
    <xsl:param name="subfield6d"/>
    <xsl:param name="subfield6e"/>
    <xsl:param name="subfield6f"/>

    <xsl:call-template name="concatEnum1">
        <xsl:with-param name="caption" select="$subfield5a"/>
        <xsl:with-param name="data" select="$subfield6a"/>
        <xsl:with-param name="previous" select="false()"/>
    </xsl:call-template>

    <xsl:call-template name="concatEnum1">
        <xsl:with-param name="caption" select="$subfield5b"/>
        <xsl:with-param name="data" select="$subfield6b"/>
    </xsl:call-template>

    <xsl:call-template name="concatEnum1">
        <xsl:with-param name="caption" select="$subfield5c"/>
        <xsl:with-param name="data" select="$subfield6c"/>
    </xsl:call-template>

    <xsl:call-template name="concatEnum1">
        <xsl:with-param name="caption" select="$subfield5d"/>
        <xsl:with-param name="data" select="$subfield6d"/>
    </xsl:call-template>

    <xsl:call-template name="concatEnum1">
        <xsl:with-param name="caption" select="$subfield5e"/>
        <xsl:with-param name="data" select="$subfield6e"/>
    </xsl:call-template>

    <xsl:call-template name="concatEnum1">
        <xsl:with-param name="caption" select="$subfield5f"/>
        <xsl:with-param name="data" select="$subfield6f"/>
    </xsl:call-template>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="concatEnum1">
    <xsl:param name="caption"/>
    <xsl:param name="data"/>
    <xsl:param name="previous" select="true()"/>

    <xsl:if test="string-length($data)">
        <xsl:variable name="prefix">
            <xsl:call-template name="hyphenPrefix">
                <xsl:with-param name="text" select="$data"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="string-length($prefix)">
            <xsl:if test="$previous = true()">
                <xsl:value-of select="$enumLevelSeparator"/>
            </xsl:if>
            <xsl:value-of select="$caption"/>
            <xsl:if test="substring($caption, (string-length($caption) - string-length($enumLabelDataSeparator)) + 1) != $enumLabelDataSeparator">
                <xsl:value-of select="$enumLabelDataSeparator"/>
            </xsl:if>
            <xsl:value-of select="$prefix"/>
        </xsl:if>
    </xsl:if>
</xsl:template>

<!-- ************************************************ -->

<xsl:template name="buildEnum2Variable">
    <xsl:param name="subfield5a"/>
    <xsl:param name="subfield5b"/>
    <xsl:param name="subfield5c"/>
    <xsl:param name="subfield5d"/>
    <xsl:param name="subfield5e"/>
    <xsl:param name="subfield5f"/>
    <xsl:param name="subfield6a"/>
    <xsl:param name="subfield6b"/>
    <xsl:param name="subfield6c"/>
    <xsl:param name="subfield6d"/>
    <xsl:param name="subfield6e"/>
    <xsl:param name="subfield6f"/>

    <xsl:if test="string-length($subfield6a)">
        <xsl:variable name="displayA">
            <xsl:call-template name="concatEnum2">
                <xsl:with-param name="caption" select="$subfield5a"/>
                <xsl:with-param name="data" select="$subfield6a"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$displayA"/>

        <xsl:if test="string-length($subfield6b)">
            <xsl:variable name="displayB">
                <xsl:call-template name="concatEnum2">
                    <xsl:with-param name="caption" select="$subfield5b"/>
                    <xsl:with-param name="data" select="$subfield6b"/>
                    <xsl:with-param name="previous" select="string-length($displayA)"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$displayB"/>

            <xsl:if test="string-length($subfield6c)">
                <xsl:variable name="displayC">
                    <xsl:call-template name="concatEnum2">
                        <xsl:with-param name="caption" select="$subfield5c"/>
                        <xsl:with-param name="data" select="$subfield6c"/>
                        <xsl:with-param name="previous" select="number(string-length($displayA) + string-length($displayB))"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:value-of select="$displayC"/>

                <xsl:if test="string-length($subfield6d)">
                    <xsl:variable name="displayD">
                        <xsl:call-template name="concatEnum2">
                            <xsl:with-param name="caption" select="$subfield5d"/>
                            <xsl:with-param name="data" select="$subfield6d"/>
                            <xsl:with-param name="previous" select="number(string-length($displayA) + string-length($displayB) + string-length($displayC))"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:value-of select="$displayD"/>

                    <xsl:if test="string-length($subfield6e)">
                        <xsl:variable name="displayE">
                            <xsl:call-template name="concatEnum2">
                                <xsl:with-param name="caption" select="$subfield5e"/>
                                <xsl:with-param name="data" select="$subfield6e"/>
                                <xsl:with-param name="previous" select="number(string-length($displayA) + string-length($displayB) + string-length($displayC) + string-length($displayD))"/>
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:value-of select="$displayE"/>

                        <xsl:if test="string-length($subfield6f)">
                            <xsl:variable name="displayF">
                                <xsl:call-template name="concatEnum2">
                                    <xsl:with-param name="caption" select="$subfield5f"/>
                                    <xsl:with-param name="data" select="$subfield6f"/>
                                    <xsl:with-param name="previous" select="number(string-length($displayA) + string-length($displayB) + string-length($displayC) + string-length($displayD) + string-length($displayE))"/>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:value-of select="$displayF"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:if>
            </xsl:if>
        </xsl:if>
    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="concatEnum2">
    <xsl:param name="caption"/>
    <xsl:param name="data"/>
    <xsl:param name="previous" select="'0'"/>

    <xsl:if test="string-length($data)">
        <xsl:variable name="suffix">
            <xsl:call-template name="hyphenSuffixDedupe">
                <xsl:with-param name="text" select="$data"/>
                <xsl:with-param name="previous" select="$previous"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="string-length($suffix)">
            <xsl:if test="number($previous) > 0">
                <xsl:value-of select="$enumLevelSeparator"/>
            </xsl:if>
            <xsl:value-of select="$caption"/>
            <xsl:if test="substring($caption, (string-length($caption) - string-length($enumLabelDataSeparator)) + 1) != $enumLabelDataSeparator">
                <xsl:value-of select="$enumLabelDataSeparator"/>
            </xsl:if>
            <xsl:value-of select="$suffix"/>
        </xsl:if>
    </xsl:if>
</xsl:template>

<!-- ************************************************ -->
<xsl:template name="buildChron1Variable">
    <xsl:param name="lang"/>
    <xsl:param name="subfield5i"/>
    <xsl:param name="subfield5j"/>
    <xsl:param name="subfield5k"/>
    <xsl:param name="subfield5l"/>
    <xsl:param name="subfield5w"/>
    <xsl:param name="subfield6i"/>
    <xsl:param name="subfield6j"/>
    <xsl:param name="subfield6k"/>
    <xsl:param name="subfield6l"/>

    <xsl:if test="string-length($subfield5i) and string-length($subfield6i)">
        <xsl:variable name="prefixI">
            <xsl:call-template name="hyphenPrefix">
                <xsl:with-param name="text" select="$subfield6i"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="displayI">
            <xsl:call-template name="getChron">
                <xsl:with-param name="caption" select="$subfield5i"/>
                <xsl:with-param name="text" select="$prefixI"/>
                <xsl:with-param name="lang" select="$lang"/>
                <xsl:with-param name="frequency" select="0"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="displayChronCaption">
            <xsl:with-param name="caption" select="$subfield5i"/>
        </xsl:call-template>
        <xsl:value-of select="$displayI"/>
    </xsl:if>

    <xsl:if test="string-length($subfield5j) and string-length($subfield6j)">
        <xsl:variable name="prefixJ">
            <xsl:call-template name="hyphenPrefix">
                <xsl:with-param name="text" select="$subfield6j"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="displayJ">
            <xsl:call-template name="getChron">
                <xsl:with-param name="caption" select="$subfield5j"/>
                <xsl:with-param name="text" select="$prefixJ"/>
                <xsl:with-param name="lang" select="$lang"/>
                <xsl:with-param name="frequency" select="$subfield5w"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$chronologyLevelSeparator"/>
        <xsl:call-template name="displayChronCaption">
            <xsl:with-param name="caption" select="$subfield5j"/>
        </xsl:call-template>
        <xsl:value-of select="$displayJ"/>
    </xsl:if>

    <xsl:if test="string-length($subfield5k) and string-length($subfield6k)">
        <xsl:variable name="prefixK">
            <xsl:call-template name="hyphenPrefix">
                <xsl:with-param name="text" select="$subfield6k"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="displayK">
            <xsl:call-template name="getChron">
                <xsl:with-param name="caption" select="$subfield5k"/>
                <xsl:with-param name="text" select="$prefixK"/>
                <xsl:with-param name="lang" select="$lang"/>
                <xsl:with-param name="frequency" select="0"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$chronologyLevelSeparator"/>
        <xsl:call-template name="displayChronCaption">
            <xsl:with-param name="caption" select="$subfield5k"/>
        </xsl:call-template>
        <xsl:value-of select="$displayK"/>
    </xsl:if>

    <xsl:if test="string-length($subfield5l) and string-length($subfield6l)">
        <xsl:variable name="prefixL">
            <xsl:call-template name="hyphenPrefix">
                <xsl:with-param name="text" select="$subfield6l"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="displayL">
            <xsl:call-template name="getChron">
                <xsl:with-param name="caption" select="$subfield5l"/>
                <xsl:with-param name="text" select="$prefixL"/>
                <xsl:with-param name="lang" select="$lang"/>
                <xsl:with-param name="frequency" select="0"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$chronologyLevelSeparator"/>
        <xsl:call-template name="displayChronCaption">
            <xsl:with-param name="caption" select="$subfield5l"/>
        </xsl:call-template>
        <xsl:value-of select="$displayL"/>
    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="buildChron2Variable">
    <xsl:param name="lang"/>
    <xsl:param name="subfield5i"/>
    <xsl:param name="subfield5j"/>
    <xsl:param name="subfield5k"/>
    <xsl:param name="subfield5l"/>
    <xsl:param name="subfield5w"/>
    <xsl:param name="subfield6i"/>
    <xsl:param name="subfield6j"/>
    <xsl:param name="subfield6k"/>
    <xsl:param name="subfield6l"/>

    <xsl:variable name="displayI">
        <xsl:choose>
            <xsl:when test="string-length($subfield5i) and contains($subfield6i, '-')">
                <xsl:call-template name="getChron">
                    <xsl:with-param name="caption" select="$subfield5i"/>
                    <xsl:with-param name="text" select="substring-after($subfield6i, '-')"/>
                    <xsl:with-param name="lang" select="$lang"/>
                    <xsl:with-param name="frequency" select="0"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <!-- Need some value to test for chronology level separator -->
                <xsl:value-of select = "''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:if test="string-length($displayI)">
        <xsl:call-template name="displayChronCaption">
            <xsl:with-param name="caption" select="$subfield5i"/>
        </xsl:call-template>
        <xsl:value-of select="$displayI"/>
    </xsl:if>

    <xsl:if test="string-length($subfield5j) and contains($subfield6j, '-')">
        <!-- Count hyphens.  Multiple dashes indicate a quarterly issue chronology -->
        <xsl:variable name="hyphenCount">
            <xsl:call-template name="countHyphenInSubfield">
                <xsl:with-param name="subfield" select="$subfield6j"/>
                </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="displayJ">
            <xsl:choose>
                <xsl:when test="$hyphenCount = '1' or $hyphenCount != '3'">
                    <xsl:call-template name="getChron">
                        <xsl:with-param name="caption" select="$subfield5j"/>
                        <xsl:with-param name="text" select="substring-after($subfield6j, '-')"/>
                        <xsl:with-param name="lang" select="$lang"/>
                        <xsl:with-param name="frequency" select="$subfield5w"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="textAfterSecondHyphen">
                        <xsl:call-template name="getTextAfterSecondHyphen">
                            <xsl:with-param name="text" select="$subfield6j"/>
                        </xsl:call-template>
                    </xsl:variable>

                    <xsl:call-template name="getChron">
                        <xsl:with-param name="caption" select="$subfield5j"/>
                        <xsl:with-param name="text" select="$textAfterSecondHyphen"/>
                        <xsl:with-param name="lang" select="$lang"/>
                        <xsl:with-param name="frequency" select="$subfield5w"/>
                    </xsl:call-template>

                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="string-length($displayI)">
            <xsl:value-of select="$chronologyLevelSeparator"/>
        </xsl:if>
        <xsl:call-template name="displayChronCaption">
            <xsl:with-param name="caption" select="$subfield5j"/>
        </xsl:call-template>
        <xsl:value-of select="$displayJ"/>
    </xsl:if>

    <xsl:if test="string-length($subfield5k) and contains($subfield6k, '-')">
        <xsl:variable name="displayK">
            <xsl:call-template name="getChron">
                <xsl:with-param name="caption" select="$subfield5k"/>
                <xsl:with-param name="text" select="substring-after($subfield6k, '-')"/>
                <xsl:with-param name="lang" select="$lang"/>
                <xsl:with-param name="frequency" select="0"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$chronologyLevelSeparator"/>
        <xsl:call-template name="displayChronCaption">
            <xsl:with-param name="caption" select="$subfield5k"/>
        </xsl:call-template>
        <xsl:value-of select="$displayK"/>
    </xsl:if>

    <xsl:if test="string-length($subfield5l) and contains($subfield6l, '-')">
        <xsl:variable name="displayL">
            <xsl:call-template name="getChron">
                <xsl:with-param name="caption" select="$subfield5l"/>
                <xsl:with-param name="text" select="substring-after($subfield6l, '-')"/>
                <xsl:with-param name="lang" select="$lang"/>
                <xsl:with-param name="frequency" select="0"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$chronologyLevelSeparator"/>
        <xsl:call-template name="displayChronCaption">
            <xsl:with-param name="caption" select="$subfield5l"/>
        </xsl:call-template>
        <xsl:value-of select="$displayL"/>
    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="standardFormat">
    <xsl:param name="enum1"/>
    <xsl:param name="enum2"/>
    <xsl:param name="chron1"/>
    <xsl:param name="chron2"/>
    <xsl:param name="altEnum"/>
    <xsl:param name="altChron"/>
    <xsl:param name="lineCaption"/>

    <xsl:if test="string-length($lineCaption)">
        <xsl:value-of select="concat($lineCaption, ': ')"/>
    </xsl:if>

    <xsl:if test="string-length($enum1)">
        <xsl:value-of select="$enum1"/>
    </xsl:if>

    <xsl:if test="string-length($enum2) and $enum2 != $enum1">
        <xsl:value-of select="concat(' - ',  $enum2)"/>
    </xsl:if>

    <xsl:if test="string-length($altEnum)">
        <xsl:value-of select="concat(' (', $altEnum, ')' )"/>
    </xsl:if>

    <xsl:if test="string-length($chron1)">
        <xsl:value-of select="concat(' (', $chron1)"/>

        <xsl:if test="string-length($chron2) and $chron2 != $chron1">
            <xsl:value-of select="concat(' - ', $chron2)"/>
        </xsl:if>

        <xsl:value-of select="')'"/>
    </xsl:if>

    <xsl:if test="string-length($altChron)">
        <xsl:value-of select="concat(' (', $altChron, ')' )"/>
    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="NISOFormat">
    <xsl:param name="enum1"/>
    <xsl:param name="enum2"/>
    <xsl:param name="chron1"/>
    <xsl:param name="chron2"/>
    <xsl:param name="altEnum"/>
    <xsl:param name="altChron"/>
    <xsl:param name="lineCaption"/>

    <xsl:if test="string-length($lineCaption)">
        <xsl:value-of select="concat($lineCaption, ':')"/>
    </xsl:if>

    <xsl:if test="string-length($enum1)">
        <xsl:value-of select="$enum1"/>
    </xsl:if>

    <xsl:if test="string-length($chron1)">
        <xsl:value-of select="concat('(', $chron1, ')')"/>
    </xsl:if>

    <xsl:if test="string-length($chron1) or string-length($chron2)">
        <xsl:value-of select="'-'"/>
    </xsl:if>

    <xsl:if test="string-length($enum2)">
        <xsl:value-of select="$enum2"/>
    </xsl:if>

    <xsl:if test="string-length($chron2)">
        <xsl:value-of select="concat('(', $chron2, ')')"/>
    </xsl:if>

    <xsl:if test="string-length($altEnum)">
        <xsl:value-of select="concat('=', $altEnum)"/>
    </xsl:if>

    <xsl:if test="string-length($altChron)">
        <xsl:value-of select="concat('(', $altChron, ')' )"/>
    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="hyphenPrefix">
    <xsl:param name="text"/>

    <xsl:variable name="hyphenCount">
        <xsl:call-template name="countHyphenInSubfield">
            <xsl:with-param name="subfield" select="$text"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
        <!-- Expecting three hyphens if there is more than 1 -->
        <xsl:when test="$hyphenCount &gt; 1">
            <xsl:variable name="textAfterSecondHyphen">
                <xsl:call-template name="getTextAfterSecondHyphen">
                    <xsl:with-param name="text" select="$text"/>
                </xsl:call-template>
            </xsl:variable>

            <!-- Add a hyphen before the end part -->
            <xsl:variable name="textAfterSecondHyphenWithPreHyphen">
                <xsl:value-of select="concat('-', $textAfterSecondHyphen)"/>
            </xsl:variable>

            <xsl:value-of select="substring-before($text, $textAfterSecondHyphenWithPreHyphen)"/>
        </xsl:when>

        <!-- Is there a hyphen and something after the hyphen? -->
        <xsl:when test="$hyphenCount = 1 and substring-after($text, '-')">
                <xsl:value-of select="substring-before($text, '-')"/>
        </xsl:when>

        <!-- Is there a hyphen?  There is nothing after the hyphen but include hyphen in display. -->
        <xsl:when test="$hyphenCount = 1">
                <xsl:value-of select="concat(substring-before($text, '-'),' -')"/>
        </xsl:when>
        <xsl:otherwise>
                <xsl:value-of select="$text"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- **************************************** -->

<xsl:template name="hyphenSuffixDedupe">
    <xsl:param name="text"/>
    <xsl:param name="previous" select="'0'"/>

    <xsl:if test="contains($text, '-' )">
        <xsl:value-of select="substring-after($text, '-')"/>
    </xsl:if>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="getChron">
    <xsl:param name="caption"/>
    <xsl:param name="text"/>
    <xsl:param name="lang"/>
    <xsl:param name="frequency"/>

    <!-- do we need to translate a chronology code? -->
    <xsl:choose>
        <xsl:when test="contains($caption, 'month') or contains($caption, 'season')">

            <!-- yes -->
            <xsl:variable name="chronName">
                <xsl:choose>
                    <!-- check for double chrons -->
                    <xsl:when test="contains($text, '/')">
                        <xsl:variable name="temp1a" select="substring-before($text, '/')"/>
                        <xsl:variable name="temp1b" select="substring-after($text, '/')"/>

                        <xsl:variable name="temp1aName">
                            <xsl:call-template name="translateChron">
                                <xsl:with-param name="chronCode" select="$temp1a"/>
                                <xsl:with-param name="chronLang" select="$lang"/>
                                <xsl:with-param name="frequency" select="$frequency"/>
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:variable name="temp1bName">
                            <xsl:call-template name="translateChron">
                                <xsl:with-param name="chronCode" select="$temp1b"/>
                                <xsl:with-param name="chronLang" select="$lang"/>
                                <xsl:with-param name="frequency" select="$frequency"/>
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:value-of select="concat($temp1aName, '/', $temp1bName) "/>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:variable name="temp1Name">
                            <xsl:call-template name="translateChron">
                                <xsl:with-param name="chronCode" select="$text"/>
                                <xsl:with-param name="chronLang" select="$lang"/>
                                <xsl:with-param name="frequency" select="$frequency"/>
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:value-of select="$temp1Name"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:value-of select="$chronName"/>
        </xsl:when>

        <xsl:otherwise>
            <!-- no chron code - just display text -->
            <xsl:value-of select="$text"/>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<!-- ************************************************ -->

<xsl:template name="translateChron">
    <xsl:param name="chronCode"/>
    <xsl:param name="chronLang"/>
    <xsl:param name="frequency"/>

    <!-- uppercase1D chronLang -->
    <xsl:variable name="chronLangUC">
        <xsl:call-template name="uppercase1D">
            <xsl:with-param name="text" select="$chronLang"/>
        </xsl:call-template>
    </xsl:variable>

    <!-- see if <lang> element with chronLangUC attribute exists in chronValues file -->
    <xsl:variable name="testForLang">
        <xsl:value-of select="$chronValues//lang[@id=$chronLangUC]/@id"/>
    </xsl:variable>

    <xsl:variable name="pubFrequency">
        <xsl:choose>
            <xsl:when test="$frequency='b'">
                <!-- Frequency is Bi-Monthly -->
                <xsl:value-of select="concat('-',$frequency)"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Default is empty -->
                <xsl:value-of select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <!-- if chronLangUC was found, use that for language. Otherwise, default to ENG -->
    <xsl:variable name="language">
        <xsl:choose>
            <xsl:when test="(string-length($testForLang) and $pubFrequency!='')">
                <xsl:value-of select="concat($testForLang,$pubFrequency)"/>
            </xsl:when>
            <xsl:when test="string-length($testForLang)">
                <xsl:value-of select="($testForLang)"/>
            </xsl:when>
            <xsl:when test="$pubFrequency!=''">
                <xsl:value-of select="concat('ENG',$pubFrequency)"/>
            </xsl:when>
            <xsl:otherwise>ENG</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <!-- chronCode may or may not have a leading zero - so let's strip any leading zero's -->
    <xsl:variable name="chroncodeNoZero">
        <xsl:choose>
            <xsl:when test="starts-with($chronCode, '0')">
                <xsl:value-of select="substring-after($chronCode, '0')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$chronCode"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <!-- get the value for chronCode -->
    <xsl:variable name="text" select="$chronValues//lang[@id=$language]/chron[@id=$chroncodeNoZero]"/>

    <!-- if no value was matched for chronCode, display the given chronCode -->
    <xsl:choose>
        <xsl:when test="string-length($text)"><xsl:value-of select="$text"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$chronCode"/></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ************************************************ -->
<xsl:template name="uppercase1D">
    <xsl:param name="text"/>
    <xsl:variable name="uppercase1DText" select="translate($text, $lowercase1D, $uppercase1D)"/>
    <xsl:value-of select="$uppercase1DText"/>
</xsl:template>

<!-- ************************************************ -->

<xsl:template name="displayChronCaption">
    <xsl:param name="caption"/>
    <xsl:choose>
        <xsl:when test="(starts-with($caption, '(')) and (substring($caption, string-length($caption)) = ')')">
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$caption"/>
            <xsl:if test="substring($caption, (string-length($caption) - string-length($chronLabelDataSeparator)) + 1) != $chronLabelDataSeparator">
                <xsl:value-of select="$chronLabelDataSeparator"/>
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ************************************************ -->

<xsl:template name="countHyphenInSubfield">
    <xsl:param name="subfield"/>

    <xsl:variable name="hyphenCounter">
        <!-- Remove hyphens from string and check the difference to get the counter. -->
        <xsl:value-of select="string-length($subfield) - string-length(translate($subfield, '-', ''))"/>
    </xsl:variable>
    <xsl:value-of select="$hyphenCounter"/>
</xsl:template>

<!-- ************************************************ -->

<xsl:template name="getTextAfterSecondHyphen">
    <xsl:param name="text"/>

    <xsl:variable name="textAfterHyphen">
        <xsl:value-of select="substring-after($text, '-')"/>
    </xsl:variable>

    <xsl:value-of select="substring-after($textAfterHyphen, '-')"/>
</xsl:template>

</xsl:stylesheet>





