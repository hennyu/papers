<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cligs="https://cligs.hypotheses.org/ns/cligs"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- 
        @author: Ulrike Henny-Krahmer
        
        This script produces a CSV file containing basic metadata about the novels in the corpus.
        
        How to call the script:
        java -jar /home/ulrike/Programme/saxon/saxon9he.jar /home/ulrike/Git/conha19/tei/nh0001.xml /home/ulrike/Git/papers/original_american_romtag21/metadata.xsl > /home/ulrike/Git/papers/original_american_romtag21/metadata.csv
    -->
    
    
    <xsl:variable name="corpus-dir" select="'/home/ulrike/Git/conha19/tei/'"/>
    <xsl:variable name="separator">,</xsl:variable>
    <xsl:variable name="novelas-americanas" select="('novela americana','novela mexicana','novela cubana','novela argentina','novela criolla','novela bonaerense','novela porteña','novela habanera','novela yucateca','novela suriana','novela tapatía','novela india','novela mixteca','novela de Tabasco','novela azteca','novela camagüeyana','novela kantabro-americana', 'novela franco-argentina')"/>
    <xsl:variable name="novelas-mexicanas" select="('novela mexicana','novela yucateca','novela suriana','novela tapatía','novela mixteca','novela de Tabasco','novela azteca')"/>
    <xsl:variable name="novelas-argentinas" select="('novela argentina','novela bonaerense','novela porteña','novela franco-argentina')"/>
    <xsl:variable name="novelas-cubanas" select="('novela cubana','novela habanera','novela camagüeyana')"/>
    
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <xsl:text>"idno"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"author-short"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"title-short"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"year"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"country"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"narrative-perspective"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"subgenre-theme"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"subgenre-current"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"subgenre-novela-original"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"subgenre-novela-americana"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"subgenre-novela-mexicana"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"subgenre-novela-argentina"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"subgenre-novela-cubana"</xsl:text><xsl:value-of select="$separator"/>
        <xsl:text>"tokens"</xsl:text><xsl:text>
</xsl:text>
        <xsl:for-each select="collection($corpus-dir)//TEI">
            <xsl:sort select=".//idno[@type='cligs']"/>
            <xsl:text>"</xsl:text><xsl:value-of select=".//idno[@type='cligs']"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
            <xsl:text>"</xsl:text><xsl:value-of select=".//author/name[@type='short']"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
            <xsl:text>"</xsl:text><xsl:value-of select=".//title[@type='short']"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
            <xsl:value-of select=".//bibl[@type='edition-first']//date/@when"/><xsl:value-of select="$separator"/>
            <xsl:text>"</xsl:text><xsl:value-of select=".//term[@type='author.country']"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
            <xsl:text>"</xsl:text><xsl:value-of select=".//term[@type='text.narration.narrator']"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
            <xsl:choose>
                <xsl:when test=".//term[contains(@type,'text.genre.subgenre.summary.theme')][@cligs:importance]">
                    <xsl:text>"</xsl:text><xsl:value-of select=".//term[contains(@type,'text.genre.subgenre.summary.theme')][@cligs:importance='2']/normalize-space(.)"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>"</xsl:text><xsl:value-of select=".//term[contains(@type,'text.genre.subgenre.summary.theme')]/normalize-space(.)"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//term[contains(@type,'text.genre.subgenre.summary.current')][@cligs:importance]">
                    <xsl:text>"</xsl:text><xsl:value-of select=".//term[contains(@type,'text.genre.subgenre.summary.current')][@cligs:importance='2']/normalize-space(.)"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:when>
                <xsl:when test=".//term[contains(@type,'text.genre.subgenre.summary.current')]">
                    <xsl:text>"</xsl:text><xsl:value-of select=".//term[contains(@type,'text.genre.subgenre.summary.current')]/normalize-space(.)"/><xsl:text>"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>"unknown"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//term[@type='text.genre.subgenre.summary.identity.explicit'][normalize-space(.)='novela original']">
                    <xsl:text>"novela original"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>"none"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//term[@type='text.genre.subgenre.summary.identity.explicit'][normalize-space(.)=$novelas-americanas]">
                    <xsl:text>"novela americana"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>"none"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//term[@type='text.genre.subgenre.summary.identity.explicit'][normalize-space(.)=$novelas-mexicanas]">
                    <xsl:text>"novela mexicana"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>"none"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//term[@type='text.genre.subgenre.summary.identity.explicit'][normalize-space(.)=$novelas-argentinas]">
                    <xsl:text>"novela argentina"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>"none"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//term[@type='text.genre.subgenre.summary.identity.explicit'][normalize-space(.)=$novelas-cubanas]">
                    <xsl:text>"novela cubana"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>"none"</xsl:text><xsl:value-of select="$separator"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select=".//measure[@unit='words']"/>
            <xsl:if test="position() != last()">
                <xsl:text>
</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>