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
**          Product : WebVoyage :: clSearchDatabases
**          Version : 7.2.0
**          Created : 31-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ################### -->
<!-- ## buildDBSelect ## -->
<!-- ##################################################################################################### -->

<xsl:template name="buildDBSelect">

   <xsl:for-each select="/page:page/page:pageBody">
   <!--
      <p class="pageTitle"><xsl:value-of select="page:element[@nameId='page.selectDatabase.selectDatabase.label']/page:label"/></p>
  --> 

   	<fieldset id="databases">
   		<legend><xsl:value-of select="page:element[@nameId='page.selectDatabase.selectDatabase.message']/page:messageText"/></legend>
         <a name="nav"></a>
         <h2 class="nav">Database Selections</h2>
   		<ol class="navbar" title="Database selections">
            <xsl:call-template name="buildDBGroups"/>
   			<li>
   				<label for="submit"><input type="submit" value="{page:element[@nameId='page.selectDatabase.select.button']/page:buttonText}" class="submit" id="submit" /></label>
   				<!--
   				<label for="reset"></label><input id="reset" class="reset" type="reset" value="{page:element[@nameId='page.selectDatabase.cancel.button']/page:buttonText}" />
   				-->
   			</li>
   		</ol>
   		   	
   	</fieldset>
   	

	</xsl:for-each>
			
</xsl:template>

<!-- ##################################################################################################### -->

<xsl:template name="buildDBGroups">

   <xsl:for-each select="page:element[@nameId='page.selectDatabase.databases']">
      <xsl:for-each select="page:selectionSet">
         <xsl:if test="string-length(page:option)">
         <li class="dbGroup">
      	<fieldset id="dbGroup">
      	   <legend><xsl:value-of select="page:label"/></legend>
      	   <xsl:variable name="chkBoxName" select="@nameId"/>

      	   <ol>
      	      <xsl:for-each select="page:option">
      	         <li>
      	            
         	         <input id="{$chkBoxName}{page:value}" name="{$chkBoxName}" value="{page:value}" type="radio">
            	         <xsl:if test="@selected = 'true'">
								   <xsl:attribute name="checked">checked</xsl:attribute>
							   </xsl:if>
         	         </input><label for="{$chkBoxName}{page:value}"><xsl:value-of select="page:text"/></label>
         	      </li>
      	      </xsl:for-each>
      	   </ol>

         </fieldset>
         </li>
         </xsl:if>
      </xsl:for-each>
   </xsl:for-each>

</xsl:template>

<!-- ##################################################################################################### -->

</xsl:stylesheet>


