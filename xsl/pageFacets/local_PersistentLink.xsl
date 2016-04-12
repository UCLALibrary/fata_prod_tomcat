<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page" xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:template name="persistentLink">

<xsl:param name="bibID"/>
<xsl:variable name="baseURL">/vwebv/holdingsInfo?bibId=</xsl:variable>
<!--div class="persistentLink">
<a id="persistentLink" href="{$baseURL}{$bibID}" target="_new">Permalink</a>
</div-->
<!--span class="recordLinkBullet"></span-->
<a id="persistentLink" href="{$baseURL}{$bibID}" target="_new"><span>Permalink to this record</span></a>
</xsl:template>
</xsl:stylesheet>
