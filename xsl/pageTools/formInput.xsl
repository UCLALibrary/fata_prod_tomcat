<!-- $Revision: 1.6 $ $Date: 2014/08/12 19:56:06 $ -->
<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: formInput
**          Version : 7.2.0
**          Created : 06-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet
    version="1.0"
    exclude-result-prefixes="xsl fo page"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page">

<!-- ################################################################################## -->

<xsl:template name="buildFormInput">
	<xsl:param name="eleName"/>
	<xsl:param name="idOverride"/>
	<xsl:param name="size"/>
	<xsl:param name="type"/>
	<xsl:param name="accesskey"/>
   <xsl:param name="cssClass"/>  <!-- ## pass in a cascading stylesheet class ## -->
   <xsl:param name="reqField"/>
   <xsl:param name="defaultLabelText"/>

      <xsl:call-template	name="diplayLabel">
			<xsl:with-param name="eleName" select="$eleName"/>
			<xsl:with-param name="idOverride" select="$idOverride"/>
			<xsl:with-param name="reqField" select="$reqField"/>
			<xsl:with-param name="defaultLabelText" select="$defaultLabelText"/>
		</xsl:call-template>

		<xsl:call-template	name="buildSingleInput">
			<xsl:with-param name="eleName"   select="$eleName"/>
			<xsl:with-param name="idOverride" select="$idOverride"/>
			<xsl:with-param name="size"      select="$size"/>
			<xsl:with-param name="type"      select="$type"/>
			<xsl:with-param name="accesskey" select="$accesskey"/>
			<xsl:with-param name="cssClass"  select="$cssClass"/>
		</xsl:call-template>

		<xsl:call-template	name="doMessages">
			<xsl:with-param name="eleName"   select="$eleName"/>
		</xsl:call-template>

</xsl:template>

<!-- ############################################################ -->

<xsl:template name="buildFormTextArea">
<xsl:param name="eleName"/>
<xsl:param name="rows"/>
<xsl:param name="cols"/>
<xsl:param name="accesskey"/>
<xsl:param name="cssClass"/>  <!-- ## pass in a cascading stylesheet class ## -->
<xsl:param name="reqField"/>
<xsl:param name="defaultLabelText"/>
<xsl:param name="idOverride"/>


      <xsl:call-template	name="diplayLabel">
			<xsl:with-param name="eleName" select="$eleName"/>
			<xsl:with-param name="idOverride" select="$idOverride"/>
			<xsl:with-param name="reqField" select="$reqField"/>
			<xsl:with-param name="defaultLabelText" select="$defaultLabelText"/>
		</xsl:call-template>

		<xsl:call-template	name="buildSingleInputArea">
			<xsl:with-param name="eleName"    select="$eleName"/>
			<xsl:with-param name="idOverride" select="$idOverride"/>
			<xsl:with-param name="rows"       select="$rows"/>
			<xsl:with-param name="cols"       select="$cols"/>
			<xsl:with-param name="accesskey"  select="$accesskey"/>
			<xsl:with-param name="cssClass"   select="$cssClass"/>
		</xsl:call-template>

		<xsl:call-template	name="doMessages">
			<xsl:with-param name="eleName"   select="$eleName"/>
		</xsl:call-template>

</xsl:template>

<!-- ################################################################################## -->

<xsl:template name="diplayLabel">
<xsl:param name="eleName"/>
<xsl:param name="idOverride"/>
<xsl:param name="reqField"/>
<xsl:param name="defaultLabelText"/>
<xsl:param name="beforeLabelData"/>
<xsl:param name="afterLabelData"/>

<xsl:variable name="eleID">
   <xsl:choose>
      <xsl:when test="string($idOverride)"><xsl:copy-of select="$idOverride"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$eleName"/></xsl:otherwise>
   </xsl:choose>
