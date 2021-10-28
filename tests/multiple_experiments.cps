<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.31.243+ (Source) (http://www.copasi.org) at 2021-10-27T13:38:49Z -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="31" versionDevel="243" copasiSourcesModified="1">
  <Model key="Model_2" name="multiple_experiments" simulationType="time" timeUnit="min" volumeUnit="ml" areaUnit="m²" lengthUnit="m" quantityUnit="mmol" type="deterministic" avogadroConstant="6.0221408570000002e+23">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Model_2">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2021-10-27T13:36:08Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <ListOfCompartments>
      <Compartment key="Compartment_1" name="compartment" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Compartment_1">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_5" name="PG" simulationType="ode" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_5">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E],Reference=Concentration>/(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4b],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_p],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>)
        </Expression>
      </Metabolite>
      <Metabolite key="Metabolite_6" name="E" simulationType="assignment" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_6">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0],Reference=Concentration>*exp(-&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_d],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Reference=Time>)/(1+&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>^2/(&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>)+&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/(&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>))*(1+&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>)+&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_p],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_pg],Reference=Value>)
        </Expression>
      </Metabolite>
      <Metabolite key="Metabolite_7" name="7-ADCA" simulationType="ode" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_7">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <Expression>
          -1*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E],Reference=Concentration>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>-&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E],Reference=Concentration>/(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4b],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_p],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>))
        </Expression>
      </Metabolite>
      <Metabolite key="Metabolite_8" name="PGME" simulationType="ode" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_8">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <Expression>
          -1*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E],Reference=Concentration>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>-&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E],Reference=Concentration>/(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4b],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_p],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>)+&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E],Reference=Concentration>/(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4b],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_p],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>))
        </Expression>
      </Metabolite>
      <Metabolite key="Metabolite_9" name="CEX" simulationType="ode" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_9">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E],Reference=Concentration>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>-&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E],Reference=Concentration>/(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_4b],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_p],Reference=Value>)*(&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=Value>+&lt;CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=Value>*&lt;CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration>/&lt;CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=Value>)
        </Expression>
      </Metabolite>
      <Metabolite key="Metabolite_10" name="E0" simulationType="fixed" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_10">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_0" name="K_s" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_0">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_1" name="k_2" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_1">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_2" name="K_n" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_2">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_3" name="k_3" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_3">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_4" name="k_4" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_4">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_5" name="k_5" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_5">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_6" name="k_6" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_6">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_7" name="K_si" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_7">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_8" name="K_p" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_8">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_9" name="k_4b" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_9">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_10" name="k_d" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_10">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_11" name="K_pg" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_11">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
    </ListOfModelValues>
    <ListOfModelParameterSets activeSet="ModelParameterSet_6">
      <ModelParameterSet key="ModelParameterSet_6" name="Initial State">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_6">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.2044281714e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0986712244889559e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="6.0221408570000005e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_7" name="PE: 2021-10-27T13:36:10Z Exp: Original">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_7">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="4.5045518105824969e+19" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="2.4088563428000002e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="14" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="432" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="290" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="417" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="73600" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="491" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1660" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="20" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="39" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="9126" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.00064300000000000002" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="12" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_8" name="PE: 2021-10-27T13:36:10Z Exp: OdeExperiment_0">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_8">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.2044281714e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0986712244889559e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="6.0221408570000005e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_9" name="PE: 2021-10-27T13:36:10Z Exp: OdeExperiment_1">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_9">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="7.8287831141000007e+20" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0947852806466879e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_10" name="PE: 2021-10-27T13:36:10Z Exp: OdeExperiment_2">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_10">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="3.07129183707e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0762554846912623e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="2.4088563428000002e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_11" name="PE: 2021-10-27T13:36:10Z Exp: OdeExperiment_3">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_11">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.14420676283e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.062856900929109e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="3.6132845142000003e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_12" name="PE: 2021-10-27T13:36:10Z Exp: Original (1)">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_12">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.2044281714e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0986712244889559e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="6.0221408570000005e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_13" name="PE: 2021-10-27T13:36:10Z Exp: OdeExperiment_0 (1)">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_13">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.2044281714e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0986712244889559e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="6.0221408570000005e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_14" name="PE: 2021-10-27T13:36:10Z Exp: OdeExperiment_1 (1)">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_14">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="7.8287831141000007e+20" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0947852806466879e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_15" name="PE: 2021-10-27T13:36:10Z Exp: OdeExperiment_2 (1)">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_15">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="3.07129183707e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0762554846912623e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="2.4088563428000002e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_16" name="PE: 2021-10-27T13:36:10Z Exp: OdeExperiment_3 (1)">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_16">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.14420676283e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.062856900929109e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="3.6132845142000003e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_17" name="PE: 2021-10-27T13:36:12Z Exp: Original">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_17">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.2044281714e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0986712244889559e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="6.0221408570000005e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_18" name="PE: 2021-10-27T13:36:12Z Exp: OdeExperiment_0">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_18">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.2044281714e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0986712244889559e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="6.0221408570000005e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_19" name="PE: 2021-10-27T13:36:12Z Exp: OdeExperiment_1">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_19">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="7.8287831141000007e+20" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0947852806466879e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_20" name="PE: 2021-10-27T13:36:12Z Exp: OdeExperiment_2">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_20">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="3.07129183707e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.0762554846912623e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="2.4088563428000002e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_21" name="PE: 2021-10-27T13:36:12Z Exp: OdeExperiment_3">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_21">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG]" value="1.14420676283e+21" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E]" value="1.062856900929109e+20" type="Species" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA]" value="3.6132845142000003e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME]" value="1.2044281714000001e+22" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX]" value="0" type="Species" simulationType="ode"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[E0]" value="1.2044281714000001e+20" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_s]" value="145.06072648084185" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_2]" value="190.44531023948733" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_n]" value="995.04801240345819" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_3]" value="544.05473871624145" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4]" value="61312.816248040937" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_5]" value="3343.0326423271022" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_6]" value="1392.7989784089202" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_si]" value="43.757590523654216" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_p]" value="559.58906368071735" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_4b]" value="454.50370018911059" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[k_d]" value="0.010000000000000222" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=multiple_experiments,Vector=Values[K_pg]" value="931.64780626573395" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_2"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Compartment_1"/>
      <StateTemplateVariable objectReference="ModelValue_0"/>
      <StateTemplateVariable objectReference="ModelValue_1"/>
      <StateTemplateVariable objectReference="ModelValue_2"/>
      <StateTemplateVariable objectReference="ModelValue_3"/>
      <StateTemplateVariable objectReference="ModelValue_4"/>
      <StateTemplateVariable objectReference="ModelValue_5"/>
      <StateTemplateVariable objectReference="ModelValue_6"/>
      <StateTemplateVariable objectReference="ModelValue_7"/>
      <StateTemplateVariable objectReference="ModelValue_8"/>
      <StateTemplateVariable objectReference="ModelValue_9"/>
      <StateTemplateVariable objectReference="ModelValue_10"/>
      <StateTemplateVariable objectReference="ModelValue_11"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 1.2044281714e+21 6.0221408570000005e+21 1.2044281714000001e+22 0 1.0986712244889559e+20 1.2044281714000001e+20 1 145.06072648084185 190.44531023948733 995.04801240345819 544.05473871624145 61312.816248040937 3343.0326423271022 1392.7989784089202 43.757590523654216 559.58906368071735 454.50370018911059 0.010000000000000222 931.64780626573395 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_29" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_22" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="JacobianRequested" type="bool" value="1"/>
        <Parameter name="StabilityAnalysisRequested" type="bool" value="1"/>
      </Problem>
      <Method name="Enhanced Newton" type="EnhancedNewton">
        <Parameter name="Resolution" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Derivation Factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Use Newton" type="bool" value="1"/>
        <Parameter name="Use Integration" type="bool" value="1"/>
        <Parameter name="Use Back Integration" type="bool" value="0"/>
        <Parameter name="Accept Negative Concentrations" type="bool" value="0"/>
        <Parameter name="Iteration Limit" type="unsignedInteger" value="50"/>
        <Parameter name="Maximum duration for forward integration" type="unsignedFloat" value="1000000000"/>
        <Parameter name="Maximum duration for backward integration" type="unsignedFloat" value="1000000"/>
        <Parameter name="Target Criterion" type="string" value="Distance and Rate"/>
      </Method>
    </Task>
    <Task key="Task_30" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Report reference="Report_23" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.29999999999999999"/>
        <Parameter name="Duration" type="float" value="30"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
        <Parameter name="Use Values" type="bool" value="0"/>
        <Parameter name="Values" type="string" value=""/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="100000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_31" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="1"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
        <Parameter name="Continue on Error" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_32" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_24" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_33" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_25" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Subtask" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <ParameterText name="ObjectiveExpression" type="expression">
          
        </ParameterText>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
      </Problem>
      <Method name="Random Search" type="RandomSearch">
        <Parameter name="Log Verbosity" type="unsignedInteger" value="0"/>
        <Parameter name="Number of Iterations" type="unsignedInteger" value="100000"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_34" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="true">
      <Report reference="Report_26" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[K_s],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000.0"/>
            <Parameter name="StartValue" type="float" value="145.06072648084185"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[k_2],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000000.0"/>
            <Parameter name="StartValue" type="float" value="190.44531023948733"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[K_n],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000.0"/>
            <Parameter name="StartValue" type="float" value="995.04801240345819"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[k_3],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000000.0"/>
            <Parameter name="StartValue" type="float" value="544.05473871624145"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[k_4],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000000.0"/>
            <Parameter name="StartValue" type="float" value="61312.816248040937"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[k_5],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000000.0"/>
            <Parameter name="StartValue" type="float" value="3343.0326423271022"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[k_6],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000000.0"/>
            <Parameter name="StartValue" type="float" value="1392.7989784089202"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[K_si],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000.0"/>
            <Parameter name="StartValue" type="float" value="43.757590523654216"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[K_p],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000.0"/>
            <Parameter name="StartValue" type="float" value="559.58906368071735"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[k_4b],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000000.0"/>
            <Parameter name="StartValue" type="float" value="454.50370018911059"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[k_d],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000000.0"/>
            <Parameter name="StartValue" type="float" value="0.010000000000000222"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Values[K_pg],Reference=InitialValue"/>
            <Parameter name="LowerBound" type="cn" value="0.01"/>
            <Parameter name="UpperBound" type="cn" value="1000.0"/>
            <Parameter name="StartValue" type="float" value="931.64780626573395"/>
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <ParameterGroup name="Affected Cross Validation Experiments">
            </ParameterGroup>
          </ParameterGroup>
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
        <Parameter name="Steady-State" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <Parameter name="Time-Course" type="cn" value="CN=Root,Vector=TaskList[Time-Course]"/>
        <Parameter name="Create Parameter Sets" type="bool" value="0"/>
        <Parameter name="Use Time Sens" type="bool" value="0"/>
        <Parameter name="Time-Sens" type="cn" value=""/>
        <ParameterGroup name="Experiment Set">
          <ParameterGroup name="OdeExperiment_0">
            <Parameter name="Key" type="key" value="Experiment_2"/>
            <Parameter name="File Name" type="file" value="OdeExperiment_0.txt"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Last Row" type="unsignedInteger" value="11"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Separator" type="string" value="&#x09;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="8"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=InitialConcentration"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=InitialConcentration"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=InitialConcentration"/>
              </ParameterGroup>
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="OdeExperiment_1">
            <Parameter name="Key" type="key" value="Experiment_3"/>
            <Parameter name="File Name" type="file" value="OdeExperiment_1.txt"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Last Row" type="unsignedInteger" value="11"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Separator" type="string" value="&#x09;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="8"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=InitialConcentration"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=InitialConcentration"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=InitialConcentration"/>
              </ParameterGroup>
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="OdeExperiment_2">
            <Parameter name="Key" type="key" value="Experiment_4"/>
            <Parameter name="File Name" type="file" value="OdeExperiment_2.txt"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Last Row" type="unsignedInteger" value="11"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Separator" type="string" value="&#x09;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="8"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=InitialConcentration"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=InitialConcentration"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=InitialConcentration"/>
              </ParameterGroup>
            </ParameterGroup>
          </ParameterGroup>
          <ParameterGroup name="OdeExperiment_3">
            <Parameter name="Key" type="key" value="Experiment_5"/>
            <Parameter name="File Name" type="file" value="OdeExperiment_3.txt"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Last Row" type="unsignedInteger" value="11"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Separator" type="string" value="&#x09;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="8"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[CEX],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Role" type="unsignedInteger" value="2"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=Concentration"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PG],Reference=InitialConcentration"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[7-ADCA],Reference=InitialConcentration"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Role" type="unsignedInteger" value="1"/>
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=multiple_experiments,Vector=Compartments[compartment],Vector=Metabolites[PGME],Reference=InitialConcentration"/>
              </ParameterGroup>
            </ParameterGroup>
          </ParameterGroup>
        </ParameterGroup>
        <ParameterGroup name="Validation Set">
          <Parameter name="Weight" type="unsignedFloat" value="1"/>
          <Parameter name="Threshold" type="unsignedInteger" value="5"/>
        </ParameterGroup>
      </Problem>
      <Method name="Current Solution Statistics" type="CurrentSolutionStatistics">
        <Parameter name="Log Verbosity" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_35" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_27" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_29"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Use Reder" type="bool" value="1"/>
        <Parameter name="Use Smallbone" type="bool" value="1"/>
      </Method>
    </Task>
    <Task key="Task_36" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_28" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="ExponentNumber" type="unsignedInteger" value="3"/>
        <Parameter name="DivergenceRequested" type="bool" value="1"/>
        <Parameter name="TransientTime" type="float" value="0"/>
      </Problem>
      <Method name="Wolf Method" type="WolfMethod">
        <Parameter name="Orthonormalization Interval" type="unsignedFloat" value="1"/>
        <Parameter name="Overall time" type="unsignedFloat" value="1000"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_37" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_29" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
      </Problem>
      <Method name="ILDM (LSODA,Deuflhard)" type="TimeScaleSeparation(ILDM,Deuflhard)">
        <Parameter name="Deuflhard Tolerance" type="unsignedFloat" value="0.0001"/>
      </Method>
    </Task>
    <Task key="Task_38" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_30" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="SubtaskType" type="unsignedInteger" value="1"/>
        <ParameterGroup name="TargetFunctions">
          <Parameter name="SingleObject" type="cn" value=""/>
          <Parameter name="ObjectListType" type="unsignedInteger" value="7"/>
        </ParameterGroup>
        <ParameterGroup name="ListOfVariables">
          <ParameterGroup name="Variables">
            <Parameter name="SingleObject" type="cn" value=""/>
            <Parameter name="ObjectListType" type="unsignedInteger" value="41"/>
          </ParameterGroup>
          <ParameterGroup name="Variables">
            <Parameter name="SingleObject" type="cn" value=""/>
            <Parameter name="ObjectListType" type="unsignedInteger" value="0"/>
          </ParameterGroup>
        </ParameterGroup>
      </Problem>
      <Method name="Sensitivities Method" type="SensitivitiesMethod">
        <Parameter name="Delta factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Delta minimum" type="unsignedFloat" value="9.9999999999999998e-13"/>
      </Method>
    </Task>
    <Task key="Task_39" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Report reference="Report_31" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_40" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
        <Parameter name="Use Values" type="bool" value="0"/>
        <Parameter name="Values" type="string" value=""/>
        <Parameter name="LimitCrossings" type="bool" value="0"/>
        <Parameter name="NumCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitOutTime" type="bool" value="0"/>
        <Parameter name="LimitOutCrossings" type="bool" value="0"/>
        <Parameter name="PositiveDirection" type="bool" value="1"/>
        <Parameter name="NumOutCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitUntilConvergence" type="bool" value="0"/>
        <Parameter name="ConvergenceTolerance" type="float" value="9.9999999999999995e-07"/>
        <Parameter name="Threshold" type="float" value="0"/>
        <Parameter name="DelayOutputUntilConvergence" type="bool" value="0"/>
        <Parameter name="OutputConvergenceTolerance" type="float" value="9.9999999999999995e-07"/>
        <ParameterText name="TriggerExpression" type="expression">
          
        </ParameterText>
        <Parameter name="SingleVariable" type="cn" value=""/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="100000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_41" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_32" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_29"/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
    <Task key="Task_42" name="Time-Course Sensitivities" type="timeSensitivities" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
        <Parameter name="Use Values" type="bool" value="0"/>
        <Parameter name="Values" type="string" value=""/>
        <ParameterGroup name="ListOfParameters">
        </ParameterGroup>
        <ParameterGroup name="ListOfTargets">
        </ParameterGroup>
      </Problem>
      <Method name="LSODA Sensitivities" type="Sensitivities(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_22" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_23" name="Time-Course" taskType="timeCourse" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Time-Course],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Time-Course],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_24" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_25" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Object=Description"/>
        <Object cn="String=\[Function Evaluations\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Value\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Parameters\]"/>
      </Header>
      <Body>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Function Evaluations"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Value"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Parameters"/>
      </Body>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_26" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Object=Description"/>
        <Object cn="String=\[Function Evaluations\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Value\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Parameters\]"/>
      </Header>
      <Body>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Function Evaluations"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Value"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Parameters"/>
      </Body>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_27" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_28" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_29" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_30" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_31" name="Moieties" taskType="moieties" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Moieties],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Moieties],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_32" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Linear Noise Approximation],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Linear Noise Approximation],Object=Result"/>
      </Footer>
    </Report>
  </ListOfReports>
  <ListOfUnitDefinitions>
    <UnitDefinition key="Unit_1" name="meter" symbol="m">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Unit_0">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        m
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_5" name="second" symbol="s">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Unit_4">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        s
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_13" name="Avogadro" symbol="Avogadro">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Unit_12">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Avogadro
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_17" name="item" symbol="#">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Unit_16">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        #
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_35" name="liter" symbol="l">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Unit_34">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        0.001*m^3
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_41" name="mole" symbol="mol">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Unit_40">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Avogadro*#
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_65" name="minute" symbol="min">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Unit_64">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        60*s
      </Expression>
    </UnitDefinition>
  </ListOfUnitDefinitions>
</COPASI>
