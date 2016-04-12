<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.24 $ $Date: 2013/11/21 15:58:21 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#            All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: display_text
**          Version : 7.2.0
**          Created : 2-NOV-2007
**      Orig Author : Scott Morgan
**    Last Modified : 16-SEP-2009
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

    <xsl:import href="../display/marc21slim_text.xsl"/>

    <xsl:import href="../configs/104X_display.xsl"/>
    <xsl:import href="../configs/102X_display.xsl"/>

    <!-- VYG-612: inherited from mard21slim_text.xsl
    <xsl:variable name="new_line" select="'&#xA;'" />
     -->
    <xsl:variable name="tab" select="'&#09;'" />

    <xsl:variable name="constStr_Field000Leader">000</xsl:variable>
    <xsl:variable name="constStr_SpacingUnderline">_</xsl:variable>
    <xsl:variable name="constStr_SubfieldPipe">|</xsl:variable>
    <xsl:variable name="chronValues" select="document('../configs/104X_chronValues.xml')"/>
    <!-- ## Our Document Holders ## -->

    <xsl:variable name="pageXML" select="/"/>

    <xsl:variable name="HoldXML" select="//hol:holdingsCollection"/>
    <xsl:variable name="bibRecord" select="//hol:bibRecord "/>
    <xsl:variable name="bibID" select="//hol:bibRecord/@bibId"/>
    <xsl:variable name="mfhdRecord" select="//hol:mfhdCollection/mfhd:mfhdRecord"/>
   <xsl:variable name="Configs" select="document('../../userTextConfigs/pageProperties.xml')"/>

   <xsl:variable name="bibFormats" select="$Configs/pageConfigs/bibFormats"/>
	<!-- VYG-1113: rename these two variables, since under some conditions
	     they are in the same scope as other .xsl files, but not always. -->
   <xsl:variable name="lowercaseDT" select="'abcdefghijklmnopqrstuvwxyz'" />
   <xsl:variable name="uppercaseDT" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <!-- ###################################################################### -->

    <xsl:template name="buildMarcDisplay">
        <xsl:param name="mfhdID"/>
        <xsl:param name="recordType"/>

        <xsl:choose>
            <xsl:when test="$recordType='bib'">
                <!-- ## Bibliographic Title ## -->
                <xsl:call-template name="buildTitle">
                       <xsl:with-param name="mfhdID" select="$mfhdID"/>
                       <xsl:with-param name="recordType" select="$recordType"/>
                </xsl:call-template>

                <!-- ## Bibliographic Tags ## -->
                <xsl:for-each select="/display/displayTags">


                    <xsl:variable name="displayData">
                        <xsl:call-template name="processDisplayTags">
                            <xsl:with-param name="mfhdID" select="$mfhdID"/>
                            <xsl:with-param name="recordType" select="$recordType"/>
                            <xsl:with-param name="label" select="@label"/>
                        </xsl:call-template>
                    </xsl:variable>

                    <xsl:call-template name="outputDisplayData">
                        <xsl:with-param name="displayData" select="$displayData"/>
                    </xsl:call-template>

                    <!--xsl:call-template name="processDisplayTagsThenOutputDisplayData">
                        <xsl:with-param name="mfhdID" select="$mfhdID"/>
                        <xsl:with-param name="recordType" select="$recordType"/>
                    </xsl:call-template-->
                </xsl:for-each>

            </xsl:when>
            <xsl:when test="$recordType='mfhd'">
                <!-- ## Holdings Tags ## -->
                <!-- ## Process Each Section of Holdings Tags at a time -->
                <xsl:for-each select="/display/holdingsTags">

                            <xsl:variable name="displayData">
                               <xsl:call-template name="processDisplayTags">
                                  <xsl:with-param name="mfhdID" select="$mfhdID"/>
                                  <xsl:with-param name="recordType" select="$recordType"/>
                                  <xsl:with-param name="label" select="@label"/>
                               </xsl:call-template>
                            </xsl:variable>

                            <xsl:call-template name="outputDisplayData">
                               <xsl:with-param name="displayData" select="$displayData"/>
                            </xsl:call-template>

                    <!--xsl:call-template name="processDisplayTagsThenOutputDisplayData">
                        <xsl:with-param name="mfhdID" select="$mfhdID"/>
                        <xsl:with-param name="recordType" select="$recordType"/>
                    </xsl:call-template-->
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
        <xsl:value-of select="$new_line" />
        <xsl:value-of select="$new_line" />
        <xsl:value-of select="$new_line" />
        <xsl:value-of select="$new_line" />
    </xsl:template>


<!-- ###################################################################### -->

