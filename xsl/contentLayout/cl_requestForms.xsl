<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.8 $ $Date: 2013/08/05 20:08:34 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: requestForms
**          Version : 8.0.0
**          Created : 13-NOV-2007
**      Orig Author : Mel Pemble
**    Last Modified : 24-MAR-2010
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo req page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:req="http://www.endinfosys.com/Voyager/requests">

<!-- ###################################################################### -->

<xsl:template name="buildDisplayRequestForms">
   <!-- ## Message to display during Ajax Request Form transactions ## -->
   <div id="disablingDiv" style="display:none"></div><span id="waitmsg" style="display:none">Please Wait</span>

   <!-- ## Add Logic here for special request forms ## -->
   <xsl:choose>
      <xsl:when test="$requestCode = 'MEDIAEQUIP'">
         <xsl:call-template name="buildRequestForm">
            <xsl:with-param name="formData">
               <xsl:call-template name="stdRequestData"/>
            </xsl:with-param>
            <xsl:with-param name="submitBtns">
               <li>
                  <label for="checkSchedule"></label>
                  <input id="checkSchedule" type="button" value="Check Schedule" class="submit" onclick="validateMediaEquip()"/>
                  <label for="bookingButton"></label>
                  <input id="bookingButton" type="submit" value="Place Booking" class="submit" style="visibility:hidden" onclick="convertMediaTimes()"/>
                  <!-- ## Cancel Button ## -->
                  <label for="cancel"></label>
                  <a id="cancel" href="{//page:element[@nameId='page.patronRequest.cancel.button']/page:buttonAction}"><xsl:value-of select="//page:element[@nameId='page.patronRequest.cancel.button']/page:buttonText"/></a>
               </li>
            </xsl:with-param>
            <xsl:with-param name="beforeFieldset">
               <div id="messageArea"></div>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:when>
      <xsl:when test="$requestCode = 'MEDIAITEM'">
         <xsl:call-template name="buildRequestForm">
            <xsl:with-param name="formData">
               <xsl:call-template name="stdRequestData"/>
            </xsl:with-param>
            <xsl:with-param name="submitBtns">
               <li>
                      <label for="checkSchedule"></label>
                  <input id="checkSchedule" type="button" value="Check Schedule" class="submit" onclick="validateItemReq()"/>
                  <label for="bookingButton"></label>
                  <input id="bookingButton" type="submit" value="Place Booking" class="submit" style="visibility:hidden" onclick="convertMediaTimes()"/>
                  <!-- ## Cancel Button ## -->
                  <label for="cancel"></label>
                  <a id="cancel" href="{//page:element[@nameId='page.patronRequest.cancel.button']/page:buttonAction}"><xsl:value-of select="//page:element[@nameId='page.patronRequest.cancel.button']/page:buttonText"/></a>
               </li>
            </xsl:with-param>
            <xsl:with-param name="beforeFieldset">
               <div id="messageArea"></div>
            </xsl:with-param>
            <xsl:with-param name="afterFieldset">
               <xsl:call-template name="doValidateHiddenProperties"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
         <xsl:call-template name="buildRequestForm">
            <xsl:with-param name="formData">
               <xsl:call-template name="stdRequestData"/>
            </xsl:with-param>
            <xsl:with-param name="submitBtns">
               <li class="submitButtons">
                  <div id="submitBtns">
                     <!-- ## Submit Button ## -->
                     <label for="submit"></label>
                     <input alt="{//page:element[@nameId='page.patronRequest.submit.button']/page:buttonMessage}" id="submit" type="submit" value="{//page:element[@nameId='page.patronRequest.submit.button']/page:buttonText}" class="requestSubmitButton" />
                     <!-- ## Cancel Button ## -->
                     <label for="cancel"></label>
                     <a id="cancel" href="{//page:element[@nameId='page.patronRequest.cancel.button']/page:buttonAction}"><xsl:value-of select="//page:element[@nameId='page.patronRequest.cancel.button']/page:buttonText"/></a>
                  </div>
               </li>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:otherwise>
   </xsl:choose>

   <xsl:copy-of select="$backToRecord"/>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="stdRequestData">
   <xsl:for-each select="$requestXML">
      <xsl:call-template name="doFieldLogic"/>
   </xsl:for-each>
