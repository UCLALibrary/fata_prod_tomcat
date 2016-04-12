<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.10 $ $Date: 2014/07/18 20:41:42 $ -->

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2013 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: cl_myAccount
**          Version : 9.0.0
**          Created : 06-AUG-2007
**      Orig Author : David Sellers
**    Last Modified : 11-APR-2013
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

   <xsl:variable name="pdshandle" select="/page:myAccount/attribute::pdsHandle"/>
   <xsl:variable name="isUB" select="/page:myAccount/attribute::isUB"/>

   <xsl:variable name="borrowingBlocks" select="count(/page:page//page:element[@nameId='page.myAccount.borrowingBlocks']/page:element/page:item)"/>
   <xsl:variable name="borrowingBlocksYILabel" select="/page:page//page:element[@nameId='page.myAccount.borrowingBlocks']/page:yourItemsLink"/>

   <xsl:variable name="fineFeeTotal" select="/page:page//page:element[@nameId='page.myAccount.finesAndFees']/page:totalFeeBalance"/>
   <xsl:variable name="fineFeeYILabel" select="/page:page//page:element[@nameId='page.myAccount.finesAndFees']/page:yourItemsLink"/>

   <xsl:variable name="demeritTotal" select="/page:page//page:element[@nameId='page.myAccount.demerits']/page:totalDemerits"/>
   <xsl:variable name="demeritYILabel" select="/page:page//page:element[@nameId='page.myAccount.demerits']/page:yourItemsLink"/>

   <xsl:variable name="chargedItems" select="count(/page:page//page:element[@nameId='page.myAccount.chargedItem']/page:element/page:item)"/>
   <xsl:variable name="chargedItemsYILabel" select="/page:page//page:element[@nameId='page.myAccount.chargedItem']/page:yourItemsLink"/>

   <xsl:variable name="availableItems" select="count(/page:page//page:element[@nameId='page.myAccount.itemAvailable']/page:element/page:item)"/>
   <xsl:variable name="availableItemsYILabel" select="/page:page//page:element[@nameId='page.myAccount.itemAvailable']/page:yourItemsLink"/>

   <xsl:variable name="pendingRequests" select="count(/page:page//page:element[@nameId='page.myAccount.reqPending']/page:element/page:item)"/>
   <xsl:variable name="pendingRequestsYILabel" select="/page:page//page:element[@nameId='page.myAccount.reqPending']/page:yourItemsLink"/>

   <xsl:variable name="upcomingBookings" select="count(/page:page//page:element[@nameId='page.myAccount.mediaBookings.upcomingBookings']/page:element/page:item)"/>
   <xsl:variable name="upcomingBookingsYILabel" select="/page:page//page:element[@nameId='page.myAccount.mediaBookings.upcomingBookings']/page:yourItemsLink"/>

   <xsl:variable name="chargedBookings" select="count(/page:page//page:element[@nameId='page.myAccount.mediaBookings.chargedBookings']/page:element/page:item)"/>
   <xsl:variable name="chargedBookingsYILabel" select="/page:page//page:element[@nameId='page.myAccount.mediaBookings.chargedBookings']/page:yourItemsLink"/>

<!-- ######################## -->
<!-- ## buildMyAccountForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildMyAccountForm">
    <xsl:for-each select="/page:page/page:pageBody">
        <div id="myAccount">
            <!--p class="pageTitle"><xsl:value-of select="page:element[@nameId='page.myAccount.page.label']/page:label"/></p-->

            <xsl:if test="//page:element[@nameId='page.myAccount.patronExpireDate']" >
               <div class="patronExpireDateContainer">
                  <div class="patronExpireDateMessage">
                     <strong><xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.patronExpireDate']/page:value"/></strong>
                  </div>
               </div>
	    </xsl:if>
            
            <div id="pageLinks">
                <xsl:call-template name="displayYourItems"/>

                <xsl:call-template name="buildMyAccountLinks">
                    <xsl:with-param name="displayType" select="'myaccount'"/>
                </xsl:call-template>

            </div>

            <xsl:if test="$borrowingBlocks &gt; 0">
                <xsl:call-template name="displayBlocks"/>
            </xsl:if>

            <xsl:if test="$fineFeeTotal != 0">
                <xsl:call-template name="displayFinesFees"/>
            </xsl:if>

            <xsl:if test="$demeritTotal &gt; 0">
                <xsl:call-template name="displayDemerits"/>
            </xsl:if>


            <xsl:if test="$chargedItems &gt; 0">
                <div id="renew">
                    <xsl:choose>
                        <xsl:when test="$borrowingBlocks &gt; 0">
                            <xsl:call-template name="displayChargedItems"><xsl:with-param name="blocked" select="'Y'"/></xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="displayChargedItems"><xsl:with-param name="blocked" select="'N'"/></xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </xsl:if>

            <xsl:if test="$availableItems &gt; 0">
                <div id="available">
                    <xsl:call-template name="displayAvailableRequests"/>
                </div>
            </xsl:if>

            <xsl:if test="$pendingRequests &gt; 0">
                <div id="requests">
                    <xsl:call-template name="displayPendingRequests"/>
                </div>
            </xsl:if>

            <xsl:if test="$upcomingBookings &gt; 0">
                <div id="upcomingMediaBookings">
                    <xsl:call-template name="displayUpcomingBookings"/>
                </div>
            </xsl:if>

            <xsl:if test="$chargedBookings &gt; 0">
                <div id="chargedMediaBookings">
                    <xsl:call-template name="displayChargedBookings"/>
                </div>
            </xsl:if>
        </div>
</xsl:for-each>

</xsl:template>

<!-- ###################### -->
<!-- ## displayYourItems ## -->
<!-- ######################################################### -->