<xsl:template name="buildTitle">
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>


    <xsl:for-each select="/display/titleTags">
        <xsl:variable name="displayData">
            <xsl:call-template name="processDisplayTags">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="recordType" select="$recordType"/>
               </xsl:call-template>
        </xsl:variable>
        <xsl:copy-of select="$displayData"/>
    </xsl:for-each>
    <xsl:value-of select="$new_line"/>
</xsl:template>

<!-- ###################################################################### -->
<xsl:template name="addTabsBeforeDataAfterLabel">
<xsl:param name="label"/>

    <xsl:choose>
        <xsl:when test="string-length($label)">
            <xsl:choose>
                <!--  assume tab size of 8 for most text editors -->
                <xsl:when test="string-length($label) &lt; 8 ">
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                </xsl:when>
                <xsl:when test="string-length($label) &lt; 12 ">
                    <xsl:value-of select="$tab"/>
                </xsl:when>
                <xsl:when test="string-length($label) &gt; 11 ">
                    <xsl:value-of select="' '"/>
                </xsl:when>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
            &#160;
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="addTabsBeforeDataWithoutLabel">
<xsl:param name="label"/>

    <xsl:choose>
        <xsl:when test="string-length($label)">
            <xsl:choose>
                <!--  assume tab size of 8 for most text editors -->
                <xsl:when test="string-length($label) &lt; 12 ">
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                </xsl:when>
                <xsl:when test="string-length($label) &gt; 11 ">
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                </xsl:when>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
            &#160;
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="outputDisplayData">
<xsl:param name="displayData"/>

<xsl:choose>
    <xsl:when test="string-length($displayData) and displayTag/@field='9000'">
        <xsl:choose>
            <xsl:when test="string-length(@label)">
                <xsl:value-of select="@label"/>
            </xsl:when>
        </xsl:choose>

        <xsl:value-of select="$new_line"/>

        <xsl:call-template name="addTabsBeforeDataAfterLabel">
            <xsl:with-param name="label" select="@label"/>
        </xsl:call-template>

        <xsl:copy-of select="$displayData"/>
    </xsl:when>

    <xsl:when test="string-length($displayData)">
        <xsl:choose>
            <xsl:when test="string-length(@label)">
                <xsl:value-of select="@label"/>
            </xsl:when>
        </xsl:choose>

        <xsl:call-template name="addTabsBeforeDataAfterLabel">
            <xsl:with-param name="label" select="@label"/>
        </xsl:call-template>

        <xsl:copy-of select="$displayData"/>
        <xsl:value-of select="$new_line"/>
    </xsl:when>

    <xsl:when test="not(string-length($displayData))">
        <xsl:if test="string-length(@notFound)">
            <xsl:choose>
                <xsl:when test="string-length(@label)">
                    <xsl:value-of select="@label"/>
                </xsl:when>
            </xsl:choose>

            <xsl:call-template name="addTabsBeforeDataAfterLabel">
                <xsl:with-param name="label" select="@label"/>
            </xsl:call-template>

            <xsl:value-of select="@notFound"/>
            <xsl:value-of select="$new_line"/>
        </xsl:if>
    </xsl:when>
</xsl:choose>


</xsl:template>


<!-- ###################################################################### -->

