<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5 $ $Date: 2012/06/09 00:27:51 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage
**          Version : 7.2.0
**          Created : 25-Oct-2007
**      Orig Author : Scott Morgan
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
    exclude-result-prefixes="xsl fo page"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <!-- External imports -->
    <xsl:include href="./cl_commonDialog.xsl"/>
    <xsl:include href="./display/dialog_display.xsl"/>

   <!-- Variables -->
   <xsl:variable name="Config" select="document('./configs/export/exportDialogConfig.xml')"/>


    <xsl:template name="cl_exportRecordDialog.exportRecordDialogForm">
        <xsl:for-each  select="/page:page/page:pageBody" >
            <form id="exportRecordDialogForm" method="POST" action="exportRecord.do" class="formBackround" >
                <div class="formLabel" >
                   <span class="formLabel"><xsl:value-of select="//page:element[@nameId='page.exportDialog.export.instructions']/page:label" /></span>
                </div>
                <br/>
                <xsl:call-template name="contentLayout.cl_commonDialog.hiddenSearchOrBib" />
                <div class="formLabel" >
                    <xsl:call-template name="buildFormDropDown">
                       <xsl:with-param name="eleName" select=" 'format'" />
                    </xsl:call-template>
                </div>
                <br/>
                <br/>
                <xsl:call-template name="renderButtons">
                   <xsl:with-param name="submitBtn"     select="'page.exportDialog.export.button'"/>
                   <xsl:with-param name="submitBtnName" select="'butExport'"/>
                   <xsl:with-param name="cancelBtn"     select="'page.return.button'"/>
                   <xsl:with-param name="cancelBtnName" select="'butCancel'"/>
                </xsl:call-template>
                <br/>
                <xsl:if test="page:element[@nameId='recordsGroup']">
                     <div  class="selectedRecords">
                         <xsl:for-each  select="page:element[@nameId='recordsGroup']/page:element" >
                             <xsl:call-template name="display_dialogDisplay_buildRecord"/>
                         </xsl:for-each>
                         <div class="moreRecords">
                             <xsl:for-each  select="page:element[@nameId='page.exportDialog.export.moreRecords']" >
                                 <xsl:value-of select="page:label" />
                             </xsl:for-each>
                         </div>
                     </div>
                </xsl:if>
            </form>
            <br/>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>


