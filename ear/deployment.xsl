<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/" xmlns:pom="http://maven.apache.org/POM/4.0.0">
<xsl:param name="wasSakaiVersion"/>
<xsl:param name="entitybrokerVersion"/>
<xsl:param name="pollVersion"/>
<xsl:param name="emailtemplateservice-toolVersion"/>
<xsl:param name="sakai-axis2Version"/>
<appdeployment:Deployment xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:appdeployment="http://www.ibm.com/websphere/appserver/schemas/5.0/appdeployment.xmi" xmi:id="Deployment_{generate-id(.)}">
  <deployedObject xmi:type="appdeployment:ApplicationDeployment" xmi:id="ApplicationDeployment_{generate-id(.)}" startingWeight="10">
    <xsl:for-each select="pom:project/pom:dependencies/pom:dependency">
      <modules xmi:type="appdeployment:WebModuleDeployment" xmi:id="WebModuleDeployment_{generate-id(.)}" startingWeight="10000" uri="" classloaderMode="PARENT_LAST">

	<!-- need to replace "${sakai.version}" in the pom:version with the actual value passed into the parameters  -->
	<xsl:variable name="version1">
	  <xsl:call-template name="replace-string">
            <xsl:with-param name="text" select="pom:version"/>
            <xsl:with-param name="from" select="'${was.sakai.version}'"/>
            <xsl:with-param name="to" select="$wasSakaiVersion"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="version2">
	  <xsl:call-template name="replace-string">
            <xsl:with-param name="text" select="$version1"/>
            <xsl:with-param name="from" select="'${entitybroker.version}'"/>
            <xsl:with-param name="to" select="$entitybrokerVersion"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="version3">
	  <xsl:call-template name="replace-string">
            <xsl:with-param name="text" select="$version2"/>
            <xsl:with-param name="from" select="'${poll.version}'"/>
            <xsl:with-param name="to" select="$pollVersion"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="version4">
	  <xsl:call-template name="replace-string">
            <xsl:with-param name="text" select="$version3"/>
            <xsl:with-param name="from" select="'${emailtemplateservice-tool.version}'"/>
            <xsl:with-param name="to" select="$emailtemplateservice-toolVersion"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="version5">
	  <xsl:call-template name="replace-string">
            <xsl:with-param name="text" select="$version4"/>
            <xsl:with-param name="from" select="'${sakai-axis2.version}'"/>
            <xsl:with-param name="to" select="$sakai-axis2Version"/>
	  </xsl:call-template>
	</xsl:variable>
        <xsl:attribute name ="uri" ><xsl:value-of select ="pom:artifactId" />-<xsl:value-of select ="$version5"/>.war</xsl:attribute> 
      </modules>
    </xsl:for-each>
    <classloader xmi:id="Classloader_{generate-id(.)}" mode="PARENT_LAST"/>
  </deployedObject>
</appdeployment:Deployment>
</xsl:template>

<!-- a global replace string function -->
 <xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="from"/>
    <xsl:param name="to"/>
    <xsl:choose>
      <xsl:when test="contains($text, $from)">
	<xsl:variable name="before" select="substring-before($text, $from)"/>
	<xsl:variable name="after" select="substring-after($text, $from)"/>
	<xsl:variable name="prefix" select="concat($before, $to)"/>
	<xsl:value-of select="$before"/>
	<xsl:value-of select="$to"/>
        <xsl:call-template name="replace-string">
	  <xsl:with-param name="text" select="$after"/>
	  <xsl:with-param name="from" select="$from"/>
	  <xsl:with-param name="to" select="$to"/>
	</xsl:call-template>
      </xsl:when> 
      <xsl:otherwise>
        <xsl:value-of select="$text"/>  
      </xsl:otherwise>
    </xsl:choose>            
 </xsl:template>

</xsl:stylesheet>