</xsl:variable>

   <label for="{$eleID}">
      <xsl:copy-of select="$beforeLabelData"/>
      <xsl:if test="$reqField"><xsl:copy-of select="$constStr_ReqField"/></xsl:if>
      <xsl:choose>
         <xsl:when test="string-length(/page:page//page:element[@nameId=$eleName]/page:label)">
            <xsl:value-of select="/page:page//page:element[@nameId=$eleName]/page:label" />
         </xsl:when>
         <xsl:when test="string-length($defaultLabelText)">
            <xsl:value-of select="$defaultLabelText" />
         </xsl:when>
      </xsl:choose>
      <xsl:copy-of select="$afterLabelData"/>
   </label>

</xsl:template>

<!-- ################################################################################## -->

<xsl:template name="doMessages">
<xsl:param name="eleName"/>
<xsl:param name="selectText"/>

   <xsl:if test="string($selectText)">
      <xsl:copy-of select="$selectText"/>
   </xsl:if>

   <xsl:for-each select="/page:page/page:element[@nameId=$eleName]">
      <xsl:if test="page:message">
         <xsl:for-each select="page:message">
            <br/><span class="fieldTextSmall"><xsl:value-of select="."/></span>
         </xsl:for-each>
      </xsl:if>
   </xsl:for-each>

</xsl:template>

<!-- ################################################################################## -->

<xsl:template name="buildSingleInput">
<xsl:param name="eleName"/>
<xsl:param name="idOverride"/>
<xsl:param name="size"/>
<xsl:param name="type"/>
<xsl:param name="accesskey"/>
<xsl:param name="cssClass"/>  <!-- ## pass in a cascading stylesheet class ## -->
<xsl:param name="disabled"/>  <!-- ## pass if the input is to be diabled ## -->

<xsl:variable name="eleID">
   <xsl:choose>
      <xsl:when test="string($idOverride)"><xsl:copy-of select="$idOverride"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$eleName"/></xsl:otherwise>
   </xsl:choose>
</xsl:variable>

   <input name="{$eleName}" id="{$eleID}" title="{$bodyText/*[name()=$eleName]}">
      <!-- ## Class Override ## -->
      <xsl:attribute name="class">
         <xsl:choose>
            <xsl:when test="string-length($cssClass)">
               <xsl:value-of select="$cssClass"/>
            </xsl:when>
            <xsl:otherwise>inputStyle</xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>

      <!-- ## Size ## -->
      <xsl:if test="string-length($size)">
         <xsl:attribute name="size">
            <xsl:value-of select="$size"/>
         </xsl:attribute>
      </xsl:if>

      <!-- ## Accesskey ## -->
      <xsl:if test="string-length($accesskey)">
         <xsl:attribute name="accesskey">
            <xsl:value-of select="$accesskey"/>
         </xsl:attribute>
      </xsl:if>

      <!-- ## disabled ## -->
      <xsl:if test="string-length($disabled) and ($disabled = 'disabled')">
         <xsl:attribute name="disabled">
            <xsl:value-of select="$disabled"/>
         </xsl:attribute>
      </xsl:if>


      <!-- ## Value ## -->
      <xsl:if test="string-length(/page:page//page:element[@nameId=$eleName]/page:value)">
         <xsl:attribute name="value">
            <xsl:value-of select="/page:page//page:element[@nameId=$eleName]/page:value"/>
         </xsl:attribute>
      </xsl:if>

      <!-- ## Type ## -->
      <xsl:attribute name="type">
         <xsl:choose>
            <xsl:when test="string-length($type)">
               <xsl:value-of select="$type"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'text'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>


   </input>

</xsl:template>

<!-- ################################################################################## -->

<xsl:template name="buildSingleInputArea">
<xsl:param name="eleName"/>
<xsl:param name="idOverride"/>
<xsl:param name="rows"/>
<xsl:param name="cols"/>
<xsl:param name="accesskey"/>
<xsl:param name="cssClass"/>  <!-- ## pass in a cascading stylesheet class ## -->