<xsl:template name="processDisplayTagsThenOutputDisplayData">
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>

        <label id="fieldLabel">
            <xsl:value-of select="@label"/>
        </label>
        <xsl:call-template name="addTabsBeforeDataAfterLabel">
            <xsl:with-param name="label" select="@label"/>
        </xsl:call-template>
        <xsl:call-template name="processDisplayTags">
                <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="recordType" select="$recordType"/>
                <xsl:with-param name="label" select="@label"/>
        </xsl:call-template>
        <xsl:value-of select="$new_line"/>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="processDisplayTags">
    <xsl:param name="mfhdID"/>
    <xsl:param name="recordType"/>
    <xsl:param name="label"/>

    <xsl:for-each select="displayTag">
        <xsl:choose>
            <xsl:when test="@field &lt; '1000'">
                <xsl:call-template name="BMDProcessMarcTags">
                    <xsl:with-param name="label" select="$label"/>
                    <xsl:with-param name="field" select="@field"/>
                    <xsl:with-param name="indicator1" select="@indicator1"/>
                    <xsl:with-param name="indicator2" select="@indicator2"/>
                    <xsl:with-param name="subfield" select="@subfield"/>
                    <xsl:with-param name="mfhdID" select="$mfhdID"/>
                    <xsl:with-param name="recordType" select="$recordType"/>
                </xsl:call-template>
            </xsl:when>
            <!-- MFHD location will be displayed along with item locations in BMD1005 -->
            <xsl:when test="@field = '1002'">                                    <!-- ## database name ## -->
               <xsl:call-template name="BMD1002">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1005'">                                    <!-- ## 1005 Item Location  ## -->
                <xsl:call-template name="BMD1005">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1010'">                                    <!-- ## number of items linked to mfhd ## -->
                <xsl:call-template name="BMD1010">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1012'">                                    <!-- ## item status for item record ## -->
                <xsl:call-template name="BMD1012">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1020'">                                    <!-- ## Recent issues from serials ## -->
                <xsl:call-template name="BMD1020">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1021'">                                    <!-- ## Recent issues/xsl ## -->
                <xsl:call-template name="BMD102X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1021'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1022'">                                    <!-- ## supplements ## -->
                <xsl:call-template name="BMD1022">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1023'">                                    <!-- ## supplements/xsl ## -->
                <xsl:call-template name="BMD102X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1023'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1024'">                                    <!-- ## indexes ## -->
                <xsl:call-template name="BMD1024">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1025'">                                    <!-- ## indexes/xsl ## -->
                <xsl:call-template name="BMD102X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1025'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1030'">                                    <!-- ## Order status  ## -->
                <xsl:call-template name="BMD1030">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>

            <xsl:when test="@field = '1040'">                                    <!-- ## Compressed serials information ## -->
                <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1040'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1042'">                                    <!-- ## Compressed serials information ## -->
                <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1042'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1044'">                                    <!-- ## Compressed serials information ## -->
               <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1044'"/>
               </xsl:call-template>
            </xsl:when>


            <xsl:when test="@field = '1041'">                                    <!-- ## Compressed serials/xsl ## -->
               <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1041'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1043'">                                    <!-- ## Compressed serials/xsl ## -->
               <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1043'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1045'">                                    <!-- ## Compressed serials/xsl ## -->
               <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1045'"/>
               </xsl:call-template>
            </xsl:when>



            <xsl:when test="@field = '1050'">                                    <!-- ## E-item ## -->
                <xsl:call-template name="BMD1050">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '2000'">                                    <!-- ## TOC ## -->

            </xsl:when>
            <xsl:when test="@field = '3000'">                                    <!-- ## 856 links ## -->
                <xsl:choose>
                    <xsl:when test="$recordType='bib'">
                        <xsl:call-template name="BMD3000">
                            <xsl:with-param name="marc" select="$recordTypeRecord/hol:marcRecord"/>
                            <xsl:with-param name="recordType" select="$recordType"/>
                            <xsl:with-param name="label" select="$label"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="BMD3000">
                            <xsl:with-param name="marc" select="$mfhdRecord[@mfhdId=$mfhdID]/mfhd:marcRecord"/>
                            <xsl:with-param name="recordType" select="''"/>
                            <xsl:with-param name="label" select="$label"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:when test="@field = '4000'">                                    <!-- ## MARC record ## -->
                <xsl:call-template name="BMD4000"/>
            </xsl:when>

            <xsl:when test="@field = '4100'">                                    <!-- ## undocumented/Dublin Core view ## -->

            </xsl:when>

            <xsl:when test="@field = '5000'">                                    <!-- ## Database name ## -->
                <xsl:call-template name="BMD5000"/>
            </xsl:when>

         <!-- ## Leader and Control field handling ## -->
         <xsl:when test="@field = '7000'">                                    <!-- ## Primary Material ## -->
             <xsl:call-template name="BMD7000"/>
         </xsl:when>
         <xsl:when test="@field = '7106'">                                    <!-- ## Includes ## -->
             <xsl:call-template name="BMD7106"/>
         </xsl:when>
         <xsl:when test="@field = '7107'">                                    <!-- ## Physical Description ## -->
             <xsl:call-template name="BMD7107"/>
         </xsl:when>

            <xsl:when test="@field = '9000'">                                    <!-- ## Holdings ## -->
                  <xsl:call-template name="BMD9000"/>
            </xsl:when>
            <xsl:when test="@field = '9500'">                                    <!-- ## Holdings summary ## -->

            </xsl:when>

        </xsl:choose>
    </xsl:for-each>



</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMDProcessMarcTags">
<xsl:param name="label"/>
<xsl:param name="field"/>
<xsl:param name="indicator1"/>
<xsl:param name="indicator2"/>
<xsl:param name="subfield"/>
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>

