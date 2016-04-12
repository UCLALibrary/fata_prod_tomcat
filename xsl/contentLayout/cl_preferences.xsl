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
**          Product : WebVoyage :: cl_preferences
**          Version : 7.2.0
**          Created : 23-AUG-2007
**      Orig Author : David Sellers
**	   Last Modified : 14-SEP-2008
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ###################### -->
<!-- ## buildPreferences ## -->
<!-- ######################################################### -->

<xsl:template name="buildPreferences">

	<xsl:for-each select="/page:page/page:pageBody">
	
		<div id="preferences">
	
			<div id="pageLinks">
				<xsl:call-template name="buildMyAccountLinks">
					<xsl:with-param name="displayType" select="'searchpreferences'"/>
				</xsl:call-template>
			</div> 
	          
			<div id="preferenceBody">
	
				<xsl:call-template name="buildSearchOptions"/>
	
				<xsl:call-template name="buildPreferenceDisplayOptions"/>
	
				<xsl:call-template name="buildDBPreferences"/>
				
				<xsl:call-template name="buildPreferenceButtons"/>
	
			</div>
		</div>
	</xsl:for-each>		
</xsl:template>

<!-- ######################################################### -->
<xsl:template name="buildSearchOptions">

	<div id="searchOptions">
			<p id="SubTitle"><xsl:value-of select="page:element[@nameId='page.myAccount.editPreferences.searchOptions.label']/page:label"/></p>

			<xsl:call-template name="buildSearchTabOption">
				<xsl:with-param name="eleName"  select="'basic'"/>
			</xsl:call-template>						

			<xsl:call-template name="buildSearchTabOption">
				<xsl:with-param name="eleName"  select="'advanced'"/>
			</xsl:call-template>						

			<xsl:call-template name="buildSearchTabOption">
				<xsl:with-param name="eleName"  select="'subject'"/>
			</xsl:call-template>						

			<xsl:call-template name="buildSearchTabOption">
				<xsl:with-param name="eleName"  select="'author'"/>
			</xsl:call-template>						
				
			<xsl:call-template name="buildCourseReserveOption"/>
	</div>

</xsl:template>

<!-- ######################################################### -->
<xsl:template name="buildSearchTabOption">
<xsl:param name="eleName"/>


			<xsl:for-each select="page:element[@nameId='page']/page:option[@nameId=$eleName]">

				<xsl:variable name="searchTabCode">
					<xsl:value-of select="$eleName"/><xsl:text>Code</xsl:text>
				</xsl:variable>

				<div id="searchTabRadio">	
				
					<input type="radio" name="{../@nameId}" value="{page:value}">
            	        <xsl:if test="@selected = 'true'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>						
						
						<xsl:value-of select="page:text"/>

					</input>
				</div>			

				<div id="searchTabDropDowns">
					<xsl:call-template name="buildSelectionSetDropDown">
						<xsl:with-param name="selName"  select="$searchTabCode"/>
					</xsl:call-template>						
					<br/>
				</div>
			</xsl:for-each>

</xsl:template>

<!-- ######################################################### -->
<xsl:template name="buildCourseReserveOption">

	<xsl:for-each select="page:element[@nameId='page']/page:option[@nameId='courseReserve']">
	
		<div id="searchOptionsCourseReserve">
			<div id="courseReserveRadio">
	
				<input type="radio" name="{../@nameId}" value="{page:value}">
        	        <xsl:if test="@selected = 'true'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>										
				
					<xsl:value-of select="page:text"/>
				</input>
				
			</div>
	
			<div id="courseReserveDropDowns">
				<xsl:call-template name="buildFormDropDown">
					<xsl:with-param name="eleName"  select="'instructor'"/>
				</xsl:call-template>						
				<br/>
	
				<xsl:call-template name="buildFormDropDown">
					<xsl:with-param name="eleName"  select="'department'"/>
				</xsl:call-template>						
				<br/>
	
				<xsl:call-template name="buildFormDropDown">
					<xsl:with-param name="eleName"  select="'course'"/>
				</xsl:call-template>						
				<br/>
	
				<xsl:call-template name="buildFormDropDown">
					<xsl:with-param name="eleName"  select="'section'"/>
				</xsl:call-template>						
				<br/>
			</div>
		</div>
	</xsl:for-each>	
</xsl:template>




<!-- ######################################################### -->
<xsl:template name="buildPreferenceDisplayOptions">

	<div id="displayOptions">
		<p id="SubTitle"><xsl:value-of select="page:element[@nameId='page.myAccount.editPreferences.displayOptions.label']/page:label"/></p>
	
		<xsl:call-template name="buildFormDropDown">
			<xsl:with-param name="eleName"  select="'display'"/>
		</xsl:call-template>		
		
		<xsl:for-each select="page:element[@nameId='display']/page:text">
			<label id="recsPerPage"><xsl:value-of select="page:element[@nameId='display']/page:text"/></label>
		</xsl:for-each>
	</div>

</xsl:template>

<!-- ######################################################### -->
<xsl:template name="buildDBPreferences">
	
	<p id="SubTitle"><xsl:value-of select="page:element[@nameId='page.myAccount.editPreferences.database.label']/page:label"/></p>

	<xsl:for-each select="page:element[@nameId='page.selectDatabase.databases']">
		<xsl:for-each select="page:selectionSet">
			<div id="dbPreferences">
				<p id="fieldLabel"><xsl:value-of select="page:label"/></p>
				<xsl:variable name="chkBoxName" select="@nameId"/>
			
				<ol>
					<xsl:for-each select="page:option">
						<li>
							<input name="{$chkBoxName}" value="{page:value}" type="checkbox">
								<xsl:if test="@selected = 'true'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input>
							<xsl:value-of select="page:text"/>
						</li>
					</xsl:for-each>
				</ol>
			
			</div> 
		</xsl:for-each>
	</xsl:for-each>

</xsl:template>

<!-- ######################################################### -->
<xsl:template name="buildPreferenceButtons">
	<div id="buttons">
	
	    <div id="prefBtns">
            <input id="savePrefBtn" type="submit" value="{page:element[@nameId='page.myAccount.editPreferences.save.button']/page:buttonText}" class="submit" />
            <!--
            <input id="cancelPrefBtn" class="reset" type="reset" value="{page:element[@nameId='page.myAccount.editPreferences.cancel.button']/page:buttonText}" />
            -->
        </div>

	</div>
</xsl:template>


<!-- ######################################################### -->

</xsl:stylesheet>



