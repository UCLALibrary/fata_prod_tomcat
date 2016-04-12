<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.6 $ $Date: 2012/06/09 00:27:52 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: frameWork
**          Version : 7.2.0
**          Created : 16-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet
   version="1.0"
   exclude-result-prefixes="xsl fo req page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:req="http://www.endinfosys.com/Voyager/requests"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page">

   <xsl:include href="../pageFacets/footer.xsl"/>
   <xsl:include href="../pageFacets/header.xsl"/>
   <xsl:include href="../pageFacets/showXML.xsl"/>

   <!-- ## DEBUG ## -->
   <xsl:variable name="debugEnabled" select="'false'"/>  <!-- ## set to 'true' to enable ## -->

   <!-- ## Our Document Holders ## -->
   <xsl:variable name="pageXML" select="/"/>
   <xsl:variable name="pageHeaderXML" select="$pageXML/page:page/page:pageHeader"/>
   <xsl:variable name="pageBodyXML"   select="$pageXML/page:page/page:pageBody"/>
   <xsl:variable name="pageFooterXML" select="$pageXML/page:page/page:pageFooter"/>
   <xsl:variable name="Configs" select="document('../userTextConfigs/pageProperties.xml')"/>
   <xsl:variable name="bodyText" select="$Configs/pageConfigs/elementTitles/body"/>

<!-- ############################################################ -->

<xsl:template name="buildHtmlPage">
<xsl:param name="myJavascripts"/>
<xsl:param name="myCSS"/>

   <xsl:variable name="resultPages" select="'page.searchResults.headings page.searchResults.titles page.searchResults.callNumbers ' "/>
   <xsl:variable name="displayPages" select="'page.holdingsInfo' "/>
   <xsl:variable name="highlightNodes">
      <xsl:variable name="terms">
         <xsl:for-each select="//page:element[@nameId='page.searchResults.term']">
            <xsl:value-of select="page:value"/><xsl:value-of select="' '"/>
          </xsl:for-each>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="contains($displayPages,/page:page/@nameId)">;highlightRecordDisplay('<xsl:value-of select="$terms"/>')</xsl:when>
         <xsl:when test="contains($resultPages,/page:page/@nameId)">;highlightResultSet('<xsl:value-of select="$terms"/>')</xsl:when>
         <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!-- ## Make sure we have a DOCTYPE ## -->
   <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"></xsl:text>

   <!-- ## set the language for the document ## -->
   <html lang="en">

      <!-- ## Head section of the page ## -->
      <head>

         <!-- ## Search Status Redirect for SimulSearch ## -->
         <xsl:for-each select="/page:page/page:pageHeader/page:element[@nameId='page.searchStatus.refresh']">
            <meta http-equiv="refresh" content="{page:linkText};url={page:URL}" />
         </xsl:for-each>

         <!-- ## Timeout ## -->

         <xsl:for-each select="/page:page/page:pageHeader/page:element[@nameId='timeout.time']">
            <xsl:variable name="timeoutTime"><xsl:value-of select="page:value * 60"/></xsl:variable>
             <meta content="{$timeoutTime};url={../page:element[@nameId='timeout.page']/page:value}" http-equiv="refresh"/>
          </xsl:for-each>

        <!-- ## External Authorization ## -->
        <xsl:variable name="link" select="/page:page/page:pageBody/page:element[@nameId='page.logIn.actions.extAuth.link']" />
        <xsl:choose>
            <xsl:when test="string-length($link)">
                <xsl:choose>
                    <xsl:when test="string-length($link/page:linkText) &lt; 1"><meta content="0;url={/page:page/page:pageBody/page:element[@nameId='page.logIn.actions.extAuth.link']/page:URL}" http-equiv="refresh" /></xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                </xsl:choose>
           </xsl:when>
           <xsl:otherwise></xsl:otherwise>
       </xsl:choose>

         <!-- ## All pages need a title ## -->
         <title>
            <xsl:call-template name="buildPageTitle">
               <xsl:with-param name="nameId" select="'page.title'"/>
            </xsl:call-template>
         </title>

          <script type="text/javascript" src="{$jscript-loc}ajaxUtils.js"/>

            <!-- ################################### -->
            <!-- ## WebVoyage Javascript Includes ## -->
            <!-- ################################### -->

         <!-- ## keep javascript to a minimum ## -->
            <xsl:if test="$debugEnabled='true'">
               <!--
               ## if debug is enabled load these javascripts
               ## for the XML window that displays when you
               ## click the Show XML button
               -->
               <script type="text/javascript" src="{$jscript-loc}prototype.js"/>
               <script type="text/javascript" src="{$jscript-loc}effects.js"/>
               <script type="text/javascript" src="{$jscript-loc}window.js"/>
               <script type="text/javascript" src="{$jscript-loc}window_ext.js"/>
               <script type="text/javascript" src="{$jscript-loc}debug.js"/>

          </xsl:if>

          <!-- ## keep javascript to a minimum ##             -->
            <xsl:if test="string-length($highlightNodes)">
               <script type="text/javascript" src="{$jscript-loc}highLight.js"/>
            </xsl:if>

          <!-- ## Firebug Lite for IE Debugging -->
          <!--
          <script type="text/javascript" src="http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js"></script>
          -->
            
          <script type="text/javascript">
            var msg;
            var timeOut;
            var seconds;
            function timedMsg(time, grace, txtMsg)
            {
              msg = txtMsg;
              timeOut = (time - grace) * 60000;
              seconds = grace * 60;
              //setTimeout("alert(msg)", timeOut);
              setTimeout("tcc_display_timeout(msg)",timeOut);
              setTimeout("alert(msg)", timeOut);
            }
          </script>