<xsl:variable name="eleID">
   <xsl:choose>
      <xsl:when test="string($idOverride)"><xsl:copy-of select="$idOverride"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$eleName"/></xsl:otherwise>
   </xsl:choose>
</xsl:variable>

   <textarea name="{$eleName}" id="{$eleID}" title="{$bodyText/*[name()=$eleName]}">
      <!-- ## Class Override ## -->
      <xsl:attribute name="class">
         <xsl:choose>
            <xsl:when test="string-length($cssClass)">
               <xsl:value-of select="$cssClass"/>
            </xsl:when>
            <xsl:otherwise>inputStyle</xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>

      <!-- ## cols ## -->
      <xsl:if test="string-length($cols)">
         <xsl:attribute name="rows">
            <xsl:value-of select="$cols"/>
         </xsl:attribute>
      </xsl:if>

      <!-- ## rows ## -->
      <xsl:if test="string-length($rows)">
         <xsl:attribute name="rows">
            <xsl:value-of select="$rows"/>
         </xsl:attribute>
      </xsl:if>

      <!-- ## Accesskey ## -->
      <xsl:if test="string-length($accesskey)">
         <xsl:attribute name="accesskey">
            <xsl:value-of select="$accesskey"/>
         </xsl:attribute>
      </xsl:if>



  	      <!-- ## Value ## -->
      <xsl:if test="string-length(/page:page//page:element[@nameId=$eleName]/page:value)">
         <xsl:value-of select="/page:page//page:element[@nameId=$eleName]/page:value"/>
      </xsl:if>
   </textarea>

</xsl:template>
<!-- ################################################################################## -->

<xsl:template name="buildFormDropDown">

<!-- ## nameID name to build the input from ## -->
<xsl:param name="eleName"/>

<xsl:param name="idOverride"/>

<!-- ## pass in a cascading stylesheet class ## -->
<xsl:param name="cssClass"/>

<!-- ## If we want to call a special javascript function ##
     ## when the form dropdown changes then pass it in   ## -->
<xsl:param name="onChangeCallJSFunction"/>
<xsl:param name="optGroupLabel"/>
<xsl:param name="size"/>
<xsl:param name="sortby"/>
<xsl:param name="multiple"/>
<xsl:param name="defaultLabelText"/>

<!--
     ## For cases where we want to combine a dropdown with the label field
     ## we will probably want to pass in combinedData element to use after the label
-->
<xsl:param name="combineLabelDropdown"/>
<xsl:param name="combinedData"/>

   <xsl:variable name="selectOptionsData">
      <xsl:call-template name="buildSelectionSetDropDown">
         <xsl:with-param name="selName">
            <xsl:value-of select="$eleName"/>
         </xsl:with-param>
         <xsl:with-param name="idOverride" select="$idOverride"/>
         <xsl:with-param name="cssClass" select="$cssClass"/>
         <xsl:with-param name="onChangeCallJSFunction" select="$onChangeCallJSFunction"/>
         <xsl:with-param name="optGroupLabel" select="$optGroupLabel"/>
         <xsl:with-param name="size" select="$size"/>
         <xsl:with-param name="sortby" select="$sortby"/>



         <xsl:with-param name="multiple" select="$multiple"/>
      </xsl:call-template>
   </xsl:variable>

   <xsl:choose>
      <xsl:when test="string-length($combineLabelDropdown)">
         <xsl:call-template	name="diplayLabel">
   			<xsl:with-param name="eleName" select="$eleName"/>
   			<xsl:with-param name="idOverride" select="$idOverride"/>
   			<xsl:with-param name="beforeLabelData" select="$selectOptionsData"/>
   			<xsl:with-param name="defaultLabelText" select="$defaultLabelText"/>
   		</xsl:call-template>
   		<xsl:value-of select="' '"/>
   		<xsl:copy-of select="$combinedData"/>

      </xsl:when>
      <xsl:otherwise>
         <xsl:call-template	name="diplayLabel">
   			<xsl:with-param name="eleName" select="$eleName"/>
   			<xsl:with-param name="idOverride" select="$idOverride"/>
   			<xsl:with-param name="defaultLabelText" select="$defaultLabelText"/>
   		</xsl:call-template>
   		<xsl:value-of select="' '"/>
   		<xsl:copy-of select="$selectOptionsData"/>
      </xsl:otherwise>
   </xsl:choose>

   <xsl:call-template name="doMessages">
      <xsl:with-param name="eleName" select="$eleName"/>
   </xsl:call-template>

