<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cligs="https://cligs.hypotheses.org/ns/cligs"
    version="2.0">
    
    <!-- 
    @author: Ulrike Henny-Krahmer

    This script produces overviews of the contents in the bibliography Bib-ACMé and the corpus Conha19 (in numbers and plots).
    
    How to call the script:
        java -jar /home/ulrike/Programme/saxon/saxon9he.jar /home/ulrike/Git/conha19/tei/nh0001.xml /home/ulrike/Git/papers/original_american_romtag21/overview.xsl
    -->
    
    <xsl:variable name="output-dir">/home/ulrike/Git/papers/original_american_romtag21/metadata_output/</xsl:variable>
    <xsl:variable name="plotly-source">/home/ulrike/Git/scripts-nh/plotly/plotly-latest.min.js</xsl:variable>
    <xsl:variable name="bibacme-authors" select="doc('/home/ulrike/Git/bibacme/app/data/authors.xml')//person"/>
    <xsl:variable name="bibacme-works" select="doc('/home/ulrike/Git/bibacme/app/data/works.xml')//bibl"/>
    <xsl:variable name="bibacme-editions" select="doc('/home/ulrike/Git/bibacme/app/data/editions.xml')//biblStruct"/>
    <xsl:variable name="corpus" select="collection('/home/ulrike/Git/conha19/tei/')//TEI"/>
    <xsl:variable name="corpus-authors-ids" select="distinct-values($corpus//titleStmt/author/idno[@type='bibacme'])"/>
    <xsl:variable name="corpus-authors" select="$bibacme-authors[@xml:id=$corpus-authors-ids]"/>
    <xsl:variable name="corpus-works" select="$bibacme-works[idno[@type='cligs']]"/>
    <xsl:variable name="corpus-editions" select="$bibacme-editions[substring-after(@corresp,'#') = $corpus-works/@xml:id]"/>
    <xsl:variable name="nationalities" select="doc('/home/ulrike/Git/bibacme/app/data/nationalities.xml')//term[@type='general']"/>
    <xsl:variable name="countries" select="doc('/home/ulrike/Git/bibacme/app/data/countries.xml')//place"/>
    <xsl:variable name="birth-places" select="distinct-values($bibacme-authors/birth/placeName[last()])"/>
    <xsl:variable name="death-places" select="distinct-values($bibacme-authors/death/placeName[last()])"/>
    <xsl:variable name="decades" select="(1830,1840,1850,1860,1870,1880,1890,1900,1910)"/>
    <xsl:variable name="num-works-bib" select="count($bibacme-works)"/>
    <xsl:variable name="num-works-corp" select="count($corpus)"/>
    
    <xsl:template match="/">
        
        <!-- Choose the overviews to be generated here by taking out comments of 
        template calls. Additional overviews that could be (but have not been) created (yet)
        are given in comments enclosed by ## ... ##. -->
        
        <!--<xsl:call-template name="numbers"/>-->
        
        <!-- ##### SUBGENRES ##### -->
        <!--<xsl:call-template name="plot-subgenres-novela-by-decade"/>-->
        <!--<xsl:call-template name="plot-subgenres-explicit-signals"/>-->
        <!--<xsl:call-template name="plot-subgenres-explicit-signals-corpus"/>-->
        <xsl:call-template name="plot-subgenres-identity-by-decade"/>
        <!--<xsl:call-template name="plot-subgenres-signals"/>-->
        <!--<xsl:call-template name="plot-subgenres-signals-corpus"/>-->
        <!--<xsl:call-template name="plot-subgenres-litHist"/>-->
        <!--<xsl:call-template name="plot-subgenres-litHist-corpus"/>-->
        
        <!--<xsl:call-template name="plot-subgenres-labels-number-bib"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-number-corpus"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-amount-bib"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-amount-corpus"/>-->
        
        <!--<xsl:call-template name="plot-subgenres-labels-number-explicit-bib"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-number-explicit-corp"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-number-litHist-bib"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-number-litHist-corp"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-amount-explicit-bib"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-amount-explicit-corp"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-amount-litHist-bib"/>-->
        <!--<xsl:call-template name="plot-subgenres-labels-amount-litHist-corp"/>-->
        
        <!--<xsl:call-template name="plot-subgenres-identity"/>-->
        <!--<xsl:call-template name="plot-subgenres-identity-bib-sources"/>-->
        <!--<xsl:call-template name="plot-subgenres-identity-bibliography"/>-->
        <!--<xsl:call-template name="plot-subgenres-identity-corpus"/>-->
        <!--<xsl:call-template name="label-combinations-identity"/>-->
        
        <!--<xsl:call-template name="plot-subgenres-num-works-label"/>-->
        <!--<xsl:call-template name="list-subgenres-num-works-label"/>-->
        
        <!-- ### SUBGENRES FOR ANALYSIS ### -->
        
        <!--<xsl:call-template name="plot-novelas-originales"/>-->
        <!--<xsl:call-template name="plot-novelas-americanas"/>-->
        <!--<xsl:call-template name="plot-novelas-nacionales"/>-->
        <!--<xsl:call-template name="plot-novelas-originales-by-country"/>-->
        <!--<xsl:call-template name="plot-novelas-americanas-by-country"/>-->
        <!--<xsl:call-template name="plot-novelas-nacionales-by-country"/>-->
        <!--<xsl:call-template name="plot-novelas-originales-by-decade-bib"/>
        <xsl:call-template name="plot-novelas-originales-by-decade-corp"/>
        <xsl:call-template name="plot-novelas-originales-1880-bib"/>
        <xsl:call-template name="plot-novelas-originales-1880-corp"/>
        <xsl:call-template name="plot-novelas-americanas-by-decade-bib"/>
        <xsl:call-template name="plot-novelas-americanas-by-decade-corp"/>
        <xsl:call-template name="plot-novelas-americanas-1880-bib"/>
        <xsl:call-template name="plot-novelas-americanas-1880-corp"/>
        <xsl:call-template name="plot-novelas-nacionales-by-decade-bib"/>
        <xsl:call-template name="plot-novelas-nacionales-by-decade-corp"/>
        <xsl:call-template name="plot-novelas-nacionales-1880-bib"/>
        <xsl:call-template name="plot-novelas-nacionales-1880-corp"/>-->
        <!--<xsl:call-template name="plot-novelas-originales-prestige"/>-->
        <!--<xsl:call-template name="plot-novelas-americanas-prestige"/>-->
        <!--<xsl:call-template name="plot-novelas-nacionales-prestige"/>-->
        <!--<xsl:call-template name="plot-novelas-originales-narrative-perspective"/>-->
        <!--<xsl:call-template name="plot-novelas-americanas-narrative-perspective"/>-->
        <!--<xsl:call-template name="plot-novelas-nacionales-narrative-perspective"/>-->
        <!--<xsl:call-template name="plot-novelas-originales-setting-continent"/>-->
        <!--<xsl:call-template name="plot-novelas-americanas-setting-continent"/>-->
        <!--<xsl:call-template name="plot-novelas-nacionales-setting-continent"/>-->
        <!--<xsl:call-template name="plot-novelas-originales-setting-time-period"/>-->
        <!--<xsl:call-template name="plot-novelas-americanas-setting-time-period"/>-->
        <!--<xsl:call-template name="plot-novelas-nacionales-setting-time-period"/>-->
        <!--<xsl:call-template name="plot-novelas-originales-length"/>-->
        <!--<xsl:call-template name="plot-novelas-americanas-length"/>-->
        <!--<xsl:call-template name="plot-novelas-nacionales-length"/>-->
        
        <!--<xsl:call-template name="plot-novelas-originales-subgenre-theme"/>
        <xsl:call-template name="plot-novelas-originales-subgenre-current"/>
        
        <xsl:call-template name="plot-novelas-americanas-subgenre-theme"/>
        <xsl:call-template name="plot-novelas-americanas-subgenre-current"/>-->
        
        <!--<xsl:call-template name="plot-novelas-mexicanas-subgenre-theme"/>
        <xsl:call-template name="plot-novelas-mexicanas-subgenre-current"/>-->
        
        <!--<xsl:call-template name="plot-novelas-argentinas-subgenre-theme"/>
        <xsl:call-template name="plot-novelas-argentinas-subgenre-current"/>-->
        
        <!--<xsl:call-template name="plot-novelas-cubanas-subgenre-theme"/>
        <xsl:call-template name="plot-novelas-cubanas-subgenre-current"/>-->
    </xsl:template>
    
    <!-- ########### TEMPLATES ############ -->
    
    <xsl:template name="numbers">
        <!-- overall counts of authors, works, editions, etc. -->
        <xsl:result-document href="{concat($output-dir,'numbers.txt')}" method="text" encoding="UTF-8">
            
            <!-- number of different works -->
            <xsl:text>Number of different works in Bib-ACMé: </xsl:text>
            <xsl:value-of select="$num-works-bib"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different works in Conha19: </xsl:text>
            <xsl:value-of select="$num-works-corp"/>
            <xsl:text> (</xsl:text><xsl:value-of select="$num-works-corp div ($num-works-bib div 100)"/><xsl:text> %)</xsl:text>
            
            <!-- number of different authors -->
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different authors in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-authors-bib" select="count($bibacme-authors)"/>
            <xsl:value-of select="$num-authors-bib"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different authors in Conha19: </xsl:text>
            <xsl:variable name="num-authors-corp" select="count(distinct-values($corpus//titleStmt/author/idno[@type='bibacme']))"/>
            <xsl:value-of select="$num-authors-corp"/>
            <xsl:text> (</xsl:text><xsl:value-of select="$num-authors-corp div ($num-authors-bib div 100)"/><xsl:text> %)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Mean number of works per author in Bib-ACMé: </xsl:text>
            <xsl:variable name="mean-num-works-per-author-bib" select="count($bibacme-works) div $num-authors-bib"/>
            <xsl:value-of select="$mean-num-works-per-author-bib"/>
            <xsl:text>
</xsl:text>
            <xsl:text>Mean number of works per author in Conha19: </xsl:text>
            <xsl:variable name="mean-num-works-per-author-corp" select="count($corpus) div $num-authors-corp"/>
            <xsl:value-of select="$mean-num-works-per-author-corp"/>
            
            <!-- author gender, Bib-ACMé -->
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works written by male authors in Bib-ACMé: </xsl:text>
            <xsl:variable name="male-author-ids" select="$bibacme-authors[sex='masculino']/@xml:id"/>
            <xsl:variable name="num-works-male-authors-bib" select="count($bibacme-works[author/@key=$male-author-ids])"/>
            <xsl:value-of select="$num-works-male-authors-bib"/>
            <xsl:text> (</xsl:text><xsl:value-of select="$num-works-male-authors-bib div (count($bibacme-works) div 100)"/><xsl:text> %)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works written by female authors in Bib-ACMé: </xsl:text>
            <xsl:variable name="female-author-ids" select="$bibacme-authors[sex='femenino']/@xml:id"/>
            <xsl:variable name="num-works-female-authors-bib" select="count($bibacme-works[author/@key=$female-author-ids])"/>
            <xsl:value-of select="$num-works-female-authors-bib"/>
            <xsl:text> (</xsl:text><xsl:value-of select="$num-works-female-authors-bib div (count($bibacme-works) div 100)"/><xsl:text> %)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works written by authors of unknown gender in Bib-ACMé: </xsl:text>
            <xsl:variable name="unknown-gender-author-ids" select="$bibacme-authors[sex='desconocido']/@xml:id"/>
            <xsl:variable name="num-works-unknown-gender-authors-bib" select="count($bibacme-works[author/@key=$unknown-gender-author-ids])"/>
            <xsl:value-of select="$num-works-unknown-gender-authors-bib"/>
            <xsl:text> (</xsl:text><xsl:value-of select="$num-works-unknown-gender-authors-bib div (count($bibacme-works) div 100)"/><xsl:text> %)</xsl:text>
            
            <!-- author gender, Conha19 -->
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works written by male authors in Conha19: </xsl:text>
            <xsl:variable name="male-author-ids" select="$bibacme-authors[sex='masculino']/@xml:id"/>
            <xsl:variable name="num-works-male-authors-corp" select="count($corpus[.//titleStmt/author/idno[@type='bibacme'] = $male-author-ids])"/>
            <xsl:value-of select="$num-works-male-authors-corp"/>
            <xsl:text> (</xsl:text><xsl:value-of select="$num-works-male-authors-corp div (count($corpus) div 100)"/><xsl:text> %)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works written by female authors in Conha19: </xsl:text>
            <xsl:variable name="female-author-ids" select="$bibacme-authors[sex='femenino']/@xml:id"/>
            <xsl:variable name="num-works-female-authors-corp" select="count($corpus[.//titleStmt/author/idno[@type='bibacme'] = $female-author-ids])"/>
            <xsl:value-of select="$num-works-female-authors-corp"/>
            <xsl:text> (</xsl:text><xsl:value-of select="$num-works-female-authors-corp div (count($corpus) div 100)"/><xsl:text> %)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works written by authors of unknown gender in Conha19: </xsl:text>
            <xsl:variable name="unknown-gender-author-ids" select="$bibacme-authors[sex='desconocido']/@xml:id"/>
            <xsl:variable name="num-works-unknown-gender-authors-corp" select="count($corpus[.//titleStmt/author/idno[@type='bibacme'] = $unknown-gender-author-ids])"/>
            <xsl:value-of select="$num-works-unknown-gender-authors-corp"/>
            <xsl:text> (</xsl:text><xsl:value-of select="$num-works-unknown-gender-authors-corp div (count($corpus) div 100)"/><xsl:text> %)</xsl:text>
            
            <!-- author, births and deaths -->
            <xsl:variable name="author-birth-unknown-bib" select="count($bibacme-authors[birth/date='desconocido'])"/>
            <xsl:variable name="author-death-unknown-bib" select="count($bibacme-authors[death/date='desconocido'])"/>
            <xsl:variable name="author-birth-unknown-corp" select="count($bibacme-authors[@xml:id = $corpus-authors-ids][birth/date='desconocido'])"/>
            <xsl:variable name="author-death-unknown-corp" select="count($bibacme-authors[@xml:id = $corpus-authors-ids][death/date='desconocido'])"/>
            <xsl:text>
</xsl:text>
            <xsl:text>Number of authors with unknown birth date (Bib-ACMé): </xsl:text>
            <xsl:value-of select="$author-birth-unknown-bib"/>
            <xsl:text>
</xsl:text>
            <xsl:text>Number of authors with unknown birth date (Conha19): </xsl:text>
            <xsl:value-of select="$author-birth-unknown-corp"/>
            <xsl:text>
</xsl:text>
            <xsl:text>Number of authors with unknown death date (Bib-ACMé): </xsl:text>
            <xsl:value-of select="$author-death-unknown-bib"/>
            <xsl:text>
</xsl:text>
            <xsl:text>Number of authors with unknown death date (Conha19): </xsl:text>
            <xsl:value-of select="$author-death-unknown-corp"/>
            
            <!-- corpus: narrative perspective -->
            <xsl:text>
</xsl:text>
            <xsl:text>Novels in Conha19 with first person narrator: </xsl:text>
            <xsl:variable name="num-first-person" select="count($corpus[.//term[@type='text.narration.narrator.person'] = 'first person'])"/>
            <xsl:value-of select="$num-first-person"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-first-person div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            <xsl:text>
</xsl:text>
            <xsl:text>Novels in Conha19 with third person narrator: </xsl:text>
            <xsl:variable name="num-third-person" select="count($corpus[.//term[@type='text.narration.narrator.person'] = 'third person'])"/>
            <xsl:value-of select="$num-third-person"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-third-person div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <!-- corpus: narrative prestige -->
            <xsl:text>
</xsl:text>
            <xsl:text>Novels in Conha19 that are high prestige: </xsl:text>
            <xsl:variable name="num-high-prestige" select="count($corpus[.//term[@type='text.prestige'] = 'high'])"/>
            <xsl:value-of select="$num-high-prestige"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-high-prestige div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Novels in Conha19 that are low prestige: </xsl:text>
            <xsl:variable name="num-low-prestige" select="count($corpus[.//term[@type='text.prestige'] = 'low'])"/>
            <xsl:value-of select="$num-low-prestige"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-low-prestige div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <!-- editions -->
            <xsl:text>
</xsl:text>
            <xsl:text>Number of editions in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-editions-bib" select="count($bibacme-editions)"/>
            <xsl:value-of select="$num-editions-bib"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of editions in Conha19: </xsl:text>
            <xsl:variable name="num-editions-corp" select="count($corpus-editions)"/>
            <xsl:value-of select="$num-editions-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-editions-corp div ($num-editions-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <!-- subgenres -->
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with explicit subgenre signal in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-explicit-bib" select="count($bibacme-works[term[@type='subgenre.summary.signal.explicit']])"/>
            <xsl:value-of select="$num-explicit-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-explicit-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with explicit subgenre signal Conha19: </xsl:text>
            <xsl:variable name="num-explicit-corp" select="count($corpus-works[term[@type='subgenre.summary.signal.explicit']])"/>
            <xsl:value-of select="$num-explicit-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-explicit-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels carrying the explicit label "novela" in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-novela-bib" select="count($bibacme-works[term[@type='subgenre.summary.signal.explicit'] = 'novela'])"/>
            <xsl:value-of select="$num-novela-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-novela-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels carrying the explicit label "novela" in Conha19: </xsl:text>
            <xsl:variable name="num-novela-corp" select="count($corpus-works[term[@type='subgenre.summary.signal.explicit'] = 'novela'])"/>
            <xsl:value-of select="$num-novela-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-novela-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with "identity labels" in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-identity-bib" select="count($bibacme-works[term[@type='subgenre.summary.identity.explicit']])"/>
            <xsl:value-of select="$num-identity-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-identity-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with "identity labels" in Conha19: </xsl:text>
            <xsl:variable name="num-identity-corp" select="count($corpus-works[term[@type='subgenre.summary.identity.explicit']])"/>
            <xsl:value-of select="$num-identity-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-identity-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with implicit signals in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-implicit-bib" select="count($bibacme-works[term[@type='subgenre.summary.signal.implicit']])"/>
            <xsl:value-of select="$num-implicit-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-implicit-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with implicit signals in Conha19: </xsl:text>
            <xsl:variable name="num-implicit-corp" select="count($corpus-works[term[@type='subgenre.summary.signal.implicit']])"/>
            <xsl:value-of select="$num-implicit-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-implicit-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with signals in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-signals-bib" select="count($bibacme-works[term[starts-with(@type,'subgenre.summary.signal')]])"/>
            <xsl:value-of select="$num-signals-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-signals-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with signals in Conha19: </xsl:text>
            <xsl:variable name="num-signals-corp" select="count($corpus-works[term[starts-with(@type,'subgenre.summary.signal')]])"/>
            <xsl:value-of select="$num-signals-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-signals-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with literary historical subgenre assignments in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-litHist-bib" select="count($bibacme-works[term[starts-with(@type,'subgenre.litHist')]])"/>
            <xsl:value-of select="$num-litHist-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-litHist-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of novels with literary historical subgenre assignments in Conha19: </xsl:text>
            <xsl:variable name="num-litHist-corp" select="count($corpus-works[term[starts-with(@type,'subgenre.litHist')]])"/>
            <xsl:value-of select="$num-litHist-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-litHist-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall number of different subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-labels-bib" select="distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-labels-bib)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall number of different subgenre labels in Conha19: </xsl:text>
            <xsl:variable name="set-labels-corp" select="distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-labels-corp)"/>
            
            <xsl:text>