<xsl:variable name="displayTag" select="."/>

   <xsl:variable name="BMDDATA">
            <xsl:for-each select="$recordTypeRecord/hol:marcRecord/slim:controlfield[@tag=$field]">
               <xsl:call-template name="BMDDisplayControlfield">
                  <xsl:with-param name="controlfield" select="$field"/>
               </xsl:call-template>
            </xsl:for-each>

            <xsl:for-each select="$recordTypeRecord/hol:marcRecord/slim:datafield[@tag=$field]">
            <xsl:if test="position() != 1" >
                <xsl:value-of select="$new_line" />
                <xsl:call-template name="addTabsBeforeDataWithoutLabel">
                    <xsl:with-param name="label" select="$label"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="($indicator1 = @ind1 or $indicator1 = 'X' or (@ind1 = ' ' and $indicator1 = '|')) and ($indicator2 = @ind2 or $indicator2 = 'X' or (@ind2 = ' ' and $indicator2 = '|'))">
                    <xsl:call-template name="BMDDisplaySubfield">
                        <xsl:with-param name="subfield" select="$subfield"/>
            <xsl:with-param name="displayTag" select="$displayTag"/>
                    </xsl:call-template>
                </xsl:when>
            </xsl:choose>
            </xsl:for-each>
   </xsl:variable>

       <xsl:if test="string-length($BMDDATA)">
        <xsl:copy-of select="$BMDDATA"/>
        <xsl:value-of select="$new_line"/>
    <xsl:call-template name="addTabsBeforeDataWithoutLabel">
                    <xsl:with-param name="label" select="$label"/>
                </xsl:call-template>
    </xsl:if>

            <!-- Process the MFHD tags mfhd:mfhdRecord[@mfhdId = $mfhdID]-->
            <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:marcRecord/slim:datafield[@tag=$field]">
               <xsl:choose>
                  <xsl:when test="($indicator1 = @ind1 or $indicator1 = 'X' or (@ind1 = ' ' and $indicator1 = '|')) and ($indicator2 = @ind2 or $indicator2 = 'X' or (@ind2 = ' ' and $indicator2 = '|'))">
                        <xsl:choose>
                            <xsl:when test="position()=1"><xsl:value-of select="'&#09;'"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="'&#09;&#09;&#09;'"/></xsl:otherwise>
                        </xsl:choose>
                      <xsl:call-template name="BMDDisplaySubfield">
                        <xsl:with-param name="subfield" select="$subfield"/>
            <xsl:with-param name="displayTag" select="$displayTag"/>
                    </xsl:call-template>
                    <xsl:value-of select="'&#xA;'"></xsl:value-of>
                  </xsl:when>
               </xsl:choose>
            </xsl:for-each>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMDDisplayControlfield">
<xsl:param name="controlfield"/>

   <xsl:if test="contains($controlfield,@tag)">
      <xsl:value-of select="."/>
      <xsl:value-of select="$new_line"/>
    </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMDDisplaySubfield">
<xsl:param name="subfield"/>
<xsl:param name="displayTag"/>

<!--
    <xsl:for-each select="slim:subfield">
        <xsl:choose>
            <xsl:when test="contains($subfield,@code)">
                <xsl:value-of select="."/><xsl:text> </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:for-each>
-->
<xsl:for-each select="slim:subfield">
   <xsl:choose>
      <xsl:when test="contains($subfield,@code)">
         <xsl:variable name="subfieldCode">
            <xsl:value-of select="@code"/>
         </xsl:variable>
         <xsl:variable name="subfieldPreText">
            <xsl:if test="$displayTag"><xsl:value-of select="$displayTag/subfield[@value=$subfieldCode]/@preText"/></xsl:if>
         </xsl:variable>
         <xsl:variable name="subfieldPostText">
            <xsl:if test="$displayTag"><xsl:value-of select="$displayTag/subfield[@value=$subfieldCode]/@postText"/></xsl:if>
         </xsl:variable>

         <xsl:choose>
            <xsl:when test="string-length($subfieldPreText)">
               <xsl:value-of select="$subfieldPreText"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:if test="position()>1"><xsl:text> </xsl:text></xsl:if>
            </xsl:otherwise>
         </xsl:choose>

         <xsl:value-of select="."/>

         <xsl:value-of select="$subfieldPostText"/>

      </xsl:when>
   </xsl:choose>
</xsl:for-each>

</xsl:template>

<!-- ###################################################################### -->

<!-- MFHD location will be displayed along with item locations in BMD1005 -->

<!-- ###################################################################### -->