</xsl:template>

<!-- ################################################################################## -->

<xsl:template name="buildSelectionSetDropDown">

<!-- ## selectionSet name to build the drop down from ## -->
<xsl:param name="selName"/>
<xsl:param name="idOverride"/>
<!-- ## pass in a cascading stylesheet class ## -->
<xsl:param name="cssClass"/>

<!-- ## If we want to call a special javascript function ##
     ## when the form dropdown changes then pass it in   ## -->
<xsl:param name="onChangeCallJSFunction"/>

<xsl:param name="optGroupLabel"/>
<xsl:param name="size"/>
<xsl:param name="multiple"/>

<xsl:param name="sortby"/>
<xsl:param name="datatype"/>
<xsl:param name="order"/>
<xsl:param name="defaultLabelText"/>

<xsl:variable name="eleID">
   <xsl:choose>
      <xsl:when test="string($idOverride)"><xsl:copy-of select="$idOverride"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$selName"/></xsl:otherwise>
   </xsl:choose>
</xsl:variable>
	<!--
		We need to look at every selection set until we find
		one whose attribute @nameId matches the passed in selName
	-->
	<xsl:for-each select="/page:page//page:element[@nameId=$selName]">

   	<xsl:variable name="isSelected">
      	<xsl:choose>
      	   <xsl:when test="page:option[@selected = 'true']">true</xsl:when>
      	   <xsl:otherwise>false</xsl:otherwise>
      	</xsl:choose>
      </xsl:variable>

		<!-- Begin building the dropdown -->
        <select title="{$bodyText/*[name()=$selName]}" autocomplete="off">
			<!-- ## External stylesheet Reference ## -->
			<xsl:attribute name="class"><xsl:value-of select="$cssClass"/></xsl:attribute>

			<xsl:choose>
				<!-- ## special javascript function to call when the form dropdown changes ## -->
				<xsl:when test="string-length($onChangeCallJSFunction)">
					<xsl:attribute name="onchange"><xsl:value-of select="$onChangeCallJSFunction"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>

         <!-- ## Size ## -->
         <xsl:if test="string-length($size)">
            <xsl:attribute name="size">
               <xsl:value-of select="$size"/>
            </xsl:attribute>
         </xsl:if>

         <!-- ## Multiple ## -->
         <xsl:if test="string-length($multiple)">
            <xsl:attribute name="multiple">
               <xsl:value-of select="'multiple'"/>
            </xsl:attribute>
         </xsl:if>

			<!-- ## Need to give the element a name and ID so that we can access it specifically with say.. javascript ## -->
			<xsl:attribute name="name"><xsl:value-of select="$selName"/></xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="$eleID"/></xsl:attribute>

			<xsl:variable name="options">
   			<!-- ## Now build all the option values ## -->
   			<!-- <xsl:sort select="*[local-name() = string($sortby)]" data-type="{$datatype}" order="{$order}"/> -->
   			<xsl:for-each select="page:option">
               <xsl:sort select="@nameId[$sortby = '@nameId'][1]"/>
               <xsl:sort select="page:text[$sortby = 'page:text'][1]"/>
               <xsl:sort select="page:value[$sortby = 'page:value'][1]"/>
      				<option>

      					<!-- ## The XML selected attribute tells us to select the option ## -->
      					<xsl:if test="@selected = 'true'">
      						<xsl:attribute name="selected">selected</xsl:attribute>
      					</xsl:if>

      					<!-- ## This will make sure the 1st option is selected if there was no default selection -->
      					<xsl:if test="$isSelected = 'false'  and position()='1'">
      						<xsl:attribute name="selected">selected</xsl:attribute>
      					</xsl:if>

      					<!-- ## this is the value that gets sent back to the server if the option is selected ## -->
      					<xsl:attribute name="value"><xsl:value-of select="page:value"/></xsl:attribute>

      					<!-- ## This is the text to display ## -->
      					<xsl:choose>
      						<xsl:when test="contains(page:text,'|')">
      							<!-- ## Handle Multiples ## -->
      							<xsl:call-template name="replace-chars-with-space">
      								<xsl:with-param name="text" select="page:text" />
      								<xsl:with-param name="replace" select="'|'" />
      							</xsl:call-template>
      						</xsl:when>
      						<xsl:otherwise><xsl:value-of select="page:text"/></xsl:otherwise>
      					</xsl:choose>
      				</option>

   			</xsl:for-each>
         </xsl:variable>

         <xsl:choose>
            <xsl:when test="string-length($optGroupLabel)">
               <optgroup label="{$optGroupLabel}">
                  <xsl:copy-of select="$options"/>
               </optgroup>
            </xsl:when>
            <xsl:otherwise>
               <xsl:copy-of select="$options"/>
            </xsl:otherwise>
         </xsl:choose>

		</select>

	</xsl:for-each>