</xsl:text>
            
            <xsl:text>Overall amount of subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="labels-bib" select="cligs:get-labels($bibacme-works)"/>
            <xsl:value-of select="count($labels-bib)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall amount of subgenre labels in Conha19: </xsl:text>
            <xsl:variable name="labels-corp" select="cligs:get-labels($corpus-works)"/>
            <xsl:value-of select="count($labels-corp)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall number of different explicit subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-labels-explicit-bib" select="distinct-values($bibacme-works//term[contains(@type,'summary') and contains(@type,'explicit')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-labels-explicit-bib)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall number of different explicit subgenre labels in Conha19: </xsl:text>
            <xsl:variable name="set-labels-explicit-corp" select="distinct-values($corpus-works//term[contains(@type,'summary') and contains(@type,'explicit')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-labels-explicit-corp)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall amount of explicit subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="labels-explicit-bib" select="$bibacme-works//term[contains(@type,'summary') and contains(@type,'explicit') and not(contains(@type,'signal'))]/normalize-space(.)"/>
            <xsl:value-of select="count($labels-explicit-bib)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall amount of explicit subgenre labels in Conha19: </xsl:text>
            <xsl:variable name="labels-explicit-corp" select="$corpus-works//term[contains(@type,'summary') and contains(@type,'explicit') and not(contains(@type,'signal'))]/normalize-space(.)"/>
            <xsl:value-of select="count($labels-explicit-corp)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall number of different literary historical subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-labels-litHist-bib" select="distinct-values($bibacme-works//term[contains(@type,'summary') and contains(@type,'litHist')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-labels-litHist-bib)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall number of different literary historical subgenre labels in Conha19: </xsl:text>
            <xsl:variable name="set-labels-litHist-corp" select="distinct-values($corpus-works//term[contains(@type,'summary') and contains(@type,'litHist')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-labels-litHist-corp)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall amount of literary historical subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="labels-litHist-bib" select="$bibacme-works//term[contains(@type,'summary') and contains(@type,'litHist')]/normalize-space(.)"/>
            <xsl:value-of select="count($labels-litHist-bib)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Overall amount of literary historical subgenre labels in Conha19: </xsl:text>
            <xsl:variable name="labels-litHist-corp" select="$corpus-works//term[contains(@type,'summary') and contains(@type,'litHist')]/normalize-space(.)"/>
            <xsl:value-of select="count($labels-litHist-corp)"/>
            
            <xsl:text>
</xsl:text>
            
            <xsl:text>Number of different thematic subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-thematic-labels" select="distinct-values($bibacme-works//term[contains(@type,'theme')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-thematic-labels)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of thematic subgenre labels in Bib-ACMé that are assigned to at least 10 works: </xsl:text>
            <xsl:variable name="thematic-more-than-10" select="cligs:get-labels-least($bibacme-works,$set-thematic-labels,'theme',10)"/>
            <xsl:value-of select="count($thematic-more-than-10)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different subgenre labels related to literary currents in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-labels-current" select="distinct-values($bibacme-works//term[contains(@type,'current')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-labels-current)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different subgenre labels related to the mode of representation in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-representation-labels" select="distinct-values($bibacme-works//term[contains(@type,'mode.representation')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-representation-labels)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of subgenre labels related to the mode of representation in Bib-ACMé that are assigned to at least 5 works: </xsl:text>
            <xsl:variable name="representation-more-than-5" select="cligs:get-labels-least($bibacme-works,$set-representation-labels,'mode.representation',5)"/>
            <xsl:value-of select="count($representation-more-than-5)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different subgenre labels related to the mode of reality in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-reality-labels" select="distinct-values($bibacme-works//term[contains(@type,'mode.reality')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-reality-labels)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different subgenre labels related to the identity in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-identity-labels" select="distinct-values($bibacme-works//term[contains(@type,'identity')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-identity-labels)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different subgenre labels related to the medium in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-medium-labels" select="distinct-values($bibacme-works//term[contains(@type,'mode.medium')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-medium-labels)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different subgenre labels related to the attitude in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-attitude-labels" select="distinct-values($bibacme-works//term[contains(@type,'mode.attitude')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-attitude-labels)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of different subgenre labels related to the intention in Bib-ACMé: </xsl:text>
            <xsl:variable name="set-intention-labels" select="distinct-values($bibacme-works//term[contains(@type,'mode.intention')]/normalize-space(.))"/>
            <xsl:value-of select="count($set-intention-labels)"/>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with thematic subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-works-thematic-labels-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.theme')]])"/>
            <xsl:value-of select="$num-works-thematic-labels-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-thematic-labels-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with thematic subgenre labels in Conha19: </xsl:text>
            <xsl:variable name="num-works-thematic-labels-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.theme')]])"/>
            <xsl:value-of select="$num-works-thematic-labels-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-thematic-labels-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to literary currents in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-works-current-labels-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.current')]])"/>
            <xsl:value-of select="$num-works-current-labels-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-current-labels-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to literary currents in Conha19: </xsl:text>
            <xsl:variable name="num-works-current-labels-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.current')]])"/>
            <xsl:value-of select="$num-works-current-labels-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-current-labels-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the mode of representation in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-works-representation-labels-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.mode.representation')]])"/>
            <xsl:value-of select="$num-works-representation-labels-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-representation-labels-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the mode of representation in Conha19: </xsl:text>
            <xsl:variable name="num-works-representation-labels-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.mode.representation')]])"/>
            <xsl:value-of select="$num-works-representation-labels-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-representation-labels-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the mode of reality in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-works-reality-labels-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.mode.reality')]])"/>
            <xsl:value-of select="$num-works-reality-labels-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-reality-labels-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the mode of reality in Conha19: </xsl:text>
            <xsl:variable name="num-works-reality-labels-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.mode.reality')]])"/>
            <xsl:value-of select="$num-works-reality-labels-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-reality-labels-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with identity subgenre labels in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-works-identity-labels-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity')]])"/>
            <xsl:value-of select="$num-works-identity-labels-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-identity-labels-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with identity subgenre labels in Conha19: </xsl:text>
            <xsl:variable name="num-works-identity-labels-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.identity')]])"/>
            <xsl:value-of select="$num-works-identity-labels-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-identity-labels-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the medium in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-works-medium-labels-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.mode.medium')]])"/>
            <xsl:value-of select="$num-works-medium-labels-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-medium-labels-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the medium in Conha19: </xsl:text>
            <xsl:variable name="num-works-medium-labels-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.mode.medium')]])"/>
            <xsl:value-of select="$num-works-medium-labels-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-medium-labels-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the attitude in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-works-attitude-labels-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.mode.attitude')]])"/>
            <xsl:value-of select="$num-works-attitude-labels-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-attitude-labels-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the attitude in Conha19: </xsl:text>
            <xsl:variable name="num-works-attitude-labels-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.mode.attitude')]])"/>
            <xsl:value-of select="$num-works-attitude-labels-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-attitude-labels-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the intention in Bib-ACMé: </xsl:text>
            <xsl:variable name="num-works-intention-labels-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.mode.intention')]])"/>
            <xsl:value-of select="$num-works-intention-labels-bib"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-intention-labels-bib div ($num-works-bib div 100)"/>
            <xsl:text>%)</xsl:text>
            
            <xsl:text>