<xsl:template name="BMD1002">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:mfhdData[@name='databaseName']">
        <xsl:if test="string-length(.)">
            <xsl:value-of select="normalize-space(.)"/><br/>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1005">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:itemCollection/item:itemLocation">
        <xsl:if test="string-length(item:itemLocationData[@name='tempLocation'])">

                <xsl:if test="string-length(item:itemLocationData[@name='itemEnum'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemEnum']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemChron'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemChron']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemYear'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemYear']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemCaption'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemCaption']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemFreeText'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemFreeText']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemCopyNumber'])">
                    c.<xsl:value-of select="item:itemLocationData[@name='itemCopyNumber']"/>&#160;
                </xsl:if>

                <xsl:value-of select="item:itemLocationData[@name='tempLocation']"/><br/>
                <xsl:text>&#xA;</xsl:text>
        </xsl:if>
        <!--  
        <xsl:if test="string-length(item:itemLocationData[@name='tmpLoc']) and 'Y' = item:itemLocationData[@name='tmpLoc']">
            <xsl:if test="string-length(item:itemLocationData[@name='tempLocation'])">
                <xsl:value-of select="item:itemLocationData[@name='tempLocation']"/>
                <xsl:text>&#xA;</xsl:text>
            </xsl:if>
        </xsl:if>
        -->
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1010">
<xsl:param name="mfhdID"/>

    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:itemCollection">
        <xsl:if test="string-length(item:itemCount)">
            <xsl:value-of select="item:itemCount"/><br/>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1012">
<xsl:param name="mfhdID"/>

    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:itemCollection/item:itemRecord">
        <xsl:if test="string-length(item:itemData[@name='displayStatus'])">
            <xsl:choose>
               <xsl:when test="position()=1"><xsl:value-of select="'&#09;'"/></xsl:when>
               <xsl:otherwise><xsl:value-of select="'&#09;&#09;&#09;'"/></xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="item:itemData[@name='displayStatus']"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD102X">
<xsl:param name="mfhdID"/>
<xsl:param name="iField"/>

   <xsl:variable name="compressedData">
       <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:serialsSubscriptions">
         <xsl:choose>
            <xsl:when test="$iField='1020'"><xsl:call-template name="BMD1020"/></xsl:when>
            <xsl:when test="$iField='1021'">
                <xsl:call-template name="displaySubscription">
                    <xsl:with-param name="subscription" select="mfhd:subscription"/>
                    <xsl:with-param name="componentTypeFilter" select="'Basic'"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$iField='1022'"><xsl:call-template name="BMD1022"/></xsl:when>
            <xsl:when test="$iField='1023'">
                <xsl:call-template name="displaySubscription">
                    <xsl:with-param name="subscription" select="mfhd:subscription"/>
                    <xsl:with-param name="componentTypeFilter" select="'Supplement'"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$iField='1024'"><xsl:call-template name="BMD1024"/></xsl:when>
            <xsl:when test="$iField='1025'">
                <xsl:call-template name="displaySubscription">
                    <xsl:with-param name="subscription" select="mfhd:subscription"/>
                    <xsl:with-param name="componentTypeFilter" select="'Index'"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
         </xsl:choose>
       </xsl:for-each>
   </xsl:variable>

    <xsl:if test="string-length($compressedData)">
           <xsl:copy-of select="$compressedData"/><br/>
   </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1020">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:serialsCheckIn/mfhd:recent">

            <xsl:for-each select="mfhd:enumChron">
                <xsl:choose>
                    <xsl:when test="position()=1"><xsl:value-of select="'&#09;'"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="'&#09;&#09;&#09;'"/></xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="normalize-space(.)"/><xsl:value-of select="'&#xA;'"></xsl:value-of>
            </xsl:for-each>

    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1022">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:serialsCheckIn/mfhd:supplements">

            <xsl:for-each select="mfhd:enumChron">
                <xsl:choose>
                    <xsl:when test="position()=1"><xsl:value-of select="'&#09;'"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="'&#09;&#09;&#09;'"/></xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="normalize-space(.)"/><xsl:value-of select="'&#xA;'"></xsl:value-of>
            </xsl:for-each>

    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1024">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:serialsCheckIn/mfhd:indexes">

            <xsl:for-each select="mfhd:enumChron">
                <xsl:choose>
                    <xsl:when test="position()=1"><xsl:value-of select="'&#09;'"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="'&#09;&#09;&#09;'"/></xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="normalize-space(.)"/><xsl:value-of select="'&#xA;'"></xsl:value-of>
            </xsl:for-each>

    </xsl:for-each>
</xsl:template>


<!-- ###################################################################### -->

<xsl:template name="BMD1030">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:poLineItems">

            <xsl:for-each select="mfhd:lineItemStatus">
                <xsl:call-template name="buildOrderStatus">
                    <xsl:with-param name="sStatus" select="mfhd:status"/>
                    <xsl:with-param name="iCount" select="mfhd:count"/>
                    <xsl:with-param name="sDueDate" select="mfhd:date"/>
                </xsl:call-template>
            </xsl:for-each>

    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="buildOrderStatus">