</xsl:template>

<!-- ################## -->
<!-- ## buildNavTabs ## -->
<!-- ################################################################################## -->

<xsl:template name="buildNavTabs">
<xsl:param name="divID"/>
<xsl:param name="selectedTab"/>

   <a name="searchnavbar"></a>
	<div id="{$divID}">
		<h2 class="nav">Search Tab Navigation Bar</h2>
		<ul class="navbar" title="Search Tab Navigation Bar">

			<xsl:for-each select="$Configs/pageConfigs/searchTabDisplayOrder/tab">
				<xsl:variable name="tabName" select="@name"/>
				<xsl:for-each select="$pageBodyXML//page:tabs[@nameId='page.search.buttons']/page:button[@nameId=$tabName]">
					<xsl:variable name="tabOn">
						<xsl:choose>
							<xsl:when test="$selectedTab = ./@nameId">on</xsl:when>
							<xsl:otherwise>off</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<li class="{$tabOn}" title="{page:buttonMessage}"><a href="{page:buttonAction}" name="{./@nameId}"><span><xsl:value-of select="page:buttonText"/></span></a></li>
				</xsl:for-each>
			</xsl:for-each>
		</ul>
	</div>

</xsl:template>

<!-- ################################################################################## -->
<xsl:template name="formVerticalSpacer">
	<div class="formVerticalSpacer" />
</xsl:template>

<!-- ################################################################################## -->

<xsl:template name="formHorizontalSpacer">
	<div class="formHorizontalSpacer" />
</xsl:template>

<!-- ################################################################################## -->

<xsl:template name="buildSingleRadio">
   <xsl:param name="eleName"/>
   <xsl:param name="idOverride"/>
   <xsl:param name="optName"/>
   <xsl:param name="size"/>
   <xsl:param name="type" select="'radio'"/>
   <xsl:param name="accesskey"/>
   <xsl:param name="cssClass"/>  <!-- ## pass in a cascading stylesheet class ## -->
   <xsl:param name="defaultLabelText"/>


   <xsl:call-template name="diplayLabel">
      <xsl:with-param name="eleName" select="$eleName"/>
      <xsl:with-param name="idOverride" select="$idOverride"/>
      <xsl:with-param name="defaultLabelText" select="$defaultLabelText"/>
   </xsl:call-template>

   <xsl:call-template name="buildSingleOption">
      <xsl:with-param name="eleName"   select="$eleName"/>
      <xsl:with-param name="idOverride" select="$idOverride"/>
      <xsl:with-param name="optName"   select="$optName"/>
      <xsl:with-param name="type"      select="$type"/>
      <xsl:with-param name="accesskey" select="$accesskey"/>
      <xsl:with-param name="cssClass"  select="$cssClass"/>
   </xsl:call-template>

   <xsl:call-template	name="doMessages">
      <xsl:with-param name="eleName"   select="$eleName"/>
   </xsl:call-template>