</xsl:text>
            <xsl:text>Number of works with subgenre labels related to the intention in Conha19: </xsl:text>
            <xsl:variable name="num-works-intention-labels-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.mode.intention')]])"/>
            <xsl:value-of select="$num-works-intention-labels-corp"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$num-works-intention-labels-corp div ($num-works-corp div 100)"/>
            <xsl:text>%)</xsl:text>
        </xsl:result-document>
    </xsl:template>
    
        
    <xsl:template name="plot-subgenres-novela-by-decade">
        <!-- creates a series of donut charts showing the number of "novelas" per decade, for Bib-ACMé -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-per-decade.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 500px;"></div>
                    <script>
                        var labels = ["novela", "no label"];
                        var data = [
                        <xsl:for-each select="$decades">
                            {
                            <xsl:variable name="works-decade" select="cligs:get-works-by-decade(current(), $bibacme-works)"/>
                            <xsl:variable name="works-novela" select="$works-decade[term[@type='subgenre.summary.signal.explicit']='novela']"/>
                            values: [<xsl:value-of select="count($works-novela)"/>, <xsl:value-of select="count($works-decade) - count($works-novela)"/>],
                            labels: labels,
                            type: "pie",
                            sort: false,
                            name: "<xsl:value-of select="."/>",
                            domain: {row: <xsl:choose>
                                <xsl:when test="position() &lt;= 5">0</xsl:when>
                                <xsl:otherwise>1</xsl:otherwise>
                            </xsl:choose>, column: <xsl:choose>
                                <xsl:when test="position() &lt;= 5">
                                    <xsl:value-of select="position() - 1"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="position() - 6"/>
                                </xsl:otherwise>
                            </xsl:choose>},
                            hole: 0.4
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ];
                        
                        var layout = {
                        grid: {rows: 2, columns: 5},
                        legend: {orientation: "h"},
                        annotations: [
                        <xsl:for-each select="$decades">
                            {
                            font: {
                            size: 14
                            },
                            showarrow: false,
                            text: '<xsl:value-of select="."/>',
                            x: <xsl:choose>
                                <xsl:when test="position() = (1,6)">0.066</xsl:when>
                                <xsl:when test="position() = (2,7)">0.265</xsl:when>
                                <xsl:when test="position() = (3,8)">0.5</xsl:when>
                                <xsl:when test="position() = (4,9)">0.73</xsl:when>
                                <xsl:otherwise>0.935</xsl:otherwise>
                            </xsl:choose>,
                            y: <xsl:choose>
                                <xsl:when test="position() &lt;= 5">0.8</xsl:when>
                                <xsl:otherwise>0.2</xsl:otherwise>
                            </xsl:choose>
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                        };
                        
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-explicit-signals">
        <!-- creates a bar plot showing the most frequent explicit subgenre signals in Bib-ACMé and Conha19 -->
        
        <xsl:variable name="subgenre-signals-bib">
            <subgenres xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each-group select="$bibacme-works//term[@type='subgenre.summary.signal.explicit']" group-by="normalize-space(.)">
                    <xsl:sort select="count(current-group())" order="descending"/>
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:if test="position() &lt;= 20">
                        <label xmlns="https://cligs.hypotheses.org/ns/cligs" n="{count(current-group())}"><xsl:value-of select="current-grouping-key()"/></label>
                    </xsl:if>
                </xsl:for-each-group>
            </subgenres>
        </xsl:variable>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-explicit-signals.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        x: ["<xsl:value-of select="string-join($subgenre-signals-bib//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:value-of select="string-join($subgenre-signals-bib//@n, ',')"/>],
                        name: 'Bib-ACMé',
                        type: 'bar'
                        };
                        
                        var trace2 = {
                        x: ["<xsl:value-of select="string-join($subgenre-signals-bib//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$subgenre-signals-bib//cligs:label">
                            <xsl:value-of select="count($corpus-works[.//term[@type='subgenre.summary.signal.explicit']/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'Conha19',
                        type: 'bar'
                        };
                        
                        var data = [trace1, trace2];
                        
                        var layout = {
                        barmode: 'group',
                        yaxis: {title: 'number of assignments'},
                        xaxis: {title: 'subgenre labels', tickmode: 'linear', dtick: 1, tickangle: 270, automargin: true},
                        legend: {x: 1, y: 1, xanchor: 'right'}
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-explicit-signals-corpus">
        <!-- creates a bar plot showing the most frequent explicit subgenre signals in Bib-ACMé and Conha19,
        ordered by top positions in the corpus -->
        
        <xsl:variable name="subgenre-signals-corp">
            <subgenres xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each-group select="$corpus-works//term[@type='subgenre.summary.signal.explicit']" group-by="normalize-space(.)">
                    <xsl:sort select="count(current-group())" order="descending"/>
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:if test="position() &lt;= 20">
                        <label xmlns="https://cligs.hypotheses.org/ns/cligs" n="{count(current-group())}"><xsl:value-of select="current-grouping-key()"/></label>
                    </xsl:if>
                </xsl:for-each-group>
            </subgenres>
        </xsl:variable>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-explicit-signals-corpus.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        x: ["<xsl:value-of select="string-join($subgenre-signals-corp//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:value-of select="string-join($subgenre-signals-corp//@n, ',')"/>],
                        name: 'Conha19',
                        type: 'bar'
                        };
                        
                        var trace2 = {
                        x: ["<xsl:value-of select="string-join($subgenre-signals-corp//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$subgenre-signals-corp//cligs:label">
                            <xsl:value-of select="count($bibacme-works[.//term[@type='subgenre.summary.signal.explicit']/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'Bib-ACMé',
                        type: 'bar'
                        };
                        
                        var data = [trace1, trace2];
                        
                        var layout = {
                        barmode: 'group',
                        yaxis: {title: 'number of assignments'},
                        xaxis: {title: 'subgenre labels', tickmode: 'linear', dtick: 1, tickangle: 270, automargin: true},
                        legend: {x: 1, y: 1, xanchor: 'right'}
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-identity-by-decade">
        <!-- creates a series of donut charts showing the number of novels with identity labels per decade, for Bib-ACMé -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-identity-per-decade.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 500px;"></div>
                    <script>
                        var labels = ["identity label", "no identity label"];
                        var data = [
                        <xsl:for-each select="$decades">
                            {
                            <xsl:variable name="works-decade" select="cligs:get-works-by-decade(current(), $bibacme-works)"/>
                            <xsl:variable name="works-identity" select="$works-decade[term[@type='subgenre.summary.identity.explicit']]"/>
                            values: [<xsl:value-of select="count($works-identity)"/>, <xsl:value-of select="count($works-decade) - count($works-identity)"/>],
                            labels: labels,
                            type: "pie",
                            sort: false,
                            name: "<xsl:value-of select="."/>",
                            domain: {row: <xsl:choose>
                                <xsl:when test="position() &lt;= 5">0</xsl:when>
                                <xsl:otherwise>1</xsl:otherwise>
                            </xsl:choose>, column: <xsl:choose>
                                <xsl:when test="position() &lt;= 5">
                                    <xsl:value-of select="position() - 1"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="position() - 6"/>
                                </xsl:otherwise>
                            </xsl:choose>},
                            hole: 0.4
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ];
                        
                        var layout = {
                        grid: {rows: 2, columns: 5},
                        legend: {orientation: "h", font: {size: 16}},
                        annotations: [
                        <xsl:for-each select="$decades">
                            {
                            font: {
                            size: 14
                            },
                            showarrow: false,
                            text: '<xsl:value-of select="."/>',
                            x: <xsl:choose>
                                <xsl:when test="position() = (1,6)">0.066</xsl:when>
                                <xsl:when test="position() = (2,7)">0.265</xsl:when>
                                <xsl:when test="position() = (3,8)">0.5</xsl:when>
                                <xsl:when test="position() = (4,9)">0.73</xsl:when>
                                <xsl:otherwise>0.935</xsl:otherwise>
                            </xsl:choose>,
                            y: <xsl:choose>
                                <xsl:when test="position() &lt;= 5">0.8</xsl:when>
                                <xsl:otherwise>0.2</xsl:otherwise>
                            </xsl:choose>
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                        };
                        
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-signals">
        <!-- creates a bar plot showing the most frequent subgenre signals (explicit and implicit) in Bib-ACMé and Conha19 -->
        
        <xsl:variable name="subgenre-signals-bib">
            <subgenres xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each-group select="$bibacme-works//term[starts-with(@type,'subgenre.summary.signal')]" group-by="normalize-space(.)">
                    <xsl:sort select="count(current-group())" order="descending"/>
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:if test="position() &lt;= 20">
                        <label xmlns="https://cligs.hypotheses.org/ns/cligs" n="{count(current-group())}"><xsl:value-of select="current-grouping-key()"/></label>
                    </xsl:if>
                </xsl:for-each-group>
            </subgenres>
        </xsl:variable>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-signals.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        x: ["<xsl:value-of select="string-join($subgenre-signals-bib//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:value-of select="string-join($subgenre-signals-bib//@n, ',')"/>],
                        name: 'Bib-ACMé',
                        type: 'bar'
                        };
                        
                        var trace2 = {
                        x: ["<xsl:value-of select="string-join($subgenre-signals-bib//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$subgenre-signals-bib//cligs:label">
                            <xsl:value-of select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.signal')]/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'Conha19',
                        type: 'bar'
                        };
                        
                        var data = [trace1, trace2];
                        
                        var layout = {
                        barmode: 'group',
                        yaxis: {title: 'number of assignments'},
                        xaxis: {title: 'subgenre labels', tickmode: 'linear', dtick: 1, tickangle: 270, automargin: true},
                        legend: {x: 1, y: 1, xanchor: 'right'}
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-signals-corpus">
        <!-- creates a bar plot showing the most frequent subgenre signals (explicit and implicit) in Bib-ACMé and Conha19,
        ordered by top positions in the corpus -->
        
        <xsl:variable name="subgenre-signals-corp">
            <subgenres xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each-group select="$corpus-works//term[starts-with(@type,'subgenre.summary.signal')]" group-by="normalize-space(.)">
                    <xsl:sort select="count(current-group())" order="descending"/>
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:if test="position() &lt;= 20">
                        <label xmlns="https://cligs.hypotheses.org/ns/cligs" n="{count(current-group())}"><xsl:value-of select="current-grouping-key()"/></label>
                    </xsl:if>
                </xsl:for-each-group>
            </subgenres>
        </xsl:variable>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-signals-corpus.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        x: ["<xsl:value-of select="string-join($subgenre-signals-corp//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:value-of select="string-join($subgenre-signals-corp//@n, ',')"/>],
                        name: 'Conha19',
                        type: 'bar'
                        };
                        
                        var trace2 = {
                        x: ["<xsl:value-of select="string-join($subgenre-signals-corp//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$subgenre-signals-corp//cligs:label">
                            <xsl:value-of select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.signal')]/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'Bib-ACMé',
                        type: 'bar'
                        };
                        
                        var data = [trace1, trace2];
                        
                        var layout = {
                        barmode: 'group',
                        yaxis: {title: 'number of assignments'},
                        xaxis: {title: 'subgenre labels', tickmode: 'linear', dtick: 1, tickangle: 270, automargin: true},
                        legend: {x: 1, y: 1, xanchor: 'right'}
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-litHist">
        <!-- creates a bar plot showing the most frequent literary historical subgenre labels in Bib-ACMé and Conha19 -->
        
        <xsl:variable name="subgenre-labels-bib">
            <subgenres xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each-group select="$bibacme-works//term[@type='subgenre.litHist.interp']" group-by="normalize-space(.)">
                    <xsl:sort select="count(current-group())" order="descending"/>
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:if test="position() &lt;= 20">
                        <label xmlns="https://cligs.hypotheses.org/ns/cligs" n="{count(current-group())}"><xsl:value-of select="current-grouping-key()"/></label>
                    </xsl:if>
                </xsl:for-each-group>
            </subgenres>
        </xsl:variable>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-litHist.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        x: ["<xsl:value-of select="string-join($subgenre-labels-bib//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:value-of select="string-join($subgenre-labels-bib//@n, ',')"/>],
                        name: 'Bib-ACMé',
                        type: 'bar'
                        };
                        
                        var trace2 = {
                        x: ["<xsl:value-of select="string-join($subgenre-labels-bib//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$subgenre-labels-bib//cligs:label">
                            <xsl:value-of select="count($corpus-works[.//term[@type='subgenre.litHist.interp']/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'Conha19',
                        type: 'bar'
                        };
                        
                        var data = [trace1, trace2];
                        
                        var layout = {
                        barmode: 'group',
                        yaxis: {title: 'number of assignments'},
                        xaxis: {title: 'subgenre labels', tickmode: 'linear', dtick: 1, tickangle: 270, automargin: true},
                        legend: {x: 1, y: 1, xanchor: 'right'}
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-litHist-corpus">
        <!-- creates a bar plot showing the most frequent literary historical subgenre labels in Bib-ACMé and Conha19,
        ordered by top positions in the corpus -->
        
        <xsl:variable name="subgenre-labels-corp">
            <subgenres xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each-group select="$corpus-works//term[@type='subgenre.litHist.interp']" group-by="normalize-space(.)">
                    <xsl:sort select="count(current-group())" order="descending"/>
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:if test="position() &lt;= 20">
                        <label xmlns="https://cligs.hypotheses.org/ns/cligs" n="{count(current-group())}"><xsl:value-of select="current-grouping-key()"/></label>
                    </xsl:if>
                </xsl:for-each-group>
            </subgenres>
        </xsl:variable>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-litHist-corpus.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        x: ["<xsl:value-of select="string-join($subgenre-labels-corp//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:value-of select="string-join($subgenre-labels-corp//@n, ',')"/>],
                        name: 'Conha19',
                        type: 'bar'
                        };
                        
                        var trace2 = {
                        x: ["<xsl:value-of select="string-join($subgenre-labels-corp//cligs:label,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$subgenre-labels-corp//cligs:label">
                            <xsl:value-of select="count($bibacme-works[.//term[@type='subgenre.litHist.interp']/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'Bib-ACMé',
                        type: 'bar'
                        };
                        
                        var data = [trace1, trace2];
                        
                        var layout = {
                        barmode: 'group',
                        yaxis: {title: 'number of assignments'},
                        xaxis: {title: 'subgenre labels', tickmode: 'linear', dtick: 1, tickangle: 270, automargin: true},
                        legend: {x: 1, y: 1, xanchor: 'right'}
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-number-bib">
        <!-- creates a sankey diagram showing how many different subgenre labels there are in each 
        category of the discursive subgenre model, for Bib-ACMé -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-number-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                            type: "sankey",
                            orientation: "h",
                            arrangement: "snap",
                            node: {
                                pad: 15,
                                thickness: 30,
                                line: {
                                color: "black",
                                width: 0.5
                                },
                            label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                            color: [<xsl:for-each select="1 to 9">
                                <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                            </xsl:for-each><xsl:for-each select="1 to 8">
                                <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                                    <xsl:if test="position() != last()">,</xsl:if>
                            </xsl:for-each>]
                        },
                        
                        link: {
                            source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                            target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                            <xsl:variable name="comm_frame" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention') or starts-with(@type,'subgenre.summary.mode.attitude') or starts-with(@type,'subgenre.summary.mode.reality')]/normalize-space(.)))"/>
                            <xsl:variable name="realization" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium') or starts-with(@type,'subgenre.summary.mode.representation') or starts-with(@type,'subgenre.summary.theme')]/normalize-space(.)))"/>
                            <xsl:variable name="context" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.identity') or starts-with(@type,'subgenre.summary.current')]/normalize-space(.)))"/>
                            <xsl:variable name="medium" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium')]/normalize-space(.)))"/>
                            <xsl:variable name="syntactic" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.representation')]/normalize-space(.)))"/>
                            <xsl:variable name="semantic" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.theme')]/normalize-space(.)))"/>
                            <xsl:variable name="spatial" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)))"/>
                            <xsl:variable name="temporal" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.current')]/normalize-space(.)))"/>
                            <xsl:variable name="intention" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention')]/normalize-space(.)))"/>
                            <xsl:variable name="attitude" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.attitude')]/normalize-space(.)))"/>
                            <xsl:variable name="reality" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.reality')]/normalize-space(.)))"/>
                            value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                                    <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of different subgenre labels",
                        font: {
                            size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-number-corpus">
        <!-- creates a sankey diagram showing how many different subgenre labels there are in each 
        category of the discursive subgenre model, for Conha19 -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-number-corpus.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        arrangement: "snap",
                        orientation: "h",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention') or starts-with(@type,'subgenre.summary.mode.attitude') or starts-with(@type,'subgenre.summary.mode.reality')]/normalize-space(.)))"/>
                        <xsl:variable name="realization" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium') or starts-with(@type,'subgenre.summary.mode.representation') or starts-with(@type,'subgenre.summary.theme')]/normalize-space(.)))"/>
                        <xsl:variable name="context" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.identity') or starts-with(@type,'subgenre.summary.current')]/normalize-space(.)))"/>
                        <xsl:variable name="medium" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium')]/normalize-space(.)))"/>
                        <xsl:variable name="syntactic" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.representation')]/normalize-space(.)))"/>
                        <xsl:variable name="semantic" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.theme')]/normalize-space(.)))"/>
                        <xsl:variable name="spatial" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)))"/>
                        <xsl:variable name="temporal" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.current')]/normalize-space(.)))"/>
                        <xsl:variable name="intention" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention')]/normalize-space(.)))"/>
                        <xsl:variable name="attitude" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.attitude')]/normalize-space(.)))"/>
                        <xsl:variable name="reality" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.reality')]/normalize-space(.)))"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of different subgenre labels",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-amount-bib">
        <!-- creates a sankey diagram showing how many subgenre labels there are in each 
        category of the discursive subgenre model, for Bib-ACMé -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-amount-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count($bibacme-works//(term[starts-with(@type,'subgenre.summary.mode.intention')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.intention')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.mode.attitude')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.attitude')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.mode.reality')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.reality')]/normalize-space(.))]))"/>
                        <xsl:variable name="realization" select="count($bibacme-works//(term[starts-with(@type,'subgenre.summary.mode.medium')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.medium')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.mode.representation')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.representation')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.theme')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.theme')]/normalize-space(.))]))"/>
                        <xsl:variable name="context" select="count($bibacme-works//(term[starts-with(@type,'subgenre.summary.identity')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.current')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.current')]/normalize-space(.))]))"/>
                        <xsl:variable name="medium" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.medium')]/normalize-space(.))])"/>
                        <xsl:variable name="syntactic" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.representation')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.representation')]/normalize-space(.))])"/>
                        <xsl:variable name="semantic" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.theme')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.theme')]/normalize-space(.))])"/>
                        <xsl:variable name="spatial" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.identity')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.))])"/>
                        <xsl:variable name="temporal" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.current')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.current')]/normalize-space(.))])"/>
                        <xsl:variable name="intention" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.intention')]/normalize-space(.))])"/>
                        <xsl:variable name="attitude" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.attitude')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.attitude')]/normalize-space(.))])"/>
                        <xsl:variable name="reality" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.reality')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.reality')]/normalize-space(.))])"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of subgenre labels",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-amount-corpus">
        <!-- creates a sankey diagram showing how many subgenre labels there are in each 
        category of the discursive subgenre model, for Conha19 -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-amount-corpus.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count($corpus-works//(term[starts-with(@type,'subgenre.summary.mode.intention')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.intention')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.mode.attitude')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.attitude')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.mode.reality')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.reality')]/normalize-space(.))]))"/>
                        <xsl:variable name="realization" select="count($corpus-works//(term[starts-with(@type,'subgenre.summary.mode.medium')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.medium')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.mode.representation')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.representation')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.theme')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.theme')]/normalize-space(.))]))"/>
                        <xsl:variable name="context" select="count($corpus-works//(term[starts-with(@type,'subgenre.summary.identity')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.))]|term[starts-with(@type,'subgenre.summary.current')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.current')]/normalize-space(.))]))"/>
                        <xsl:variable name="medium" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.medium')]/normalize-space(.))])"/>
                        <xsl:variable name="syntactic" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.representation')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.representation')]/normalize-space(.))])"/>
                        <xsl:variable name="semantic" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.theme')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.theme')]/normalize-space(.))])"/>
                        <xsl:variable name="spatial" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.identity')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.))])"/>
                        <xsl:variable name="temporal" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.current')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.current')]/normalize-space(.))])"/>
                        <xsl:variable name="intention" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.intention')]/normalize-space(.))])"/>
                        <xsl:variable name="attitude" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.attitude')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.attitude')]/normalize-space(.))])"/>
                        <xsl:variable name="reality" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.reality')][not(normalize-space(.) = preceding-sibling::term[starts-with(@type,'subgenre.summary.mode.reality')]/normalize-space(.))])"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of subgenre labels",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-number-explicit-bib">
        <!-- creates a sankey diagram showing how many different explicit subgenre labels there are in each 
        category of the discursive subgenre model, for Bib-ACMé -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-number-explicit-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention.explicit') or starts-with(@type,'subgenre.summary.mode.attitude.explicit') or starts-with(@type,'subgenre.summary.mode.reality.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="realization" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium.explicit') or starts-with(@type,'subgenre.summary.mode.representation.explicit') or starts-with(@type,'subgenre.summary.theme.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="context" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.identity.explicit') or starts-with(@type,'subgenre.summary.current.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="medium" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="syntactic" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.representation.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="semantic" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.theme.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="spatial" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.identity.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="temporal" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.current.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="intention" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="attitude" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.attitude.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="reality" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.reality.explicit')]/normalize-space(.)))"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of different explicit subgenre labels",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-number-explicit-corp">
        <!-- creates a sankey diagram showing how many different explicit subgenre labels there are in each 
        category of the discursive subgenre model, for Conha19 -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-number-explicit-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention.explicit') or starts-with(@type,'subgenre.summary.mode.attitude.explicit') or starts-with(@type,'subgenre.summary.mode.reality.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="realization" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium.explicit') or starts-with(@type,'subgenre.summary.mode.representation.explicit') or starts-with(@type,'subgenre.summary.theme.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="context" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.identity.explicit') or starts-with(@type,'subgenre.summary.current.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="medium" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="syntactic" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.representation.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="semantic" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.theme.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="spatial" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.identity.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="temporal" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.current.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="intention" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="attitude" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.attitude.explicit')]/normalize-space(.)))"/>
                        <xsl:variable name="reality" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.reality.explicit')]/normalize-space(.)))"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of different explicit subgenre labels (Conha19)",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-number-litHist-bib">
        <!-- creates a sankey diagram showing how many different literary historical subgenre labels there are in each 
        category of the discursive subgenre model, for Bib-ACMé -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-number-litHist-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention.litHist') or starts-with(@type,'subgenre.summary.mode.attitude.litHist') or starts-with(@type,'subgenre.summary.mode.reality.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="realization" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium.litHist') or starts-with(@type,'subgenre.summary.mode.representation.litHist') or starts-with(@type,'subgenre.summary.theme.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="context" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.identity.litHist') or starts-with(@type,'subgenre.summary.current.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="medium" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="syntactic" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.representation.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="semantic" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.theme.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="spatial" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.identity.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="temporal" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.current.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="intention" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="attitude" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.attitude.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="reality" select="count(distinct-values($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.reality.litHist')]/normalize-space(.)))"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of different literary historical subgenre labels",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-number-litHist-corp">
        <!-- creates a sankey diagram showing how many different literary historical subgenre labels there are in each 
        category of the discursive subgenre model, for Conha19 -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-number-litHist-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention.litHist') or starts-with(@type,'subgenre.summary.mode.attitude.litHist') or starts-with(@type,'subgenre.summary.mode.reality.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="realization" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium.litHist') or starts-with(@type,'subgenre.summary.mode.representation.litHist') or starts-with(@type,'subgenre.summary.theme.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="context" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.identity.litHist') or starts-with(@type,'subgenre.summary.current.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="medium" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="syntactic" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.representation.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="semantic" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.theme.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="spatial" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.identity.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="temporal" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.current.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="intention" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="attitude" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.attitude.litHist')]/normalize-space(.)))"/>
                        <xsl:variable name="reality" select="count(distinct-values($corpus-works//term[starts-with(@type,'subgenre.summary.mode.reality.litHist')]/normalize-space(.)))"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of different literary historical subgenre labels (Conha19)",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-amount-explicit-bib">
        <!-- creates a sankey diagram showing how many explicit subgenre labels there are in each 
        category of the discursive subgenre model, for Bib-ACMé -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-amount-explicit-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention.explicit') or starts-with(@type,'subgenre.summary.mode.attitude.explicit') or starts-with(@type,'subgenre.summary.mode.reality.explicit')])"/>
                        <xsl:variable name="realization" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium.explicit') or starts-with(@type,'subgenre.summary.mode.representation.explicit') or starts-with(@type,'subgenre.summary.theme.explicit')])"/>
                        <xsl:variable name="context" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.identity.explicit') or starts-with(@type,'subgenre.summary.current.explicit')])"/>
                        <xsl:variable name="medium" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium.explicit')])"/>
                        <xsl:variable name="syntactic" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.representation.explicit')])"/>
                        <xsl:variable name="semantic" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.theme.explicit')])"/>
                        <xsl:variable name="spatial" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.identity.explicit')])"/>
                        <xsl:variable name="temporal" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.current.explicit')])"/>
                        <xsl:variable name="intention" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention.explicit')])"/>
                        <xsl:variable name="attitude" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.attitude.explicit')])"/>
                        <xsl:variable name="reality" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.reality.explicit')])"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of explicit subgenre labels",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-amount-explicit-corp">
        <!-- creates a sankey diagram showing how many explicit subgenre labels there are in each 
        category of the discursive subgenre model, for Conha19 -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-amount-explicit-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention.explicit') or starts-with(@type,'subgenre.summary.mode.attitude.explicit') or starts-with(@type,'subgenre.summary.mode.reality.explicit')])"/>
                        <xsl:variable name="realization" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium.explicit') or starts-with(@type,'subgenre.summary.mode.representation.explicit') or starts-with(@type,'subgenre.summary.theme.explicit')])"/>
                        <xsl:variable name="context" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.identity.explicit') or starts-with(@type,'subgenre.summary.current.explicit')])"/>
                        <xsl:variable name="medium" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium.explicit')])"/>
                        <xsl:variable name="syntactic" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.representation.explicit')])"/>
                        <xsl:variable name="semantic" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.theme.explicit')])"/>
                        <xsl:variable name="spatial" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.identity.explicit')])"/>
                        <xsl:variable name="temporal" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.current.explicit')])"/>
                        <xsl:variable name="intention" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention.explicit')])"/>
                        <xsl:variable name="attitude" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.attitude.explicit')])"/>
                        <xsl:variable name="reality" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.reality.explicit')])"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of explicit subgenre labels (Conha19)",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-amount-litHist-bib">
        <!-- creates a sankey diagram showing how many explicit subgenre labels there are in each 
        category of the discursive subgenre model, for Bib-ACMé -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-amount-litHist-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention.litHist') or starts-with(@type,'subgenre.summary.mode.attitude.litHist') or starts-with(@type,'subgenre.summary.mode.reality.litHist')])"/>
                        <xsl:variable name="realization" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium.litHist') or starts-with(@type,'subgenre.summary.mode.representation.litHist') or starts-with(@type,'subgenre.summary.theme.litHist')])"/>
                        <xsl:variable name="context" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.identity.litHist') or starts-with(@type,'subgenre.summary.current.litHist')])"/>
                        <xsl:variable name="medium" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.medium.litHist')])"/>
                        <xsl:variable name="syntactic" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.representation.litHist')])"/>
                        <xsl:variable name="semantic" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.theme.litHist')])"/>
                        <xsl:variable name="spatial" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.identity.litHist')])"/>
                        <xsl:variable name="temporal" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.current.litHist')])"/>
                        <xsl:variable name="intention" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.intention.litHist')])"/>
                        <xsl:variable name="attitude" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.attitude.litHist')])"/>
                        <xsl:variable name="reality" select="count($bibacme-works//term[starts-with(@type,'subgenre.summary.mode.reality.litHist')])"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of literary historical subgenre labels",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-labels-amount-litHist-corp">
        <!-- creates a sankey diagram showing how many explicit subgenre labels there are in each 
        category of the discursive subgenre model, for Conha19 -->
        
        <xsl:result-document href="{concat($output-dir,'subgenres-labels-amount-litHist-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 900px;"></div>
                    <script>
                        var data = {
                        type: "sankey",
                        orientation: "h",
                        arrangement: "snap",
                        node: {
                        pad: 15,
                        thickness: 30,
                        line: {
                        color: "black",
                        width: 0.5
                        },
                        label: ["discursive act", "communicational frame", "realization", "context", "medium", "syntactic", "semantic", "spatial", "temporal", "mode.intention", "mode.attitude", "mode.reality", "mode.medium", "mode.representation", "theme", "identity", "current"],
                        color: [<xsl:for-each select="1 to 9">
                            <xsl:text>"rgb(31, 119, 180)",</xsl:text>
                        </xsl:for-each><xsl:for-each select="1 to 8">
                            <xsl:text>"rgb(255, 127, 14)"</xsl:text>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        },
                        
                        link: {
                        source: [0,0,0,2,2,2,3,3,1,1,1,4,5,6,7,8],
                        target: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
                        <xsl:variable name="comm_frame" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention.litHist') or starts-with(@type,'subgenre.summary.mode.attitude.litHist') or starts-with(@type,'subgenre.summary.mode.reality.litHist')])"/>
                        <xsl:variable name="realization" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium.litHist') or starts-with(@type,'subgenre.summary.mode.representation.litHist') or starts-with(@type,'subgenre.summary.theme.litHist')])"/>
                        <xsl:variable name="context" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.identity.litHist') or starts-with(@type,'subgenre.summary.current.litHist')])"/>
                        <xsl:variable name="medium" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.medium.litHist')])"/>
                        <xsl:variable name="syntactic" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.representation.litHist')])"/>
                        <xsl:variable name="semantic" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.theme.litHist')])"/>
                        <xsl:variable name="spatial" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.identity.litHist')])"/>
                        <xsl:variable name="temporal" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.current.litHist')])"/>
                        <xsl:variable name="intention" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.intention.litHist')])"/>
                        <xsl:variable name="attitude" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.attitude.litHist')])"/>
                        <xsl:variable name="reality" select="count($corpus-works//term[starts-with(@type,'subgenre.summary.mode.reality.litHist')])"/>
                        value: [<xsl:value-of select="$comm_frame"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$realization"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$context"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$intention"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$attitude"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$reality"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$medium"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$syntactic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$semantic"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$spatial"/><xsl:text>,</xsl:text>
                        <xsl:value-of select="$temporal"/><xsl:text>,</xsl:text>]
                        }
                        }
                        
                        var data = [data]
                        
                        var layout = {
                        title: "Number of literary historical subgenre labels (Conha19)",
                        font: {
                        size: 14
                        }
                        }
                        
                        Plotly.react('myDiv', data, layout)
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
      
    <xsl:template name="plot-subgenres-identity">
        <!-- creates an overview of subgenres related to the identity in the bibliography compared to Conha19,
        a grouped bar chart, how many works have them? -->
        
        <xsl:variable name="identity-labels-set" select="cligs:get-sorted-labels-set($bibacme-works, 'identity')"/>
        
        <xsl:variable name="labels-x" select="concat('&quot;',string-join($identity-labels-set,'&quot;,&quot;'),'&quot;')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-identity.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1200px; height: 800px;"></div>
                    <script>
                        var trace1 = {
                        x: [<xsl:value-of select="$labels-x"/>],
                        y: [<xsl:for-each select="$identity-labels-set">
                            <xsl:value-of select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'Bib-ACMé',
                        type: 'bar'
                        };
                        
                        var trace2 = {
                        x: [<xsl:value-of select="$labels-x"/>],
                        y: [<xsl:for-each select="$identity-labels-set">
                            <xsl:value-of select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'Conha19',
                        type: 'bar'
                        };
                        
                        var data = [trace1, trace2];
                        
                        var layout = {
                        barmode: 'group',
                        font: {size: 14},
                        legend: {
                        x: 1,
                        xanchor: 'right',
                        y: 1,
                        font: {size: 16}
                        },
                        title: 'Subgenre labels related to the identity in Bib-ACMé and Conha19',
                        xaxis: {title: 'subgenres', automargin: true},
                        yaxis: {title: 'number of works'},
                        annotations: [
                        <xsl:for-each select="$identity-labels-set">{
                            <xsl:variable name="num-bib" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.) = current()])"/>
                            <xsl:variable name="num-corp" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.) = current()])"/>
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-corp"/>,
                            text: "<xsl:value-of select="round($num-corp div ($num-bib div 100))"/>%",
                            showarrow: false,
                            xanchor: "left",
                            yanchor: "bottom",
                            font: {size: 12}
                            }<xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-identity-bib-sources">
        <!-- creates an overview of the subgenres related to the identity in the bibliography,
        a stacked bar chart (including different source types: explicit, implicit, litHist), how many works have them? -->
        
        <xsl:variable name="identity-labels-set" select="cligs:get-sorted-labels-set($bibacme-works, 'identity')"/>
        
        <xsl:variable name="labels-x" select="concat('&quot;',string-join($identity-labels-set,'&quot;,&quot;'),'&quot;')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-identity-bib-sources.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1200px; height: 800px;"></div>
                    <script>
                        
                        var trace1 = {
                        x: [<xsl:value-of select="$labels-x"/>],
                        y: [<xsl:for-each select="$identity-labels-set">
                            <xsl:value-of select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity.explicit')]/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'explicit signals',
                        type: 'bar'
                        };
                        
                        var trace2 = {
                        x: [<xsl:value-of select="$labels-x"/>],
                        y: [<xsl:for-each select="$identity-labels-set">
                            <xsl:value-of select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity.implicit')]/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'implicit signals',
                        type: 'bar'
                        };
                        
                        var trace3 = {
                        x: [<xsl:value-of select="$labels-x"/>],
                        y: [<xsl:for-each select="$identity-labels-set">
                            <xsl:value-of select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity.litHist')]/normalize-space(.) = current()])"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        name: 'literary historical',
                        type: 'bar'
                        };
                        
                        var data = [trace1, trace2, trace3];
                        
                        var layout = {
                        barmode: 'stack',
                        font: {size: 14},
                        legend: {
                        x: 1,
                        xanchor: 'right',
                        y: 1,
                        font: {size: 16}
                        },
                        title: 'Sources of subgenre labels related to the identity in Bib-ACMé',
                        xaxis: {title: 'subgenres', automargin: true},
                        yaxis: {title: 'number of works'}
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-subgenres-identity-corpus">
        <!-- creates three donut charts showing the proportions of groups of identity labels 
        in the corpus: 
        - "novela original" vs. other
        - American context vs. other
        - Argentina, Mexico, Cuba vs. other
        -->
        <xsl:result-document href="{concat($output-dir,'subgenres-identity-corpus.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 420px;"></div>
                    <script>
                        var data = [{
                        <xsl:variable name="novelas-originales" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)='novela original'])"/>
                            values: [<xsl:value-of select="$novelas-originales"/>, <xsl:value-of select="$num-works-corp - $novelas-originales"/>],
                            labels: ["novela original", "other"],
                            type: "pie",
                            hole: 0.5,
                            name: "Original novels",
                            domain: {row: 0, column: 0},
                            direction: "clockwise",
                            legendgroup: "group1"
                            },{
                        <xsl:variable name="labels-American-context" select="('novela mexicana','novela cubana','novela argentina','novela americana','novela criolla','novela bonaerense','novela porteña','novela habanera','novela yucateca','novela suriana','novela tapatía','novela india','novela mixteca','novela de Tabasco','novela azteca','novela camagüeyana','novela kantabro-americana', 'novela franco-argentina')"/>
                        <xsl:variable name="American-context" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)=$labels-American-context])"/>
                            values: [<xsl:value-of select="$American-context"/>, <xsl:value-of select="$num-works-corp - $American-context"/>],
                            labels: ["novela americana", "other"],
                            type: "pie",
                            hole: 0.5,
                            name: "American novels",
                            domain: {row: 0, column: 1},
                            direction: "clockwise",
                            legendgroup: "group2"
                            },{
                        <xsl:variable name="labels-mexicana" select="('novela mexicana','novela yucateca','novela suriana','novela tapatía','novela mixteca','novela de Tabasco','novela azteca')"/>
                        <xsl:variable name="labels-cubana" select="('novela cubana','novela habanera','novela camagüeyana')"/>
                        <xsl:variable name="labels-argentina" select="('novela argentina','novela bonaerense','novela porteña','novela franco-argentina')"/>
                        <xsl:variable name="mexicana" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)=$labels-mexicana])"/>
                        <xsl:variable name="cubana" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)=$labels-cubana])"/>
                        <xsl:variable name="argentina" select="count($corpus-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)=$labels-argentina])"/>
                            values: [<xsl:value-of select="$mexicana"/>, <xsl:value-of select="$cubana"/>, <xsl:value-of select="$argentina"/>, <xsl:value-of select="$num-works-corp - $mexicana - $cubana - $argentina"/>],
                            labels: ["novela mexicana","novela cubana","novela argentina", "other"],
                            type: "pie",
                            hole: 0.5,
                            name: "National novels",
                            domain: {row: 0, column: 2},
                            direction: "clockwise",
                            legendgroup: "group3"
                            },
                        ];
                        
                        var layout = {
                        grid: {rows: 1, columns: 3},
                        legend: {font: {size: 16}},
                        annotations: [{
                            text: "original",
                            x: 0.09,
                            y: 0.5,
                            font: {size: 18},
                            showarrow: false
                            },{
                            text: "American",
                            x: 0.5,
                            y: 0.5,
                            font: {size: 18},
                            showarrow: false
                            },{
                            text: "national",
                            x: 0.91,
                            y: 0.5,
                            font: {size: 18},
                            showarrow: false
                            }
                        ]
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-subgenres-identity-bibliography">
        <!-- creates three donut charts showing the proportions of groups of identity labels 
        in the bibliography: 
        - "novela original" vs. other
        - American context vs. other
        - Argentina, Mexico, Cuba vs. other
        -->
        <xsl:result-document href="{concat($output-dir,'subgenres-identity-bibliography.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 420px;"></div>
                    <script>
                        var data = [{
                        <xsl:variable name="novelas-originales" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)='novela original'])"/>
                        values: [<xsl:value-of select="$novelas-originales"/>, <xsl:value-of select="$num-works-bib - $novelas-originales"/>],
                        labels: ["novela original", "other"],
                        type: "pie",
                        hole: 0.5,
                        name: "Original novels",
                        domain: {row: 0, column: 0},
                        direction: "clockwise",
                        legendgroup: "group1"
                        },{
                        <xsl:variable name="labels-American-context" select="('novela mexicana','novela cubana','novela argentina','novela americana','novela criolla','novela bonaerense','novela porteña','novela habanera','novela yucateca','novela suriana','novela tapatía','novela india','novela mixteca','novela de Tabasco','novela azteca','novela camagüeyana','novela kantabro-americana', 'novela franco-argentina')"/>
                        <xsl:variable name="American-context" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)=$labels-American-context])"/>
                        values: [<xsl:value-of select="$American-context"/>, <xsl:value-of select="$num-works-bib - $American-context"/>],
                        labels: ["novela americana", "other"],
                        type: "pie",
                        hole: 0.5,
                        name: "American novels",
                        domain: {row: 0, column: 1},
                        direction: "clockwise",
                        legendgroup: "group2"
                        },{
                        <xsl:variable name="labels-mexicana" select="('novela mexicana','novela yucateca','novela suriana','novela tapatía','novela mixteca','novela de Tabasco','novela azteca')"/>
                        <xsl:variable name="labels-cubana" select="('novela cubana','novela habanera','novela camagüeyana')"/>
                        <xsl:variable name="labels-argentina" select="('novela argentina','novela bonaerense','novela porteña','novela franco-argentina')"/>
                        <xsl:variable name="mexicana" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)=$labels-mexicana])"/>
                        <xsl:variable name="cubana" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)=$labels-cubana])"/>
                        <xsl:variable name="argentina" select="count($bibacme-works[.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.)=$labels-argentina])"/>
                        values: [<xsl:value-of select="$mexicana"/>, <xsl:value-of select="$cubana"/>, <xsl:value-of select="$argentina"/>, <xsl:value-of select="$num-works-bib - $mexicana - $cubana - $argentina"/>],
                        labels: ["novela mexicana","novela cubana","novela argentina", "other"],
                        type: "pie",
                        hole: 0.5,
                        name: "National novels",
                        domain: {row: 0, column: 2},
                        direction: "clockwise",
                        legendgroup: "group3"
                        },
                        ];
                        
                        var layout = {
                        grid: {rows: 1, columns: 3},
                        legend: {font: {size: 16}},
                        annotations: [{
                        text: "original",
                        x: 0.09,
                        y: 0.5,
                        font: {size: 18},
                        showarrow: false
                        },{
                        text: "American",
                        x: 0.5,
                        y: 0.5,
                        font: {size: 18},
                        showarrow: false
                        },{
                        text: "national",
                        x: 0.91,
                        y: 0.5,
                        font: {size: 18},
                        showarrow: false
                        }
                        ]
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    
    <xsl:template name="label-combinations-identity">
        <!-- creates a csv file listing combinations of subgenre labels related to the 
        identity, in the bibliography and the corpus, and how frequent they are  -->
        <xsl:variable name="works-with-combinations-bib" select="$bibacme-works[count(distinct-values(.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.))) >= 2]"/>
        <xsl:variable name="works-with-combinations-corp" select="$corpus-works[count(distinct-values(.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.))) >= 2]"/>
        
        <xsl:variable name="combinations-bib">
            <list xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each select="$works-with-combinations-bib">
                    <xsl:variable name="distinct-labels">
                        <xsl:for-each select="distinct-values(.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.))">
                            <xsl:sort select="."/>
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">-</xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <item xmlns="https://cligs.hypotheses.org/ns/cligs"><xsl:value-of select="$distinct-labels"/></item>
                </xsl:for-each>
            </list>
        </xsl:variable>
        <xsl:variable name="combinations-corp">
            <list xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each select="$works-with-combinations-corp">
                    <xsl:variable name="distinct-labels">
                        <xsl:for-each select="distinct-values(.//term[starts-with(@type,'subgenre.summary.identity')]/normalize-space(.))">
                            <xsl:sort select="."/>
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">-</xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <item xmlns="https://cligs.hypotheses.org/ns/cligs"><xsl:value-of select="$distinct-labels"/></item>
                </xsl:for-each>
            </list>
        </xsl:variable>
        
        <xsl:result-document href="{concat($output-dir, 'subgenres-label-combinations-identity.csv')}" method="text" encoding="UTF-8">
            <xsl:text>label_combination,amount_bib,amount_corp</xsl:text>
            <xsl:text>
</xsl:text>
            <xsl:for-each-group select="$combinations-bib" group-by=".//cligs:item">
                <xsl:sort select="current-grouping-key()"/>
                <xsl:text>"</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>",</xsl:text>
                <xsl:variable name="split-key" select="tokenize(current-grouping-key(),'-')"/>
                <xsl:value-of select="count($combinations-bib//cligs:item[every $i in $split-key satisfies contains(.,$i)])"/><xsl:text>,</xsl:text>
                <xsl:value-of select="count($combinations-corp//cligs:item[every $i in $split-key satisfies contains(.,$i)])"/>
                <xsl:if test="position() != last()">
                    <xsl:text>
</xsl:text>
                </xsl:if>
            </xsl:for-each-group>
        </xsl:result-document>
        
    </xsl:template>
    
     
    <xsl:template name="plot-subgenres-num-works-label">
        <!-- creates a histogram showing how many works the labels are associated with,
        for Bib-ACMé and Conha19 -->
        <xsl:variable name="num-works-per-label-bib" select="cligs:get-works-per-label($bibacme-works)"/>
        <xsl:variable name="num-works-per-label-corp" select="cligs:get-works-per-label($corpus-works)"/>
        <xsl:result-document href="{concat($output-dir,'subgenres-works-per-label.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 800px; height: 600px;"></div>
                    <script>
                        var x1 = [<xsl:value-of select="string-join($num-works-per-label-bib,',')"/>];
                        var trace1 = {
                        x: x1,
                        type: 'histogram',
                        xbins: {size: 10},
                        opacity: 0.5,
                        name: 'Bib-ACMé'
                        };
                        var x2 = [<xsl:value-of select="string-join($num-works-per-label-corp,',')"/>];
                        var trace2 = {
                        x: x2,
                        type: 'histogram',
                        xbins: {size: 10},
                        opacity: 0.5,
                        name: 'Conha19'
                        };
                        var data = [trace1, trace2];
                        var layout = {
                        xaxis: {title: "number of works"}, 
                        yaxis: {title: "number of labels"},
                        barmode: "overlay",
                        legend: {
                        x: 1,
                        xanchor: 'right',
                        y: 1,
                        font: {size: 16}
                        },
                        font: {size: 14},
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="list-subgenres-num-works-label">
        <!-- get the number of works for each subgenre label (for the bibliography and corpus) -->
        <xsl:for-each select="('bib','corp')">
            <xsl:variable name="works" select="if (.='corp') then $corpus-works else $bibacme-works"/>
            <xsl:variable name="label-set" select="distinct-values($works//term[starts-with(@type,'subgenre.summary')]/normalize-space(.))"/>
            
            <!-- write this also to an external file: -->
            <xsl:result-document href="{concat($output-dir,'subgenres-works-per-label-',.,'.csv')}" method="text" encoding="UTF-8">
                <xsl:text>label,num_works</xsl:text>
                <xsl:text>
</xsl:text>
                <xsl:for-each select="$label-set">
                    <xsl:sort select="count($works[.//term[starts-with(@type,'subgenre.summary')]/normalize-space(.) = current()])" order="descending"/>
                    <xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
                    <xsl:text>,</xsl:text>
                    <xsl:value-of select="count($works[.//term[starts-with(@type,'subgenre.summary')]/normalize-space(.) = current()])"/>
                    <xsl:if test="position() != last()">
                        <xsl:text>
</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
      
    <xsl:template name="plot-novelas-originales">
        <!-- creates two donut charts comparing the proportions of works in Bib-ACMé and Conha19
        carrying the label "novela original" -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:variable name="labels-bib" select="cligs:get-primary-labels($bibacme-works,'identity')"/>
        <xsl:variable name="labels-corp" select="cligs:get-primary-labels($corpus-works,'identity')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 800px; height: 400px;"></div>
                    <script>
                        var labels = ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"]
                        var values_bib = [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        var values_corp = [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        var data = [{
                        values: values_bib,
                        labels: labels,
                        type: "pie",
                        direction: "clockwise",
                        name: "Bib-ACMé",
                        domain: {row: 0, column: 0},
                        hole: 0.5
                        },{
                        values: values_corp,
                        labels: labels,
                        type: "pie",
                        direction: "clockwise",
                        name: "Conha19",
                        domain: {row: 0, column: 1},
                        hole: 0.5
                        }];
                        
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        legend: {font: {size: 16}},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Bib-ACMé',
                        x: 0.16,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Conha19',
                        x: 0.84,
                        y: 0.5
                        }
                        ]
                        };
                        
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas">
        <!-- creates two donut charts comparing the proportions of works in Bib-ACMé and Conha19
        carrying labels related to the American context -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:variable name="labels-bib" select="cligs:get-primary-labels($bibacme-works,'identity','novela americana')"/>
        <xsl:variable name="labels-corp" select="cligs:get-primary-labels($corpus-works,'identity','novela americana')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 800px; height: 400px;"></div>
                    <script>
                        var labels = ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"]
                        var values_bib = [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        var values_corp = [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        var data = [{
                        values: values_bib,
                        labels: labels,
                        type: "pie",
                        direction: "clockwise",
                        name: "Bib-ACMé",
                        domain: {row: 0, column: 0},
                        hole: 0.5
                        },{
                        values: values_corp,
                        labels: labels,
                        type: "pie",
                        direction: "clockwise",
                        name: "Conha19",
                        domain: {row: 0, column: 1},
                        hole: 0.5
                        }];
                        
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        legend: {font: {size: 16}},
                        colorway: ["rgb(227, 119, 194)","rgb(31, 119, 180)","rgb(148, 103, 189)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Bib-ACMé',
                        x: 0.16,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Conha19',
                        x: 0.84,
                        y: 0.5
                        }
                        ]
                        };
                        
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales">
        <!-- creates two donut charts comparing the proportions of works in Bib-ACMé and Conha19
        carrying labels carrying national identity labels -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:variable name="labels-bib" select="cligs:get-primary-labels($bibacme-works,'identity','novela nacional')"/>
        <xsl:variable name="labels-corp" select="cligs:get-primary-labels($corpus-works,'identity','novela nacional')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 800px; height: 400px;"></div>
                    <script>
                        var labels = ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"]
                        var values_bib = [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        var values_corp = [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>]
                        var data = [{
                        values: values_bib,
                        labels: labels,
                        type: "pie",
                        direction: "clockwise",
                        name: "Bib-ACMé",
                        domain: {row: 0, column: 0},
                        hole: 0.5
                        },{
                        values: values_corp,
                        labels: labels,
                        type: "pie",
                        direction: "clockwise",
                        name: "Conha19",
                        domain: {row: 0, column: 1},
                        hole: 0.5
                        }];
                        
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        legend: {font: {size: 16}},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(44, 160, 44)","rgb(214, 39, 40)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Bib-ACMé',
                        x: 0.16,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Conha19',
                        x: 0.84,
                        y: 0.5
                        }
                        ]
                        };
                        
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-by-country">
        <!-- creates three donut charts comparing the distribution of works that carry the label "novela original" by country,
        comparing the bibliography and the corpus -->
        
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-country.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-MX" select="cligs:get-primary-labels($bibacme-works[country='México'],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-MX[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-MX[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-MX,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Mexico (Bib)",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-AR" select="cligs:get-primary-labels($bibacme-works[country='Argentina'],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-AR[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-AR[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-AR,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Argentina (Bib)",
                        domain: {row: 0, column: 1}
                        };
                        var trace3 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-CU" select="cligs:get-primary-labels($bibacme-works[country='Cuba'],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-CU[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-CU[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-CU,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Cuba (Bib)",
                        domain: {row: 0, column: 2}
                        };
                        var trace4 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-MX" select="cligs:get-primary-labels($corpus-works[country='México'],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-MX[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-MX[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-MX,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Mexico (Corp)",
                        domain: {row: 1, column: 0}
                        };
                        var trace5 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-AR" select="cligs:get-primary-labels($corpus-works[country='Argentina'],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-AR[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-AR[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-AR,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Argentina (Corp)",
                        domain: {row: 1, column: 1}
                        };
                        var trace6 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-CU" select="cligs:get-primary-labels($corpus-works[country='Cuba'],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-CU[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-CU[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-CU,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Cuba (Corp)",
                        domain: {row: 1, column: 2}
                        };
                        var data = [trace1, trace2, trace3, trace4, trace5, trace6];
                        var layout = {
                        grid: {rows: 2, columns: 3},
                        font: {size: 12},
                        legend: {font: {size: 14}, orientation: "h"},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Mexico (Bib)',
                        x: 0.1,
                        y: 0.78
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Argentina (Bib)',
                        x: 0.5,
                        y: 0.78
                        },
                        ,
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Cuba (Bib)',
                        x: 0.89,
                        y: 0.78
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Mexico (Corp)',
                        x: 0.09,
                        y: 0.22
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Argentina (Corp)',
                        x: 0.5,
                        y: 0.22
                        },
                        ,
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Cuba (Corp)',
                        x: 0.9,
                        y: 0.22
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-by-country">
        <!-- creates three donut charts comparing the distribution of "novelas americanas" by country,
        comparing the bibliography and the corpus -->
        
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-country.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-MX" select="cligs:get-primary-labels($bibacme-works[country='México'],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-MX[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-MX[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-MX,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Mexico (Bib)",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-AR" select="cligs:get-primary-labels($bibacme-works[country='Argentina'],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-AR[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-AR[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-AR,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Argentina (Bib)",
                        domain: {row: 0, column: 1}
                        };
                        var trace3 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-CU" select="cligs:get-primary-labels($bibacme-works[country='Cuba'],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-CU[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-CU[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-CU,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Cuba (Bib)",
                        domain: {row: 0, column: 2}
                        };
                        var trace4 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-MX" select="cligs:get-primary-labels($corpus-works[country='México'],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-MX[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-MX[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-MX,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Mexico (Corp)",
                        domain: {row: 1, column: 0}
                        };
                        var trace5 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-AR" select="cligs:get-primary-labels($corpus-works[country='Argentina'],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-AR[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-AR[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-AR,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Argentina (Corp)",
                        domain: {row: 1, column: 1}
                        };
                        var trace6 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-CU" select="cligs:get-primary-labels($corpus-works[country='Cuba'],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-CU[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-CU[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-CU,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Cuba (Corp)",
                        domain: {row: 1, column: 2}
                        };
                        var data = [trace1, trace2, trace3, trace4, trace5, trace6];
                        var layout = {
                        grid: {rows: 2, columns: 3},
                        font: {size: 12},
                        legend: {font: {size: 14}, orientation: "h"},
                        colorway: ["rgb(227, 119, 194)","rgb(31, 119, 180)","rgb(148, 103, 189)"],
                        annotations: [
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Mexico (Bib)',
                        x: 0.1,
                        y: 0.78
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Argentina (Bib)',
                        x: 0.5,
                        y: 0.78
                        },
                        ,
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Cuba (Bib)',
                        x: 0.89,
                        y: 0.78
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Mexico (Corp)',
                        x: 0.09,
                        y: 0.22
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Argentina (Corp)',
                        x: 0.5,
                        y: 0.22
                        },
                        ,
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Cuba (Corp)',
                        x: 0.9,
                        y: 0.22
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-by-country">
        <!-- creates three donut charts comparing the distribution of works that carry the label "novela original" by country,
        comparing the bibliography and the corpus -->
        
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-by-country.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 900px; height: 700px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-MX" select="cligs:get-primary-labels($bibacme-works[country='México'],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-MX[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-MX[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-MX,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Mexico (Bib)",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-AR" select="cligs:get-primary-labels($bibacme-works[country='Argentina'],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-AR[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-AR[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-AR,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Argentina (Bib)",
                        domain: {row: 0, column: 1}
                        };
                        var trace3 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-bib-CU" select="cligs:get-primary-labels($bibacme-works[country='Cuba'],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-bib-CU[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-bib-CU[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-bib-CU,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Cuba (Bib)",
                        domain: {row: 0, column: 2}
                        };
                        var trace4 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-MX" select="cligs:get-primary-labels($corpus-works[country='México'],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-MX[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-MX[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-MX,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Mexico (Corp)",
                        domain: {row: 1, column: 0}
                        };
                        var trace5 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-AR" select="cligs:get-primary-labels($corpus-works[country='Argentina'],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-AR[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-AR[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-AR,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Argentina (Corp)",
                        domain: {row: 1, column: 1}
                        };
                        var trace6 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="labels-corp-CU" select="cligs:get-primary-labels($corpus-works[country='Cuba'],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-corp-CU[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:when test=". = 'none'">
                                    <xsl:value-of select="count($labels-corp-CU[.='none'])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-corp-CU,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Cuba (Corp)",
                        domain: {row: 1, column: 2}
                        };
                        var data = [trace1, trace2, trace3, trace4, trace5, trace6];
                        var layout = {
                        grid: {rows: 2, columns: 3},
                        font: {size: 12},
                        legend: {font: {size: 14}, orientation: "h"},
                        colorway: ["rgb(227, 119, 194)","rgb(44, 160, 44)","rgb(148, 103, 189)","rgb(31, 119, 180)","rgb(214, 39, 40)"],
                        annotations: [
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Mexico (Bib)',
                        x: 0.1,
                        y: 0.78
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Argentina (Bib)',
                        x: 0.5,
                        y: 0.78
                        },
                        ,
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Cuba (Bib)',
                        x: 0.89,
                        y: 0.78
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Mexico (Corp)',
                        x: 0.09,
                        y: 0.22
                        },
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Argentina (Corp)',
                        x: 0.5,
                        y: 0.22
                        },
                        ,
                        {
                        font: {
                        size: 12
                        },
                        showarrow: false,
                        text: 'Cuba (Corp)',
                        x: 0.9,
                        y: 0.22
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-by-decade-bib">
        <!-- creates a stacked bar chart showing the works carrying the label "novela original" by decade,
        in Bib-ACMé -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-decade-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: [<xsl:value-of select="string-join($decades,',')"/>],
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            y: [<xsl:value-of select="cligs:get-num-decades($decades, $work-publication-years)"/>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {tickmode: "linear", dtick: 10, title: "decades", tickfont: {size: 16}},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 14}},
                        font: {size: 16},
                        colorway: ["rgb(31, 119, 180)","rgb(148, 103, 189)","rgb(227, 119, 194)"]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-by-decade-corp">
        <!-- creates a stacked bar chart showing the works carrying the label "novela original" by decade,
        in Conha19 -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-decade-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: [<xsl:value-of select="string-join($decades,',')"/>],
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            y: [<xsl:value-of select="cligs:get-num-decades($decades, $work-publication-years)"/>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {tickmode: "linear", dtick: 10, title: "decades", tickfont: {size: 16}},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 14}},
                        font: {size: 16},
                        colorway: ["rgb(31, 119, 180)","rgb(148, 103, 189)","rgb(227, 119, 194)"]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-1880-bib">
        <!-- creates a grouped bar chart showing the works carrying the label "novela original" before and in/after 1880,
        in Bib-ACMé -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-1880-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 600px;"></div>
                    <script>
                        var trace1 = {
                        type: "bar",
                        name: "before 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var trace2 = {
                        type: "bar",
                        name: "in or after 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        barmode: "group",
                        xaxis: {tickmode: "linear", dtick: 1, title: "subgenres", tickfont: {size: 16}, automargin: true},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        <xsl:variable name="all-work-publication-years" select="cligs:get-first-edition-years($bibacme-works)"/>
                        <!-- get the number of all works published before 1880 -->
                        <xsl:variable name="num-all-works-before-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'before')"/>
                        <!-- get the number of all works published after 1880 -->
                        <xsl:variable name="num-all-works-after-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'after')"/>
                        annotations: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:variable name="num-works-before-1880" select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:variable name="num-works-after-1880" select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-before-1880"/>,
                            text: "<xsl:value-of select="round($num-works-before-1880 div ($num-all-works-before-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "right",
                            yanchor: "bottom",
                            font: {size: 14}
                            },
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-after-1880"/>,
                            text: "<xsl:value-of select="round($num-works-after-1880 div ($num-all-works-after-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "left",
                            yanchor: "bottom",
                            font: {size: 14}
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-1880-corp">
        <!-- creates a grouped bar chart showing the works carrying the label "novela original" before and in/after 1880,
        in Conha19 -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-1880-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 600px;"></div>
                    <script>
                        var trace1 = {
                        type: "bar",
                        name: "before 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var trace2 = {
                        type: "bar",
                        name: "in or after 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        barmode: "group",
                        xaxis: {tickmode: "linear", dtick: 1, title: "subgenres", tickfont: {size: 16}, automargin: true},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        <xsl:variable name="all-work-publication-years" select="cligs:get-first-edition-years($corpus-works)"/>
                        <!-- get the number of all works published before 1880 -->
                        <xsl:variable name="num-all-works-before-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'before')"/>
                        <!-- get the number of all works published after 1880 -->
                        <xsl:variable name="num-all-works-after-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'after')"/>
                        annotations: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:variable name="num-works-before-1880" select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:variable name="num-works-after-1880" select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-before-1880"/>,
                            text: "<xsl:value-of select="round($num-works-before-1880 div ($num-all-works-before-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "right",
                            yanchor: "bottom",
                            font: {size: 14}
                            },
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-after-1880"/>,
                            text: "<xsl:value-of select="round($num-works-after-1880 div ($num-all-works-after-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "left",
                            yanchor: "bottom",
                            font: {size: 14}
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-by-decade-bib">
        <!-- creates a stacked bar chart showing "novelas americanas" by decade,
        in Bib-ACMé -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-decade-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: [<xsl:value-of select="string-join($decades,',')"/>],
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity','novela americana',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            y: [<xsl:value-of select="cligs:get-num-decades($decades, $work-publication-years)"/>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {tickmode: "linear", dtick: 10, title: "decades", tickfont: {size: 16}},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 14}},
                        font: {size: 16},
                        colorway: ["rgb(31, 119, 180)","rgb(148, 103, 189)","rgb(227, 119, 194)"]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-by-decade-corp">
        <!-- creates a stacked bar chart showing the "novelas americanas" by decade,
        in Conha19 -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-decade-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: [<xsl:value-of select="string-join($decades,',')"/>],
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela americana',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            y: [<xsl:value-of select="cligs:get-num-decades($decades, $work-publication-years)"/>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {tickmode: "linear", dtick: 10, title: "decades", tickfont: {size: 16}},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 14}},
                        font: {size: 16},
                        colorway: ["rgb(31, 119, 180)","rgb(148, 103, 189)","rgb(227, 119, 194)"]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-1880-bib">
        <!-- creates a grouped bar chart showing the "novelas americanas" before and in/after 1880,
        in Bib-ACMé -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-1880-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 600px;"></div>
                    <script>
                        var trace1 = {
                        type: "bar",
                        name: "before 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity','novela americana',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var trace2 = {
                        type: "bar",
                        name: "in or after 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity','novela americana',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        barmode: "group",
                        xaxis: {tickmode: "linear", dtick: 1, title: "subgenres", tickfont: {size: 16}, automargin: true},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        <xsl:variable name="all-work-publication-years" select="cligs:get-first-edition-years($bibacme-works)"/>
                        <!-- get the number of all works published before 1880 -->
                        <xsl:variable name="num-all-works-before-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'before')"/>
                        <!-- get the number of all works published after 1880 -->
                        <xsl:variable name="num-all-works-after-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'after')"/>
                        annotations: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity','novela americana',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:variable name="num-works-before-1880" select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:variable name="num-works-after-1880" select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-before-1880"/>,
                            text: "<xsl:value-of select="round($num-works-before-1880 div ($num-all-works-before-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "right",
                            yanchor: "bottom",
                            font: {size: 14}
                            },
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-after-1880"/>,
                            text: "<xsl:value-of select="round($num-works-after-1880 div ($num-all-works-after-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "left",
                            yanchor: "bottom",
                            font: {size: 14}
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-1880-corp">
        <!-- creates a grouped bar chart showing the "novelas americanas" before and in/after 1880,
        in Conha19 -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-1880-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 600px;"></div>
                    <script>
                        var trace1 = {
                        type: "bar",
                        name: "before 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela americana',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var trace2 = {
                        type: "bar",
                        name: "in or after 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela americana',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        barmode: "group",
                        xaxis: {tickmode: "linear", dtick: 1, title: "subgenres", tickfont: {size: 16}, automargin: true},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        <xsl:variable name="all-work-publication-years" select="cligs:get-first-edition-years($corpus-works)"/>
                        <!-- get the number of all works published before 1880 -->
                        <xsl:variable name="num-all-works-before-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'before')"/>
                        <!-- get the number of all works published after 1880 -->
                        <xsl:variable name="num-all-works-after-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'after')"/>
                        annotations: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela americana',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:variable name="num-works-before-1880" select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:variable name="num-works-after-1880" select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-before-1880"/>,
                            text: "<xsl:value-of select="round($num-works-before-1880 div ($num-all-works-before-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "right",
                            yanchor: "bottom",
                            font: {size: 14}
                            },
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-after-1880"/>,
                            text: "<xsl:value-of select="round($num-works-after-1880 div ($num-all-works-after-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "left",
                            yanchor: "bottom",
                            font: {size: 14}
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-by-decade-bib">
        <!-- creates a stacked bar chart showing "novelas nacionales" by decade,
        in Bib-ACMé -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-by-decade-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: [<xsl:value-of select="string-join($decades,',')"/>],
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity','novela nacional',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            y: [<xsl:value-of select="cligs:get-num-decades($decades, $work-publication-years)"/>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {tickmode: "linear", dtick: 10, title: "decades", tickfont: {size: 16}},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 14}},
                        font: {size: 16},
                        colorway: ["rgb(44, 160, 44)","rgb(31, 119, 180)","rgb(214, 39, 40)","rgb(148, 103, 189)","rgb(227, 119, 194)"]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-by-decade-corp">
        <!-- creates a stacked bar chart showing the "novelas nacionales" by decade,
        in Conha19 -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-by-decade-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: [<xsl:value-of select="string-join($decades,',')"/>],
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela nacional',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            y: [<xsl:value-of select="cligs:get-num-decades($decades, $work-publication-years)"/>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {tickmode: "linear", dtick: 10, title: "decades", tickfont: {size: 16}},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 14}},
                        font: {size: 16},
                        colorway: ["rgb(44, 160, 44)","rgb(31, 119, 180)","rgb(214, 39, 40)","rgb(148, 103, 189)","rgb(227, 119, 194)"]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-1880-bib">
        <!-- creates a grouped bar chart showing the "novelas nacionales" before and in/after 1880,
        in Bib-ACMé -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-1880-bib.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 600px;"></div>
                    <script>
                        var trace1 = {
                        type: "bar",
                        name: "before 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity','novela nacional',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var trace2 = {
                        type: "bar",
                        name: "in or after 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity','novela nacional',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        barmode: "group",
                        xaxis: {tickmode: "linear", dtick: 1, title: "subgenres", tickfont: {size: 16}, automargin: true},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        <xsl:variable name="all-work-publication-years" select="cligs:get-first-edition-years($bibacme-works)"/>
                        <!-- get the number of all works published before 1880 -->
                        <xsl:variable name="num-all-works-before-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'before')"/>
                        <!-- get the number of all works published after 1880 -->
                        <xsl:variable name="num-all-works-after-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'after')"/>
                        annotations: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($bibacme-works,'identity','novela nacional',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:variable name="num-works-before-1880" select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:variable name="num-works-after-1880" select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-before-1880"/>,
                            text: "<xsl:value-of select="round($num-works-before-1880 div ($num-all-works-before-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "right",
                            yanchor: "bottom",
                            font: {size: 14}
                            },
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-after-1880"/>,
                            text: "<xsl:value-of select="round($num-works-after-1880 div ($num-all-works-after-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "left",
                            yanchor: "bottom",
                            font: {size: 14}
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-1880-corp">
        <!-- creates a grouped bar chart showing the "novelas nacionales" before and in/after 1880,
        in Conha19 -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-1880-corp.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 600px;"></div>
                    <script>
                        var trace1 = {
                        type: "bar",
                        name: "before 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela nacional',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var trace2 = {
                        type: "bar",
                        name: "in or after 1880",
                        x: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        y: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela nacional',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:value-of select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>]
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        barmode: "group",
                        xaxis: {tickmode: "linear", dtick: 1, title: "subgenres", tickfont: {size: 16}, automargin: true},
                        yaxis: {title: "number of works"},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        <xsl:variable name="all-work-publication-years" select="cligs:get-first-edition-years($corpus-works)"/>
                        <!-- get the number of all works published before 1880 -->
                        <xsl:variable name="num-all-works-before-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'before')"/>
                        <!-- get the number of all works published after 1880 -->
                        <xsl:variable name="num-all-works-after-1880" select="cligs:get-num-years(1880, $all-work-publication-years, 'after')"/>
                        annotations: [<xsl:for-each select="$labels">
                            <!-- get the works with a certain subgenre  -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela nacional',$labels,.)"/>
                            <!-- get the years of the first editions of these works -->
                            <xsl:variable name="work-publication-years" select="cligs:get-first-edition-years($works-subgenre)"/>
                            <!-- of these, get the number of works published before 1880 -->
                            <xsl:variable name="num-works-before-1880" select="cligs:get-num-years(1880, $work-publication-years, 'before')"/>
                            <!-- of these, get the number of works published after 1880 -->
                            <xsl:variable name="num-works-after-1880" select="cligs:get-num-years(1880, $work-publication-years, 'after')"/>
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-before-1880"/>,
                            text: "<xsl:value-of select="round($num-works-before-1880 div ($num-all-works-before-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "right",
                            yanchor: "bottom",
                            font: {size: 14}
                            },
                            {
                            x: <xsl:value-of select="position() - 1"/>,
                            y: <xsl:value-of select="$num-works-after-1880"/>,
                            text: "<xsl:value-of select="round($num-works-after-1880 div ($num-all-works-after-1880 div 100))"/>%",
                            showarrow: false,
                            xanchor: "left",
                            yanchor: "bottom",
                            font: {size: 14}
                            }
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-prestige">
        <!-- creates two donut charts comparing the proportions of works carrying the label "novela original" in 
        high and low prestige novels -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-prestige.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 650px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-high-prestige" select="$corpus[.//term[@type='text.prestige'] = 'high']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-high" select="cligs:get-primary-labels($corpus-works[idno=$idnos-high-prestige],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-high[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-high,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "high prestige",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-low-prestige" select="$corpus[.//term[@type='text.prestige'] = 'low']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-low" select="cligs:get-primary-labels($corpus-works[idno=$idnos-low-prestige],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-low[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-low,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "low prestige",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'high',
                        x: 0.18,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'low',
                        x: 0.81,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-prestige">
        <!-- creates two donut charts comparing the proportions of works carrying the label "novela americana" in 
        high and low prestige novels -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-prestige.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-high-prestige" select="$corpus[.//term[@type='text.prestige'] = 'high']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-high" select="cligs:get-primary-labels($corpus-works[idno=$idnos-high-prestige],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-high[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-high,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "high prestige",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-low-prestige" select="$corpus[.//term[@type='text.prestige'] = 'low']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-low" select="cligs:get-primary-labels($corpus-works[idno=$idnos-low-prestige],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-low[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-low,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "low prestige",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(31, 119, 180)","rgb(148, 103, 189)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'high',
                        x: 0.19,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'low',
                        x: 0.8,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-prestige">
        <!-- creates two donut charts comparing the proportions of works carrying the label "novela nacional" in 
        high and low prestige novels -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-by-prestige.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-high-prestige" select="$corpus[.//term[@type='text.prestige'] = 'high']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-high" select="cligs:get-primary-labels($corpus-works[idno=$idnos-high-prestige],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-high[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-high,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "high prestige",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-low-prestige" select="$corpus[.//term[@type='text.prestige'] = 'low']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-low" select="cligs:get-primary-labels($corpus-works[idno=$idnos-low-prestige],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-low[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-low,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "low prestige",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(44, 160, 44)","rgb(148, 103, 189)","rgb(214, 39, 40)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'high',
                        x: 0.19,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'low',
                        x: 0.8,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-narrative-perspective">
        <!-- creates two donut charts comparing the proportions of works with the label "novela original" in 
        third and first person novels -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-narrative-perspective.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-third-person" select="$corpus[.//term[@type='text.narration.narrator.person'] = 'third person']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-third" select="cligs:get-primary-labels($corpus-works[idno=$idnos-third-person],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-third[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-third,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "third person",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-first-person" select="$corpus[.//term[@type='text.narration.narrator.person'] = 'first person']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-first" select="cligs:get-primary-labels($corpus-works[idno=$idnos-first-person],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-first[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-first,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "first person",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'third',
                        x: 0.18,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'first',
                        x: 0.81,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-narrative-perspective">
        <!-- creates two donut charts comparing the proportions of works with the label "novela americana" in 
        third and first person novels -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-narrative-perspective.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-third-person" select="$corpus[.//term[@type='text.narration.narrator.person'] = 'third person']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-third" select="cligs:get-primary-labels($corpus-works[idno=$idnos-third-person],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-third[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-third,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "third person",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-first-person" select="$corpus[.//term[@type='text.narration.narrator.person'] = 'first person']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-first" select="cligs:get-primary-labels($corpus-works[idno=$idnos-first-person],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-first[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-first,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "first person",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(31, 119, 180)","rgb(148, 103, 189)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'third',
                        x: 0.18,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'first',
                        x: 0.81,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-narrative-perspective">
        <!-- creates two donut charts comparing the proportions of works with the label "novela nacional" in 
        third and first person novels -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-by-narrative-perspective.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-third-person" select="$corpus[.//term[@type='text.narration.narrator.person'] = 'third person']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-third" select="cligs:get-primary-labels($corpus-works[idno=$idnos-third-person],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-third[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-third,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "third person",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-first-person" select="$corpus[.//term[@type='text.narration.narrator.person'] = 'first person']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-first" select="cligs:get-primary-labels($corpus-works[idno=$idnos-first-person],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-first[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-first,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "first person",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(44, 160, 44)","rgb(214, 39, 40)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'third',
                        x: 0.18,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'first',
                        x: 0.81,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-setting-continent">
        <!-- creates two donut charts comparing the proportions works with the label "novela original" in 
        novels with an American vs. European setting -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-setting-continent.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-America" select="$corpus[.//term[@type='text.setting.continent'] = 'America']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-America" select="cligs:get-primary-labels($corpus-works[idno=$idnos-America],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-America[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-America,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "America",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-Europe" select="$corpus[.//term[@type='text.setting.continent'] = 'Europe']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-Europe" select="cligs:get-primary-labels($corpus-works[idno=$idnos-Europe],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-Europe[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-Europe,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Europe",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'America',
                        x: 0.15,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Europe',
                        x: 0.84,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-setting-continent">
        <!-- creates two donut charts comparing the proportions works with the label "novela americana" in 
        novels with an American vs. European setting -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-setting-continent.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-America" select="$corpus[.//term[@type='text.setting.continent'] = 'America']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-America" select="cligs:get-primary-labels($corpus-works[idno=$idnos-America],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-America[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-America,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "America",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-Europe" select="$corpus[.//term[@type='text.setting.continent'] = 'Europe']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-Europe" select="cligs:get-primary-labels($corpus-works[idno=$idnos-Europe],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-Europe[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-Europe,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Europe",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(31, 119, 180)","rgb(148, 103, 189)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'America',
                        x: 0.15,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Europe',
                        x: 0.84,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-setting-continent">
        <!-- creates two donut charts comparing the proportions works with the label "novela nacional" in 
        novels with an American vs. European setting -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-by-setting-continent.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-America" select="$corpus[.//term[@type='text.setting.continent'] = 'America']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-America" select="cligs:get-primary-labels($corpus-works[idno=$idnos-America],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-America[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-America,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "America",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-Europe" select="$corpus[.//term[@type='text.setting.continent'] = 'Europe']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-Europe" select="cligs:get-primary-labels($corpus-works[idno=$idnos-Europe],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-Europe[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-Europe,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "Europe",
                        domain: {row: 0, column: 1}
                        };
                        
                        var data = [trace1, trace2];
                        var layout = {
                        grid: {rows: 1, columns: 2},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(44, 160, 44)","rgb(148, 103, 189)","rgb(214, 39, 40)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'America',
                        x: 0.15,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'Europe',
                        x: 0.84,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-setting-time-period">
        <!-- creates three donut charts comparing the proportions of the label "novela original" in 
        novels with a contemporary setting and a setting in the recent past or past -->
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-setting-time-period.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-contemp" select="$corpus[.//term[@type='text.time.period.publication'] = 'contemporary']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-contemp" select="cligs:get-primary-labels($corpus-works[idno=$idnos-contemp],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-contemp[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-contemp,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "contemporary",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-past" select="$corpus[.//term[@type='text.time.period.publication'] = 'past']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-past" select="cligs:get-primary-labels($corpus-works[idno=$idnos-past],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-past[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-past,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "past",
                        domain: {row: 0, column: 1}
                        };
                        var trace3 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-recent" select="$corpus[.//term[@type='text.time.period.publication'] = 'recent past']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-recent" select="cligs:get-primary-labels($corpus-works[idno=$idnos-recent],'identity')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-recent[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-recent,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "recent past",
                        domain: {row: 0, column: 2}
                        };
                        
                        var data = [trace1, trace2, trace3];
                        var layout = {
                        grid: {rows: 1, columns: 3},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'contemp.',
                        x: 0.1,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'past',
                        x: 0.5,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'recent',
                        x: 0.88,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-setting-time-period">
        <!-- creates three donut charts comparing the proportions of the label "novela americana" in 
        novels with a contemporary setting and a setting in the recent past or past -->
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-setting-time-period.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-contemp" select="$corpus[.//term[@type='text.time.period.publication'] = 'contemporary']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-contemp" select="cligs:get-primary-labels($corpus-works[idno=$idnos-contemp],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-contemp[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-contemp,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "contemporary",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-past" select="$corpus[.//term[@type='text.time.period.publication'] = 'past']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-past" select="cligs:get-primary-labels($corpus-works[idno=$idnos-past],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-past[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-past,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "past",
                        domain: {row: 0, column: 1}
                        };
                        var trace3 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-recent" select="$corpus[.//term[@type='text.time.period.publication'] = 'recent past']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-recent" select="cligs:get-primary-labels($corpus-works[idno=$idnos-recent],'identity','novela americana')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-recent[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-recent,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "recent past",
                        domain: {row: 0, column: 2}
                        };
                        
                        var data = [trace1, trace2, trace3];
                        var layout = {
                        grid: {rows: 1, columns: 3},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(31, 119, 180)","rgb(148, 103, 189)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'contemp.',
                        x: 0.1,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'past',
                        x: 0.5,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'recent',
                        x: 0.88,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-setting-time-period">
        <!-- creates three donut charts comparing the proportions of the label "novela nacional" in 
        novels with a contemporary setting and a setting in the recent past or past -->
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-by-setting-time-period.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 400px;"></div>
                    <script>
                        var trace1 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-contemp" select="$corpus[.//term[@type='text.time.period.publication'] = 'contemporary']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-contemp" select="cligs:get-primary-labels($corpus-works[idno=$idnos-contemp],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-contemp[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-contemp,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "contemporary",
                        domain: {row: 0, column: 0}
                        };
                        var trace2 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-past" select="$corpus[.//term[@type='text.time.period.publication'] = 'past']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-past" select="cligs:get-primary-labels($corpus-works[idno=$idnos-past],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-past[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-past,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "past",
                        domain: {row: 0, column: 1}
                        };
                        var trace3 = {
                        labels: ["<xsl:value-of select="string-join($labels,'&quot;,&quot;')"/>"],
                        <xsl:variable name="idnos-recent" select="$corpus[.//term[@type='text.time.period.publication'] = 'recent past']//idno[@type='cligs']"/>
                        <xsl:variable name="labels-recent" select="cligs:get-primary-labels($corpus-works[idno=$idnos-recent],'identity','novela nacional')"/>
                        values: [<xsl:for-each select="$labels">
                            <xsl:choose>
                                <xsl:when test=". = 'other'">
                                    <xsl:value-of select="count($labels-recent[not(.=$labels)])"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="count(index-of($labels-recent,.))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>],
                        type: "pie",
                        hole: 0.5,
                        direction: "clockwise",
                        name: "recent past",
                        domain: {row: 0, column: 2}
                        };
                        
                        var data = [trace1, trace2, trace3];
                        var layout = {
                        grid: {rows: 1, columns: 3},
                        font: {size: 12},
                        legend: {font: {size: 14}},
                        colorway: ["rgb(227, 119, 194)","rgb(148, 103, 189)","rgb(44, 160, 44)","rgb(214, 39, 40)","rgb(31, 119, 180)"],
                        annotations: [
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'contemp.',
                        x: 0.1,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'past',
                        x: 0.5,
                        y: 0.5
                        },
                        {
                        font: {
                        size: 16
                        },
                        showarrow: false,
                        text: 'recent',
                        x: 0.88,
                        y: 0.5
                        }
                        ]
                        };
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-length">
        <!-- creates a series of box plots showing work lengths in tokens by works carrying the label "novela original" -->
        
        <xsl:variable name="labels" select="('novela original','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-length.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 600px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            <!-- get the works with this subgenre -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity',$labels,.)"/>
                            y: [<xsl:value-of select="string-join($corpus[.//idno[@type='cligs']=$works-subgenre/idno[@type='cligs']]//measure[@unit='words'],',')"/>],
                            type: 'box',
                            name: "<xsl:value-of select="."/>"
                            };
                        </xsl:for-each>
                        
                        
                        var data = [<xsl:for-each select="1 to count($labels)">
                            <xsl:text>trace</xsl:text><xsl:value-of select="."/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        yaxis: {title: "number of tokens"},
                        xaxis: {title: "works by subgenre", automargin: true},
                        showlegend: false,
                        colorway: ["rgb(31, 119, 180)","rgb(148, 103, 189)","rgb(227, 119, 194)"]
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-length">
        <!-- creates a series of box plots showing work lengths in tokens by works carrying the label "novela americana" -->
        
        <xsl:variable name="labels" select="('novela americana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-length.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 600px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            <!-- get the works with this subgenre -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela americana',$labels,.)"/>
                            y: [<xsl:value-of select="string-join($corpus[.//idno[@type='cligs']=$works-subgenre/idno[@type='cligs']]//measure[@unit='words'],',')"/>],
                            type: 'box',
                            name: "<xsl:value-of select="."/>"
                            };
                        </xsl:for-each>
                        
                        
                        var data = [<xsl:for-each select="1 to count($labels)">
                            <xsl:text>trace</xsl:text><xsl:value-of select="."/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        yaxis: {title: "number of tokens"},
                        xaxis: {title: "works by subgenre", automargin: true},
                        showlegend: false,
                        colorway: ["rgb(31, 119, 180)","rgb(148, 103, 189)","rgb(227, 119, 194)"]
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-nacionales-length">
        <!-- creates a series of box plots showing work lengths in tokens by works carrying the label "novela nacional" -->
        
        <xsl:variable name="labels" select="('novela mexicana','novela argentina','novela cubana','other','none')"/>
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-nacional-length.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 600px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels">
                            var trace<xsl:value-of select="position()"/> = {
                            <!-- get the works with this subgenre -->
                            <xsl:variable name="works-subgenre" select="cligs:get-works-primary-subgenre($corpus-works,'identity','novela nacional',$labels,.)"/>
                            y: [<xsl:value-of select="string-join($corpus[.//idno[@type='cligs']=$works-subgenre/idno[@type='cligs']]//measure[@unit='words'],',')"/>],
                            type: 'box',
                            name: "<xsl:value-of select="."/>"
                            };
                        </xsl:for-each>
                        
                        
                        var data = [<xsl:for-each select="1 to count($labels)">
                            <xsl:text>trace</xsl:text><xsl:value-of select="."/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        yaxis: {title: "number of tokens"},
                        xaxis: {title: "works by subgenre", automargin: true},
                        showlegend: false,
                        colorway: ["rgb(44, 160, 44)","rgb(31, 119, 180)","rgb(214, 39, 40)","rgb(148, 103, 189)","rgb(227, 119, 194)"],
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-subgenre-theme">
        <!-- creates a stacked bar plot showing the proportion of "novela original" vs. other for each of the 
        major primary thematic subgenres -->
        
        <!-- thematic subgenres: novela histórica, novela sentimental, novela de costumbres, novela social, novela política -->
        
        <xsl:variable name="labels-x" select="('novela histórica','novela sentimental','novela de costumbres','novela social', 'novela política', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela original', 'other')"/>
        <xsl:variable name="works-y-original" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.='novela original']]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.='novela original'])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-subgenre-theme.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela original') then $works-y-original else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                    <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'theme')"/>
                                    <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'theme')"/>
                                    <xsl:choose>
                                        <xsl:when test=".='other/unknown'">
                                            <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "subgenres (thematic)", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
    
    </xsl:template>
    
    <xsl:template name="plot-novelas-originales-subgenre-current">
        <!-- creates a stacked bar plot showing the proportion of "novela original" vs. other for each of the 
        literary currents -->
        
        <!-- currents: novela romántica, novela realista, novela naturalista, novela modernista, other/unknown -->
        
        <xsl:variable name="labels-x" select="('novela romántica','novela realista','novela naturalista','novela modernista', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela original', 'other')"/>
        <xsl:variable name="works-y-original" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.='novela original']]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.='novela original'])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-original-by-subgenre-current.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela original') then $works-y-original else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'current')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'current')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "literary currents", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-subgenre-theme">
        <!-- creates a stacked bar plot showing the proportion of novelas americanas vs. other for each of the 
        major primary thematic subgenres -->
        
        <!-- thematic subgenres: novela histórica, novela sentimental, novela de costumbres, novela social, novela política -->
        
        <xsl:variable name="labels-x" select="('novela histórica','novela sentimental','novela de costumbres','novela social', 'novela política', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela americana', 'other')"/>
        
        <xsl:variable name="novelas-americanas" select="('novela americana','novela mexicana','novela cubana','novela argentina','novela criolla','novela bonaerense','novela porteña','novela habanera','novela yucateca','novela suriana','novela tapatía','novela india','novela mixteca','novela de Tabasco','novela azteca','novela camagüeyana','novela kantabro-americana', 'novela franco-argentina')"/>
        
        <xsl:variable name="works-y-american" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-americanas]]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-americanas])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-subgenre-theme.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela americana') then $works-y-american else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'theme')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'theme')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "subgenres (thematic)", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-novelas-americanas-subgenre-current">
        <!-- creates a stacked bar plot showing the proportion of novelas americanas vs. other for each of the 
        literary currents -->
        
        <!-- currents: novela romántica, novela realista, novela naturalista, novela modernista, other/unknown -->
        
        <xsl:variable name="labels-x" select="('novela romántica','novela realista','novela naturalista','novela modernista', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela americana', 'other')"/>
        
        <xsl:variable name="novelas-americanas" select="('novela americana','novela mexicana','novela cubana','novela argentina','novela criolla','novela bonaerense','novela porteña','novela habanera','novela yucateca','novela suriana','novela tapatía','novela india','novela mixteca','novela de Tabasco','novela azteca','novela camagüeyana','novela kantabro-americana', 'novela franco-argentina')"/>
        
        <xsl:variable name="works-y-american" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-americanas]]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-americanas])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-americana-by-subgenre-current.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela americana') then $works-y-american else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'current')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'current')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "literary currents", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-novelas-mexicanas-subgenre-theme">
        <!-- creates a stacked bar plot showing the proportion of novelas mexicanas vs. other for each of the 
        major primary thematic subgenres -->
        
        <!-- thematic subgenres: novela histórica, novela sentimental, novela de costumbres, novela social, novela política -->
        
        <xsl:variable name="labels-x" select="('novela histórica','novela sentimental','novela de costumbres','novela social', 'novela política', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela mexicana', 'other')"/>
        
        <xsl:variable name="novelas-mexicanas" select="('novela mexicana','novela yucateca','novela suriana','novela tapatía','novela mixteca','novela de Tabasco','novela azteca')"/>
        
        <xsl:variable name="works-y-mexican" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-mexicanas]]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-mexicanas])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-mexicana-by-subgenre-theme.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela mexicana') then $works-y-mexican else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'theme')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'theme')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "subgenres (thematic)", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-novelas-mexicanas-subgenre-current">
        <!-- creates a stacked bar plot showing the proportion of novelas mexicanas vs. other for each of the 
        literary currents -->
        
        <!-- currents: novela romántica, novela realista, novela naturalista, novela modernista, other/unknown -->
        
        <xsl:variable name="labels-x" select="('novela romántica','novela realista','novela naturalista','novela modernista', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela mexicana', 'other')"/>
        
        <xsl:variable name="novelas-mexicanas" select="('novela mexicana','novela yucateca','novela suriana','novela tapatía','novela mixteca','novela de Tabasco','novela azteca')"/>
        
        <xsl:variable name="works-y-mexican" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-mexicanas]]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-mexicanas])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-mexicana-by-subgenre-current.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela mexicana') then $works-y-mexican else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'current')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'current')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "literary currents", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-novelas-argentinas-subgenre-theme">
        <!-- creates a stacked bar plot showing the proportion of novelas argentinas vs. other for each of the 
        major primary thematic subgenres -->
        
        <!-- thematic subgenres: novela histórica, novela sentimental, novela de costumbres, novela social, novela política -->
        
        <xsl:variable name="labels-x" select="('novela histórica','novela sentimental','novela de costumbres','novela social', 'novela política', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela argentina', 'other')"/>
        
        <xsl:variable name="novelas-argentinas" select="('novela argentina','novela bonaerense','novela porteña','novela franco-argentina')"/>
        
        <xsl:variable name="works-y-argentine" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-argentinas]]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-argentinas])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-argentina-by-subgenre-theme.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela argentina') then $works-y-argentine else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'theme')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'theme')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "subgenres (thematic)", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-novelas-argentinas-subgenre-current">
        <!-- creates a stacked bar plot showing the proportion of novelas argentinas vs. other for each of the 
        literary currents -->
        
        <!-- currents: novela romántica, novela realista, novela naturalista, novela modernista, other/unknown -->
        
        <xsl:variable name="labels-x" select="('novela romántica','novela realista','novela naturalista','novela modernista', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela argentina', 'other')"/>
        
        <xsl:variable name="novelas-argentinas" select="('novela argentina','novela bonaerense','novela porteña','novela franco-argentina')"/>
        
        <xsl:variable name="works-y-argentine" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-argentinas]]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-argentinas])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-argentina-by-subgenre-current.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela argentina') then $works-y-argentine else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'current')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'current')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "literary currents", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-novelas-cubanas-subgenre-theme">
        <!-- creates a stacked bar plot showing the proportion of novelas cubanas vs. other for each of the 
        major primary thematic subgenres -->
        
        <!-- thematic subgenres: novela histórica, novela sentimental, novela de costumbres, novela social, novela política -->
        
        <xsl:variable name="labels-x" select="('novela histórica','novela sentimental','novela de costumbres','novela social', 'novela política', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela cubana', 'other')"/>
        
        <xsl:variable name="novelas-cubanas" select="('novela cubana','novela habanera','novela camagüeyana')"/>
        
        <xsl:variable name="works-y-cuban" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-cubanas]]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-cubanas])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-cubana-by-subgenre-theme.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela cubana') then $works-y-cuban else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'theme')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'theme')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "subgenres (thematic)", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="plot-novelas-cubanas-subgenre-current">
        <!-- creates a stacked bar plot showing the proportion of novelas cubanas vs. other for each of the 
        literary currents -->
        
        <!-- currents: novela romántica, novela realista, novela naturalista, novela modernista, other/unknown -->
        
        <xsl:variable name="labels-x" select="('novela romántica','novela realista','novela naturalista','novela modernista', 'other/unknown')"/>
        <xsl:variable name="labels-y" select="('novela cubana', 'other')"/>
        
        <xsl:variable name="novelas-cubanas" select="('novela cubana','novela habanera','novela camagüeyana')"/>
        
        <xsl:variable name="works-y-cuban" select="$bibacme-works[.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-cubanas]]"/>
        <xsl:variable name="works-y-other" select="$bibacme-works[not(.//term[@type='subgenre.summary.identity.explicit'][.=$novelas-cubanas])]"/>    
        
        <xsl:result-document href="{concat($output-dir,'subgenres-novela-cubana-by-subgenre-current.html')}" method="html" encoding="UTF-8">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 1000px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="$labels-y">
                            <xsl:variable name="works-y" select="if (.='novela cubana') then $works-y-cuban else $works-y-other"/>
                            var trace<xsl:value-of select="position()"/> = {
                            type: "bar",
                            name: "<xsl:value-of select="."/>",
                            x: ["<xsl:value-of select="string-join($labels-x,'&quot;,&quot;')"/>"],
                            y: [<xsl:for-each select="$labels-x">
                                <xsl:variable name="prim-sub" select="cligs:get-primary-labels($works-y, 'current')"/>
                                <xsl:variable name="prim-sub-all" select="cligs:get-primary-labels($bibacme-works, 'current')"/>
                                <xsl:choose>
                                    <xsl:when test=".='other/unknown'">
                                        <xsl:value-of select="count($prim-sub[not(. = $labels-x)]) div count($prim-sub-all[not(. = $labels-x)])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="count($prim-sub[.=current()]) div count($prim-sub-all[.=current()])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position()!=last()">,</xsl:if>
                            </xsl:for-each>]
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="$labels-y">
                            <xsl:text>trace</xsl:text><xsl:value-of select="position()"/>
                            <xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        barmode: "stack",
                        xaxis: {title: "literary currents", tickfont: {size: 16}},
                        yaxis: {title: "number of works", range: [0,1]},
                        legend: {font: {size: 16}},
                        font: {size: 16},
                        margin: {b: 150}
                        };
                        Plotly.newPlot("myDiv", data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    
    
    <!-- ########### HELPER TEMPLATES ########### -->
    
    <xsl:template name="get-decade-range">
        <!-- for a specified range of decades (from-to):
        get all the decade steps inbetween -->
        <xsl:param name="curr-decade"/>
        <xsl:param name="start-decade"/>
        <xsl:param name="end-decade"/>
        
        <xsl:value-of select="$curr-decade"/>
        <xsl:if test="$curr-decade &lt; $end-decade">,</xsl:if>
        
        <xsl:variable name="next-decade" select="$curr-decade + 10"/>
        
        <xsl:if test="($next-decade >= $start-decade) and ($next-decade &lt;= $end-decade)">
            <xsl:call-template name="get-decade-range">
                <xsl:with-param name="curr-decade" select="$next-decade"/>
                <xsl:with-param name="start-decade" select="$start-decade"/>
                <xsl:with-param name="end-decade" select="$end-decade"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    
    <!-- ########### FUNCTIONS ############ -->
    
    <xsl:function name="cligs:count-labels" as="xs:integer+">
        <!-- of a set of subgenre labels: return counts for each label in a collection of labels
        (how often does each label occur in the collection?) -->
        <xsl:param name="label-collection"/><!-- the collection of labels to be counted -->
        <xsl:param name="label-set"/><!-- the kinds of labels to count -->
        <xsl:for-each select="$label-set">
            <xsl:value-of select="count(index-of($label-collection,.))"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-primary-labels">
        <!-- for a set of works: get just the primary labels of a certain type of subgenre label -->
        <xsl:param name="works"/>
        <xsl:param name="label-type"/><!-- e.g. "theme" -->
        <xsl:for-each select="$works">
            <xsl:variable name="labels" select=".//term[starts-with(@type,concat('subgenre.summary.',$label-type))]"/>
            <xsl:variable name="num-labels" select="count($labels)"/>
            <xsl:choose>
                <xsl:when test="$num-labels=1">
                    <xsl:value-of select="normalize-space($labels)"/>
                </xsl:when>
                <xsl:when test="$num-labels>1">
                    <xsl:choose>
                        <xsl:when test="$label-type='mode.representation'">
                            <xsl:choose>
                                <xsl:when test="$labels[normalize-space(.)='novela']">
                                    <xsl:text>novela</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$labels[1]/normalize-space(.)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$label-type='identity'">
                            <xsl:choose>
                                <xsl:when test="$labels[normalize-space(.)='novela original']">
                                    <xsl:text>novela original</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$labels[1]/normalize-space(.)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$labels[@cligs:importance='2']/normalize-space(.)"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$num-labels=0">
                    <xsl:text>none</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-primary-labels">
        <!-- for a set of works: get just the primary labels of a certain type of subgenre label,
        3-param-version with subtype -->
        <xsl:param name="works"/>
        <xsl:param name="label-type"/><!-- e.g. "theme" -->
        <xsl:param name="label-subtype"/><!-- which label(s) to consider primary 
            in case of various labels of the same type, 
        e.g. "novela original", "novela americana" or "novela nacional" for identity -->
        <xsl:variable name="novelas-americanas" select="('novela americana','novela mexicana','novela cubana','novela argentina','novela criolla','novela bonaerense','novela porteña','novela habanera','novela yucateca','novela suriana','novela tapatía','novela india','novela mixteca','novela de Tabasco','novela azteca','novela camagüeyana','novela kantabro-americana', 'novela franco-argentina')"/>
        <xsl:variable name="novelas-mexicanas" select="('novela mexicana','novela yucateca','novela suriana','novela tapatía','novela mixteca','novela de Tabasco','novela azteca')"/>
        <xsl:variable name="novelas-argentinas" select="('novela argentina','novela bonaerense','novela porteña','novela franco-argentina')"/>
        <xsl:variable name="novelas-cubanas" select="('novela cubana','novela habanera','novela camagüeyana')"/>
        <xsl:for-each select="$works">
            <xsl:variable name="labels" select=".//term[starts-with(@type,concat('subgenre.summary.',$label-type))]"/>
            <xsl:variable name="num-labels" select="count($labels)"/>
            <xsl:choose>
                <xsl:when test="$num-labels=1">
                    <xsl:choose>
                        <xsl:when test="$label-subtype='novela americana'">
                            <xsl:choose>
                                <xsl:when test="$labels[normalize-space(.)=$novelas-americanas]">
                                    <xsl:text>novela americana</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="normalize-space($labels)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$label-subtype='novela nacional'">
                            <xsl:choose>
                                <xsl:when test="$labels[normalize-space(.)=$novelas-mexicanas]">
                                    <xsl:text>novela mexicana</xsl:text>
                                </xsl:when>
                                <xsl:when test="$labels[normalize-space(.)=$novelas-argentinas]">
                                    <xsl:text>novela argentina</xsl:text>
                                </xsl:when>
                                <xsl:when test="$labels[normalize-space(.)=$novelas-cubanas]">
                                    <xsl:text>novela cubana</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="normalize-space($labels)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space($labels)"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$num-labels>1">
                    <xsl:choose>
                        <xsl:when test="$label-type='mode.representation'">
                            <xsl:choose>
                                <xsl:when test="$labels[normalize-space(.)='novela']">
                                    <xsl:text>novela</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$labels[1]/normalize-space(.)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$label-type='identity'">
                            <xsl:choose>
                                <xsl:when test="$label-subtype='novela americana'">
                                    <xsl:choose>
                                        <xsl:when test="$labels[normalize-space(.)=$novelas-americanas]">
                                            <xsl:text>novela americana</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$labels[1]/normalize-space(.)"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="$label-subtype='novela nacional'">
                                    <xsl:choose>
                                        <xsl:when test="$labels[normalize-space(.)=$novelas-mexicanas]">
                                            <xsl:text>novela mexicana</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="$labels[normalize-space(.)=$novelas-argentinas]">
                                            <xsl:text>novela argentina</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="$labels[normalize-space(.)=$novelas-cubanas]">
                                            <xsl:text>novela cubana</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$labels[1]/normalize-space(.)"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="$labels[normalize-space(.)=$label-subtype]">
                                            <xsl:value-of select="$label-subtype[1]"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$labels[1]/normalize-space(.)"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$labels[@cligs:importance='2']/normalize-space(.)"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$num-labels=0">
                    <xsl:text>none</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-explicit-labels">
        <!-- for a set of works: get the explicit labels of a certain type of subgenre label -->
        <xsl:param name="works"/>
        <xsl:param name="label-type"/><!-- e.g. "theme" -->
        <xsl:for-each select="$works">
            <xsl:variable name="labels" select=".//term[@type = concat('subgenre.summary.',$label-type,'.explicit')]"/>
            <xsl:variable name="num-labels" select="count($labels)"/>
            <xsl:choose>
                <xsl:when test="$num-labels=1">
                    <xsl:value-of select="normalize-space($labels)"/>
                </xsl:when>
                <xsl:when test="$num-labels>1">
                    <xsl:choose>
                        <xsl:when test="$labels[normalize-space(.)='novela histórica'] and $labels[normalize-space(.)='novela de costumbres']">
                            <xsl:value-of select="$labels[normalize-space(.)=('novela histórica','novela de costumbres')][@cligs:importance='2']/normalize-space(.)"/>
                        </xsl:when>
                        <xsl:when test="$labels[normalize-space(.)='novela histórica']">
                            <xsl:text>novela histórica</xsl:text>
                        </xsl:when>
                        <xsl:when test="$labels[normalize-space(.)='novela de costumbres']">
                            <xsl:text>novela de costumbres</xsl:text>
                        </xsl:when>
                        <xsl:when test="$labels[@cligs:importance]">
                            <xsl:value-of select="$labels[@cligs:importance='2']/normalize-space(.)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$labels[1]/normalize-space(.)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$num-labels=0">
                    <xsl:text>none</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-multiple-labels">
        <!-- for a set of works, get the different subgenre labels of a certain type -->
        <xsl:param name="works"/>
        <xsl:param name="label-type"/><!-- e.g. theme -->
        <xsl:for-each select="$works">
            <xsl:variable name="labels" select=".//term[starts-with(@type,concat('subgenre.summary.',$label-type))]/normalize-space(.)"/>
            <xsl:variable name="num-labels" select="count($labels)"/>
            <xsl:choose>
                <xsl:when test="$num-labels=1">
                    <xsl:value-of select="normalize-space($labels)"/>
                </xsl:when>
                <xsl:when test="$num-labels>1">
                    <xsl:for-each select="distinct-values($labels)">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="$num-labels=0">
                    <xsl:text>none</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-labels">
        <!-- get the overall amount of subgenre labels associated with a set of works -->
        <xsl:param name="works"/>
        <xsl:for-each select="('mode.intention','mode.attitude','mode.reality','mode.medium','mode.representation','theme','identity','current')">
            <xsl:variable name="label-type" select="."/>
            <xsl:copy-of select="$works//term[starts-with(@type, concat('subgenre.summary.',$label-type))][not(normalize-space(.) = preceding-sibling::term[starts-with(@type, concat('subgenre.summary.',$label-type))]/normalize-space(.))]/normalize-space(.)"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-labels-per-work">
        <!-- for a set of works, get the number of different subgenre labels of a certain type -->
        <xsl:param name="works"/>
        <xsl:param name="label-type"/><!-- e.g. 'theme' -->
        <xsl:for-each select="$works">
            <xsl:value-of select="count(distinct-values(.//term[starts-with(@type,'subgenre.summary.theme')]/normalize-space(.)))"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-sorted-labels-set">
        <!-- for a certain subgenre type, get the set of labels, sorted by how many works have the labels -->
        <xsl:param name="works"/>
        <xsl:param name="label-type"/><!-- e.g. 'current' -->
        
        <xsl:variable name="labels-set" select="distinct-values($works//term[contains(@type,$label-type)]/normalize-space(normalize-space(.)))"/>
        <xsl:for-each select="$labels-set">
            <xsl:sort select="count($works[.//term[contains(@type,$label-type)]/normalize-space(.) = current()])" order="descending"/>
            <xsl:value-of select="."/>
        </xsl:for-each>
        
    </xsl:function>
    
    <xsl:function name="cligs:get-labels-least">
        <!-- of a set of labels, return the ones that occur at least for x works -->
        <xsl:param name="works"/><!-- set of works -->
        <xsl:param name="label-set"/><!-- set of labels -->
        <xsl:param name="label-type"/><!-- e.g. "theme" for thematic labels -->
        <xsl:param name="limit"/><!-- minimum number of works, e.g. 10 -->
        <xsl:for-each select="$label-set">
            <xsl:sort select="count($works[.//term[contains(@type,$label-type)]/normalize-space(.)=current()])" order="descending"/>
            <xsl:variable name="works-with-label" select="$works[.//term[contains(@type,$label-type)]/normalize-space(.)=current()]"/>
            <xsl:if test="count($works-with-label) >= $limit">
                <xsl:value-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-author-dates-known">
        <!-- count how many authors there are with known or unknown life dates -->
        <xsl:param name="mode"/><!-- both, birth, death, none -->
        <xsl:param name="set"/><!-- bib vs. corp -->
        <xsl:choose>
            <xsl:when test="$mode = 'both'">
                <xsl:choose>
                    <xsl:when test="$set = 'bib'">
                        <xsl:value-of select="count($bibacme-authors[birth/date/@when and death/date/@when])"/>
                    </xsl:when>
                    <xsl:when test="$set = 'corp'">
                        <xsl:value-of select="count($corpus-authors[birth/date/@when and death/date/@when])"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$mode = 'birth'">
                <xsl:choose>
                    <xsl:when test="$set = 'bib'">
                        <xsl:value-of select="count($bibacme-authors[birth/date/@when][not(death/date/@when)])"/>
                    </xsl:when>
                    <xsl:when test="$set = 'corp'">
                        <xsl:value-of select="count($corpus-authors[birth/date/@when][not(death/date/@when)])"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$mode = 'death'">
                <xsl:choose>
                    <xsl:when test="$set = 'bib'">
                        <xsl:value-of select="count($bibacme-authors[death/date/@when][not(birth/date/@when)])"/>
                    </xsl:when>
                    <xsl:when test="$set = 'corp'">
                        <xsl:value-of select="count($corpus-authors[death/date/@when][not(birth/date/@when)])"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$mode = 'none'">
                <xsl:choose>
                    <xsl:when test="$set = 'bib'">
                        <xsl:value-of select="count($bibacme-authors[birth/date[.='desconocido'] and death/date[.='desconocido']])"/>
                    </xsl:when>
                    <xsl:when test="$set = 'corp'">
                        <xsl:value-of select="count($corpus-authors[birth/date[.='desconocido'] and death/date[.='desconocido']])"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="cligs:get-author-ages">
        <!-- get the ages of the author when the works were first published,
        optionally only for a specific decade -->
        <xsl:param name="works"/>
        <xsl:param name="decade"/><!-- default: none -->
        <xsl:for-each select="$works">
            <xsl:variable name="first-published-date" select="cligs:get-first-edition-year(.)"/>
            <xsl:choose>
                <!-- if the work was not published in the decade, do nothing -->
                <xsl:when test="string($decade) != 'none' and not($decade &lt;= $first-published-date and $first-published-date &lt; ($decade + 10))"/>
                <!-- if no decade is indicated or the work is in the decade, get the author's age -->
                <xsl:otherwise>
                    <!-- how old was the author when this work was first published? -->
                    <!-- in case of several authors: take the first one -->
                    <xsl:variable name="author-id" select="./author[1]/@key"/>
                    <xsl:variable name="author-birth-year" select="$bibacme-authors[@xml:id=$author-id]/birth/date[@when]/xs:integer(substring(@when,1,4))"/>
                    <xsl:variable name="author-death-year" select="$bibacme-authors[@xml:id=$author-id]/death/date[@when]/xs:integer(substring(@when,1,4))"/>
                    <!-- do only consider authors with a known birth and death year
                do not consider works published posthumously  -->
                    <xsl:if test="exists($author-birth-year) and exists($author-death-year)">
                        <xsl:if test="$first-published-date &lt;= $author-death-year">
                            <xsl:variable name="author-age" select="$first-published-date - $author-birth-year"/>
                            <xsl:value-of select="$author-age"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-author-ages-death">
        <!-- for all the authors whose life dates are known: get their age at death
        (roughly, in years) -->
        <xsl:param name="authors"/>
        <xsl:for-each select="$authors">
            <xsl:if test="birth/date/@when and death/date/@when">
                <xsl:variable name="birth-year" select="birth/date/@when/xs:integer(substring(.,1,4))"/>
                <xsl:variable name="death-year" select="death/date/@when/xs:integer(substring(.,1,4))"/>
                <xsl:value-of select="$death-year - $birth-year"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-box-group-labels">
        <xsl:param name="y"/>
        <xsl:param name="label"/>
        <!-- return a set of x labels for a set of y values corresponding to a certain label (e.g. decade) -->
        "<xsl:value-of select="string-join(for $i in 1 to count($y) return $label,'&quot;,&quot;')"/>"
    </xsl:function>
    
    <xsl:function name="cligs:get-nationalities-bib">
        <xsl:for-each select="$nationalities">
            <xsl:value-of select="count($bibacme-authors[nationality=current()])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-nationalities-corp">
        <xsl:for-each select="$nationalities">
            <xsl:value-of select="count($corpus-authors[nationality=current()])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:map-nationalities">
        <!-- return English labels for nationalities -->
        <xsl:for-each select="$nationalities">
            <xsl:choose>
                <xsl:when test=".='argentina/o'">Argentine</xsl:when>
                <xsl:when test=".='boliviana/o'">Bolivian</xsl:when>
                <xsl:when test=".='chilena/o'">Chilean</xsl:when>
                <xsl:when test=".='cubana/o'">Cuban</xsl:when>
                <xsl:when test=".='dominicana/o'">Dominican</xsl:when>
                <xsl:when test=".='español/a'">Spanish</xsl:when>
                <xsl:when test=".='francés/a'">French</xsl:when>
                <xsl:when test=".='italiana/o'">Italian</xsl:when>
                <xsl:when test=".='mexicana/o'">Mexican</xsl:when>
                <xsl:when test=".='peruana/o'">Peruvian</xsl:when>
                <xsl:when test=".='puertorriqueña/o'">Puerto Rican</xsl:when>
                <xsl:when test=".='uruguaya/o'">Uruguayan</xsl:when>
                <xsl:when test=".='desconocido'">unknown</xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:map-country-name">
        <!-- get English name for country shortcut -->
        <xsl:param name="id"/>
        <xsl:choose>
            <xsl:when test="$id = 'AR'">Argentina</xsl:when>
            <xsl:when test="$id = 'BO'">Bolivia</xsl:when>
            <xsl:when test="$id = 'CH'">Chile</xsl:when>
            <xsl:when test="$id = 'CO'">Colombia</xsl:when>
            <xsl:when test="$id = 'CU'">Cuba</xsl:when>
            <xsl:when test="$id = 'DE'">Germany</xsl:when>
            <xsl:when test="$id = 'ES'">Spain</xsl:when>
            <xsl:when test="$id = 'FR'">France</xsl:when>
            <xsl:when test="$id = 'GU'">Guatemala</xsl:when>
            <xsl:when test="$id = 'IT'">Italy</xsl:when>
            <xsl:when test="$id = 'MX'">Mexico</xsl:when>
            <xsl:when test="$id = 'PE'">Peru</xsl:when>
            <xsl:when test="$id = 'PR'">Puerto Rico</xsl:when>
            <xsl:when test="$id = 'UR'">Uruguay</xsl:when>
            <xsl:when test="$id = 'US'">USA</xsl:when>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="cligs:get-birth-places-bib">
        <xsl:for-each select="$birth-places">
            <xsl:value-of select="count($bibacme-authors[birth/placeName[last()]=current()])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-birth-places-corp">
        <xsl:for-each select="$birth-places">
            <xsl:value-of select="count($corpus-authors[birth/placeName[last()]=current()])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:map-birth-places">
        <!-- return English labels for birth country names -->
        <xsl:for-each select="$birth-places">
            <xsl:choose>
                <xsl:when test=".='Argentina'">Argentina</xsl:when>
                <xsl:when test=".='Francia'">France</xsl:when>
                <xsl:when test=".='España'">Spain</xsl:when>
                <xsl:when test=".='México'">Mexico</xsl:when>
                <xsl:when test=".='Cuba'">Cuba</xsl:when>
                <xsl:when test=".='Uruguay'">Uruguay</xsl:when>
                <xsl:when test=".='Chile'">Chile</xsl:when>
                <xsl:when test=".='Estados Unidos'">USA</xsl:when>
                <xsl:when test=".='República Dominicana'">Dominican Republic</xsl:when>
                <xsl:when test=".='Perú'">Peru</xsl:when>
                <xsl:when test=".='Bélgica'">Belgium</xsl:when>
                <xsl:when test=".='Italia'">Italy</xsl:when>
                <xsl:when test=".='Puerto Rico'">Puerto Rico</xsl:when>
                <xsl:when test=".='desconocido'">unknown</xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-death-places-bib">
        <xsl:for-each select="$death-places">
            <xsl:value-of select="count($bibacme-authors[death/placeName[last()]=current()])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-death-places-corp">
        <xsl:for-each select="$death-places">
            <xsl:value-of select="count($corpus-authors[death/placeName[last()]=current()])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:map-death-places">
        <!-- return English labels for death country names -->
        <xsl:for-each select="$death-places">
            <xsl:choose>
                <xsl:when test=".='Argentina'">Argentina</xsl:when>
                <xsl:when test=".='México'">Mexico</xsl:when>
                <xsl:when test=".='Estados Unidos'">USA</xsl:when>
                <xsl:when test=".='Cuba'">Cuba</xsl:when>
                <xsl:when test=".='España'">Spain</xsl:when>
                <xsl:when test=".='Chile'">Chile</xsl:when>
                <xsl:when test=".='Brasil'">Brazil</xsl:when>
                <xsl:when test=".='Francia'">France</xsl:when>
                <xsl:when test=".='Paraguay'">Paraguay</xsl:when>
                <xsl:when test=".='República Dominicana'">Dominican Republic</xsl:when>
                <xsl:when test=".='Italia'">Italy</xsl:when>
                <xsl:when test=".='Bolivia'">Bolivia</xsl:when>
                <xsl:when test=".='Uruguay'">Uruguay</xsl:when>
                <xsl:when test=".='desconocido'">unknown</xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-num-authors-active">
        <!-- for a range of years: get the number of authors that were active in each year.
        Active means: published a novel in that year, or before and after it.
        Only the first publication date of each novel is considered. -->
        <xsl:param name="years"/>
        <xsl:param name="authors"/>
        <!-- get years of activity for all authors -->
        <xsl:variable name="activity-years">
            <list xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each select="$authors">
                    <xsl:variable name="author-id" select="@xml:id"/>
                    <xsl:variable name="author-works" select="$bibacme-works[author/@key = $author-id]"/>
                    <xsl:variable name="first-edition-years" select="cligs:get-first-edition-years($author-works)"/>
                    <author xmlns="https://cligs.hypotheses.org/ns/cligs" id="{$author-id}">
                        <from xmlns="https://cligs.hypotheses.org/ns/cligs"><xsl:value-of select="min($first-edition-years)"/></from>
                        <to xmlns="https://cligs.hypotheses.org/ns/cligs"><xsl:value-of select="max($first-edition-years)"/></to>
                    </author>
                </xsl:for-each>
            </list>
        </xsl:variable>
        <xsl:for-each select="$years">
            <!-- check how many authors active -->
            <xsl:value-of select="count($activity-years//cligs:author[cligs:from &lt;= current() and current() &lt;= cligs:to])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-num-authors-active">
        <!-- 3 param-version of above function.
            For a certain year: 
            depending on the mode (before, after),
            get the number of authors that were active in before or in and after that year.
        Active means: published a novel in that year, or before and after it.
        Only the first publication date of each novel is considered. -->
        <xsl:param name="year"/>
        <xsl:param name="mode"/>
        <xsl:param name="authors"/>
        <!-- get years of activity for all authors -->
        <xsl:variable name="activity-years">
            <list xmlns="https://cligs.hypotheses.org/ns/cligs">
                <xsl:for-each select="$authors">
                    <xsl:variable name="author-id" select="@xml:id"/>
                    <xsl:variable name="author-works" select="$bibacme-works[author/@key = $author-id]"/>
                    <xsl:variable name="first-edition-years" select="cligs:get-first-edition-years($author-works)"/>
                    <author xmlns="https://cligs.hypotheses.org/ns/cligs" id="{$author-id}">
                        <from xmlns="https://cligs.hypotheses.org/ns/cligs"><xsl:value-of select="min($first-edition-years)"/></from>
                        <to xmlns="https://cligs.hypotheses.org/ns/cligs"><xsl:value-of select="max($first-edition-years)"/></to>
                    </author>
                </xsl:for-each>
            </list>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$mode='before'">
                <!-- check how many authors active before the year -->
                <xsl:value-of select="count($activity-years//cligs:author[cligs:from &lt; $year])"/>    
            </xsl:when>
            <xsl:when test="$mode='after'">
                <!-- check how many authors active in and after the year -->
                <xsl:value-of select="count($activity-years//cligs:author[cligs:from = $year or cligs:to &gt;= $year])"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="cligs:get-edition-country">
        <!-- get the country of an edition -->
        <xsl:param name="edition"/>
        <!-- if there are several, take the first one -->
        <xsl:variable name="country-short" select="$edition//pubPlace/@corresp/substring-after(.,'countries.xml#')"/>
        <!-- get the English name for the country  -->
        <xsl:variable name="country-name" select="cligs:map-country-name($country-short)"/>
        <xsl:value-of select="$country-name"/>
    </xsl:function>
    
    <xsl:function name="cligs:get-first-edition">
        <!-- get the first edition of a work -->
        <xsl:param name="work"/>
        <xsl:variable name="work-id" select="$work/@xml:id"/>
        <xsl:variable name="first-edition-year" select="cligs:get-first-edition-year($work)"/>
        <!-- if there are several editions in the same year, take the first one -->
        <xsl:variable name="first-edition" select="$bibacme-editions[substring-after(@corresp,'#') = $work-id][.//date[@when or @to]/xs:integer(substring(@when|@to,1,4)) = $first-edition-year][1]"/>
        <xsl:copy-of select="$first-edition"/>
    </xsl:function>
    
    <xsl:function name="cligs:get-first-edition-year">
        <!-- get the year of the first edition of a work -->
        <xsl:param name="work"/>
        <xsl:variable name="work-id" select="$work/@xml:id"/>
        <xsl:variable name="edition-year" select="$bibacme-editions[substring-after(@corresp,'#') = $work-id]//date[@when or @to]/xs:integer(substring(@when|@to,1,4))"/>
        <xsl:value-of select="min($edition-year)"/>
    </xsl:function>
    
    <xsl:function name="cligs:get-first-edition-years">
        <!-- get the years of the first edition of a set of works -->
        <xsl:param name="works"/>
        <xsl:for-each select="$works">
            <xsl:variable name="work-id" select="@xml:id"/>
            <xsl:variable name="edition-years" select="$bibacme-editions[substring-after(@corresp,'#') = $work-id]//date[@when or @to]/xs:integer(substring(@when|@to,1,4))"/>
            <xsl:value-of select="min($edition-years)"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-first-edition-countries">
        <!-- get the countries of the first edition of a set of works -->
        <xsl:param name="works"/>
        <xsl:for-each select="$works">
            <xsl:variable name="first-edition" select="cligs:get-first-edition(.)"/>
            <xsl:variable name="edition-country" select="cligs:get-edition-country($first-edition)"/>
            <xsl:value-of select="$edition-country"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-num-authors-alive">
        <!-- return the number of authors alive for each year -->
        <xsl:param name="years"/>
        <xsl:param name="authors"/>
        <xsl:for-each select="$years">
            <xsl:value-of select="count($authors[birth/date/@when/number(substring(.,1,4)) &lt;= current()][death/date/@when/number(substring(.,1,4)) > current()])"/>
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-num-authors-dead">
        <!-- return the number of authors that are already dead for each year -->
        <xsl:param name="years"/>
        <xsl:param name="authors"/>
        <xsl:for-each select="$years">
            <xsl:value-of select="count($authors[death/date/@when/number(substring(.,1,4)) &lt;= current()])"/>
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-num-authors-not-born">
        <!-- return the number of authors that were not yet born for each year -->
        <xsl:param name="years"/>
        <xsl:param name="authors"/>
        <xsl:for-each select="$years">
            <xsl:value-of select="count($authors[birth/date/@when/number(substring(.,1,4)) > current()])"/>
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-num-years">
        <!-- for a specified range of years (from-to):
            get the number a certain year in that range occurs in a data set of years.
            Return as a comma-separated list -->
        <xsl:param name="year-range"/>
        <xsl:param name="years"/>
        <xsl:for-each select="$year-range">
            <xsl:value-of select="count($years[.=current()])"/>
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-num-years">
        <!-- three parameter version of the above function. For a certain year (e.g. 1880):
        get the number of years before or in/after it (depending on the mode)-->
        <xsl:param name="year"/><!-- year to compare with -->
        <xsl:param name="years"/><!-- set of years to count -->
        <xsl:param name="mode"/><!-- before or after -->
        <xsl:choose>
            <xsl:when test="$mode='before'">
                <xsl:value-of select="count($years[. &lt; $year])"/>
            </xsl:when>
            <xsl:when test="$mode='after'">
                <xsl:value-of select="count($years[. >= $year])"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="cligs:get-num-decades">
        <!-- for a specified set of decades:
            get the number of years that fall into that decade.
            Return as a comma-separated list -->
        <xsl:param name="decades"/>
        <xsl:param name="years"/>
        <xsl:for-each select="$decades">
            <xsl:value-of select="count($years[.>=current() and .&lt;=(current() + 9)])"/>
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-editions-per-work">
        <!-- get the number of editions for each work in a set of works -->
        <xsl:param name="works"/>
        <xsl:for-each select="$works">
            <xsl:variable name="work-id" select="@xml:id"/>
            <xsl:variable name="editions" select="$bibacme-editions[substring-after(@corresp,'#') = $work-id]"/>
            <xsl:value-of select="count($editions)"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-per-label">
        <!-- get the number of works for each subgenre label -->
        <xsl:param name="works"/>
        <xsl:variable name="label-set" select="distinct-values($works//term[starts-with(@type,'subgenre.summary')]/normalize-space(.))"/>
        <xsl:for-each select="$label-set">
            <xsl:value-of select="count($works[.//term[starts-with(@type,'subgenre.summary')]/normalize-space(.) = current()])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-per-author-bib">
        <!-- get the number of works per author in Bib-ACMé -->
        <xsl:for-each select="$bibacme-authors">
            <xsl:variable name="author-id" select="@xml:id"/>
            <xsl:value-of select="count($bibacme-works[author/@key = $author-id])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-per-author-corp">
        <!-- get the number of works per author in Conha19 -->
        <xsl:for-each select="distinct-values($corpus//titleStmt/author/idno[@type='bibacme'])">
            <xsl:variable name="author-id" select="."/>
            <xsl:value-of select="count($corpus[.//titleStmt/author/idno[@type='bibacme'] = $author-id])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-by-decade">
        <!-- get the works that were first published in a certain decade -->
        <xsl:param name="decade"/>
        <xsl:param name="works"/><!-- set of works (Bib-ACMé or Conha19) -->
        <!-- return only the works that were first published in that decade -->
        <xsl:for-each select="$works">
            <xsl:variable name="pub-year" select="cligs:get-first-edition-year(.)"/>
            <xsl:if test="$pub-year >= $decade and $pub-year &lt;= ($decade + 9)">
                <xsl:copy-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-by-year">
        <!-- get the works that were first published before or in/after a certain year -->
        <xsl:param name="year"/>
        <xsl:param name="mode"/><!-- before or after -->
        <xsl:param name="works"/><!-- set of works (Bib-ACMé or Conha19) -->
        <!-- return only the works that were first published before or in/after that year -->
        <xsl:for-each select="$works">
            <xsl:variable name="pub-year" select="cligs:get-first-edition-year(.)"/>
            <xsl:choose>
                <xsl:when test="$mode = 'before'">
                    <xsl:if test="$pub-year &lt; $year">
                        <xsl:copy-of select="."/>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="$mode = 'after'">
                    <xsl:if test="$pub-year >= $year">
                        <xsl:copy-of select="."/>
                    </xsl:if>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-primary-subgenre">
        <!-- return a set of works which has a certain primary subgenre -->
        <xsl:param name="works"/><!-- a set of work entries -->
        <xsl:param name="label-type"/><!-- type of subgenre label, e.g. "theme" -->
        <xsl:param name="label-set"/><!-- the set of labels to look for, e.g. "novela histórica", "novela sentimental", "other" -->
        <xsl:param name="label"/><!-- the subgenre, e.g. "novela histórica", "other", "none" -->
        
        <xsl:for-each select="$works">
            <xsl:variable name="labels" select=".//term[starts-with(@type,concat('subgenre.summary.',$label-type))]"/>
            <xsl:variable name="num-labels" select="count($labels)"/>
            <xsl:variable name="primary-label">
                <xsl:choose>
                    <xsl:when test="$num-labels=1">
                        <xsl:choose>
                            <xsl:when test="normalize-space($labels)=$label-set">
                                <xsl:value-of select="normalize-space($labels)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>other</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$num-labels>1">
                        <xsl:choose>
                            <xsl:when test="$label-type='mode.representation'">
                                <xsl:choose>
                                    <xsl:when test="$labels[normalize-space(.)='novela']">
                                        <xsl:text>novela</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>other</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="$label-type='identity'">
                                <xsl:choose>
                                    <xsl:when test="$labels[normalize-space(.)='novela original']">
                                        <xsl:text>novela original</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>other</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="$labels[@cligs:importance='2']/normalize-space(.)=$label-set">
                                        <xsl:value-of select="$labels[@cligs:importance='2']/normalize-space(.)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>other</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$num-labels=0">
                        <xsl:text>none</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:if test="$primary-label = $label">
                <xsl:copy-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-primary-subgenre">
        <!-- return a set of works which has a certain primary subgenre, 5-param-version with label subtype -->
        <xsl:param name="works"/><!-- a set of work entries -->
        <xsl:param name="label-type"/><!-- type of subgenre label, e.g. "theme" -->
        <xsl:param name="label-subtype"/><!-- subtype of subgenre label, e.g. "novela americana" -->
        <xsl:param name="label-set"/><!-- the set of labels to look for, e.g. "novela histórica", "novela sentimental", "other" -->
        <xsl:param name="label"/><!-- the subgenre, e.g. "novela histórica", "other", "none" -->
        <xsl:variable name="novelas-americanas" select="('novela americana','novela mexicana','novela cubana','novela argentina','novela criolla','novela bonaerense','novela porteña','novela habanera','novela yucateca','novela suriana','novela tapatía','novela india','novela mixteca','novela de Tabasco','novela azteca','novela camagüeyana','novela kantabro-americana', 'novela franco-argentina')"/>
        <xsl:variable name="novelas-mexicanas" select="('novela mexicana','novela yucateca','novela suriana','novela tapatía','novela mixteca','novela de Tabasco','novela azteca')"/>
        <xsl:variable name="novelas-argentinas" select="('novela argentina','novela bonaerense','novela porteña','novela franco-argentina')"/>
        <xsl:variable name="novelas-cubanas" select="('novela cubana','novela habanera','novela camagüeyana')"/>
        
        <xsl:for-each select="$works">
            <xsl:variable name="labels" select=".//term[starts-with(@type,concat('subgenre.summary.',$label-type))]"/>
            <xsl:variable name="num-labels" select="count($labels)"/>
            <xsl:variable name="primary-label">
                <xsl:choose>
                    <xsl:when test="$num-labels=1">
                        <xsl:choose>
                            <xsl:when test="$label-subtype='novela americana'">
                                <xsl:choose>
                                    <xsl:when test="$labels[normalize-space(.)=$novelas-americanas]">
                                        <xsl:text>novela americana</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>other</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="$label-subtype='novela nacional'">
                                <xsl:choose>
                                    <xsl:when test="$labels[normalize-space(.)=$novelas-mexicanas]">
                                        <xsl:text>novela mexicana</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$labels[normalize-space(.)=$novelas-argentinas]">
                                        <xsl:text>novela argentina</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$labels[normalize-space(.)=$novelas-cubanas]">
                                        <xsl:text>novela cubana</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>other</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="normalize-space($labels)=$label-set">
                                        <xsl:value-of select="normalize-space($labels)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>other</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>        
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$num-labels>1">
                        <xsl:choose>
                            <xsl:when test="$label-type='mode.representation'">
                                <xsl:choose>
                                    <xsl:when test="$labels[normalize-space(.)='novela']">
                                        <xsl:text>novela</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>other</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="$label-type='identity'">
                                <xsl:choose>
                                    <xsl:when test="$label-subtype='novela americana'">
                                        <xsl:choose>
                                            <xsl:when test="$labels[normalize-space(.)=$novelas-americanas]">
                                                <xsl:text>novela americana</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>other</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:when test="$label-subtype='novela nacional'">
                                        <xsl:choose>
                                            <xsl:when test="$labels[normalize-space(.)=$novelas-mexicanas]">
                                                <xsl:text>novela mexicana</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="$labels[normalize-space(.)=$novelas-argentinas]">
                                                <xsl:text>novela argentina</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="$labels[normalize-space(.)=$novelas-cubanas]">
                                                <xsl:text>novela cubana</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>other</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$labels[normalize-space(.)=$label-subtype]">
                                                <xsl:value-of select="$label-subtype[1]"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>other</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="$labels[@cligs:importance='2']/normalize-space(.)=$label-set">
                                        <xsl:value-of select="$labels[@cligs:importance='2']/normalize-space(.)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>other</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$num-labels=0">
                        <xsl:text>none</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:if test="$primary-label = $label">
                <xsl:copy-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-explicit-subgenre">
        <!-- return a set of works which has a certain explicit subgenre -->
        <xsl:param name="works"/><!-- a set of work entries -->
        <xsl:param name="label-type"/><!-- type of subgenre label, e.g. "theme" -->
        <xsl:param name="label-set"/><!-- the set of labels to look for, e.g. "novela histórica", "novela de costumbres", "other" -->
        <xsl:param name="label"/><!-- the subgenre, e.g. "novela histórica", "other", "none" -->
        
        <xsl:for-each select="$works">
            <xsl:variable name="labels" select=".//term[@type = concat('subgenre.summary.',$label-type,'.explicit')]"/>
            <xsl:variable name="num-labels" select="count($labels)"/>
            <xsl:variable name="explicit-label">
                <xsl:choose>
                    <xsl:when test="$num-labels=1">
                        <xsl:choose>
                            <xsl:when test="normalize-space($labels)=$label-set">
                                <xsl:value-of select="normalize-space($labels)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>other</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$num-labels>1">
                        <xsl:choose>
                            <xsl:when test="$labels[normalize-space(.)='novela histórica'] and $labels[normalize-space(.)='novela de costumbres']">
                                <xsl:value-of select="$labels[normalize-space(.)=('novela histórica','novela de costumbres')][@cligs:importance='2']/normalize-space(.)"/>
                            </xsl:when>
                            <xsl:when test="$labels[normalize-space(.)='novela histórica']">
                                <xsl:text>novela histórica</xsl:text>
                            </xsl:when>
                            <xsl:when test="$labels[normalize-space(.)='novela de costumbres']">
                                <xsl:text>novela de costumbres</xsl:text>
                            </xsl:when>
                            <xsl:when test="$labels[@cligs:importance]">
                                <xsl:choose>
                                    <xsl:when test="$labels[@cligs:importance='2']/normalize-space(.)=$label-set">
                                        <xsl:value-of select="$labels[@cligs:importance='2']/normalize-space(.)"/>
                                    </xsl:when>
                                    <xsl:otherwise>other</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="$labels[1]/normalize-space(.)=$label-set">
                                        <xsl:value-of select="$labels[1]/normalize-space(.)"/>
                                    </xsl:when>
                                    <xsl:otherwise>other</xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$num-labels=0">
                        <xsl:text>none</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:if test="$explicit-label = $label">
                <xsl:copy-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-works-subgenre">
        <!-- return a set of works which has a certain subgenre -->
        <xsl:param name="works"/><!-- a set of work entries -->
        <xsl:param name="label-type"/><!-- type of subgenre label, e.g. "theme" -->
        <xsl:param name="label-set"/><!-- the set of labels to look for, e.g. "novela histórica", "novela sentimental", "other" -->
        <xsl:param name="label"/><!-- the subgenre, e.g. "novela histórica", "other", "none" -->
        
        <xsl:for-each select="$works">
            <xsl:variable name="curr-work" select="."/>
            <xsl:variable name="labels" select=".//term[starts-with(@type,concat('subgenre.summary.',$label-type))]"/>
            <xsl:variable name="num-labels" select="count($labels)"/>
            <xsl:variable name="labels-evaluated" as="node()+">
                <xsl:choose>
                    <xsl:when test="$num-labels=1">
                        <xsl:choose>
                            <xsl:when test="normalize-space($labels)=$label-set">
                                <xsl:value-of select="normalize-space($labels)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>other</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$num-labels>1">
                        <xsl:for-each select="distinct-values($labels)">
                            <xsl:choose>
                                <xsl:when test="normalize-space(.)=$label-set">
                                    <xsl:value-of select="normalize-space(.)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>other</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="$num-labels=0">
                        <xsl:text>none</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:for-each select="$labels-evaluated">
                <xsl:if test=". = $label">
                    <xsl:copy-of select="$curr-work"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-author-gender-bib">
        <xsl:param name="gender"/>
        <xsl:value-of select="count($bibacme-authors[sex=$gender])"/>
    </xsl:function>
    
    <xsl:function name="cligs:get-author-gender-corp">
        <xsl:param name="gender"/>
        <xsl:variable name="corpus-authors" select="distinct-values($corpus//titleStmt/author/idno[@type='bibacme'])"/>
        <xsl:value-of select="count($bibacme-authors[sex=$gender][@xml:id=$corpus-authors])"/>
    </xsl:function>
    
    <xsl:function name="cligs:get-editions-per-author-bib">
        <!-- get the number of editions per author in Bib-ACMé -->
        <xsl:for-each select="$bibacme-authors">
            <xsl:variable name="author-id" select="@xml:id"/>
            <xsl:value-of select="count($bibacme-editions[.//author/@key = $author-id])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-editions-per-author-corp">
        <!-- get the number of editions per author in Conha19 -->
        <xsl:for-each select="$corpus-authors">
            <xsl:variable name="author-id" select="@xml:id"/>
            <xsl:variable name="corpus-works" select="$bibacme-works[idno[@type='cligs']]/@xml:id"/>
            <xsl:value-of select="count($bibacme-editions[.//author/@key = $author-id][substring-after(@corresp,'#')=$corpus-works])"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="cligs:get-edition-years">
        <!-- return the years of the editions of a set of works -->
        <xsl:param name="works"/>
        <xsl:for-each select="$works">
            <xsl:variable name="work-id" select="@xml:id"/>
            <xsl:variable name="editions" select="$bibacme-editions[substring-after(@corresp,'#') = $work-id]"/>
            <!-- if the edition has a year, return it -->
            <xsl:for-each select="$editions">
                <xsl:if test=".//date[@when|@to]">
                    <!-- if there are several dates, take the last one -->
                    <xsl:value-of select="substring(.//date[last()]/(@when|@to),1,4)"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:function>
    
</xsl:stylesheet>