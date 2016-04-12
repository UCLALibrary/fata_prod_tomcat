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
**          Product : WebVoyage :: cl_changePin.xsl
**          Version : 7.2.0
**          Created : 22-AUG-2007
**      Orig Author : David Sellers
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- #################### -->
<!-- ## buildChangePin ## -->
<!-- ######################################################### -->

<xsl:template name="buildChangePin">
    <xsl:for-each select="/page:page/page:pageBody">
        <div id="changePin">

            <div id="pageLinks">
                <xsl:call-template name="buildMyAccountLinks">
                    <xsl:with-param name="displayType" select="'changepin'"/>
                </xsl:call-template>
            </div>

            <div id="pins">

                <div id="input">
                    <xsl:call-template name="buildFormInput">
                        <xsl:with-param name="eleName"  select="'oldPatronPIN'"/>
                         <xsl:with-param name="type" select="'password'"/>
                        <xsl:with-param name="size"  select="'30'"/>
                    </xsl:call-template>
                </div>

                <div id="input">
                    <xsl:call-template name="buildFormInput">
                        <xsl:with-param name="eleName"  select="'newPatronPIN'"/>
                         <xsl:with-param name="type" select="'password'"/>
                        <xsl:with-param name="size"  select="'30'"/>
                    </xsl:call-template>
                </div>

                <div id="input">
                    <xsl:call-template name="buildFormInput">
                        <xsl:with-param name="eleName"  select="'confirmNewPin'"/>
                         <xsl:with-param name="type" select="'password'"/>
                        <xsl:with-param name="size"  select="'30'"/>
                    </xsl:call-template>
                </div>

                <div id="buttons">
                    <input id="saveBtn" type="submit" value="{page:element[@nameId='page.myAccount.changePin.save.button']/page:buttonText}" class="submit" />
                </div>
            </div>
        </div>
    </xsl:for-each>
</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>