</xsl:template>

<!-- ################################################################################## -->

<xsl:template name="buildSingleOption">
<xsl:param name="eleName"/>
<xsl:param name="idOverride"/>
<xsl:param name="optName"/>
<xsl:param name="type"/>
<xsl:param name="accesskey"/>
<xsl:param name="cssClass"/>  <!-- ## pass in a cascading stylesheet class ## -->

<xsl:variable name="eleID">
   <xsl:choose>
      <xsl:when test="string($idOverride)"><xsl:copy-of select="$idOverride"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$eleName"/></xsl:otherwise>
   </xsl:choose>
</xsl:variable>

   <input name="{$eleName}" id="{$eleID}" title="{$bodyText/*[name()=$eleName]}">
      <!-- ## Class Override ## -->
      <xsl:attribute name="class">
         <xsl:choose>
            <xsl:when test="string-length($cssClass)">
               <xsl:value-of select="$cssClass"/>
            </xsl:when>
            <xsl:otherwise>inputStyle</xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>


      <!-- ## Accesskey ## -->
      <xsl:if test="string-length($accesskey)">
         <xsl:attribute name="accesskey">
            <xsl:value-of select="$accesskey"/>
         </xsl:attribute>
      </xsl:if>

      <!-- ## Value ## -->
      <xsl:if test="string-length(/page:page//page:element[@nameId=$eleName]/page:option[@nameId=$optName]/page:value)">
         <xsl:attribute name="value">
            <xsl:value-of select="/page:page//page:element[@nameId=$eleName]/page:option[@nameId=$optName]/page:value"/>
         </xsl:attribute>
      </xsl:if>

      <!-- ## Type ## -->
      <xsl:attribute name="type">
         <xsl:choose>
            <xsl:when test="string-length($type)">
               <xsl:value-of select="$type"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'text'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>

      <!-- ## Selected / Checked ## -->
      <xsl:if test="/page:page//page:element[@nameId=$eleName]/page:option[@nameId=$optName]/@selected='true'">
         <xsl:attribute name="checked"/>
      </xsl:if>


   </input>

</xsl:template>


<!-- ################################################################################## -->

<xsl:template name="buildLimitSetDropDown">

