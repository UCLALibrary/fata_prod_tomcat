<!-- $Revision: 1.4 $ $Date: 2012/06/11 14:46:57 $ -->
<!-- 
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage
**          Version : 7.2.0
**          Created : 06-JUL-2007
**    Last Modified : 29-SEP-2009
**      Orig Author : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page">

<xsl:variable name="footerText" select="$Configs/pageConfigs/elementTitles/footer"/>
	
<!-- ################# -->
<!-- ## buildFooter ## -->
<!-- ######################################################### -->

<xsl:template name="buildFooter">

   <xsl:for-each select="/page:page/page:pageFooter">
      <div id="pageFooter">
         <xsl:for-each select="page:tabs[@nameId='page.footer.buttons']">
            
            <div id="footerTabs" title="{$footerText/footerTabs}">
               <a name="navFooter"></a>
               <h2 class="navFooter"><xsl:value-of select="$footerText/footerTabs"/></h2>
               <ul class="navbar">
                   <xsl:for-each select="$Configs/pageConfigs/footerTabDisplayOrder/tab">
                     <xsl:variable name="tempName" select="@name"/>
                     <xsl:variable name="newWin" select="@clickOpensNewWindow"/>
                     <xsl:call-template name="buildFooterTab">
                        <xsl:with-param name="displayTab" select="$tempName"/>
                        <xsl:with-param name="newWin" select="$newWin"/>
                        <xsl:with-param name="highlight" select="highlight/@pages"/>
                     </xsl:call-template>
                   </xsl:for-each>
               </ul>
            </div>
            
         </xsl:for-each>
      
         <div id="libraryLink">
            <span>
               <xsl:call-template name="buildLinkType">
                  <xsl:with-param name="eleName"  select="'page.footer.library.link'"/>
               </xsl:call-template>
            </span>
         </div>

         <div id="copyright" title="{$footerText/copyright}"><span><xsl:value-of select="page:element[@nameId='page.footer.copyright.message']/page:messageText"/></span></div>  
      
      </div>
   </xsl:for-each>
   
 <!--Sharon added Tarrant time out msg fix found in EL Commons -->

   <!-- ######### Timeout ############ -->
    <!--div id='tcc_timeout_container'>
         <div id='tcc_timeout_title'>Session Timeout</div>
         <div id='tcc_timeout_message'></div>
         <div id='tcc_timeout_page_refresh'>
            <script type='text/javascript'>
                document.write('<a href="' + window.location.href + '">Continue Session</a>');
            </script>
         </div>
         <div id='tcc_timeout_session_refresh'>
            <a href='/vwebv/exit.do'>New Session</a>
         </div>
      </div>
      <script type='text/javascript'>
         var dragBase = document.getElementById('tcc_timeout_container');
         var dragHandle = document.getElementById('tcc_timeout_title');
         tccDrag.init(dragBase, dragHandle, '400px', '250px');
      </script-->
   <!-- ######### Timeout ############ -->

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildFooterTab">
<xsl:param name="displayTab"/>
<xsl:param name="newWin"/>
<xsl:param name="highlight"/>

    <xsl:for-each select="$pageFooterXML//page:button[@nameId=$displayTab]">
        <xsl:variable name="tabClass">
            <xsl:choose>
                <xsl:when test="contains($highlight,/page:page/@nameId)">on</xsl:when>
                <xsl:otherwise>off</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <li class="{$tabClass}" title="{page:buttonMessage}">
            <a href="{page:buttonAction}" name="{@nameId}" id="{@nameId}">
                <xsl:if test="$newWin='true'">
                    <xsl:attribute name="target">newWin</xsl:attribute>
                </xsl:if>
                <span><xsl:value-of select="page:buttonText"/></span>
            </a>
        </li>
    </xsl:for-each>

</xsl:template>

<!-- ######################################################### -->
</xsl:stylesheet>



