<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5 $ $Date: 2012/06/09 00:27:52 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : : WebVoyage :: displayFacets
**          Version : 7.2.0
**          Created : 26-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
    exclude-result-prefixes="xsl fo page"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:include href="../local_googleBooksAvail.xsl"/>

<!-- ###################################################################### -->

<xsl:template name="buildActionBox">
<xsl:param name="pageRecordType"/>
<xsl:param name="moreActions"/>

    <xsl:for-each select="page:element[@nameId='actionBox.group']">
        <div class="actionBox">
            <a id="actionBoxQuickLink" name="actionBoxQuickLink"></a>
            <!--h3>Action Box</h3-->
            <!--ul class="actionBoxList"-->

            <xsl:for-each select="page:element[@nameId='actionBox.thisItem.group']">
                <div class="thisItem">
                    <label><xsl:value-of select="page:label"/></label>
                    <h2 class="nav">Action Box</h2>
                    <ul title="Action Box">

                        <xsl:for-each select="page:element">
                            <xsl:choose>
                                <xsl:when test="@nameId=$pageRecordType">
                                    <li><span class="recordPointer">&#160;</span><label><xsl:value-of select="page:linkText"/></label></li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li><span class="recordLinkBullet">&#183;</span><a href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                        <xsl:copy-of select="$moreActions"/>

<li><span class="recordLinkBullet">&#183;</span><label>
                        <xsl:call-template name="persistentLink" >
                            <xsl:with-param name="bibID" select="$bibID"/>
                        </xsl:call-template>
</label></li>
                    </ul>
                </div>
            </xsl:for-each>

            <xsl:for-each select="page:element[@nameId='actionBox.actions.group']">
                <div class="actions">
                    <label><xsl:value-of select="page:label"/></label>
                    <h2 class="nav">Action Navigation</h2>
                    <ul title="Action Navigation" class="actions">

                        <xsl:for-each select="page:element">
                            <xsl:variable name="message">
                                   <xsl:value-of select="page:linkMessage"/>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="string-length($message)">
                                    <li title="{$message}"><span class="recordLinkBullet">·</span><a href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a><br/><span class="fieldSubText"><xsl:value-of select="page:postText"/></span></li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li><span class="recordLinkBullet">·</span><a href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a><br/><span class="fieldSubText"><xsl:value-of select="page:postText"/></span></li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:for-each>

            <xsl:for-each select="page:element[@nameId='actionBox.moreAboutThisItem.group']">

                <div class="moreInfo">

                    <label><xsl:value-of select="page:label"/></label>
                    <h2 class="nav">Action Box More Info Navigation</h2>
                    <ul title="Action Box More Info Navigation" class="moreInfo">

                        <xsl:for-each select="page:element">
                            <li>
                                <xsl:call-template name="buildImageUrl">
                                    <xsl:with-param name="eleName" select="@nameId"/>
                                </xsl:call-template>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>


            <!-- ## mdp add the google book template ## -->
            <div id="googleBooksRow">
               <xsl:call-template name="googleBooksAvail"/>
             </div>

            </xsl:for-each>
            <!--/ul-->

        </div>
    </xsl:for-each>


</xsl:template>

<!-- ###################################################################### -->

</xsl:stylesheet>