<xsl:template name="displayYourItems">

    <xsl:variable name="yourItemsData">
        <xsl:if test="$borrowingBlocks"><a href="#blocks"><xsl:value-of select="$borrowingBlocksYILabel"/> (<xsl:value-of select="$borrowingBlocks"/>)</a><br /></xsl:if>
        <xsl:if test="$fineFeeTotal"><a href="#finefee"><xsl:value-of select="$fineFeeYILabel"/> (<xsl:value-of select="$fineFeeTotal"/>)</a><br /></xsl:if>
        <xsl:if test="$demeritTotal"><a href="#demerits"><xsl:value-of select="$demeritYILabel"/> (<xsl:value-of select="$demeritTotal"/>)</a><br /></xsl:if>
        <xsl:if test="$chargedItems"><a href="#charged"><xsl:value-of select="$chargedItemsYILabel"/> (<xsl:value-of select="$chargedItems"/>)</a><br /></xsl:if>
        <xsl:if test="$availableItems"><a href="#available"><xsl:value-of select="$availableItemsYILabel"/> (<xsl:value-of select="$availableItems"/>)</a><br /></xsl:if>
        <xsl:if test="$pendingRequests"><a href="#requestsPending"><xsl:value-of select="$pendingRequestsYILabel"/> (<xsl:value-of select="$pendingRequests"/>)</a><br /></xsl:if>
        <xsl:if test="$upcomingBookings"><a href="#upcomingBookings"><xsl:value-of select="$upcomingBookingsYILabel"/> (<xsl:value-of select="$upcomingBookings"/>)</a><br /></xsl:if>
        <xsl:if test="$chargedBookings"><a href="#chargedMediaBookings"><xsl:value-of select="$chargedBookingsYILabel"/> (<xsl:value-of select="$chargedBookings"/>)</a><br /></xsl:if>
    </xsl:variable>

    <xsl:if test="$yourItemsData">
        <div id="yourItems">
            <div class="menu">
                <p>
                    <strong><xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.yourItems.label']/page:label"/></strong>
                </p>
                <p>
                    <xsl:copy-of select="$yourItemsData"/>
                </p>
            </div>
        </div>
    </xsl:if>

</xsl:template>

<!-- ################### -->
<!-- ## displayBlocks ## -->
<!-- ######################################################### -->

<xsl:template name="displayBlocks">
    <span class="subTitleWarning">
        <a name="blocks"/>
        <xsl:value-of select="page:element[@nameId='page.myAccount.borrowingBlocks']/page:label"/>
    </span>

    <xsl:for-each select="//page:element[@nameId='page.myAccount.recordSet.borrowingBlocks']">
        <table id="tableBlocks" cellspacing="0">
                <tr class="tableHeadingRowFinesFees">
                     <th colspan="1"><xsl:value-of select="page:clusterLabel"/>&#160;<xsl:value-of select="page:clusterName"/></th>
                </tr>
                <tr class="tableHeadingRowFinesFees">
                    <xsl:for-each select="page:heading">
                        <th id="tableCellHeading">
                            <xsl:value-of select="page:heading"/>
                            <xsl:text/>
                        </th>
                    </xsl:for-each>
                </tr>

                <xsl:for-each select="page:item">
                    <tr>
                        <td class="tableCell" headers="tableCellHeading">
                            <xsl:value-of select="page:reason"/>
                        </td>
                    </tr>
                </xsl:for-each>
        </table>
        <br/><br/>
    </xsl:for-each>

    <br/>
    <br/>
</xsl:template>

<!-- ###################### -->
<!-- ## displayFinesFees ## -->
<!-- ######################################################### -->

<xsl:template name="displayFinesFees">

    <span class="subTitleWarning">
        <a name="finefee"/>
        <xsl:value-of select="page:element[@nameId='page.myAccount.finesAndFees']/page:label"/>
    </span>

    <br/><br/>

        <xsl:for-each select="//page:element[@nameId='page.myAccount.recordSet.finesAndFees']">
            <table id="tableFinesFees" cellspacing="0" >
                    <tr class="tableHeadingRowFinesFees">
                        <th colspan="6"><xsl:value-of select="page:clusterLabel"/>&#160;<xsl:value-of select="page:clusterName"/></th>
                    </tr>
                    <tr class="tableHeadingRowFinesFees">
                        <th id="cellFeeDate"><xsl:value-of select="page:heading[@nameId='date']"/></th>
                        <th id="cellFeeItem"><xsl:value-of select="page:heading[@nameId='item']"/></th>
                        <th id="cellFeeType"><xsl:value-of select="page:heading[@nameId='feePaymentType']"/></th>
                        <th id="cellFeeAmount"><xsl:value-of select="page:heading[@nameId='fee']"/></th>
                        <th id="cellFeePayment"><xsl:value-of select="page:heading[@nameId='payment']"/></th>
                        <th id="cellFeeBalance"><xsl:value-of select="page:heading[@nameId='balance']"/></th>
                    </tr>

                    <xsl:for-each select="page:item">
                        <tr>
                            <td class="tableCell" headers="cellFeeDate"><xsl:value-of select="page:feeDate"/>&#160;</td>
                            <td class="tableCell" headers="cellFeeItem"><xsl:value-of select="page:feeItem"/>&#160;</td>
                            <td class="tableCell" headers="cellFeeType"><xsl:value-of select="page:feeType"/>&#160;</td>
                            <td class="tableCell" headers="cellFeeAmount"><xsl:value-of select="page:feeAmount"/>&#160;</td>
                            <td class="tableCell" headers="cellFeePayment"><xsl:value-of select="page:feePayment"/>&#160;</td>
                            <td class="tableCell" headers="cellFeeBalance"><xsl:value-of select="page:balance"/>&#160;</td>
                        </tr>
                    </xsl:for-each>
            </table>

            <span class="subTitleWarning">
                <xsl:value-of select="following::page:element[@nameId='page.myAccount.finesAndFees.amountDue.label']/page:label"/>
                &#160;
                <xsl:value-of select="following::page:element[@nameId='page.myAccount.finesAndFees.amountDue.label']/page:value"/>
            </span>
            <br/><br/>
        </xsl:for-each>

        <br/>

