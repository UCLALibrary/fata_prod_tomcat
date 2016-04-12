<?xml version="1.0" encoding="UTF-8"?>
<!-- $Revision: 1.5.2.1 $ $Date: 2012/06/11 22:12:06 $ -->
<!-- 
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2012 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: stdImports
**          Version : 7.2.0
**          Created : 06-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet
    version="1.0"
    exclude-result-prefixes="xsl fo"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <!-- ## Imported by most every stylesheet ## -->
    <xsl:include href="constants.xsl"/>
    <xsl:include href="constantStrings.xsl"/>

    <xsl:include href="../pageTools/tools.xsl"/>
    <xsl:include href="../pageTools/formInput.xsl"/>
    <xsl:include href="../pageTools/frameWork.xsl"/>

    <!-- ## Set the output Method ## -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

</xsl:stylesheet>