<xsl:param name="sStatus"/>
<xsl:param name="iCount"/>
<xsl:param name="sDueDate"/>

    <xsl:variable name="sDisplayDueDate"><xsl:value-of select="normalize-space($sDueDate)"/></xsl:variable>

    <xsl:variable name="iStatus">
        <xsl:choose>
            <xsl:when test="iCount='1'"><xsl:value-of select="sStatus"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$sStatus + 1"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:choose>
        <xsl:when test="$iStatus = '0'">In the Pre-Order Process</xsl:when>
        <xsl:when test="$iStatus = '1'">In the Pre-Order Process</xsl:when>
        <xsl:when test="$iStatus = '2'"><xsl:value-of select="$iCount"/> Copy Ordered as of <xsl:value-of select="$sDisplayDueDate"/></xsl:when>
        <xsl:when test="$iStatus = '3'"><xsl:value-of select="$iCount"/> Copies Ordered as of <xsl:value-of select="$sDisplayDueDate"/></xsl:when>
        <xsl:when test="$iStatus = '8'"><xsl:value-of select="$iCount"/> Copy Claimed as of <xsl:value-of select="$sDisplayDueDate"/></xsl:when>
        <xsl:when test="$iStatus = '9'"><xsl:value-of select="$iCount"/> Copies Claimed as of <xsl:value-of select="$sDisplayDueDate"/></xsl:when>
        <xsl:when test="$iStatus = '16'"><xsl:value-of select="$iCount"/> Copy Received as of <xsl:value-of select="$sDisplayDueDate"/></xsl:when>
        <xsl:when test="$iStatus = '17'"><xsl:value-of select="$iCount"/> Copies Received as of <xsl:value-of select="$sDisplayDueDate"/></xsl:when>
    </xsl:choose>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD104X">
<xsl:param name="mfhdID"/>
<xsl:param name="iField"/>

   <xsl:variable name="compressedData">
       <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:marcRecord">
         <xsl:choose>
            <xsl:when test="$iField='1040'"><xsl:call-template name="display1041"/></xsl:when>
            <xsl:when test="$iField='1041'"><xsl:call-template name="display1041"/></xsl:when>
            <xsl:when test="$iField='1042'"><xsl:call-template name="display1043"/></xsl:when>
            <xsl:when test="$iField='1043'"><xsl:call-template name="display1043"/></xsl:when>
            <xsl:when test="$iField='1044'"><xsl:call-template name="display1045"/></xsl:when>
            <xsl:when test="$iField='1045'"><xsl:call-template name="display1045"/></xsl:when>
         </xsl:choose>
       </xsl:for-each>
   </xsl:variable>

    <xsl:if test="string-length($compressedData)">
           <xsl:copy-of select="$compressedData"/>
   </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1050">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$mfhdRecord[@mfhdId = $mfhdID]/mfhd:eItems">
        <xsl:if test="string-length(mfhd:eItem)">
                <xsl:for-each select="mfhd:eItem">
                    <xsl:if test="string-length(mfhd:link)">
                        <xsl:if test="not(position() = 1)">
                             <xsl:value-of select="$new_line"/>
                        </xsl:if>
                        <xsl:value-of select="normalize-space(mfhd:caption)"/>
                        <xsl:value-of select="normalize-space(mfhd:enum)"/>
                        <xsl:value-of select="normalize-space(mfhd:chron)"/>
                        <xsl:value-of select="normalize-space(mfhd:year)"/>
                    </xsl:if>
                </xsl:for-each>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD3000">