</xsl:template>

<!-- ##################### -->
<!-- ## displayDemerits ## -->
<!-- ######################################################### -->

<xsl:template name="displayDemerits">
    <span class="subTitleWarning">
        <a name="demerits"/>
        <xsl:value-of select="page:element[@nameId='page.myAccount.demerits']/page:label"/>
    </span>

    <table  id="tableDemerits" cellspacing="0" >

        <xsl:for-each select="page:element[@nameId='page.myAccount.demerits']">
                <tr id="tableHeadingRowDemerits">
                    <th id="cellDemeritDate"><xsl:value-of select="page:element/page:heading[@nameId='date']"/></th>
                    <th id="cellDemeritLoc"><xsl:value-of select="page:element/page:heading[@nameId='location']"/></th>
                    <th id="cellDemeritItem"><xsl:value-of select="page:element/page:heading[@nameId='item']"/></th>
                    <th id="cellDemeritType"><xsl:value-of select="page:element/page:heading[@nameId='type']"/></th>
                    <th id="cellDemeritDemerits"><xsl:value-of select="page:element/page:heading[@nameId='demerits']"/></th>
                    <th id="cellDemeritPosting"><xsl:value-of select="page:element/page:heading[@nameId='posting']"/></th>
                    <th id="cellDemeritBalance"><xsl:value-of select="page:element/page:heading[@nameId='balance']"/></th>
                </tr>

                <xsl:for-each select="page:element/page:item">
                    <tr>
                        <td class="tableCell" headers="cellDemeritDate"><xsl:value-of select="page:demeritDate"/>&#160;</td>
                        <td class="tableCell" headers="cellDemeritLoc"><xsl:value-of select="page:location"/>&#160;</td>
                        <td class="tableCell" headers="cellDemeritItem"><xsl:value-of select="page:itemTitle"/>&#160;</td>
                        <td class="tableCell" headers="cellDemeritType"><xsl:value-of select="page:demeritType"/>&#160;</td>
                        <td class="tableCell" headers="cellDemeritDemerits"><xsl:value-of select="page:amount"/>&#160;</td>
                        <td class="tableCell" headers="cellDemeritPosting"><xsl:value-of select="page:post"/>&#160;</td>
                        <td class="tableCell" headers="cellDemeritBalance"><xsl:value-of select="page:balance"/>&#160;</td>
                    </tr>
                </xsl:for-each>
        </xsl:for-each>
    </table>


    <span class="subTitleWarning">
        <xsl:value-of select="page:element[@nameId='page.myAccount.demerits']/page:element[@nameId='page.myAccount.demerits.total.label']/page:label"/>
        &#160;
        <xsl:value-of select="page:element[@nameId='page.myAccount.demerits']/page:element[@nameId='page.myAccount.demerits.total.label']/page:value"/>
    </span>
    <br/>
    <br/>



</xsl:template>

<!-- ######################### -->
<!-- ## displayChargedItems ## -->
<!-- ######################################################### -->

