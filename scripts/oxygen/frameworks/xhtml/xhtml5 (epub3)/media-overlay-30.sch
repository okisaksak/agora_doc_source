<?xml version="1.0" encoding="UTF-8"?><schema xmlns="http://purl.oclc.org/dsdl/schematron">
          
    <ns uri="http://www.idpf.org/2007/ops" prefix="epub"/>
    <ns uri="http://www.w3.org/ns/SMIL" prefix="s"/>
          
    <pattern id="id-unique">
    <!-- note: assumes that NCName lexical constraints are tested elsewhere -->
    <let name="id-set" value="//*[@id]"/>
    <rule context="*[@id]">
        <assert test="count($id-set[normalize-space(@id) = normalize-space(current()/@id)]) = 1">Duplicate '<value-of select="normalize-space(current()/@id)"/>'</assert>
    </rule>
</pattern>     
            
</schema>