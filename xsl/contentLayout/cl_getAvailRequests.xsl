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
**          Product : WebVoyage :: getAvailRequests
**          Version : 7.2.0
**          Created : 07-NOV-2007
**      Orig Author : Mel Pemble
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ###################################################################### -->

<xsl:template name="buildGetAvailRequestsForm">

   <xsl:for-each select="//page:element[@nameId='patronRequests.group']">
      <div class="AvailRequests">
         <h2 class="nav">Request Navigation Bar</h2>
         <ul id="requestNavigation">
            <xsl:for-each select="page:element[@nameId='page.patronRequests.actions.getRequest.link']">
               <li>
                  <span class="requestPreText"><xsl:value-of select="page:preText"/></span>
                  <span class="requestLinkText"><a href="{page:URL}" alt="{page:linkText}"><xsl:value-of select="page:linkText"/></a></span>
                  <span class="requestPostText"><xsl:value-of select="page:postText"/></span>
               </li>
            </xsl:for-each>
         </ul>
      </div>
   </xsl:for-each>

   <xsl:copy-of select="$backToRecord"/>
   
</xsl:template>

<!-- ###################################################################### -->

</xsl:stylesheet>