<xsl:param name="marc"/>
<xsl:param name="recordType"/>
<xsl:param name="label"/>

    <xsl:for-each select="$marc/slim:datafield[@tag='856']">
        <xsl:choose>
            <!--
            ## This will handle the case of multiple subfield u's.
            ## We won't however try and match up and notes to them,
            ## or do any other logic for that matter
            -->
            <xsl:when test="count(slim:subfield[@code='u']) &gt; 1">
                <xsl:for-each select="slim:subfield[@code='u']">
                    <xsl:if test="contains(translate(., $lowercaseDT, $uppercaseDT), 'HTTP:') or
                                 contains(translate(., $lowercaseDT, $uppercaseDT), 'HTTPS:') or
                                 contains(translate(., $lowercaseDT, $uppercaseDT), 'MAILTO') or
                                 contains(translate(., $lowercaseDT, $uppercaseDT), 'FTP')">
                        <xsl:if test="position() != 1">
                            <xsl:call-template name="addTabsBeforeDataForLinks">
                                <xsl:with-param name="label" select="$label" />
                                    </xsl:call-template>
                        </xsl:if>
                        <xsl:value-of select="." />
                        <xsl:value-of select="$new_line" />
                    </xsl:if>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="note">
                    <xsl:choose>
                        <xsl:when test="slim:subfield[@code='3']">
                            <xsl:value-of select="slim:subfield[@code='3']"/>
                            <xsl:if test="slim:subfield[@code='z']">
                                <xsl:value-of select="$tab"/>
                                <xsl:copy-of select="slim:subfield[@code='z']"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="slim:subfield[@code='y']">
                                    <xsl:value-of select="slim:subfield[@code='y']"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="slim:subfield[@code='z']">
                                        <xsl:copy-of select="slim:subfield[@code='z']"/>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

               <!-- Get local link-to-file information. -->
                <xsl:variable name="path">
                    <xsl:if test="slim:subfield[@code='d']">
                        <xsl:value-of select="slim:subfield[@code='d']"/>
                    </xsl:if>
                </xsl:variable>
                <xsl:variable name="fileName">
                    <xsl:for-each select="slim:subfield[@code='f']">
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="operSys">
                    <xsl:if test="slim:subfield[@code='o']">
                        <xsl:value-of select="slim:subfield[@code='o']"/>
                    </xsl:if>
                </xsl:variable>

                <!-- Set path and file. -->
                <xsl:variable name="pathToFile">
                    <xsl:if test="string-length($fileName)>0">
                        <xsl:value-of select="'file:///'"/>
                        <xsl:copy-of select="$path"/>
                        <xsl:choose>
                            <xsl:when test="$operSys='DOS'">
                                <xsl:value-of select="'\'"/>
                            </xsl:when>
                            <xsl:when test="$operSys='UNIX'">
                                <xsl:value-of select="'/'"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'/'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:copy-of select="$fileName"/>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="url">
                    <xsl:for-each select="slim:subfield[@code='u']">
                        <xsl:if test="contains(translate(., $lowercaseDT, $uppercaseDT), 'HTTP:') or
                                     contains(translate(., $lowercaseDT, $uppercaseDT), 'HTTPS:') or
                                     contains(translate(., $lowercaseDT, $uppercaseDT), 'MAILTO') or
                                     contains(translate(., $lowercaseDT, $uppercaseDT), 'FTP')">
                            <xsl:value-of select="."/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>

                <xsl:variable name="doi">
                    <xsl:for-each select="slim:subfield[@code='u']">
                         <xsl:if test="contains(translate(., $lowercaseDT, $uppercaseDT), 'DOI:') or
                                       contains(translate(., $lowercaseDT, $uppercaseDT), 'URN:')">
                            <xsl:value-of select="."/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>

                <xsl:variable name="doi2">
                    <xsl:if test="string-length($doi)=0">
                        <xsl:if test="./slim:subfield[@code='g']">
                            <xsl:value-of select="./slim:subfield[@code='g']"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="doi2note">
                    <xsl:if test="string-length($doi2)>0">
                        <xsl:if test="./slim:subfield[@code='z']">
                            <xsl:value-of select="./slim:subfield[@code='z']"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="link">
                    <xsl:choose>
                        <xsl:when test="string-length($url)>0">
                            <xsl:value-of select="$url"/>
                        </xsl:when>
                        <xsl:when test="string-length($doi)>0">
                            <xsl:value-of select="$doi"/>
                        </xsl:when>
                        <xsl:when test="string-length($doi2)>0">
                            <xsl:value-of select="$doi2"/>
                        </xsl:when>
                        <xsl:when test="string-length($pathToFile)>0">
                            <xsl:value-of select="$pathToFile"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:variable>

                <xsl:choose>
                    <xsl:when test="string-length($note)>0">
                        <xsl:if test="position() != 1" >
                            <xsl:call-template name="addTabsBeforeDataForLinks">
                                <xsl:with-param name="label" select="$label"/>
                            </xsl:call-template>
                        </xsl:if>
                        <xsl:value-of select="$note"/>
                        <xsl:value-of select="$tab"/>
                        <xsl:value-of select="$tab"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="string-length($doi2note)>0">
                            <xsl:if test="position() != 1" >
                                <xsl:call-template name="addTabsBeforeDataForLinks">
                                    <xsl:with-param name="label" select="$label"/>
                                </xsl:call-template>
                            </xsl:if>
                            <xsl:value-of select="$doi2note"/>
                            <xsl:value-of select="$tab"/>
                            <xsl:value-of select="$tab"/>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:if test="string-length($link)>0">
                        <xsl:value-of select="$link"/>
                        <xsl:value-of select="$new_line" />
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="addTabsBeforeDataForLinks">
<xsl:param name="label"/>

    <xsl:choose>
        <xsl:when test="string-length($label)">
            <xsl:choose>
                <!--  assume tab size of 8 for most text editors -->
                <xsl:when test="string-length($label) &gt; 32 ">
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                </xsl:when>
                <xsl:when test="string-length($label) &gt; 24 ">
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                </xsl:when>
                <xsl:when test="string-length($label) &gt; 16 ">
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                </xsl:when>
                <xsl:when test="string-length($label) &gt; 8 ">
                    <xsl:value-of select="$tab"/>
                    <xsl:value-of select="$tab"/>
                </xsl:when>
                <xsl:when test="string-length($label) &gt; 0 ">
                    <xsl:value-of select="$tab"/>
                </xsl:when>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
            &#160;
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD4000">
    <xsl:for-each select="$recordTypeRecord/hol:marcRecord">
        <xsl:call-template name="buildMarcRecord"/>
        <xsl:value-of select="$new_line"/>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD5000">
    <xsl:for-each select="$recordTypeRecord/hol:bibData[@name='databaseName']">
        <xsl:if test="string-length(.)">
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:value-of select="$new_line"/>
        </xsl:if>
    </xsl:for-each>