<xsl:template name="displayChargedItems">
<xsl:param name="blocked"/>


    <span class="subTitle">
        <a name="charged"/>
        <xsl:value-of select="page:element[@nameId='page.myAccount.chargedItem']/page:label"/>
    </span>

    <br />

            <xsl:variable name="formAction" select="page:element[@nameId='page.myAccount.chargedItem']/page:element[@nameId='selectCharged']">

            </xsl:variable>


    <form action="{//page:element[@nameId='page.form.action']/page:value}" method="POST" accept-charset="UTF-8"  name="myAccountRenew" id="myAccountRenewForm">

        <div id="tableDisplayChargedItems" class="tableDisplay">

            <xsl:variable name="chargedItemRenew"><xsl:value-of select="page:element[@nameId='page.myAccount.chargedItem']/page:element[@nameId='page.myAccount.chargedItem.renew.button']/page:buttonText"/></xsl:variable>
            <xsl:variable name="chargedItemRenewAction"><xsl:value-of select="page:element[@nameId='page.myAccount.chargedItem']/page:element[@nameId='page.myAccount.chargedItem.renew.button']/page:buttonAction"/></xsl:variable>

            <xsl:variable name="selectCharged" select="page:element[@nameId='page.myAccount.chargedItem']/page:element[@nameId='selectCharged']"/>

            <xsl:variable name="selectChargedAll"></xsl:variable>

            <xsl:if test="string-length($chargedItemRenew)">
                <div class="topLinks">
                   <h2 class="nav">Renew Charged Item Bar (Top)</h2>
                    <ul class="tableLinksTop">
                        <!-- Renew Charged Link -->
                        <li class="tableCancelLink">
                            <span class="imageLineCorner">&#160;</span>
                            <div class="yellowButton">
                                <span class="yellowBtnLeft">&#160;</span>
                                   <label for="chargedItemRenew">
                                       <input class="yellowBtn" type="submit" name="{$chargedItemRenewAction}" id="chargedItemRenew" value="{$chargedItemRenew}" />
                                   </label>
                                <span class="yellowBtnRight">&#160;</span>
                                <!--span class="endLine">&#160;</span-->
                                           <span class="endLine">&#160;</span>
                            </div>
                        </li>

                        <!-- Select All Check Box -->
                            <li class="tableSelectAll">
                                <div class="selectChkBox">
                                    <label for="selectChargedTop" class="fieldBold"><xsl:value-of select="$selectCharged/page:label"/></label>
                                    <input type="checkbox" name="selectChargedAll" id="selectChargedTop" value="{$selectChargedAll}" onclick="selectAllChargedCheckbox(document.getElementById('myAccountRenewForm'),this)" />
                                </div>
                            </li>
                    </ul>
                </div>
            </xsl:if>

            <table  id="tableChargedItems" cellspacing="0" >
                <xsl:for-each select="//page:element[@nameId='page.myAccount.recordSet.chargedItem']">
                            <tr class="tableHeadingRowCharged">
                                <th class="headerCheckbox">&#160;</th>
                                <th colspan="4" class="cellChargedItem"><xsl:value-of select="page:clusterLabel"/>&#160;<xsl:value-of select="page:clusterName"/></th>
                            </tr>
                            <tr class="tableHeadingRowCharged">
                                <xsl:if test="string-length($chargedItemRenew)">
                                    <th id="chargedHeaderCheckbox">&#160;</th>
                                </xsl:if>
                                <th id="cellChargedItem"><xsl:value-of select="page:heading[@nameId='item']"/></th>
                                <th id="cellChargedType"><xsl:value-of select="page:heading[@nameId='type']"/></th>
                                <th id="cellChargedStatus"><xsl:value-of select="page:heading[@nameId='status']"/></th>
                                <th id="cellChargedDueDate"><xsl:value-of select="page:heading[@nameId='dueDate']"/></th>
                            </tr>

                            <xsl:for-each select="page:item">

                                <xsl:variable name="rowClass">
                                    <xsl:choose>
                                        <xsl:when test="(position() mod 2) = 0">resultListRowHighlight</xsl:when>
                                        <xsl:otherwise>resultListRow</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>

                                <tr class="{$rowClass}">

                                    <xsl:if test="string-length($chargedItemRenew)">
                                        <th class="checkbox" headers="chargedHeaderCheckbox">
                                           <label for="chargedItemId_{position()}_{page:itemId}">
                                               <input type="checkbox" id="chargedItemId_{position()}_{page:itemId}" name="selectCharged" value="{page:itemId}" onclick="selectChargedItemChkBx(document.getElementById('myAccountRenewForm'))"/>
                                            </label>
                                        </th>
                                    </xsl:if>

                                    <td class="tableCell" headers="cellChargedItem"><xsl:value-of select="page:title"/>&#160;</td>
                                    <td class="tableCell" headers="cellChargedType"><xsl:value-of select="page:itemType"/>&#160;</td>
                                    <td class="tableCell" headers="cellChargedStatus">&#160;
                                         <xsl:choose>
                                            <xsl:when test="page:renewFailReason">
                                            <br/>
                                            <div class="renewFailReason">
                                                <xsl:for-each select="page:renewFailReason/page:reason">
                                                   <span class="value">
                                                       <xsl:value-of select="."/>
                                                   </span>
                                                   <br/>
                                                </xsl:for-each>
                                             </div>
                                             </xsl:when>
                                             <xsl:otherwise>
                                                <xsl:value-of select="page:status"/>
                                             </xsl:otherwise>
                                         </xsl:choose>
                                         &#160;
                                    </td>
                                    <td class="tableCell" headers="cellChargedDueDate"><xsl:value-of select="page:dueDate"/>&#160;</td>
                                </tr>
                            </xsl:for-each>
                </xsl:for-each>
            </table>


            <xsl:if test="string-length($chargedItemRenew)">
                <div class="bottomLinks">
                   <h2 class="nav">Renew Charged Item Bar (Bottom)</h2>
                    <ul class="tableLinksBottom">
                        <!-- Renew Charged Link -->
                        <li class="tableCancelLink">
                            <span class="imageLineCornerBottom">&#160;</span>
                            <div class="yellowButton">
                                <span class="yellowBtnLeft">&#160;</span>
                                   <label for="chargedItemRenewBottom">
                                       <input class="yellowBtn" type="submit" name="{$chargedItemRenewAction}" id="chargedItemRenewBottom" value="{$chargedItemRenew}" />
                                   </label>
                                <span class="yellowBtnRight">&#160;</span>
                                <!--span class="endLine">&#160;</span-->
                                           <span class="endLine">&#160;</span>
                            </div>
                        </li>


                        <!-- Select All Check Box -->
                            <li class="tableSelectAll">
                                <div class="selectChkBox">
                                    <label for="selectChargedBottom" class="fieldBold"><xsl:value-of select="$selectCharged/page:label"/></label>
                                    <input type="checkbox" name="selectCharged" id="selectChargedBottom" value="{$selectChargedAll}" onclick="selectAllChargedCheckbox(document.getElementById('myAccountRenewForm'),this)" />
                                </div>
                            </li>
                    </ul>
                </div>
            </xsl:if>
        </div>

    </form>

    <br/>
    <br/>

</xsl:template>

<!-- ############################## -->
<!-- ## displayAvailableRequests ## -->
<!-- ######################################################### -->

