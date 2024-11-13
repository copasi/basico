<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.44 (Build 293) (http://www.copasi.org) at 2024-11-13T13:34:34Z -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="44" versionDevel="293" copasiSourcesModified="0">
  <ListOfFunctions>
    <Function key="Function_13" name="Mass action (irreversible)" type="MassAction" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
   <rdf:Description rdf:about="#Function_13">
   <CopasiMT:is rdf:resource="urn:miriam:obo.sbo:SBO:0000163" />
   </rdf:Description>
   </rdf:RDF>
      </MiriamAnnotation>
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
<b>Mass action rate law for irreversible reactions</b>
<p>
Reaction scheme where the products are created from the reactants and the change of a product quantity is proportional to the product of reactant activities. The reaction scheme does not include any reverse process that creates the reactants from the products. The change of a product quantity is proportional to the quantity of one reactant.
</p>
</body>
      </Comment>
      <Expression>
        k1*PRODUCT&lt;substrate_i>
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_80" name="k1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_81" name="substrate" order="1" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_41" name="Function for binding of RAF and RAFK" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_41">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a1*RAF*(RAFK*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_266" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_276" name="RAF" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_277" name="RAFK" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_278" name="a1" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_42" name="Function for binding of RAF-P and RAF phosphatase" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_42">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a2*RAFp*(RAFPH*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_287" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_288" name="RAFPH" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_289" name="RAFp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_290" name="a2" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_43" name="Function for binding of MEK and RAF-P" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_43">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a3*MEK*(RAFp*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_299" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_300" name="MEK" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_301" name="RAFp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_302" name="a3" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_44" name="Function for binding of MEK-P and MEK phosphatase" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_44">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a4*MEKp*(MEKPH*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_311" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_312" name="MEKPH" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_313" name="MEKp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_314" name="a4" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_45" name="Function for binding of MEK-P and RAF-P" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_45">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a5*MEKp*(RAFp*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_323" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_324" name="MEKp" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_325" name="RAFp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_326" name="a5" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_46" name="Function for binding of MEK-PP and MEK phosphatase" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_46">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a6*MEKPH*(MEKpp*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_335" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_336" name="MEKPH" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_337" name="MEKpp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_338" name="a6" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_47" name="Function for binding of MAPK and MEK-PP" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_47">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a7*MAPK*(MEKpp*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_347" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_348" name="MAPK" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_349" name="MEKpp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_350" name="a7" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="Function for binding of MAPK-P and MAPK phosphatase" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_48">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a8*MAPKp*(MAPKPH*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_359" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_360" name="MAPKPH" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_361" name="MAPKp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_362" name="a8" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="Function for binding of MAPK-P and MEK-PP" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_49">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a9*MAPKp*(MEKpp*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_371" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_372" name="MAPKp" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_373" name="MEKpp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_374" name="a9" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="Function for binding of MAPK-PP and MAPK phosphatase" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_50">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        a10*MAPKPH*(MAPKpp*Cytoplasm)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_383" name="Cytoplasm" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_384" name="MAPKPH" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_385" name="MAPKpp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_386" name="a10" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_0" name="Levchenko2000_MAPK_noScaffold" simulationType="time" timeUnit="s" volumeUnit="l" areaUnit="m²" lengthUnit="m" quantityUnit="µmol" type="deterministic" avogadroConstant="6.0221407599999999e+23">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:bqmodel="http://biomodels.net/model-qualifiers/"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:vCard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <rdf:Description rdf:about="#Model_0">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/mamo/MAMO_0000046"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <bqbiol:hasTaxon>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/taxonomy/8355"/>
      </rdf:Bag>
    </bqbiol:hasTaxon>
    <bqmodel:isDerivedFrom>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.db/BIOMD0000000009"/>
        <rdf:li rdf:resource="http://identifiers.org/pubmed/6501300"/>
        <rdf:li rdf:resource="http://identifiers.org/pubmed/6947258"/>
      </rdf:Bag>
    </bqmodel:isDerivedFrom>
    <dcterms:bibliographicCitation>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/10823939"/>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:bibliographicCitation>
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2005-02-15T00:12:30Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <dcterms:creator>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <vCard:EMAIL>bshapiro@jpl.nasa.gov</vCard:EMAIL>
            <vCard:N>
              <rdf:Description>
                <vCard:Family>Shapiro</vCard:Family>
                <vCard:Given>Bruce</vCard:Given>
              </rdf:Description>
            </vCard:N>
            <vCard:ORG>
              <rdf:Description>
                <vCard:Orgname>NASA Jet Propulsion Laboratory</vCard:Orgname>
              </rdf:Description>
            </vCard:ORG>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:creator>
    <dcterms:modified>
      <rdf:Description>
        <dcterms:W3CDTF>2013-06-03T13:36:09Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:modified>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.db/MODEL6615234250"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.db/BIOMD0000000011"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_634"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0000165"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <Comment>
      
  <body xmlns="http://www.w3.org/1999/xhtml">
    <h1>MAPK cascade in solution (no scaffold)</h1>
    <table border="0" cellpadding="2" cellspacing="0">
      <thead>
        <tr>
          <th align="left" bgcolor="#eeeeee" valign="middle">Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>This model describes a basic 3-
							stage Mitogen Activated Protein Kinase (MAPK)
							 cascade in solution. This cascade is typically expressed as RAF=
							=&gt;MEK==&gt;MAPK (alternative forms are K3==&gt;K2==&gt;
							K1 and KKK==&gt;KK==&gt;K)
							. The input signal is RAFK (RAF Kinase)
							 and the output signal is MAPKpp (
							doubly phosphorylated form of MAPK)
							.  RAFK phosphorylates RAF once to RAFp.  RAFp,
							 the phosphorylated form of RAF induces two phoshporylations of MEK,
							to MEKp and MEKpp. MEKpp,
							 the doubly phosphorylated form of MEK,
							 induces two phosphorylations of MAPK to MAPKp and MAPKpp.</td>
        </tr>
      </tbody>
    </table>
    <table border="0" cellpadding="2" cellspacing="0">
      <thead>
        <tr>
          <th align="left" bgcolor="#eeeeee" valign="middle">Rate constant      </th>
          <th align="left" bgcolor="#eeeeee" valign="middle">Reaction</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>a10 = 5.</td>
          <td>MAPKPH + MAPKpp -&gt; MAPKppMAPKPH</td>
        </tr>
        <tr>
          <td>a1 = 1.</td>
          <td>RAF + RAFK -&gt; RAFRAFK</td>
        </tr>
        <tr>
          <td>a2 = 0.5</td>
          <td>RAFp + RAFPH -&gt; RAFpRAFPH</td>
        </tr>
        <tr>
          <td>a3 = 3.3</td>
          <td>MEK + RAFp -&gt; MEKRAFp</td>
        </tr>
        <tr>
          <td>a4 = 10.</td>
          <td>MEKp + MEKPH -&gt; MEKpMEKPH</td>
        </tr>
        <tr>
          <td>a5 = 3.3</td>
          <td>MEKp + RAFp -&gt; MEKpRAFp</td>
        </tr>
        <tr>
          <td>a6 = 10.</td>
          <td>MEKPH + MEKpp -&gt; MEKppMEKPH</td>
        </tr>
        <tr>
          <td>a7 = 20.</td>
          <td>MAPK + MEKpp -&gt; MAPKMEKpp</td>
        </tr>
        <tr>
          <td>a8 = 5.</td>
          <td>MAPKp + MAPKPH -&gt; MAPKpMAPKPH</td>
        </tr>
        <tr>
          <td>a9 = 20.</td>
          <td>MAPKp + MEKpp -&gt; MAPKpMEKpp</td>
        </tr>
        <tr>
          <td>d10 = 0.4</td>
          <td>MAPKppMAPKPH -&gt; MAPKPH + MAPKpp</td>
        </tr>
        <tr>
          <td>d1 = 0.4</td>
          <td>RAFRAFK -&gt; RAF + RAFK</td>
        </tr>
        <tr>
          <td>d2 = 0.5</td>
          <td>RAFpRAFPH -&gt; RAFp + RAFPH</td>
        </tr>
        <tr>
          <td>d3 = 0.42</td>
          <td>MEKRAFp -&gt; MEK + RAFp</td>
        </tr>
        <tr>
          <td>d4 = 0.8</td>
          <td>MEKpMEKPH -&gt; MEKp + MEKPH</td>
        </tr>
        <tr>
          <td>d5 = 0.4</td>
          <td>MEKpRAFp -&gt; MEKp + RAFp</td>
        </tr>
        <tr>
          <td>d6 = 0.8</td>
          <td>MEKppMEKPH -&gt; MEKPH + MEKpp</td>
        </tr>
        <tr>
          <td>d7 = 0.6</td>
          <td>MAPKMEKpp -&gt; MAPK + MEKpp</td>
        </tr>
        <tr>
          <td>d8 = 0.4</td>
          <td>MAPKpMAPKPH -&gt; MAPKp + MAPKPH</td>
        </tr>
        <tr>
          <td>d9 = 0.6</td>
          <td>MAPKpMEKpp -&gt; MAPKp + MEKpp</td>
        </tr>
        <tr>
          <td>k10 = 0.1</td>
          <td>MAPKppMAPKPH -&gt; MAPKp + MAPKPH</td>
        </tr>
        <tr>
          <td>k1 = 0.1</td>
          <td>RAFRAFK -&gt; RAFK + RAFp</td>
        </tr>
        <tr>
          <td>k2 = 0.1</td>
          <td>RAFpRAFPH -&gt; RAF + RAFPH</td>
        </tr>
        <tr>
          <td>k3 = 0.1</td>
          <td>MEKRAFp -&gt; MEKp + RAFp</td>
        </tr>
        <tr>
          <td>k4 = 0.1</td>
          <td>MEKpMEKPH -&gt; MEK + MEKPH</td>
        </tr>
        <tr>
          <td>k5 = 0.1</td>
          <td>MEKpRAFp -&gt; MEKpp + RAFp</td>
        </tr>
        <tr>
          <td>k6 = 0.1</td>
          <td>MEKppMEKPH -&gt; MEKp + MEKPH</td>
        </tr>
        <tr>
          <td>k7 = 0.1</td>
          <td>MAPKMEKpp -&gt; MAPKp + MEKpp</td>
        </tr>
        <tr>
          <td>k8 = 0.1</td>
          <td>MAPKpMAPKPH -&gt; MAPK + MAPKPH</td>
        </tr>
        <tr>
          <td>k9 = 0.1</td>
          <td>MAPKpMEKpp -&gt; MAPKpp + MEKpp</td>
        </tr>
      </tbody>
    </table>
    <table border="0" cellpadding="2" cellspacing="0">
      <thead>
        <tr>
          <th align="left" bgcolor="#eeeeee" valign="middle">Variable</th>
          <th align="left" bgcolor="#eeeeee" valign="middle">IC  </th>
          <th align="left" bgcolor="#eeeeee" valign="middle">ODE</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>MAPK</td>
          <td>0.3</td>
          <td>MAPK&apos;[t] == d7*MAPKMEKpp[t] + k8*MAPKpMAPKPH[t] -
							 a7*MAPK[t]*MEKpp[t]</td>
        </tr>
        <tr>
          <td>MAPKMEKpp</td>
          <td>0</td>
          <td>MAPKMEKpp&apos;[t] == -(d7*MAPKMEKpp[t]) - k7*MAPKMEKpp[t]
							 + a7*MAPK[t]*MEKpp[t]</td>
        </tr>
        <tr>
          <td>MAPKp</td>
          <td>0</td>
          <td>MAPKp&apos;[t] == k7*MAPKMEKpp[t] - a8*MAPKp[t]*MAPKPH[t]
							 + d8*MAPKpMAPKPH[t] + d9*MAPKpMEKpp[t] + k10*
							MAPKppMAPKPH[t] - a9*MAPKp[t]*MEKpp[t]</td>
        </tr>
        <tr>
          <td>MAPKPH</td>
          <td>0.3</td>
          <td>MAPKPH&apos;[t] == -(a8*MAPKp[t]*MAPKPH[t]) + d8*MAPKpMAPKPH[
							t] + k8*MAPKpMAPKPH[t] - a10*MAPKPH[t]*MAPKpp[t] +
							 d10*MAPKppMAPKPH[t] + k10*MAPKppMAPKPH[t]</td>
        </tr>
        <tr>
          <td>MAPKpMAPKPH</td>
          <td>0</td>
          <td>MAPKpMAPKPH&apos;[t] == a8*MAPKp[t]*MAPKPH[t] - d8*
							MAPKpMAPKPH[t] - k8*MAPKpMAPKPH[t]</td>
        </tr>
        <tr>
          <td>MAPKpMEKpp</td>
          <td>0</td>
          <td>MAPKpMEKpp&apos;[t] == -(d9*MAPKpMEKpp[t]) - k9*MAPKpMEKpp[t]
							 + a9*MAPKp[t]*MEKpp[t]</td>
        </tr>
        <tr>
          <td>MAPKpp</td>
          <td>0</td>
          <td>MAPKpp&apos;[t] == k9*MAPKpMEKpp[t] - a10*MAPKPH[t]*MAPKpp[t]
							 + d10*MAPKppMAPKPH[t]</td>
        </tr>
        <tr>
          <td>MAPKppMAPKPH</td>
          <td>0</td>
          <td>MAPKppMAPKPH&apos;[t] == a10*MAPKPH[t]*MAPKpp[t] - d10*
							MAPKppMAPKPH[t] - k10*MAPKppMAPKPH[t]</td>
        </tr>
        <tr>
          <td>MEK</td>
          <td>0.2</td>
          <td>MEK&apos;[t] == k4*MEKpMEKPH[t] + d3*MEKRAFp[t] -
							 a3*MEK[t]*RAFp[t]</td>
        </tr>
        <tr>
          <td>MEKp</td>
          <td>0</td>
          <td>MEKp&apos;[t] == -(a4*MEKp[t]*MEKPH[t]) + d4*MEKpMEKPH[t]
							 + k6*MEKppMEKPH[t] + d5*MEKpRAFp[t] + k3*MEKRAFp[
							t] - a5*MEKp[t]*RAFp[t]</td>
        </tr>
        <tr>
          <td>MEKPH</td>
          <td>0.2</td>
          <td>MEKPH&apos;[t] == -(a4*MEKp[t]*MEKPH[t]) + d4*MEKpMEKPH[t]
							 + k4*MEKpMEKPH[t] - a6*MEKPH[t]*MEKpp[t] + d6*
							MEKppMEKPH[t] + k6*MEKppMEKPH[t]</td>
        </tr>
        <tr>
          <td>MEKpMEKPH</td>
          <td>0</td>
          <td>MEKpMEKPH&apos;[t] == a4*MEKp[t]*MEKPH[t] - d4*MEKpMEKPH[t]
							 - k4*MEKpMEKPH[t]</td>
        </tr>
        <tr>
          <td>MEKpp</td>
          <td>0</td>
          <td>MEKpp&apos;[t] == d7*MAPKMEKpp[t] + k7*MAPKMEKpp[t] +
							 d9*MAPKpMEKpp[t] + k9*MAPKpMEKpp[t] - a7*MAPK[t]*
							MEKpp[t] - a9*MAPKp[t]*MEKpp[t] - a6*MEKPH[t]*MEKpp[t]
							 + d6*MEKppMEKPH[t] + k5*MEKpRAFp[t]</td>
        </tr>
        <tr>
          <td>MEKppMEKPH</td>
          <td>0</td>
          <td>MEKppMEKPH&apos;[t] == a6*MEKPH[t]*MEKpp[t] - d6*MEKppMEKPH[
							t] - k6*MEKppMEKPH[t]</td>
        </tr>
        <tr>
          <td>MEKpRAFp</td>
          <td>0</td>
          <td>MEKpRAFp&apos;[t] == -(d5*MEKpRAFp[t]) - k5*MEKpRAFp[t]
							 + a5*MEKp[t]*RAFp[t]</td>
        </tr>
        <tr>
          <td>MEKRAFp</td>
          <td>0</td>
          <td>MEKRAFp&apos;[t] == -(d3*MEKRAFp[t]) - k3*MEKRAFp[t] +
							 a3*MEK[t]*RAFp[t]</td>
        </tr>
        <tr>
          <td>RAF</td>
          <td>0.4</td>
          <td>RAF&apos;[t] == -(a1*RAF[t]*RAFK[t]) + k2*RAFpRAFPH[t] +
							 d1*RAFRAFK[t]</td>
        </tr>
        <tr>
          <td>RAFK</td>
          <td>0.1</td>
          <td>RAFK&apos;[t] == -(a1*RAF[t]*RAFK[t]) + d1*RAFRAFK[t] +
							 k1*RAFRAFK[t]</td>
        </tr>
        <tr>
          <td>RAFp</td>
          <td>0</td>
          <td>RAFp&apos;[t] == d5*MEKpRAFp[t] + k5*MEKpRAFp[t] +
							 d3*MEKRAFp[t] + k3*MEKRAFp[t] - a3*MEK[t]*RAFp[t]
							 - a5*MEKp[t]*RAFp[t] - a2*RAFp[t]*RAFPH[t] + d2*
							RAFpRAFPH[t] + k1*RAFRAFK[t]</td>
        </tr>
        <tr>
          <td>RAFPH</td>
          <td>0.3</td>
          <td>RAFPH&apos;[t] == -(a2*RAFp[t]*RAFPH[t]) + d2*RAFpRAFPH[t]
							 + k2*RAFpRAFPH[t]</td>
        </tr>
        <tr>
          <td>RAFpRAFPH</td>
          <td>0</td>
          <td>RAFpRAFPH&apos;[t] == a2*RAFp[t]*RAFPH[t] - d2*RAFpRAFPH[t]
							 - k2*RAFpRAFPH[t]</td>
        </tr>
        <tr>
          <td>RAFRAFK</td>
          <td>0</td>
          <td>RAFRAFK&apos;[t] == a1*RAF[t]*RAFK[t] - d1*RAFRAFK[t] -
							 k1*RAFRAFK[t]</td>
        </tr>
      </tbody>
    </table>
    <p>Generated by Cellerator Version 1.4.3 (6-March-2004) using Mathematica 5.0 
				for Mac OS X (November 19, 2003), March 6, 2004 12:18:07, using (PowerMac,
				PowerPC,Mac OS X,MacOSX,Darwin)</p>
    <p>author=B.E.Shapiro</p>
    <p>This model originates from BioModels Database: A Database of Annotated Published Models (http://www.ebi.ac.uk/biomodels/). It is copyright (c) 2005-2010 The BioModels.net Team.      <br/>
          For more information see the      <a href="http://www.ebi.ac.uk/biomodels/legal.html" target="_blank">terms of use</a>
          .      <br/>
          To cite BioModels Database, please use:      <a href="http://www.ncbi.nlm.nih.gov/pubmed/20587024" target="_blank">Li C, Donizelli M, Rodriguez N, Dharuri H, Endler L, Chelliah V, Li L, He E, Henry A, Stefan MI, Snoep JL, Hucka M, Le Novère N, Laibe C (2010) BioModels Database: An enhanced, curated and annotated resource for published quantitative kinetic models. BMC Syst Biol., 4:92.</a></p>
  </body>

    </Comment>
    <ListOfCompartments>
      <Compartment key="Compartment_0" name="Cytoplasm" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_0">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005737"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_0" name="MAPK" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_0">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P26696"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_1" name="MAPK_MEK-PP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_1">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P26696"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_2" name="MAPK-P" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_2">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P26696"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_3" name="MAPK phosphatase" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_3">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q90W58"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_4" name="MAPK-P_MAPKPase" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_4">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P26696"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q90W58"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_5" name="MAPK-P_MEK-PP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_5">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P26696"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_6" name="MAPK-PP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_6">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P26696"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_7" name="MAPK-PP_MAPKPase" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_7">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P26696"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q90W58"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_8" name="MEK" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_8">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_9" name="MEK-P" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_9">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_10" name="MEK phosphatase" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_10">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_11" name="MEK-P_MEKPase" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_11">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_12" name="MEK-PP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_12">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_13" name="MEK-PP_MEKPase" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_13">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_14" name="MEK-P_RAF-P" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_14">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P09560"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_15" name="MEK_RAF-P" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_15">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P09560"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q05116"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_16" name="RAF" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_16">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P09560"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_17" name="RAFK" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_17">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/interpro/IPR003577"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_18" name="RAF-P" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_18">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P09560"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_19" name="RAF phosphatase" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_19">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_20" name="RAF-P_RAFPase" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_20">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P09560"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_21" name="RAF_RAFK" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_21">
    <CopasiMT:hasPart>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/interpro/IPR003577"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P09560"/>
      </rdf:Bag>
    </CopasiMT:hasPart>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
    </ListOfMetabolites>
    <ListOfReactions>
      <Reaction key="Reaction_0" name="binding of RAF and RAFK" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_0">
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_996"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031435"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_16" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4709" name="a1" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_41" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_266">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Parameter_4709"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="dissociation of RAF_RAFK" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_1">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_16" stoichiometry="1"/>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4706" name="k1" value="0.4"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_4706"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_2" name="phosphorylation of RAF" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_2">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.11.1"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0000185"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006468"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0008349"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4707" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_4707"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_3" name="binding of RAF-P and RAF phosphatase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_3">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031435"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_18" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4708" name="a2" value="0.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_287">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_288">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_289">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_290">
              <SourceParameter reference="Parameter_4708"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_4" name="dissociation of RAF-P_RAFPase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_4">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4705" name="k1" value="0.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_4705"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_5" name="dephosphorylation of RAF-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_5">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/3.1.3.16"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006470"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0051390"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_16" stoichiometry="1"/>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4704" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_4704"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_6" name="binding of MEK and RAF-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_6">
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_143"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031434"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031435"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_8" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8513" name="a3" value="3.3"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_299">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_300">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Parameter_8513"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="dissociation of MEK_RAF-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_7">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_8" stoichiometry="1"/>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5379" name="k1" value="0.42"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_5379"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="phosphorylation of MEK" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_8">
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_614"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.11.25"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0004709"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006468"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5376" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_5376"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="binding of MEK-P and MEK phosphatase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_9">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031434"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8514" name="a4" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_311">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_312">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_313">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_314">
              <SourceParameter reference="Parameter_8514"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="dissociation of MEK-P_MEKPase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_10">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8515" name="k1" value="0.8"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_8515"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="dephosphorylation of MEK-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_11">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/3.1.3.16"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006470"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_8" stoichiometry="1"/>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8511" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_8511"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="binding of MEK-P and RAF-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_12">
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_143"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031434"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031435"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8512" name="a5" value="3.3"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_323">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_324">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_325">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_326">
              <SourceParameter reference="Parameter_8512"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="dissociation of MEK-P_RAF-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_13">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5380" name="k1" value="0.4"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_5380"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="phosphorylation of MEK-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_14">
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_614"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.11.25"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0000186"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0004709"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006468"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5378" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_5378"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="binding of MEK-PP and MEK phosphatase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_15">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031434"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5385" name="a6" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_335">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_336">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_337">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_338">
              <SourceParameter reference="Parameter_5385"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="dissociation of MEK-PP_MEKPase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_16">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5384" name="k1" value="0.8"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_5384"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_17" name="dephosphorylation of MEK-PP" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_17">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/3.1.3.16"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006470"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0051389"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_7620" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_7620"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_18" name="binding of MAPK and MEK-PP" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_18">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031434"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0051019"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_1780"/>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_495"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5383" name="a7" value="20"/>
        </ListOfConstants>
        <KineticLaw function="Function_47" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_347">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_348">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_349">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_350">
              <SourceParameter reference="Parameter_5383"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_19" name="dissociation of MAPK_MEK-PP" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_19">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_0" stoichiometry="1"/>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5381" name="k1" value="0.6"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_5381"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_20" name="phosphorylation of MAPK" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_20">
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_136"/>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_2247"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.12.2"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0004708"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006468"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_7623" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_7623"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_21" name="binding of MAPK-P and MAPK phosphatase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_21">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0051019"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_7622" name="a8" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_48" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_359">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_360">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_361">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_362">
              <SourceParameter reference="Parameter_7622"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="dissociation of MAPK-P_MAPKPase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_22">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5377" name="k1" value="0.4"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_5377"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_23" name="dephosphorylation of MAPK-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_23">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/3.1.3.16"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006470"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_0" stoichiometry="1"/>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_7621" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_7621"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_24" name="binding of MAPK-P and MEK-PP" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_24">
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_1780"/>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_495"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0031434"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0051019"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_7619" name="a9" value="20"/>
        </ListOfConstants>
        <KineticLaw function="Function_49" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_371">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_372">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_373">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_374">
              <SourceParameter reference="Parameter_7619"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_25" name="dissociation of MAPK-P_MEK-PP" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_25">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8165" name="k1" value="0.6"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_8165"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_26" name="phosphorylation of MAPK-P" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_26">
    <CopasiMT:isHomologTo>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_136"/>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACT_2247"/>
      </rdf:Bag>
    </CopasiMT:isHomologTo>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.12.2"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0000187"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0004708"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006468"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8163" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_8163"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_27" name="binding of MAPK-PP and MAPK phosphatase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_27">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0051019"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5389" name="a10" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_50" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_383">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_384">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_385">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_386">
              <SourceParameter reference="Parameter_5389"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_28" name="dissociation of MAPK-PP_MAPKPase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_28">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0043241"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4940" name="k1" value="0.4"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_4940"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_29" name="dephosphorylation of MAPK-PP" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_29">
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/3.1.3.16"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0000188"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0006470"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5388" name="k1" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="Parameter_5388"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfModelParameterSets activeSet="ModelParameterSet_0">
      <ModelParameterSet key="ModelParameterSet_0" name="Initial State">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_0">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK]" value="2.408856304e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK_MEK-PP]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK phosphatase]" value="1.806642228e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P_MAPKPase]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P_MEK-PP]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-PP]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-PP_MAPKPase]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK]" value="1.204428152e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK phosphatase]" value="1.204428152e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P_MEKPase]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-PP]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-PP_MEKPase]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P_RAF-P]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK_RAF-P]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF]" value="1.806642228e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAFK]" value="1.204428152e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF-P]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF phosphatase]" value="1.806642228e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF-P_RAFPase]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF_RAFK]" value="0" type="Species" simulationType="reactions"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of RAF and RAFK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of RAF and RAFK],ParameterGroup=Parameters,Parameter=a1" value="1" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of RAF_RAFK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of RAF_RAFK],ParameterGroup=Parameters,Parameter=k1" value="0.40000000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of RAF]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of RAF],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of RAF-P and RAF phosphatase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of RAF-P and RAF phosphatase],ParameterGroup=Parameters,Parameter=a2" value="0.5" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of RAF-P_RAFPase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of RAF-P_RAFPase],ParameterGroup=Parameters,Parameter=k1" value="0.5" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of RAF-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of RAF-P],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK and RAF-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK and RAF-P],ParameterGroup=Parameters,Parameter=a3" value="3.2999999999999998" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK_RAF-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK_RAF-P],ParameterGroup=Parameters,Parameter=k1" value="0.41999999999999998" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MEK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MEK],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-P and MEK phosphatase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-P and MEK phosphatase],ParameterGroup=Parameters,Parameter=a4" value="10" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-P_MEKPase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-P_MEKPase],ParameterGroup=Parameters,Parameter=k1" value="0.80000000000000004" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MEK-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MEK-P],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-P and RAF-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-P and RAF-P],ParameterGroup=Parameters,Parameter=a5" value="3.2999999999999998" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-P_RAF-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-P_RAF-P],ParameterGroup=Parameters,Parameter=k1" value="0.40000000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MEK-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MEK-P],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-PP and MEK phosphatase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-PP and MEK phosphatase],ParameterGroup=Parameters,Parameter=a6" value="10" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-PP_MEKPase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-PP_MEKPase],ParameterGroup=Parameters,Parameter=k1" value="0.80000000000000004" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MEK-PP]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MEK-PP],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK and MEK-PP]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK and MEK-PP],ParameterGroup=Parameters,Parameter=a7" value="20" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK_MEK-PP]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK_MEK-PP],ParameterGroup=Parameters,Parameter=k1" value="0.59999999999999998" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MAPK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MAPK],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-P and MAPK phosphatase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-P and MAPK phosphatase],ParameterGroup=Parameters,Parameter=a8" value="5" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-P_MAPKPase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-P_MAPKPase],ParameterGroup=Parameters,Parameter=k1" value="0.40000000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MAPK-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MAPK-P],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-P and MEK-PP]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-P and MEK-PP],ParameterGroup=Parameters,Parameter=a9" value="20" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-P_MEK-PP]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-P_MEK-PP],ParameterGroup=Parameters,Parameter=k1" value="0.59999999999999998" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MAPK-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MAPK-P],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-PP and MAPK phosphatase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-PP and MAPK phosphatase],ParameterGroup=Parameters,Parameter=a10" value="5" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-PP_MAPKPase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-PP_MAPKPase],ParameterGroup=Parameters,Parameter=k1" value="0.40000000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MAPK-PP]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MAPK-PP],ParameterGroup=Parameters,Parameter=k1" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_0"/>
      <StateTemplateVariable objectReference="Metabolite_12"/>
      <StateTemplateVariable objectReference="Metabolite_18"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_16"/>
      <StateTemplateVariable objectReference="Metabolite_19"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="Metabolite_15"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_17"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_14"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Metabolite_20"/>
      <StateTemplateVariable objectReference="Metabolite_21"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 0 0 1.806642228e+17 1.204428152e+17 0 0 1.806642228e+17 1.806642228e+17 2.408856304e+17 0 0 0 0 1.204428152e+17 1.204428152e+17 0 0 0 0 0 0 0 1 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_13" name="Time-Course" type="timeCourse" scheduled="true" updateModel="false">
      <Report reference="Report_10" target="" append="0" confirmOverwrite="0"/>
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="1000"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="10"/>
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
    <Task key="Task_12" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_9" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_11" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
        </ParameterGroup>
        <Parameter name="Subtask Output" type="string" value="subTaskDuring"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
        <Parameter name="Continue on Error" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_10" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_7" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_9" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_6" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_8" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_5" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
        <Parameter name="Steady-State" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <Parameter name="Time-Course" type="cn" value="CN=Root,Vector=TaskList[Time-Course]"/>
        <Parameter name="Create Parameter Sets" type="bool" value="0"/>
        <Parameter name="Use Time Sens" type="bool" value="0"/>
        <Parameter name="Time-Sens" type="cn" value=""/>
        <ParameterGroup name="Experiment Set">
        </ParameterGroup>
        <ParameterGroup name="Validation Set">
          <Parameter name="Weight" type="unsignedFloat" value="1"/>
          <Parameter name="Threshold" type="unsignedInteger" value="5"/>
        </ParameterGroup>
      </Problem>
      <Method name="Evolutionary Programming" type="EvolutionaryProgram">
        <Parameter name="Log Verbosity" type="unsignedInteger" value="0"/>
        <Parameter name="Number of Generations" type="unsignedInteger" value="200"/>
        <Parameter name="Population Size" type="unsignedInteger" value="20"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
        <Parameter name="Stop after # Stalled Generations" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_7" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_4" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_12"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Use Reder" type="bool" value="1"/>
        <Parameter name="Use Smallbone" type="bool" value="1"/>
      </Method>
    </Task>
    <Task key="Task_6" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_3" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_5" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_2" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_16" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_1" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_15" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Report reference="Report_0" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_4" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
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
    <Task key="Task_3" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="true" updateModel="false">
      <Report reference="Report_22" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_12"/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
    <Task key="Task_2" name="Time-Course Sensitivities" type="timeSensitivities" scheduled="false" updateModel="false">
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
    <Report key="Report_10" name="Auto-generated report for task1, including all symbols in SBML with mathematical meaning, both constant and variable." taskType="timeCourse" separator=", " precision="6">
      <Comment>
        Import from SED-ML
      </Comment>
      <Header>
        <Object cn="String=Time"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MAPK"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MAPKMEKpp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MAPKp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MAPKPH"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MAPKpMAPKPH"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MAPKpMEKpp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MAPKpp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MAPKppMAPKPH"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MEK"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MEKp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MEKPH"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MEKpMEKPH"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MEKpp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MEKppMEKPH"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MEKpRAFp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=MEKRAFp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=RAF"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=RAFK"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=RAFp"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=RAFPH"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=RAFpRAFPH"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=RAFRAFK"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Cytoplasm"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction1"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction2"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction3"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction4"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction5"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction6"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction7"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction8"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction9"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction10"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction11"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction12"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction13"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction14"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction15"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction16"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction17"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction18"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction19"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction20"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction21"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction22"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction23"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction24"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction25"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction26"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction27"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction28"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction29"/>
        <Object cn="Separator=\, "/>
        <Object cn="String=Reaction30"/>
        <Object cn="Separator=\, "/>
      </Header>
      <Body>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK_MEK-PP],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK phosphatase],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P_MAPKPase],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P_MEK-PP],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-PP],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-PP_MAPKPase],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK phosphatase],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P_MEKPase],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-PP],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-PP_MEKPase],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P_RAF-P],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK_RAF-P],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAFK],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF-P],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF phosphatase],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF-P_RAFPase],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF_RAFK],Reference=Concentration"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Reference=Volume"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of RAF and RAFK],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of RAF_RAFK],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of RAF],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of RAF-P and RAF phosphatase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of RAF-P_RAFPase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of RAF-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK and RAF-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK_RAF-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MEK],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-P and MEK phosphatase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-P_MEKPase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MEK-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-P and RAF-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-P_RAF-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MEK-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MEK-PP and MEK phosphatase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MEK-PP_MEKPase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MEK-PP],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK and MEK-PP],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK_MEK-PP],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MAPK],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-P and MAPK phosphatase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-P_MAPKPase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MAPK-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-P and MEK-PP],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-P_MEK-PP],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[phosphorylation of MAPK-P],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[binding of MAPK-PP and MAPK phosphatase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dissociation of MAPK-PP_MAPKPase],Reference=Flux"/>
        <Object cn="Separator=\, "/>
        <Object cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Reactions[dephosphorylation of MAPK-PP],Reference=Flux"/>
        <Object cn="Separator=\, "/>
      </Body>
    </Report>
    <Report key="Report_9" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_8" name="Time-Course" taskType="timeCourse" separator="&#x09;" precision="6">
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
    <Report key="Report_7" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_6" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
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
    <Report key="Report_5" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
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
    <Report key="Report_4" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_3" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
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
    <Report key="Report_2" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_1" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
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
    <Report key="Report_0" name="Moieties" taskType="moieties" separator="&#x09;" precision="6">
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
    <Report key="Report_22" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
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
  <ListOfPlots>
    <PlotSpecification name="Auto-generated plot for task1, including all species." type="Plot2D" active="1" taskTypes="">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="MAPK" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MAPKMEKpp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK_MEK-PP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MAPKp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MAPKPH" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK phosphatase],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MAPKpMAPKPH" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P_MAPKPase],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MAPKpMEKpp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-P_MEK-PP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MAPKpp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-PP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MAPKppMAPKPH" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MAPK-PP_MAPKPase],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MEK" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MEKp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MEKPH" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK phosphatase],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MEKpMEKPH" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P_MEKPase],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MEKpp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-PP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MEKppMEKPH" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-PP_MEKPase],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MEKpRAFp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK-P_RAF-P],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="MEKRAFp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[MEK_RAF-P],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="RAF" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="RAFK" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAFK],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="RAFp" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF-P],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="RAFPH" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF phosphatase],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="RAFpRAFPH" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF-P_RAFPase],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="RAFRAFK" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Levchenko2000_MAPK_noScaffold,Vector=Compartments[Cytoplasm],Vector=Metabolites[RAF_RAFK],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
  </ListOfPlots>
  <GUI>
  </GUI>
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
  </ListOfUnitDefinitions>
</COPASI>