</xsl:template>


<!-- ###################################################################### -->
<!-- ## Primary Material ## -->

<xsl:template name="BMD7000">

   <xsl:variable name="primaryMaterial" select="substring($recordTypeRecord/hol:marcRecord/slim:leader,7,2)"/>

   <xsl:choose>
      <xsl:when test="string-length($bibFormats/bibFormat[@type=$primaryMaterial])">
         <xsl:value-of select="$bibFormats/bibFormat[@type=$primaryMaterial]"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$primaryMaterial"/>
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<!-- ###################################################################### -->
<!-- ## Includes ## -->
<xsl:template name="BMD7106">
   <xsl:for-each select="$recordTypeRecord/hol:marcRecord/slim:controlfield[@tag='006']">
       <xsl:variable name="cfdata" select="substring(.,1,1)"/>
       <xsl:if test="not(position() = 1)">
          <xsl:value-of select="$tab"/>
          <xsl:value-of select="$tab"/>
       </xsl:if>
   <xsl:choose>
      <xsl:when test="string-length($Configs/pageConfigs/formMaterial/format[@type=$cfdata])">
         <xsl:value-of select="$Configs/pageConfigs/formMaterial/format[@type=$cfdata]"/>
               <xsl:value-of select="$new_line"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$cfdata"/>
               <xsl:value-of select="$new_line"/>
      </xsl:otherwise>
   </xsl:choose>
   </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->
<!-- ## Physical Description ## -->
<xsl:template name="BMD7107">
   <xsl:for-each select="$recordTypeRecord/hol:marcRecord/slim:controlfield[@tag='007']">

   <!-- ## use one byte compare ##
   <xsl:variable name="cfdata" select="substring($bibRecord/hol:marcRecord/slim:controlfield[@tag='007'],1,1)"/>
   -->
   <!-- ## use two byte compare ## -->
       <xsl:variable name="cfdata" select="substring(.,1,2)"/>
       <xsl:if test="not(position() = 1)">
           <xsl:value-of select="$tab"/>
           <xsl:value-of select="$tab"/>
       </xsl:if>
   <xsl:choose>
      <xsl:when test="string-length($Configs/pageConfigs/physicalDescription/format[@type=$cfdata])">
         <xsl:value-of select="$Configs/pageConfigs/physicalDescription/format[@type=$cfdata]"/>
                <xsl:value-of select="$new_line"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$cfdata"/>
                <xsl:value-of select="$new_line"/>
      </xsl:otherwise>
   </xsl:choose>

   </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD9000">
    <xsl:variable name="holdingsData">
        <xsl:for-each select="$mfhdRecord">
            <xsl:variable name="mfhdId" select="@mfhdId"/>

            <xsl:for-each select="$holdingsConfig">
                <xsl:call-template name="buildMarcDisplay">
                    <xsl:with-param name="mfhdID" select="$mfhdId"/>
                    <xsl:with-param name="recordType" select="'mfhd'"/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>

    <xsl:if test="string-length($holdingsData)">
        <xsl:copy-of select="$holdingsData"/>&#160;
    </xsl:if>
</xsl:template>

<!-- ###################################################################### -->


</xsl:stylesheet>