<xsl:template name="displayAvailableRequests">

    <span class="subTitle">
        <a name="available"/>
        <xsl:value-of select="page:element[@nameId='page.myAccount.itemAvailable']/page:label"/>
    </span>

    <br />

    <form action="{//page:element[@nameId='page.form.action']/page:value}" method="POST" accept-charset="UTF-8"  name="myAccountCancelAvailable">

        <div id="tableDisplayAvailableRequests" class="tableDisplay">

            <xsl:variable name="availableRequestsCancel"><xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.itemAvailable']/page:element[@nameId='page.myAccount.itemAvailable.cancel.button']/page:buttonText"/></xsl:variable>
            <xsl:variable name="availableRequestsCancelAction"><xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.itemAvailable']/page:element[@nameId='page.myAccount.itemAvailable.cancel.button']/page:buttonAction"/></xsl:variable>

            <xsl:variable name="selectItem" select="page:element[@nameId='page.myAccount.itemAvailable']/page:element[@nameId='selectItem']"/>

            <xsl:if test="string-length($availableRequestsCancel)">
                <div class="topLinks">
                   <h2 class="nav">Cancel Available Item Bar (Top)</h2>
                    <ul class="tableLinksTop">
                        <!-- Cancel Available Item -->
                        <li class="tableCancelLink">
                            <span class="imageLineCorner">&#160;</span>
                            <div class="yellowButton">
                                <span class="yellowBtnLeft">&#160;</span>
                                  <label for="availableRequestsCancel">
                              <input class="yellowBtn" type="submit" name="{$availableRequestsCancelAction}" id="availableRequestsCancel" value="{$availableRequestsCancel}" />
                           </label>
                                <span class="yellowBtnRight">&#160;</span>
                                <!--span class="endLine">&#160;</span-->
                                           <span class="endLine">&#160;</span>
                            </div>
                        </li>

                        <!-- Select All Check Box -->
                        <xsl:for-each select="$selectItem">
                            <li class="tableSelectAll">
                                <div class="selectChkBox">
                                    <label class="fieldBold" for="availSelectAllTop"><xsl:value-of select="$selectItem/page:label"/></label>
                                    <xsl:for-each select="page:option">
                                        <input type="checkbox" name="selectItem" id="availSelectAllTop" value="{page:value}" />
                                    </xsl:for-each>
                                </div>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:if>

            <table  id="tableAvailable" cellspacing="0" >
                <xsl:for-each select="page:element[@nameId='page.myAccount.itemAvailable']">
                        <tr id="tableHeadingRowAvailable">
                            <xsl:if test="string-length($availableRequestsCancel)">
                                <th class="headerCheckbox"><span class="imageLine">&#160;</span></th>
                            </xsl:if>
                            <th id="cellAvailableItem"><xsl:value-of select="page:element/page:heading[@nameId='item']"/></th>
                            <th id="cellAvailableDB"><xsl:value-of select="page:element/page:heading[@nameId='database']"/></th>
                            <th id="cellAvailableExpires"><xsl:value-of select="page:element/page:heading[@nameId='expires']"/></th>
                            <!--th id="cellAvailableStatus"><xsl:value-of select="page:element/page:heading[@nameId='status']"/></th-->
                            <th id="cellAvailablePickupLoc"><xsl:value-of select="page:element/page:heading[@nameId='pickupLoc']"/></th>
                        </tr>

                        <xsl:for-each select="page:element/page:item">

                            <xsl:variable name="rowClass">
                                <xsl:choose>
                                    <xsl:when test="(position() mod 2) = 0">resultListRowHighlight</xsl:when>
                                    <xsl:otherwise>resultListRow</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>

                            <tr class="{$rowClass}">
                                <xsl:if test="string-length($availableRequestsCancel)">
                                    <th class="checkbox" headers="headerCheckbox">
                                       <label for="availReqItemId_{position()}_{page:itemId}">
                                           <input type="checkbox" name="selectItem" id="availReqItemId_{position()}_{page:itemId}" value="{page:itemId}" />
                                        </label>
                                    </th>
                                </xsl:if>

                                <td class="tableCell" headers="cellAvailableItem">
                                    <!--a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="page:link"/>
                                           </xsl:attribute-->
                                        <xsl:value-of select="page:title"/>
                                    <!--/a-->

                                    &#160;
                                </td>
                                <td class="tableCell" headers="cellAvailableDB"><xsl:value-of select="page:database"/>&#160;</td>
                                <td class="tableCell" headers="cellAvailableExpires"><xsl:value-of select="page:expires"/>&#160;</td>
                                <!--  td class="tableCell" headers="cellAvailableStatus"><xsl:value-of select="page:status"/>&#160;</td-->
                                <td class="tableCell" headers="cellAvailablePickupLoc"><xsl:value-of select="page:pickUpLocation"/>&#160;</td>
                            </tr>
                        </xsl:for-each>
                </xsl:for-each>
            </table>

            <xsl:if test="string-length($availableRequestsCancel)">
                <div class="bottomLinks">
                   <h2 class="nav">Cancel Available Item Bar (Bottom)</h2>
                    <ul class="tableLinksBottom">
                        <!-- Cancel Available Item -->
                        <li class="tableCancelLink">
                            <span class="imageLineCornerBottom">&#160;</span>
                            <div class="yellowButton">
                                <span class="yellowBtnLeft">&#160;</span>
                                   <label for="availableRequestsCancel">
                                       <input class="yellowBtn" type="submit" name="{$availableRequestsCancelAction}" id="availableRequestsCancel" value="{$availableRequestsCancel}" />
                                    </label>
                                <span class="yellowBtnRight">&#160;</span>
                                <!--span class="endLine">&#160;</span-->
                                           <span class="endLine">&#160;</span>
                            </div>
                        </li>

                        <!-- Select All Check Box -->
                        <xsl:for-each select="$selectItem">
                            <li class="tableSelectAll">
                                <div class="selectChkBox">
                                    <label class="fieldBold" for="availSelectAllBottom"><xsl:value-of select="$selectItem/page:label"/></label>
                                    <xsl:for-each select="page:option">
                                        <input type="checkbox" name="selectItem" id="availSelectAllBottom" value="{page:value}" />
                                    </xsl:for-each>
                                </div>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:if>
        </div>
    </form>

    <br/>
    <br/>

</xsl:template>