<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-32672693-1']);
_gaq.push(['_setDomainName', 'library.ucla.edu']);
_gaq.push(['_trackPageview']);
(function() { var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })();
</script>

          <script type="text/javascript" src="{$jscript-loc}pageInputFocus.js"/>

         <!--
         ## any javascripts that are specific to a single page should be passed
         ## in otherwise the script is global to all pages
         -->
         <xsl:copy-of select="$myJavascripts"/>

         <!-- <noscript>JavaScript is disabled. Please enable JavaScript.</noscript> -->

            <!-- ############################ -->
            <!-- ## WebVoyage CSS Includes ## -->
            <!-- ############################ -->
            <!-- These stylesheets are used on nearly everypage , so define them here to make them global -->
         <link href="{$css-loc}frameWork.css"      media="all" type="text/css" rel="stylesheet"/>
         <link href="{$css-loc}header.css"         media="all" type="text/css" rel="stylesheet"/>
         <link href="{$css-loc}quickSearchBar.css" media="all" type="text/css" rel="stylesheet"/>
         <link href="{$css-loc}pageProperties.css" media="all" type="text/css" rel="stylesheet"/>

            <xsl:if test="$debugEnabled='true'">
               <!-- We only need these if we are in debug mode, for the Show XML Window -->
               <link href="{$css-loc}window.css"    media="all" type="text/css" rel="stylesheet"/>
               <link href="{$css-loc}alphacube.css" media="all" type="text/css" rel="stylesheet"/>
               <link href="{$css-loc}showXML.css"   media="all" type="text/css" rel="stylesheet"/>
          </xsl:if>

         <!--
         ## any stylesheets that are specific to a single page should be passed
         ## in otherwise the the stylesheet is global to all pages
         -->
         <xsl:copy-of select="$myCSS"/>
         <link href="{$css-loc}ucla_style.css"      media="all" type="text/css" rel="stylesheet"/>


         <xsl:text disable-output-escaping = "yes">&lt;!--[if lt IE 8]&gt;</xsl:text>
            <link href="{$css-loc}ieFixes.css"   media="all" type="text/css" rel="stylesheet"/>
         <xsl:text disable-output-escaping = "yes">&lt;![endif]--&gt;</xsl:text>
         <xsl:text disable-output-escaping = "yes">&lt;!--[if IE 7]&gt;</xsl:text>
            <link href="{$css-loc}ie7Fixes.css"   media="all" type="text/css" rel="stylesheet"/>
         <xsl:text disable-output-escaping = "yes">&lt;![endif]--&gt;</xsl:text>
         <xsl:text disable-output-escaping = "yes">&lt;!--[if gt IE 7]&gt;</xsl:text>
            <link href="{$css-loc}ie8Fixes.css"   media="all" type="text/css" rel="stylesheet"/>
         <xsl:text disable-output-escaping = "yes">&lt;![endif]--&gt;</xsl:text>

        </head>

    <xsl:variable name="timeout" select="/page:page/page:pageHeader/page:element[@nameId='timeout.time']/page:value"/>
    <xsl:variable name="grace" select="/page:page/page:pageHeader/page:element[@nameId='timeout.grace']/page:value"/>
    <xsl:variable name="timeoutMessage">
        <xsl:for-each select="$Configs/pageConfigs/jsmessage[@nameId='timeOutMessage']">
            <xsl:value-of select="preText"/><xsl:value-of select="$grace"/><xsl:value-of select="postText"/>
        </xsl:for-each>
    </xsl:variable>

      <!-- ## Html Body Section of the Page ## -->
      <body class="frameWorkUI" onLoad="setFocus('{/page:page/@nameId}'){$highlightNodes};timedMsg({$timeout}, {$grace}, '{$timeoutMessage}')">
           <div id="pageContainer">

              <!-- ## access Keys ## -->
             <a href="#mainContentLink"  accesskey="1"></a>    <!-- provide access to the main content on the page. -->
             <a href="#searchnavbar" accesskey="2"></a>    <!-- provide access to the search function on the page. -->
             <a href="#mainNav"      accesskey="3"></a>    <!-- provide access to the main menu on the page. -->

             <!-- This is the Header -->
            <div id="pageHeader">
               <xsl:call-template name="buildHeader"/>
            </div>