<xsl:param name="limitType"/>
<xsl:param name="selectedLimit"/>
<xsl:param name="limitData"/>
<xsl:param name="cssClass"/>
<xsl:param name="onChangeCallJSFunction"/>

	<xsl:variable name="selectedLimitCode">
		<xsl:choose>
			<xsl:when test="string-length($selectedLimit)">
				<xsl:value-of select="$selectedLimit"/>
			</xsl:when>
			<xsl:when test="//page:element[@nameId=$limitType]/page:option/page:value">
				<xsl:value-of select="//page:element[@nameId=$limitType]/page:option/page:value"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$limitData/pageLimits/limitGroup[@type=$limitType]/limit[@default='Y']">
					<xsl:value-of select="$limitData/pageLimits/limitGroup[@type=$limitType]/limit[@default='Y']/@code"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>


	<xsl:variable name="output">
		<xsl:for-each select="$limitData/pageLimits/limitGroup[@type=$limitType]">

			<label for="{$limitType}"><xsl:value-of select="@label" /></label>


				<!-- Begin building the dropdown -->
				<select title="{$bodyText/*[name()=$limitType]}">
					<!-- ## External stylesheet Reference ## -->
					<xsl:attribute name="class"><xsl:value-of select="$cssClass"/></xsl:attribute>

					<xsl:choose>
						<!-- ## special javascript function to call when the form dropdown changes ## -->
						<xsl:when test="string-length($onChangeCallJSFunction)">
							<xsl:attribute name="onchange"><xsl:value-of select="$onChangeCallJSFunction"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>

					<!-- ## Need to give the element a name and ID so that we can access it specifically with say.. javascript ## -->
					<xsl:attribute name="name"><xsl:value-of select="$limitType"/></xsl:attribute>
					<xsl:attribute name="id"><xsl:value-of select="$limitType"/></xsl:attribute>

					<!-- ## Now build all the option values ## -->
					<xsl:for-each select="limit">
						<option>
							<!-- ## The XML selected attribute tells us to select the option ## -->
							<xsl:if test="$selectedLimitCode = @code">
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>

							<!-- ## this is the value that gets sent back to the server if the option is selected ## -->
							<xsl:attribute name="value"><xsl:value-of select="@code"/></xsl:attribute>

							<!-- ## This is the text to display ## -->
							<xsl:value-of select="."/>

						</option>
					</xsl:for-each>
				</select>

		</xsl:for-each>
	</xsl:variable>

	<xsl:copy-of select="$output"/>

</xsl:template>


<!-- added to make radio-list search type in basic search drickard 20140130 -->
<xsl:template name="buildRadioList">

        <xsl:param name="eleName"/>

        <xsl:param name="idOverride"/>

        <!-- ## pass in a cascading stylesheet class ## -->
        <xsl:param name="cssClass"/>

        <!-- ## If we want to call a special javascript function ##
             ## when the form dropdown changes then pass it in   ## -->
        <xsl:param name="onChangeCallJSFunction"/>
        <xsl:param name="optGroupLabel"/>
        <xsl:param name="size"/>
        <xsl:param name="sortby"/>
        <xsl:param name="multiple"/>
        <xsl:param name="defaultLabelText"/>

        <xsl:variable name="eleID">
           <xsl:choose>
              <xsl:when test="string($idOverride)"><xsl:copy-of select="$idOverride"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="$eleName"/></xsl:otherwise>
           </xsl:choose>
        </xsl:variable>

        <xsl:variable name="isSelected">
          <xsl:choose>
            <xsl:when test="page:option[@selected = 'true']">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="diplayLabel">
          <xsl:with-param name="eleName" select="$eleName"/>
          <xsl:with-param name="idOverride" select="$idOverride"/>
          <xsl:with-param name="defaultLabelText" select="$defaultLabelText"/>
        </xsl:call-template>

        &#160;
        <div style="float: right;">
        <xsl:for-each select="/page:page//page:element[@nameId=$eleName]">
          <xsl:for-each select="page:option">
            <input name="{$eleName}" id="{$eleID}" title="{$bodyText/*[name()=$eleName]}">
              <xsl:if test="@selected = 'true'">
                <xsl:attribute name="checked">true</xsl:attribute>
              </xsl:if>
              <xsl:if test="$isSelected = 'false'  and position()='1'">
                <xsl:attribute name="checked">true</xsl:attribute>
              </xsl:if>
              <xsl:attribute name="type">
                <xsl:value-of select="'radio'" />
              </xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select="page:value"/></xsl:attribute>
            </input>
            &#160;&#160;<span style="text-weight: bolder;"><xsl:value-of select="page:text"/></span><br/>
          </xsl:for-each>
        </xsl:for-each>
        </div>

        <xsl:call-template name="doMessages">
          <xsl:with-param name="eleName" select="$eleName"/>
        </xsl:call-template>

</xsl:template>

</xsl:stylesheet>