<!-- ############################ -->
<!-- ## displayPendingRequests ## -->
<!-- ######################################################### -->
<xsl:template name="displayPendingRequests">

    <span class="subTitle">
        <a name="requestsPending"/>
        <xsl:value-of select="page:element[@nameId='page.myAccount.reqPending']/page:label"/>
    </span>
    <br />

    <form action="{//page:element[@nameId='page.form.action']/page:value}" method="POST" accept-charset="UTF-8"  name="myAccountCancelPending">

        <div id="tableDisplayPendingRequests" class="tableDisplay">

            <xsl:variable name="pendingRequestsCancel"><xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.reqPending']/page:element[@nameId='page.myAccount.reqPending.cancel.button']/page:buttonText"/></xsl:variable>
            <xsl:variable name="pendingRequestsCancelAction"><xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.reqPending']/page:element[@nameId='page.myAccount.reqPending.cancel.button']/page:buttonAction"/></xsl:variable>

            <xsl:variable name="selectRequest" select="page:element[@nameId='page.myAccount.reqPending']/page:element[@nameId='selectRequest']"/>

            <xsl:if test="string-length($pendingRequestsCancel)">
                <div class="topLinks">
                   <h2 class="nav">Cancel Pending Requests Item Bar (Top)</h2>
                    <ul class="tableLinksTop">
                        <!-- Cancel Available Item -->
                        <li class="tableCancelLink">
                            <span class="imageLineCorner">&#160;</span>
                            <div class="yellowButton">
                                <span class="yellowBtnLeft">&#160;</span>
                                   <label for="pendingRequestsCancel">
                                       <input class="yellowBtn" type="submit" name="{$pendingRequestsCancelAction}" id="pendingRequestsCancel" value="{$pendingRequestsCancel}" />
                                    </label>
                                <span class="yellowBtnRight">&#160;</span>
                                <!--span class="endLine">&#160;</span-->
                                           <span class="endLine">&#160;</span>
                            </div >
                        </li>


                        <!-- Select All Check Box -->
                        <xsl:for-each select="$selectRequest">
                            <li class="tableSelectAll">
                                <div class="selectChkBox">
                                    <label class="fieldBold" for="pendingSelectAllTop"><xsl:value-of select="$selectRequest/page:label"/></label>
                                    <xsl:for-each select="page:option">
                                        <input type="checkbox" name="selectRequest" id="pendingSelectAllTop" value="{page:value}" />
                                    </xsl:for-each>
                                </div>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:if>

            <table  id="tablePendingReq" cellspacing="0" >
                <xsl:for-each select="page:element[@nameId='page.myAccount.reqPending']">

                        <xsl:variable name="pickupLocation" select="page:element/page:heading[@nameId='pickupLocation']"/>
                        <xsl:variable name="noFillReason" select="page:element/page:heading[@nameId='noFillReason']"/>
                        <xsl:variable name="replyNote" select="page:element/page:heading[@nameId='replyNote']"/>

                        <tr id="tableHeadingRowRequests">
                            <xsl:if test="string-length($pendingRequestsCancel)">
                                <th id="headerPendingCheckbox"><span class="imageLine">&#160;</span></th>
                            </xsl:if>
                            <th id="cellRequestItem"><xsl:value-of select="page:element/page:heading[@nameId='item']"/></th>

                            <xsl:if  test="string-length($pickupLocation)">
                                <th id="cellRequestPickUp"><xsl:value-of select="$pickupLocation"/></th>
                            </xsl:if>

                            <th id="cellRequestDB"><xsl:value-of select="page:element/page:heading[@nameId='database']"/></th>
                            <th id="cellRequestStatus"><xsl:value-of select="page:element/page:heading[@nameId='status']"/></th>
                            <!--th id="cellRequestHoldExp"><xsl:value-of select="page:element/page:heading[@nameId='holdExpires']"/></th-->
                            <xsl:if  test="string-length($noFillReason)">
                                <th id="cellRequestNoFillReason"><xsl:value-of select="$noFillReason"/></th>
                            </xsl:if>
                            <xsl:if  test="string-length($replyNote)">
                                <th id="cellRequestReplyNote"><xsl:value-of select="$replyNote"/></th>
                            </xsl:if>
                        </tr>

                        <xsl:for-each select="page:element/page:item">

                            <xsl:variable name="rowClass">
                                <xsl:choose>
                                    <xsl:when test="(position() mod 2) = 0">resultListRowHighlight</xsl:when>
                                    <xsl:otherwise>resultListRow</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>

                            <xsl:variable name="requestType" select="page:requestType"/>

                            <tr class="{$rowClass}">
                                <xsl:if test="string-length($pendingRequestsCancel)">
                                    <th class="checkbox" headers="headerPendingCheckbox">
                                        <xsl:choose>
                                            <xsl:when test="string-length($requestType)"><!-- No checkbox --></xsl:when>
                                            <xsl:otherwise>
                                                <label for="pendItemId_{position()}_{page:itemId}">
                                                    <input type="checkbox" name="selectRequest" id="pendItemId_{position()}_{page:itemId}" value="{page:itemId}" />
                                                </label>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </th>
                                </xsl:if>

                                <td class="tableCell" headers="cellRequestItem">
                                    <xsl:if test="string-length($requestType)">
                                        <span class="bold"><xsl:value-of select="$requestType"/></span>&#160;
                                    </xsl:if>
                                    <!--a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="page:link"/>
                                           </xsl:attribute-->
                                        <xsl:value-of select="page:title"/>
                                    <!--/a-->

                                    &#160;
                                </td>

                                <xsl:if  test="string-length($pickupLocation)">
                                    <td class="tableCell" headers="cellRequestPickUp"><xsl:value-of select="page:pickUpLocation"/>&#160;</td>
                                </xsl:if>

                                <td class="tableCell" headers="cellRequestDB"><xsl:value-of select="page:database"/>&#160;</td>
                                <td class="tableCell" headers="cellRequestStatus"><xsl:value-of select="page:status"/>&#160;</td>
                                <!--td class="tableCell" headers="cellRequestHoldExp"><xsl:value-of select="page:holdExpires"/>&#160;</td-->
                                <xsl:if  test="string-length($noFillReason)">
                                    <td class="tableCell" headers="cellRequestNoFillReason"><xsl:value-of select="page:noFillReason"/>&#160;</td>
                                </xsl:if>
                                <xsl:if  test="string-length($replyNote)">
                                    <td class="tableCell" headers="cellRequestNoFillReason"><xsl:value-of select="page:note"/>&#160;</td>
                                </xsl:if>
                            </tr>
                        </xsl:for-each>
                </xsl:for-each>
            </table>

            <xsl:if test="string-length($pendingRequestsCancel)">



                <div class="bottomLinks">
                   <h2 class="nav">Cancel Pending Requests Item Bar (Bottom)</h2>
                    <ul class="tableLinksBottom">
                        <!-- Cancel Available Item -->
                        <li class="tableCancelLink">
                            <span class="imageLineCornerBottom">&#160;</span>
                            <div class="yellowButton">
                                <span class="yellowBtnLeft">&#160;</span>
                                  <label for="pendingRequestsCancelBottom">
                                     <input class="yellowBtn" type="submit" name="{$pendingRequestsCancelAction}" id="pendingRequestsCancelBottom" value="{$pendingRequestsCancel}" />
                                 </label>
                                <span class="yellowBtnRight">&#160;</span>
                                <!--span class="endLine">&#160;</span-->
                                           <span class="endLine">&#160;</span>
                            </div >
                        </li>



                        <!-- Select All Check Box -->
                        <xsl:for-each select="$selectRequest">
                            <li class="tableSelectAll">
                                <div class="selectChkBox">
                                    <label class="fieldBold" for="pendingSelectAllBottom"><xsl:value-of select="$selectRequest/page:label"/></label>
                                    <xsl:for-each select="page:option">
                                        <input type="checkbox" name="selectRequest" id="pendingSelectAllBottom" value="{page:value}" />
                                    </xsl:for-each>
                                </div>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:if>
        </div>
    </form>

    <br/>
    <br/>