</xsl:template>


<!-- ###################################################################### -->

<xsl:template name="buildRequestForm">
<xsl:param name="formData"/>
<xsl:param name="instructions"/>
<xsl:param name="submitBtns"/>
<xsl:param name="beforeFieldset"/>
<xsl:param name="afterFieldset"/>

   <xsl:variable name="myFormData">
      <xsl:copy-of select="$beforeFieldset"/>
      <xsl:for-each select="//page:requestDefinition">
         <fieldset>
            <legend><xsl:value-of select="req:requestIdentifier/@requestName"/></legend>
            <ol>
               <xsl:copy-of select="$instructions"/>
               <xsl:copy-of select="$formData"/>
               <xsl:copy-of select="$submitBtns"/>
            </ol>
         </fieldset>
      </xsl:for-each>
      <xsl:copy-of select="$afterFieldset"/>
   </xsl:variable>

   <xsl:if test="string-length($myFormData)">
      <form action="{//page:element[@nameId='page.patronRequest.submit.button']/page:buttonAction}" class="requestForm">
         <xsl:copy-of select="$myFormData"/>
      </form>
   </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="doValidateHiddenProperties">
<xsl:text>&#xA;</xsl:text>
    <script type="text/javascript">
    function validateHiddenProps()
    {
      var sendURL="";
       <xsl:for-each select="//req:fields/req:field[@hidden='Y']">
               sendURL += "&amp;<xsl:value-of select="@tag"/>=<xsl:value-of select="."/>";
       </xsl:for-each>
       return sendURL;
   }
    </script>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="doFieldLogic">
   <xsl:for-each select="req:fields">
      <xsl:call-template name="doField"/>
   </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="doField">
   <xsl:for-each select="req:field">
      <xsl:choose>
         <xsl:when test="@isOption='Y'">
            <li class="field"><div class="labelSection">
               <!-- display radio button -->
               <xsl:call-template name="doRadioButton"/>
               <!-- isOption might contain nothing, or a select, or more fields -->
               </div>
               <div class="dataSection">
               <xsl:choose>
                  <xsl:when test="count(req:select)">
                     <xsl:call-template name="doSelect"/>
                  </xsl:when>
                  <xsl:when test="count(req:field)">
                     <fieldset>
                        <ol>
                           <xsl:call-template name="doField"/>
                        </ol>
                     </fieldset>
                  </xsl:when>
                  <xsl:otherwise>
                     <span>&#160;</span>
                  </xsl:otherwise>
               </xsl:choose>
               </div>
            </li>
         </xsl:when>
         <xsl:when test="@hidden='Y'">
            <input type="hidden" name="{@tag}" value="{.}" class="hidden"/>
         </xsl:when>
         <xsl:when test="@isDate='Y'">
            <xsl:call-template name="doDateTimeField"/>
         </xsl:when>
         <xsl:otherwise>
            <li class="field">
               <div class="labelSection">
                  <xsl:call-template name="doLabel"/>
               </div>
               <div class="dataSection">
                  <xsl:choose>
                     <xsl:when test="count(req:select)">
                        <xsl:call-template name="doSelect"/>
                     </xsl:when>
                     <xsl:when test="@tag='REQCOMMENTS' ">
                        <textarea name="{@tag}" rows="2" cols="60" maxlength="100">
                           <xsl:value-of select="req:text"/>
                        </textarea>
                     </xsl:when>
                     <xsl:when test="@tag='bibInfo' ">
                        <textarea name="{@tag}" rows="4" cols="60" readonly="readonly" class="readonly">
                           <xsl:value-of select="req:text"/>
                        </textarea>
                     </xsl:when>
                     <xsl:when test="@readonly='Y' and not(@tag) and ($requestCode = 'MEDIAEQUIP' or $requestCode = 'MEDIAITEM')">
                        <span class="readonly" id="equipInRoom">
                           <xsl:for-each select="req:text">
                              <xsl:call-template name="br-replace">
                                 <xsl:with-param name="word" select="."/>
                              </xsl:call-template>
                              <xsl:if test="not(position()=last())">
                                 <br/>
                              </xsl:if>
                           </xsl:for-each>&#160;
                        </span><input class="hidden" type="hidden" id="{@label}" name="{@tag}" value="{.}"/>
                     </xsl:when>
                     <xsl:when test="@readonly='Y' and ($requestCode = 'MEDIAEQUIP' or $requestCode = 'MEDIAITEM')">
                        <span class="readonly" id="{@tag}">
                           <xsl:for-each select="req:text">
                              <xsl:call-template name="br-replace">
                                 <xsl:with-param name="word" select="."/>
                              </xsl:call-template>
                              <xsl:if test="not(position()=last())">
                                 <br/>
                              </xsl:if>
                           </xsl:for-each>&#160;
                        </span><input class="hidden" type="hidden" id="{@label}" name="{@tag}" value="{.}"/>
                     </xsl:when>
                     <xsl:when test="@readonly='Y' and (not(@isPassword='Y'))">
                        <span class="readonly" id="{@tag}">
                           <xsl:for-each select="req:text">
                              <xsl:call-template name="br-replace">
                                 <xsl:with-param name="word" select="."/>
                              </xsl:call-template>
                              <xsl:if test="not(position()=last())">
                                 <br/>
                              </xsl:if>
                           </xsl:for-each>&#160;
                        </span><input class="hidden" type="hidden" id="{@label}" name="{@tag}" value="{.}"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <input id="{@label}" name="{@tag}" value="{.}">
                           <xsl:if test="@readonly='Y'">
                              <xsl:attribute name="readonly">readonly</xsl:attribute>
                              <xsl:attribute name="class">readonly</xsl:attribute>
                              <xsl:attribute name="tabindex">-1</xsl:attribute>                  <!-- ## to prevent tab key from focusing on a readonly input ## -->
                           </xsl:if>
                           <xsl:choose>
                              <xsl:when test="@isPassword='Y'">
                                 <xsl:attribute name="type">password</xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:attribute name="type">text</xsl:attribute>
                              </xsl:otherwise>
                           </xsl:choose>
                        </input>
                     </xsl:otherwise>
                  </xsl:choose>
               </div>
               <div class="endRow"/>
            </li>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="doLabel">
   <label>
      <xsl:attribute name="for">
         <xsl:choose>
            <xsl:when test="@tag"><xsl:value-of select="@tag"/></xsl:when>
            <xsl:when test="count(req:select)"><xsl:value-of select="req:select/@tag"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="@label"/></xsl:otherwise>
         </xsl:choose></xsl:attribute>
      <xsl:attribute name="id">
         <xsl:choose>
            <xsl:when test="@tag"><xsl:value-of select="@tag"/>_label</xsl:when>
            <xsl:when test="count(req:select)"><xsl:value-of select="req:select/@tag"/>_label</xsl:when>
            <xsl:otherwise><xsl:value-of select="@label"/>_label</xsl:otherwise>
         </xsl:choose></xsl:attribute>
         <xsl:if test="@required='Y'">
            <em>*</em>
         </xsl:if>
      <xsl:value-of select="@label"/>&#160;
   </label>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="doDateTimeField">
   <li class="field">
   <div class="labelSection">
      <label id="{@tag}_label" for="{@label}">
         <xsl:if test="@required='Y'">
            <em>*</em>
         </xsl:if>
         <xsl:value-of select="@label"/>
      </label>
    </div>
    <div class="dataSection">
      <input class="inputStyle" name="{@tag}" id="{@tag}" size="20" value="{.}">

      <xsl:variable name="onchangeValue">
         <xsl:call-template name="doOnChange">
            <xsl:with-param name="tag" select="@tag"/>
         </xsl:call-template>
      </xsl:variable>

      <xsl:if test="string-length($onchangeValue)">
         <xsl:attribute name="onchange"><xsl:value-of select="$onchangeValue"/></xsl:attribute>
      </xsl:if>
      </input>
      <img  src="{$image-loc}icon_calendar.gif" id="trigger_{@tag}" class="imgCalendarIcon" width="18" height="18" alt="{@label}"/>
      <script type="text/javascript">
         <xsl:call-template name="buildCalendarText">
            <xsl:with-param name="inputFieldTag" select="@tag"/>
         </xsl:call-template>
                 
         <xsl:if test="$timeFormat='12' and ($requestCode='MEDIAITEM' or $requestCode='MEDIAEQUIP')">
            chng<xsl:value-of select="@tag"/>  = document.getElementById("<xsl:value-of select="@tag"/>");

            chng<xsl:value-of select="@tag"/>.value = convertTo1224(chng<xsl:value-of select="@tag"/>,12)

         </xsl:if>
      </script>
      </div>
   </li>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="doOnChange">
   <xsl:param name="tag"/>


   <xsl:choose>
      <xsl:when test="$requestCode='HOLD' or $requestCode='RECALL'">
         <xsl:if test="$tag='requestGroupId'">SetPickupLocs(this.options[this.selectedIndex].value);</xsl:if>
      </xsl:when>
      <xsl:when test="$tag='deliverLocId'">
         <xsl:if test="$requestCode='MEDIAITEM' or $requestCode='MEDIAEQUIP'">
            changeMediaDeliveryLoc();hideEle('bookingButton');updateMedia();
         </xsl:if>
      </xsl:when>
      <xsl:otherwise>
         <xsl:choose>
            <xsl:when test="$tag='Select_Library'">changeUBHoldingsLib(this.options[this.selectedIndex].value,'<xsl:value-of select="$bibId"/>')</xsl:when>
            <xsl:when test="$tag='Select_Pickup_Lib'">changeUBPickUpLib(this.options[this.selectedIndex].value)</xsl:when>
            <xsl:when test="$tag='SL_Res_Date'">slLoad('<xsl:value-of select="$requestSiteId"/>','<xsl:value-of select="$bibId"/>')</xsl:when>
            <xsl:when test="$tag='SL_Start_Time'">populateEndTimes()</xsl:when>
            <xsl:when test="$tag='itemId' and $requestCode='SHORTLOAN'">slLoad('<xsl:value-of select="$requestSiteId"/>','<xsl:value-of select="$bibId"/>')</xsl:when>
            <xsl:when test="$tag='itemId' and $requestCode='MEDIAITEM'">changeMediaItem('');hideEle('bookingButton');updateMedia()</xsl:when>
            <xsl:when test="$requestCode='MEDIAITEM' or $requestCode='MEDIAEQUIP'">hideEle('bookingButton');updateMedia()</xsl:when>
         </xsl:choose>
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="doRadioButton">

   <label>
      <input type="radio" name="{@tag}" value="{@value}">
         <xsl:if test="@isDefault='Y'">
            <xsl:attribute name="checked">checked</xsl:attribute>
         </xsl:if>

         <xsl:variable name="onchangeValue">
            <xsl:call-template name="doOnChange">
               <xsl:with-param name="tag" select="@tag"/>
            </xsl:call-template>
         </xsl:variable>

         <xsl:variable name="onClickValue">
            <xsl:call-template name="checkForRadioButtonOnClick">
               <xsl:with-param name="value" select="@value"/>
            </xsl:call-template>
         </xsl:variable>

         <xsl:if test="string-length($onClickValue)">
            <xsl:attribute name="onclick"><xsl:value-of select="$onClickValue"/></xsl:attribute>
         </xsl:if>

         <xsl:if test="string-length($onchangeValue)">
            <xsl:attribute name="onchange"><xsl:value-of select="$onchangeValue"/></xsl:attribute>
         </xsl:if>

      </input>
      <xsl:value-of select="@label"/>
   </label>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="checkForRadioButtonOnClick">
   <xsl:param name="value"/>
   <xsl:if test="$requestCode='HOLD' or $requestCode='RECALL'">
      <xsl:choose>
          <xsl:when test="$value='anyCopyAt'">SetPickupLocs(document.forms[1].requestGroupId.options[document.forms[1].requestGroupId.selectedIndex].value);</xsl:when>
      </xsl:choose>
   </xsl:if>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="doSelect">
   <xsl:for-each select="req:select">
      <select name="{@tag}" id="{@tag}">
         <xsl:if test="@isMultiple='Y'">
             <xsl:attribute name="multiple">multiple</xsl:attribute>
         </xsl:if>

         <xsl:variable name="onchangeValue">
            <xsl:call-template name="doOnChange">
               <xsl:with-param name="tag" select="@tag"/>
            </xsl:call-template>
         </xsl:variable>

         <xsl:if test="string-length($onchangeValue)">
            <xsl:attribute name="onchange"><xsl:value-of select="$onchangeValue"/></xsl:attribute>
         </xsl:if>

         <xsl:for-each select="req:option">
            <option value="{@id}">
               <xsl:if test="@isDefault='Y'">
                   <xsl:attribute name="selected">selected</xsl:attribute>
               </xsl:if>
               <xsl:value-of select="."/>
            </option>
         </xsl:for-each>
      </select>
   </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="buildCalendarText">
   <xsl:param name="inputFieldTag"/>

   <xsl:variable name="calText1">
         Calendar.setup({
            inputField     :    "</xsl:variable>

   <xsl:variable name="calText2">",                   // id of the input field
     <xsl:choose>
        <xsl:when test="$requestCode='MEDIAITEM' or $requestCode='MEDIAEQUIP'">
           <xsl:choose>
              <xsl:when test="$timeFormat='12'">
                 ifFormat       :    "%Y-%m-%d %I:%M:%S %p",  // format of the input field
                 timeFormat     : "12",
              </xsl:when>
              <xsl:otherwise>
                 ifFormat       :    "%Y-%m-%d %H:%M:%S",  // format of the input field
                 timeFormat     : "24",
              </xsl:otherwise>
           </xsl:choose>
        </xsl:when>
        <xsl:otherwise>ifFormat       :    "%Y-%m-%d",           // format of the input field</xsl:otherwise>
     </xsl:choose>
      button         :    "trigger_</xsl:variable>

   <xsl:variable name="calText3">
      <xsl:choose>
         <xsl:when test="$requestCode = 'MEDIAEQUIP' or $requestCode = 'MEDIAITEM'">",    // trigger for the calendar (button ID)
         showsTime      :    true,
         align          :    "Tl",                 // alignment (defaults to "Bl")
         singleClick    :    true
         });
         </xsl:when>
         <xsl:otherwise>",    // trigger for the calendar (button ID)
         showsTime      :    false,
         align          :    "Tl",                 // alignment (defaults to "Bl")
         singleClick    :    true
         });
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:value-of select="$calText1"/><xsl:value-of select="$inputFieldTag"/><xsl:value-of select="$calText2"/><xsl:value-of select="$inputFieldTag"/><xsl:value-of select="$calText3"/>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="buildRequestGroupsData">
   <script type="text/javascript">
      var arrGroupIds = new Array();
      var arrPickupIds = new Array();
      var arrPickupNames = new Array();
      <xsl:for-each select="//req:requestGroups">
         var defaultPickup = <xsl:value-of select="@defaultPickupId"/>;
         <xsl:for-each select="req:requestGroup">
            <xsl:variable name="groupIndex" select="position()-1"/>
            arrGroupIds[<xsl:value-of select="$groupIndex"/>] = "<xsl:value-of select="@id"/>"
            arrPickupIds[<xsl:value-of select="$groupIndex"/>] = new Array();
            arrPickupNames[<xsl:value-of select="$groupIndex"/>] = new Array();
            <xsl:for-each select="req:option">
               <xsl:variable name="locIndex" select="position()-1"/>
               arrPickupIds[<xsl:value-of select="$groupIndex"/>][<xsl:value-of select="$locIndex"/>] = "<xsl:value-of select="@id"/>";
               arrPickupNames[<xsl:value-of select="$groupIndex"/>][<xsl:value-of select="$locIndex"/>] = "<xsl:value-of select="."/>";
            </xsl:for-each>
         </xsl:for-each>
      </xsl:for-each>
   </script>
</xsl:template>

<!-- ###################################################################### -->

</xsl:stylesheet>


