<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://wwww.w3.org/2001/XMLSchema"
    xmlns:str="http://exslt.org/strings"
    version="1.0">
    <xsl:param name="rootPrefix" select="'src/main/java/'" />
    <xsl:param name="errorIcon" select="'`ERROR`'" />
    <xsl:param name="warningIcon" select="'`WARNING`'" />
    <xsl:param name="infoIcon" select="'`INFO`'" />
    <xsl:output method="text" />
    <xsl:template match="checkstyle">
        <xsl:text># Checkstyle Report Summary&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>| Version | Files Analysed | Violations |&#10;</xsl:text>
        <xsl:text>|:-------:|:--------------:|:----------:|&#10;</xsl:text>
        <xsl:text>|</xsl:text><xsl:value-of select="@version" />
        <xsl:text>|</xsl:text><xsl:value-of select="count(file)"/>
        <xsl:text>|</xsl:text><xsl:value-of select="count(file[error])" />
        <xsl:text>|&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:if test="file[error]">
            <xsl:text>## Violations Summary&#10;</xsl:text>
            <xsl:apply-templates />
        </xsl:if>
    </xsl:template>
    <xsl:template match="file[error]">
        <xsl:text>&#10;</xsl:text>
        <xsl:variable name="filePath" select="@name" />
        <xsl:text>File: **</xsl:text><xsl:value-of select="substring-after($filePath, $rootPrefix)" /><xsl:text>**&#10;</xsl:text>
        <xsl:text>___&#10;</xsl:text>
        <xsl:text>| Line | Severity | Comment | Rule |&#10;</xsl:text>
        <xsl:text>|:-----|:--------:|:--------|:-----|&#10;</xsl:text>
        <xsl:for-each select="error">
            <xsl:text>|</xsl:text><xsl:value-of select="@line" />
            <xsl:text>|</xsl:text>
            <xsl:choose>
                <xsl:when test="@severity = 'error'"><xsl:value-of select="$errorIcon" /></xsl:when>
                <xsl:when test="@severity = 'warning'"><xsl:value-of select="$warningIcon" /></xsl:when>
                <xsl:when test="@severity = 'info'"><xsl:value-of select="$infoIcon" /></xsl:when>
            </xsl:choose>
            <xsl:text>|</xsl:text><xsl:value-of select="@message" />
            <xsl:text>|</xsl:text><xsl:value-of select="str:tokenize(@source, '.')[last()]" />
            <xsl:text>|&#10;</xsl:text>
        </xsl:for-each>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>