</xsl:template>
<!-- ############################# -->
<!-- ## displayUpcomingBookings ## -->
<!-- ######################################################### -->
<xsl:template name="displayUpcomingBookings">

    <span class="subTitle">
        <a name="upcomingBookings"/>
        <xsl:value-of select="page:element[@nameId='page.myAccount.mediaBookings.upcomingBookings']/page:label"/>
    </span>
    <br />

    <form action="{//page:element[@nameId='page.form.action']/page:value}" method="POST" accept-charset="UTF-8"  name="myAccountCancelUpcomingBookings">

        <div id="tableDisplayUpcomingBookings" class="tableDisplay">

            <xsl:variable name="upcomingBookingsCancel"><xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.mediaBookings.upcomingBookings']/page:element[@nameId='page.myAccount.mediaBookings.cancel.button']/page:buttonText"/></xsl:variable>
            <xsl:variable name="upcomingBookingsCancelAction"><xsl:value-of select="/page:page//page:element[@nameId='page.myAccount.mediaBookings.upcomingBookings']/page:element[@nameId='page.myAccount.mediaBookings.cancel.button']/page:buttonAction"/></xsl:variable>

            <xsl:variable name="selectUpcomingBookings" select="page:element[@nameId='page.myAccount.mediaBookings.upcomingBookings']/page:element[@nameId='selectBookings']"/>

            <xsl:if test="string-length($upcomingBookingsCancel)">
                <div class="topLinks">
                   <h2 class="nav">Cancel Upcoming Bookings Requests Item Bar (Top)</h2>
                    <ul class="tableLinksTop">
                        <!-- Cancel Available Item -->
                        <li class="tableCancelLink">
                            <span class="imageLineCorner">&#160;</span>
                            <div class="yellowButton">
                                <span class="yellowBtnLeft">&#160;</span>
                                   <label for="upcomingBookingsCancel">
                                       <input class="yellowBtn" type="submit" name="{$upcomingBookingsCancelAction}" id="upcomingBookingsCancel" value="{$upcomingBookingsCancel}" />
                                    </label>
                                <span class="yellowBtnRight">&#160;</span>
                                <!--span class="endLine">&#160;</span-->
                                           <span class="endLine">&#160;</span>
                            </div >
                        </li>


                        <!-- Select All Check Box -->
                        <xsl:for-each select="$selectUpcomingBookings">
                            <li class="tableSelectAll">
                                <div class="selectChkBox">
                                    <label class="fieldBold" for="bookingsSelectAllTop"><xsl:value-of select="$selectUpcomingBookings/page:label"/></label>
                                    <xsl:for-each select="page:option">
                                        <input type="checkbox" name="selectBookings" id="bookingsSelectAllTop" value="{page:value}" />
                                    </xsl:for-each>
                                </div>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:if>

            <xsl:call-template name="createBookingTable">
                 <xsl:with-param name="nameId" select="'page.myAccount.mediaBookings.upcomingBookings'"/>
                 <xsl:with-param name="tableId" select="'tableUpcomingBookingsReq'"/>
                 <xsl:with-param name="tableRowId" select="'tableHeadingRowUpcomingBookings'"></xsl:with-param>
                 <xsl:with-param name="cancel" select="$upcomingBookingsCancel"></xsl:with-param>
            </xsl:call-template>

            <xsl:if test="string-length($upcomingBookingsCancel)">
                <div class="bottomLinks">
                   <h2 class="nav">Cancel Upcoming Bookings Requests Item Bar (Bottom)</h2>
                    <ul class="tableLinksBottom">
                        <!-- Cancel Available Item -->
                        <li class="tableCancelLink">
                            <span class="imageLineCornerBottom">&#160;</span>
                            <div class="yellowButton">
                                <span class="yellowBtnLeft">&#160;</span>
                                  <label for="upcomingBookingsCancelBottom">
                                     <input class="yellowBtn" type="submit" name="{$upcomingBookingsCancelAction}" id="upcomingBookingsCancelBottom" value="{$upcomingBookingsCancel}" />
                                 </label>
                                <span class="yellowBtnRight">&#160;</span>
                                <!--span class="endLine">&#160;</span-->
                                           <span class="endLine">&#160;</span>
                            </div >
                        </li>

                        <!-- Select All Check Box -->
                        <xsl:for-each select="$selectUpcomingBookings">
                            <li class="tableSelectAll">
                                <div class="selectChkBox">
                                    <label class="fieldBold" for="bookingsSelectAllBottom"><xsl:value-of select="$selectUpcomingBookings/page:label"/></label>
                                    <xsl:for-each select="page:option">
                                           <input type="checkbox" name="selectBookings" id="bookingsSelectAllBottom" value="{page:value}" />
                                    </xsl:for-each>
                                </div>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:if>
        </div>
    </form>

    <br/>
    <br/>