<xsl:comment>this is calling quickSearchBar in xsl/pageTools/frameWork.xsl</xsl:comment>
               <!--xsl:call-template name="quickSearchBar"/-->

               <!-- This is the main page content -->
               <div id="mainContent">
                  <a name="mainContentLink"></a>               <!-- This will help screen readers skip the header -->

                  <!-- ## Display blockCode errorCode etc  messages ## -->
                  <xsl:call-template name="displayPageMessages"/>

<div id="dtrMixingContent">
                  <div id="pageHeadingTitle">
                     <xsl:call-template name="buildPageHeading">
                        <xsl:with-param name="nameId" select="'page.heading'"/>
                     </xsl:call-template>
                  </div>
<xsl:call-template name="quickSearchBar"/>
</div>

                  <!-- ## This will be displayed for users who have javascript disabled ## -->
                  <noscript>
                      <h2 class="accessibilityHeader">
                          <xsl:for-each select="$Configs/pageConfigs/accessibilityHeader[@nameId='timeOutNoScript']">
                              <xsl:value-of select="preText"/><xsl:value-of select="$timeout"/><xsl:value-of select="postText"/>
                          </xsl:for-each>
                      </h2>
                  </noscript>

                  <xsl:call-template name="displayPageHtmlSnippet">
                     <xsl:with-param name="position" select="'aboveContent'"/>
                  </xsl:call-template>
		  
                  <xsl:call-template name="buildContent"/>
		  
                  <xsl:call-template name="displayPageHtmlSnippet">
                     <xsl:with-param name="position" select="'belowContent'"/>
                  </xsl:call-template>
               </div>

               <div class="push"></div>

         </div>
        
	 <!-- This is the Footer -->
         <xsl:call-template name="buildFooter"/>
         <!-- ## this is a show XML feature for debugging purposes ## -->
         <!-- ## for now it will probably fail validation and WAGS ## -->
         <xsl:if test="$debugEnabled='true'">
            <div id="showXML">
               <span id="showXmlLink"><a href="#" onclick="xmlWin.show();">Show XML</a></span>
            </div>

            <div id="hiddenXML" style="visibility:hidden;display:none">
                  <xsl:call-template name="showXML"/>
              </div>

            <script type="text/javascript">
               xmlWin = new Window('xmlView', {className: "alphacube", title: "Xml View", width:500, height:400, top:70, left:100});
               xmlWin.getContent().innerHTML = document.getElementById('hiddenXML').innerHTML;
            </script>
         </xsl:if>
         <xsl:call-template name="doAfterPageLoad"/>
      </body>
   </html>

</xsl:template>

<!-- ######################################################################################################################## -->

<xsl:template name="buildPageTitle">
<xsl:param name="nameId"/>

   <xsl:choose>
      <xsl:when test="/page:page//page:element[@nameId=$nameId]">
         <xsl:value-of select="/page:page//page:element[@nameId=$nameId]"/>
      </xsl:when>
      <xsl:when test="/page:page//page:element[@nameId='page.heading']">
         <xsl:value-of select="/page:page//page:element[@nameId='page.heading']"/>
      </xsl:when>
      <xsl:otherwise>
         Page Title not defined. Please define one in xml.
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<!-- ######################################################################################################################## -->

<xsl:template name="buildPageHeading">
<xsl:param name="nameId"/>

   <xsl:choose>
      <xsl:when test="/page:page//page:element[@nameId=$nameId]">
         <xsl:value-of select="/page:page//page:element[@nameId=$nameId]"/>
      </xsl:when>
      <xsl:when test="/page:page//page:element[@nameId='page.title']">
         <xsl:value-of select="/page:page//page:element[@nameId='page.title']"/>
      </xsl:when>
      <xsl:otherwise>
         Page Heading not defined. Please define one in xml.
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<!-- ######################################################################################################################## -->

<xsl:template name="doAfterPageLoad">
<!-- ## Place to put code to handle something after the page loads ## -->

    <!-- ## Request Forms ## -->
    <xsl:if test="/page:page[@nameId='page.patronRequest']">
        <xsl:choose>
            <xsl:when test="//page:pageBody/page:requestDefinition/req:requestIdentifier[@requestCode='SHORTLOAN']">            <!-- ## Short Loan ## -->
                <xsl:for-each select="//req:field/req:select[@tag='SL_Res_Date']">
                    <script type="text/javascript">slLoad('<xsl:value-of select="//req:requestIdentifier/@requestSiteId"/>','<xsl:value-of select="//req:fields/req:field[@tag = 'bibId']"/>')</script>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:if>

</xsl:template>

<!-- ######################################################################################################################## -->

</xsl:stylesheet>