</xsl:template>

<!-- ################################################## -->
<!-- ## displayChargedBookings - No Cancel or renew  ## -->
<!-- ######################################################### -->
<xsl:template name="displayChargedBookings">

    <span class="subTitle">
        <a name="chargedMediaBookings"/>
        <xsl:value-of select="page:element[@nameId='page.myAccount.mediaBookings.chargedBookings']/page:label"/>
    </span>
    <br />
    <div id="tableDisplayChargedBookings" class="tableDisplay">
        <xsl:call-template name="createBookingTable">
             <xsl:with-param name="nameId" select="'page.myAccount.mediaBookings.chargedBookings'"/>
             <xsl:with-param name="tableId" select="'tableChargedBookingsReq'"/>
             <xsl:with-param name="tableRowId" select="'tableHeadingRowChargedBookings'"></xsl:with-param>
             <xsl:with-param name="cancel" select="''"></xsl:with-param>
        </xsl:call-template>
    </div>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="createBookingTable">
<xsl:param name="nameId"/>
<xsl:param name="tableId" />
<xsl:param name="tableRowId" />
<xsl:param name="cancel"/>
            <table  id="{$tableId}" cellspacing="0" >
                <xsl:for-each select="page:element[@nameId=$nameId]">

                        <tr id="{$tableRowId}">
                            <xsl:if test="string-length($cancel)">
                                <th id="headerCheckboxBooking"><span class="imageLine">&#160;</span></th>
                            </xsl:if>
                            <th id="cellStartTime"><xsl:value-of select="page:element/page:heading[@nameId='startTime']"/></th>
                            <th id="cellEndTime"><xsl:value-of select="page:element/page:heading[@nameId='endTime']"/></th>
                            <th id="cellConfirmationNumber"><xsl:value-of select="page:element/page:heading[@nameId='confirmationNumber']"/></th>
                            <th id="cellBookingType"><xsl:value-of select="page:element/page:heading[@nameId='bookingType']"/></th>
                            <th id="cellRoom"><xsl:value-of select="page:element/page:heading[@nameId='room']"/></th>
                            <th id="cellEquipmentCount"><xsl:value-of select="page:element/page:heading[@nameId='equipmentCount']"/></th>
                            <th id="cellItemCount"><xsl:value-of select="page:element/page:heading[@nameId='itemCount']"/></th>
                            <!--th id="cellItemData"><xsl:value-of select="page:element/page:heading[@nameId='itemData']"/></th>-->
                        </tr>
                        <xsl:for-each select="page:element/page:item">

                            <xsl:variable name="rowClass">
                                <xsl:choose>
                                    <xsl:when test="(position() mod 2) = 0">resultListRowHighlight</xsl:when>
                                    <xsl:otherwise>resultListRow</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="equipment" select="count(page:equipmentData)" >
                            </xsl:variable>
                            <xsl:variable name="items" select="count(page:itemData)" >
                            </xsl:variable>

                            <tr class="{$rowClass}">
                                <xsl:if test="string-length($cancel)">
                                    <th class="checkbox" headers="headerCheckboxBooking">
                                        <label for="bookItemId_{position()}_{page:itemId}">
                                            <input type="checkbox" name="selectBookings" id="bookItemId_{position()}_{page:itemId}" value="{page:itemId}" />
                                        </label>
                                    </th>
                                </xsl:if>

                                <td class="tableCell" headers="cellStartTime"><xsl:value-of select="page:startTime"/>&#160;</td>
                                <td class="tableCell" headers="cellEndTime"><xsl:value-of select="page:endTime"/>&#160;</td>
                                <td class="tableCell" headers="cellConfirmationNumber"><xsl:value-of select="page:confirmationNumber"/>&#160;</td>
                                <td class="tableCell" headers="cellBookingType"><xsl:value-of select="page:itemType"/>&#160;</td>
                                <td class="tableCell" headers="cellRoom"><xsl:value-of select="page:room"/>&#160;</td>
                                <td class="tableCell" headers="cellEquipmentCount">
                                 <span class="label">
                                     <xsl:value-of select="page:equipmentCount"/>
                                </span><br/>
                                 <xsl:if test="$equipment &gt; 0">
                                        <xsl:for-each select="page:equipmentData">
                                            <span class="label" style="font-style: italic;">
                                                 <xsl:value-of select="@name"/>
                                            </span> &#160;<span class="value">
                                                  <xsl:value-of select="."/>
                                            </span>
                                            <br/>
                                        </xsl:for-each>
                                    </xsl:if>&#160;
                                </td>
                                <td class="tableCell" headers="cellItemCount">
                                 <span class="label">
                                <xsl:value-of select="page:itemCount"/>
                                 </span><br/>
                                <xsl:if test="$items &gt; 0">
                                        <xsl:for-each select="page:itemData">
                                            <span class="label" style="font-style: italic;">
                                                 <xsl:value-of select="@name"/>
                                            </span> &#160;<span class="value">
                                                  <xsl:value-of select="."/>
                                            </span>
                                            <br/>
                                        </xsl:for-each>
                                    </xsl:if>
                                &#160;</td>
                            </tr>

                        </xsl:for-each>

                </xsl:for-each>
            </table>
</xsl:template>
</xsl:stylesheet>



