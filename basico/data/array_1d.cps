<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.23 (Build 178) (http://www.copasi.org) at 2018-03-27 11:08:17 UTC -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="23" versionDevel="178" copasiSourcesModified="0">
  <ListOfFunctions>
    <Function key="Function_6" name="Constant flux (irreversible)" type="PreDefined" reversible="false">
      <Expression>
        v
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_49" name="v" order="0" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_14" name="Mass action (reversible)" type="MassAction" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
   <rdf:Description rdf:about="#Function_14">
   <CopasiMT:is rdf:resource="urn:miriam:obo.sbo:SBO:0000042" />
   </rdf:Description>
   </rdf:RDF>
      </MiriamAnnotation>
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
<b>Mass action rate law for reversible reactions</b>
<p>
Reaction scheme where the products are created from the reactants and the change of a product quantity is proportional to the product of reactant activities. The reaction scheme does include a reverse process that creates the reactants from the products.
</p>
</body>
      </Comment>
      <Expression>
        k1*PRODUCT&lt;substrate_i>-k2*PRODUCT&lt;product_j>
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_69" name="k1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_68" name="substrate" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_78" name="k2" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_79" name="product" order="3" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_42" name="linear activation_1" type="UserDefined" reversible="false">
      <Expression>
        constant*a
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_269" name="a" order="0" role="modifier"/>
        <ParameterDescription key="FunctionParameter_270" name="constant" order="1" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_43" name="Irr Michaelis-Menten (enzyme)[userdefined]_1" type="UserDefined" reversible="false">
      <Expression>
        V*b*a/(Km+a)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_275" name="Km" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_276" name="V" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_277" name="a" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_278" name="b" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_44" name="Irr Michaelis-Menten (enzyme)[userdefined]_2" type="UserDefined" reversible="false">
      <Expression>
        V*c*a/(Km+a)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_283" name="Km" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_284" name="V" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_285" name="a" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_286" name="c" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_45" name="Henri-Michaelis-Menten (irreversible)_1" type="UserDefined" reversible="false">
      <Expression>
        V*b/(Km+b)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_268" name="Km" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_293" name="V" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_294" name="b" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_46" name="Henri-Michaelis-Menten (irreversible)_2" type="UserDefined" reversible="false">
      <Expression>
        V*c/(Km+c)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_274" name="Km" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_301" name="V" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_302" name="c" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_0" name="Kummer2000 - Oscillations in Calcium Signalling" simulationType="time" timeUnit="s" volumeUnit="l" areaUnit="m²" lengthUnit="m" quantityUnit="nmol" type="deterministic" avogadroConstant="6.0221408570000002e+23">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:vCard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <rdf:Description rdf:about="#Model_0">
    <bqbiol:hasTaxon>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/taxonomy/10116"/>
      </rdf:Bag>
    </bqbiol:hasTaxon>
    <dcterms:bibliographicCitation>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/10968983"/>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:bibliographicCitation>
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-11T15:35:19Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <dcterms:creator>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <vCard:EMAIL>viji@ebi.ac.uk</vCard:EMAIL>
            <vCard:N>
              <rdf:Description>
                <vCard:Family>Chelliah</vCard:Family>
                <vCard:Given>Vijayalakshmi</vCard:Given>
              </rdf:Description>
            </vCard:N>
            <vCard:ORG>
              <rdf:Description>
                <vCard:Orgname>EMBL-EBI</vCard:Orgname>
              </rdf:Description>
            </vCard:ORG>
          </rdf:Description>
        </rdf:li>
        <rdf:li>
          <rdf:Description>
            <vCard:EMAIL>ursula.kummer@bioquant.uni-heidelberg.de</vCard:EMAIL>
            <vCard:N>
              <rdf:Description>
                <vCard:Family>Kummer</vCard:Family>
                <vCard:Given>Ursula</vCard:Given>
              </rdf:Description>
            </vCard:N>
            <vCard:ORG>
              <rdf:Description>
                <vCard:Orgname>Ruprecht-Karls-Universität Heidelberg</vCard:Orgname>
              </rdf:Description>
            </vCard:ORG>
          </rdf:Description>
        </rdf:li>
        <rdf:li>
          <rdf:Description>
            <vCard:EMAIL>pedro.mendes@manchester.ac.uk</vCard:EMAIL>
            <vCard:N>
              <rdf:Description>
                <vCard:Family>Mendes</vCard:Family>
                <vCard:Given>Pedro</vCard:Given>
              </rdf:Description>
            </vCard:N>
            <vCard:ORG>
              <rdf:Description>
                <vCard:Orgname>University of Manchester</vCard:Orgname>
              </rdf:Description>
            </vCard:ORG>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:creator>
    <dcterms:modified>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-11T16:20:22Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:modified>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.db/MODEL1105060000"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.db/BIOMD0000000329"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0019722"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
    <CopasiMT:occursIn>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/bto/BTO:0000575"/>
      </rdf:Bag>
    </CopasiMT:occursIn>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <Comment>
      
  <body xmlns="http://www.w3.org/1999/xhtml">
    <div class="dc:title">Kummer2000 - Oscillations in Calcium
Signalling</div>
    <div class="dc:description">
      <p>Simplified (3-variable) calcium oscillation model Kummer et
  al. (2000) Biophys. J. 79, 1188-1195 This model is defined in a
  small compartment with low concentrations. You can run it first
  with the LSODA ODE solver and then with the Gillespie Monte Carlo
  method (in Time Course widget). This illustrates that at low
  particle numbers, as here, the stochastic simulation and the ODE
  approach produce different results (the stochastic approach is
  more correct in these circumstances). This file also demonstrates
  the use of several different plots to visualize results,
  including a histogram.</p>
    </div>
    <div class="dc:bibliographicCitation">
      <p>This model is described in the article:</p>
      <div class="bibo:title">
        <a href="http://identifiers.org/pubmed/10968983" title="Access to this publication">Switching from simple to
    complex oscillations in calcium signaling.</a>
      </div>
      <div class="bibo:authorList">Kummer U, Olsen LF, Dixon CJ, Green
  AK, Bornberg-Bauer E, Baier G.</div>
      <div class="bibo:Journal">Biophys. J. 2000 Sep; 79(3):
  1188-1195</div>
      <p>Abstract:</p>
      <div class="bibo:abstract">
        <p>We present a new model for calcium oscillations based on
    experiments in hepatocytes. The model considers feedback
    inhibition on the initial agonist receptor complex by calcium
    and activated phospholipase C, as well as receptor
    type-dependent self-enhanced behavior of the activated G(alpha)
    subunit. It is able to show simple periodic oscillations and
    periodic bursting, and it is the first model to display chaotic
    bursting in response to agonist stimulations. Moreover, our
    model offers a possible explanation for the differences in
    dynamic behavior observed in response to different agonists in
    hepatocytes.</p>
      </div>
    </div>
    <div class="dc:publisher">
      <p>This model is hosted on 
  <a href="http://www.ebi.ac.uk/biomodels/">BioModels Database</a>
  and identified by: 
  <a href="http://identifiers.org/biomodels.db/BIOMD0000000329">BIOMD0000000329</a>.</p>
      <p>To cite BioModels Database, please use: 
  <a href="http://identifiers.org/pubmed/20587024" title="Latest BioModels Database publication">BioModels Database:
  An enhanced, curated and annotated resource for published
  quantitative kinetic models</a>.</p>
    </div>
    <div class="dc:license">
      <p>To the extent possible under law, all copyright and related or
  neighbouring rights to this encoded model have been dedicated to
  the public domain worldwide. Please refer to 
  <a href="http://creativecommons.org/publicdomain/zero/1.0/" title="Access to: CC0 1.0 Universal (CC0 1.0), Public Domain Dedication">CC0
  Public Domain Dedication</a> for more information.</p>
    </div>
  </body>

    </Comment>
    <ListOfCompartments>
      <Compartment key="Compartment_1" name="compartment[0]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_1">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_2" name="compartment[1]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_2">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_3" name="compartment[2]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_3">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_4" name="compartment[3]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_4">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_5" name="compartment[4]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_5">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_6" name="compartment[5]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_6">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_7" name="compartment[6]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_7">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_8" name="compartment[7]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_8">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_9" name="compartment[8]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_9">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_10" name="compartment[9]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_10">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_11" name="compartment[10]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_11">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_12" name="compartment[11]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_12">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_13" name="compartment[12]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_13">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_14" name="compartment[13]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_14">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_15" name="compartment[14]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_15">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_16" name="compartment[15]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_16">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_17" name="compartment[16]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_17">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_18" name="compartment[17]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_18">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_19" name="compartment[18]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_19">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
      <Compartment key="Compartment_20" name="compartment[19]" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_20">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000290"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_3" name="activePLC" simulationType="reactions" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_3">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_4" name="Calcium" simulationType="reactions" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_4">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_5" name="G-alpha" simulationType="reactions" compartment="Compartment_1" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_5">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_6" name="activePLC" simulationType="reactions" compartment="Compartment_2" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_6">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_7" name="Calcium" simulationType="reactions" compartment="Compartment_2" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_7">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_8" name="G-alpha" simulationType="reactions" compartment="Compartment_2" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_8">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_9" name="activePLC" simulationType="reactions" compartment="Compartment_3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_9">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_10" name="Calcium" simulationType="reactions" compartment="Compartment_3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_10">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2018-03-26T17:59:32Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_11" name="G-alpha" simulationType="reactions" compartment="Compartment_3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_11">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_12" name="activePLC" simulationType="reactions" compartment="Compartment_4" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_12">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_13" name="Calcium" simulationType="reactions" compartment="Compartment_4" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_13">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2018-03-26T17:59:38Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_14" name="G-alpha" simulationType="reactions" compartment="Compartment_4" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_14">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_15" name="activePLC" simulationType="reactions" compartment="Compartment_5" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_15">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_16" name="Calcium" simulationType="reactions" compartment="Compartment_5" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_16">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_17" name="G-alpha" simulationType="reactions" compartment="Compartment_5" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_17">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_18" name="activePLC" simulationType="reactions" compartment="Compartment_6" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_18">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_19" name="Calcium" simulationType="reactions" compartment="Compartment_6" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_19">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_20" name="G-alpha" simulationType="reactions" compartment="Compartment_6" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_20">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_21" name="activePLC" simulationType="reactions" compartment="Compartment_7" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_21">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_22" name="Calcium" simulationType="reactions" compartment="Compartment_7" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_22">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_23" name="G-alpha" simulationType="reactions" compartment="Compartment_7" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_23">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_24" name="activePLC" simulationType="reactions" compartment="Compartment_8" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_24">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_25" name="Calcium" simulationType="reactions" compartment="Compartment_8" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_25">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_26" name="G-alpha" simulationType="reactions" compartment="Compartment_8" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_26">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_27" name="activePLC" simulationType="reactions" compartment="Compartment_9" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_27">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_28" name="Calcium" simulationType="reactions" compartment="Compartment_9" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_28">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2018-03-26T17:59:33Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_29" name="G-alpha" simulationType="reactions" compartment="Compartment_9" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_29">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_30" name="activePLC" simulationType="reactions" compartment="Compartment_10" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_30">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_31" name="Calcium" simulationType="reactions" compartment="Compartment_10" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_31">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_32" name="G-alpha" simulationType="reactions" compartment="Compartment_10" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_32">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_33" name="activePLC" simulationType="reactions" compartment="Compartment_11" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_33">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_34" name="Calcium" simulationType="reactions" compartment="Compartment_11" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_34">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_35" name="G-alpha" simulationType="reactions" compartment="Compartment_11" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_35">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_36" name="activePLC" simulationType="reactions" compartment="Compartment_12" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_36">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_37" name="Calcium" simulationType="reactions" compartment="Compartment_12" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_37">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_38" name="G-alpha" simulationType="reactions" compartment="Compartment_12" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_38">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_39" name="activePLC" simulationType="reactions" compartment="Compartment_13" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_39">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_40" name="Calcium" simulationType="reactions" compartment="Compartment_13" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_40">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_41" name="G-alpha" simulationType="reactions" compartment="Compartment_13" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_41">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_42" name="activePLC" simulationType="reactions" compartment="Compartment_14" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_42">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_43" name="Calcium" simulationType="reactions" compartment="Compartment_14" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_43">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_44" name="G-alpha" simulationType="reactions" compartment="Compartment_14" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_44">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_45" name="activePLC" simulationType="reactions" compartment="Compartment_15" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_45">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_46" name="Calcium" simulationType="reactions" compartment="Compartment_15" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_46">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_47" name="G-alpha" simulationType="reactions" compartment="Compartment_15" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_47">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_48" name="activePLC" simulationType="reactions" compartment="Compartment_16" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_48">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_49" name="Calcium" simulationType="reactions" compartment="Compartment_16" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_49">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_50" name="G-alpha" simulationType="reactions" compartment="Compartment_16" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_50">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_51" name="activePLC" simulationType="reactions" compartment="Compartment_17" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_51">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_52" name="Calcium" simulationType="reactions" compartment="Compartment_17" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_52">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2018-03-26T17:59:31Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_53" name="G-alpha" simulationType="reactions" compartment="Compartment_17" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_53">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_54" name="activePLC" simulationType="reactions" compartment="Compartment_18" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_54">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_55" name="Calcium" simulationType="reactions" compartment="Compartment_18" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_55">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_56" name="G-alpha" simulationType="reactions" compartment="Compartment_18" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_56">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_57" name="activePLC" simulationType="reactions" compartment="Compartment_19" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_57">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_58" name="Calcium" simulationType="reactions" compartment="Compartment_19" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_58">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_59" name="G-alpha" simulationType="reactions" compartment="Compartment_19" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_59">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_60" name="activePLC" simulationType="reactions" compartment="Compartment_20" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_60">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000014"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P10687"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_61" name="Calcium" simulationType="reactions" compartment="Compartment_20" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_61">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000247"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:29108"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_62" name="G-alpha" simulationType="reactions" compartment="Compartment_20" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_62">
    <CopasiMT:is rdf:resource="urn:miriam:sbo:SBO:0000252"/>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q9JID2"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_0" name="diff_compartment_Calcium" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_0">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2018-03-26T17:58:37Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
    </ListOfModelValues>
    <ListOfReactions>
      <Reaction key="Reaction_8" name="R3[0]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_8">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2833" name="Km" value="0.19"/>
          <Constant key="Parameter_2834" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2833"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2834"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="R2[0]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2835" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2835"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="R1[0]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2836" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2836"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="R7[0]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2837" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2837"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="R4[0]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2838" name="Km" value="1.18"/>
          <Constant key="Parameter_2839" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2838"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2839"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="R8[0]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2840" name="Km" value="0.16"/>
          <Constant key="Parameter_2841" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2840"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2841"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="R6[0]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2842" name="Km" value="29.09"/>
          <Constant key="Parameter_2843" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2842"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2843"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="R5[0]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2844" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2844"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="R3[1]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_16">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2845" name="Km" value="0.19"/>
          <Constant key="Parameter_2846" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2845"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2846"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_17" name="R2[1]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2847" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2847"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_18" name="R1[1]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2848" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2848"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_19" name="R7[1]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2849" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2849"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_20" name="R4[1]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2850" name="Km" value="1.18"/>
          <Constant key="Parameter_2851" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2850"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2851"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_21" name="R8[1]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2852" name="Km" value="0.16"/>
          <Constant key="Parameter_2853" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2852"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2853"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="R6[1]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2854" name="Km" value="29.09"/>
          <Constant key="Parameter_2855" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2854"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2855"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_23" name="R5[1]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2856" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2856"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_24" name="diff_compartment_Calcium[0-1]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2857" name="k1" value="1e-12"/>
          <Constant key="Parameter_2858" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_25" name="R3[2]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_25">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2859" name="Km" value="0.19"/>
          <Constant key="Parameter_2860" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2859"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2860"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_26" name="R2[2]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2861" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2861"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_27" name="R1[2]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2862" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2862"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_28" name="R7[2]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2863" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2863"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_29" name="R4[2]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2864" name="Km" value="1.18"/>
          <Constant key="Parameter_2865" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2864"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2865"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_30" name="R8[2]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2866" name="Km" value="0.16"/>
          <Constant key="Parameter_2867" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2866"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2867"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_31" name="R6[2]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2868" name="Km" value="29.09"/>
          <Constant key="Parameter_2869" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2868"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2869"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_32" name="R5[2]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2870" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2870"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_33" name="diff_compartment_Calcium[1-2]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2871" name="k1" value="1e-12"/>
          <Constant key="Parameter_2872" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_34" name="R3[3]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_34">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2873" name="Km" value="0.19"/>
          <Constant key="Parameter_2874" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2873"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2874"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_35" name="R2[3]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2875" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2875"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_36" name="R1[3]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2876" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2876"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_37" name="R7[3]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2877" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2877"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_38" name="R4[3]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2878" name="Km" value="1.18"/>
          <Constant key="Parameter_2879" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2878"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2879"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_39" name="R8[3]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2880" name="Km" value="0.16"/>
          <Constant key="Parameter_2881" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2880"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2881"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_40" name="R6[3]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2882" name="Km" value="29.09"/>
          <Constant key="Parameter_2883" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2882"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2883"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_41" name="R5[3]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2884" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2884"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_42" name="diff_compartment_Calcium[2-3]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2885" name="k1" value="1e-12"/>
          <Constant key="Parameter_2886" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_43" name="R3[4]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_43">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2887" name="Km" value="0.19"/>
          <Constant key="Parameter_2888" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2887"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2888"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_44" name="R2[4]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2889" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2889"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_45" name="R1[4]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2890" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2890"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_46" name="R7[4]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2891" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2891"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_47" name="R4[4]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2892" name="Km" value="1.18"/>
          <Constant key="Parameter_2893" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2892"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2893"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_48" name="R8[4]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2894" name="Km" value="0.16"/>
          <Constant key="Parameter_2895" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2894"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2895"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_49" name="R6[4]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2896" name="Km" value="29.09"/>
          <Constant key="Parameter_2897" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2896"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2897"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_50" name="R5[4]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2898" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2898"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_51" name="diff_compartment_Calcium[3-4]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2899" name="k1" value="1e-12"/>
          <Constant key="Parameter_2900" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_52" name="R3[5]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_52">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2901" name="Km" value="0.19"/>
          <Constant key="Parameter_2902" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2901"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2902"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_53" name="R2[5]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2903" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2903"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_54" name="R1[5]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2904" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2904"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_55" name="R7[5]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2905" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2905"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_56" name="R4[5]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2906" name="Km" value="1.18"/>
          <Constant key="Parameter_2907" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2906"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2907"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_57" name="R8[5]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2908" name="Km" value="0.16"/>
          <Constant key="Parameter_2909" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2908"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2909"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_58" name="R6[5]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2910" name="Km" value="29.09"/>
          <Constant key="Parameter_2911" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2910"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2911"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_59" name="R5[5]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2912" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2912"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_60" name="diff_compartment_Calcium[4-5]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2913" name="k1" value="1e-12"/>
          <Constant key="Parameter_2914" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_61" name="R3[6]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_61">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2915" name="Km" value="0.19"/>
          <Constant key="Parameter_2916" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2915"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2916"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_62" name="R2[6]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2917" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2917"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_63" name="R1[6]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2918" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2918"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_64" name="R7[6]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_22" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2919" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2919"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_65" name="R4[6]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_22" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2920" name="Km" value="1.18"/>
          <Constant key="Parameter_2921" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2920"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2921"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_22"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_66" name="R8[6]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_22" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2922" name="Km" value="0.16"/>
          <Constant key="Parameter_2923" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2922"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2923"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_22"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_67" name="R6[6]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2924" name="Km" value="29.09"/>
          <Constant key="Parameter_2925" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2924"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2925"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_68" name="R5[6]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2926" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2926"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_69" name="diff_compartment_Calcium[5-6]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_22" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2927" name="k1" value="1e-12"/>
          <Constant key="Parameter_2928" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_22"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_70" name="R3[7]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_70">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_26" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_24" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2929" name="Km" value="0.19"/>
          <Constant key="Parameter_2930" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2929"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2930"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_24"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_71" name="R2[7]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_26" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_26" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2931" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2931"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_72" name="R1[7]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_26" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2932" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2932"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_73" name="R7[7]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_26" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2933" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2933"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_74" name="R4[7]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_26" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2934" name="Km" value="1.18"/>
          <Constant key="Parameter_2935" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2934"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2935"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_75" name="R8[7]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2936" name="Km" value="0.16"/>
          <Constant key="Parameter_2937" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2936"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2937"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_76" name="R6[7]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_24" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2938" name="Km" value="29.09"/>
          <Constant key="Parameter_2939" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2938"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2939"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_24"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_77" name="R5[7]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_24" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_26" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2940" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2940"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_78" name="diff_compartment_Calcium[6-7]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_22" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2941" name="k1" value="1e-12"/>
          <Constant key="Parameter_2942" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_22"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_79" name="R3[8]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_79">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2943" name="Km" value="0.19"/>
          <Constant key="Parameter_2946" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2943"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2946"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_80" name="R2[8]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2945" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2945"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_81" name="R1[8]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2944" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2944"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_82" name="R7[8]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_28" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2947" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2947"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_83" name="R4[8]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_28" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2948" name="Km" value="1.18"/>
          <Constant key="Parameter_2949" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2948"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2949"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_28"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_84" name="R8[8]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_28" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2950" name="Km" value="0.16"/>
          <Constant key="Parameter_2951" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2950"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2951"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_28"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_85" name="R6[8]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2952" name="Km" value="29.09"/>
          <Constant key="Parameter_2953" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2952"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2953"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_86" name="R5[8]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2954" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2954"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_87" name="diff_compartment_Calcium[7-8]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_28" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2955" name="k1" value="1e-12"/>
          <Constant key="Parameter_2956" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_28"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_88" name="R3[9]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_88">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_30" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2957" name="Km" value="0.19"/>
          <Constant key="Parameter_2958" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2957"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2958"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_30"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_89" name="R2[9]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2959" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2959"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_90" name="R1[9]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2960" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2960"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_91" name="R7[9]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2961" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2961"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_92" name="R4[9]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2962" name="Km" value="1.18"/>
          <Constant key="Parameter_2963" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2962"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2963"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_93" name="R8[9]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2964" name="Km" value="0.16"/>
          <Constant key="Parameter_2965" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2964"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2965"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_94" name="R6[9]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_30" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2966" name="Km" value="29.09"/>
          <Constant key="Parameter_2967" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2966"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2967"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_30"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_95" name="R5[9]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_30" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2968" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2968"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_96" name="diff_compartment_Calcium[8-9]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_28" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2969" name="k1" value="1e-12"/>
          <Constant key="Parameter_2970" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_28"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_97" name="R3[10]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_97">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2971" name="Km" value="0.19"/>
          <Constant key="Parameter_2972" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2971"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2972"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_98" name="R2[10]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2973" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2973"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_99" name="R1[10]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2974" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2974"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_100" name="R7[10]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2975" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2975"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_101" name="R4[10]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2976" name="Km" value="1.18"/>
          <Constant key="Parameter_2977" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2976"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2977"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_102" name="R8[10]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2978" name="Km" value="0.16"/>
          <Constant key="Parameter_2979" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2978"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2979"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_103" name="R6[10]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2980" name="Km" value="29.09"/>
          <Constant key="Parameter_2981" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2980"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2981"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_104" name="R5[10]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2982" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2982"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_105" name="diff_compartment_Calcium[9-10]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2983" name="k1" value="1e-12"/>
          <Constant key="Parameter_2984" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_106" name="R3[11]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_106">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_36" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2985" name="Km" value="0.19"/>
          <Constant key="Parameter_2986" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2985"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_2986"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_36"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_107" name="R2[11]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2987" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2987"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_108" name="R1[11]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2988" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_2988"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_109" name="R7[11]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2989" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2989"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_110" name="R4[11]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2990" name="Km" value="1.18"/>
          <Constant key="Parameter_2991" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_2990"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_2991"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_111" name="R8[11]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2992" name="Km" value="0.16"/>
          <Constant key="Parameter_2993" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_2992"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_2993"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_112" name="R6[11]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_36" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_2994" name="Km" value="29.09"/>
          <Constant key="Parameter_2997" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_2994"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_2997"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_36"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_113" name="R5[11]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_36" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2995" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_2995"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_114" name="diff_compartment_Calcium[10-11]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2996" name="k1" value="1e-12"/>
          <Constant key="Parameter_2998" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_115" name="R3[12]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_115">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_2999" name="Km" value="0.19"/>
          <Constant key="Parameter_3000" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_2999"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_3000"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_116" name="R2[12]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3003" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3003"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_117" name="R1[12]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3001" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_3001"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_118" name="R7[12]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_40" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3002" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3002"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_119" name="R4[12]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_40" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3004" name="Km" value="1.18"/>
          <Constant key="Parameter_3005" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_3004"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_3005"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_40"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_120" name="R8[12]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_40" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3006" name="Km" value="0.16"/>
          <Constant key="Parameter_3007" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_3006"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_3007"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_40"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_121" name="R6[12]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3009" name="Km" value="29.09"/>
          <Constant key="Parameter_3011" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_3009"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_3011"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_122" name="R5[12]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3010" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3010"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_123" name="diff_compartment_Calcium[11-12]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_40" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3008" name="k1" value="1e-12"/>
          <Constant key="Parameter_3012" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_40"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_124" name="R3[13]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_124">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_42" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3013" name="Km" value="0.19"/>
          <Constant key="Parameter_3014" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_3013"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_3014"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_44"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_42"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_125" name="R2[13]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3015" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_44"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3015"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_126" name="R1[13]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3016" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_3016"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_127" name="R7[13]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3017" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_44"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3017"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_128" name="R4[13]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3018" name="Km" value="1.18"/>
          <Constant key="Parameter_3019" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_3018"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_3019"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_44"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_129" name="R8[13]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3020" name="Km" value="0.16"/>
          <Constant key="Parameter_3021" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_3020"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_3021"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_130" name="R6[13]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_42" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3022" name="Km" value="29.09"/>
          <Constant key="Parameter_3023" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_3022"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_3023"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_42"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_131" name="R5[13]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_42" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3024" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_44"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3024"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_132" name="diff_compartment_Calcium[12-13]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_40" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3025" name="k1" value="1e-12"/>
          <Constant key="Parameter_3026" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_40"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_133" name="R3[14]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_133">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_45" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3027" name="Km" value="0.19"/>
          <Constant key="Parameter_3028" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_3027"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_3028"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_45"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_134" name="R2[14]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3029" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3029"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_135" name="R1[14]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3030" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_3030"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_136" name="R7[14]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_46" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3031" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3031"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_137" name="R4[14]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_46" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3032" name="Km" value="1.18"/>
          <Constant key="Parameter_3033" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_3032"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_3033"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_46"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_138" name="R8[14]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_46" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3034" name="Km" value="0.16"/>
          <Constant key="Parameter_3035" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_3034"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_3035"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_46"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_139" name="R6[14]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_45" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3036" name="Km" value="29.09"/>
          <Constant key="Parameter_3037" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_3036"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_3037"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_45"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_140" name="R5[14]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_45" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3038" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3038"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_141" name="diff_compartment_Calcium[13-14]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_46" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3039" name="k1" value="1e-12"/>
          <Constant key="Parameter_3040" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_46"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_142" name="R3[15]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_142">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_50" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_48" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3041" name="Km" value="0.19"/>
          <Constant key="Parameter_3042" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_3041"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_3042"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_48"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_143" name="R2[15]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_50" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_50" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3043" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3043"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_144" name="R1[15]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_50" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3044" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_3044"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_145" name="R7[15]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_49" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_50" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3045" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3045"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_146" name="R4[15]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_50" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_49" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3046" name="Km" value="1.18"/>
          <Constant key="Parameter_3047" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_3046"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_3047"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_147" name="R8[15]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_49" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3048" name="Km" value="0.16"/>
          <Constant key="Parameter_3049" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_3048"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_3049"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_148" name="R6[15]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_48" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3050" name="Km" value="29.09"/>
          <Constant key="Parameter_3051" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_3050"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_3051"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_48"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_149" name="R5[15]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_48" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_50" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3052" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3052"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_150" name="diff_compartment_Calcium[14-15]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_46" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_49" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3053" name="k1" value="1e-12"/>
          <Constant key="Parameter_3054" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_46"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_151" name="R3[16]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_151">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3057" name="Km" value="0.19"/>
          <Constant key="Parameter_3055" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_3057"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_3055"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_51"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_152" name="R2[16]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3056" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3056"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_153" name="R1[16]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3058" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_3058"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_154" name="R7[16]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_52" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3059" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3059"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_155" name="R4[16]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_52" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3060" name="Km" value="1.18"/>
          <Constant key="Parameter_3061" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_3060"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_3061"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_52"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_156" name="R8[16]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_52" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3062" name="Km" value="0.16"/>
          <Constant key="Parameter_3063" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_3062"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_3063"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_52"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_157" name="R6[16]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3064" name="Km" value="29.09"/>
          <Constant key="Parameter_3065" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_3064"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_3065"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_51"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_158" name="R5[16]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3066" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3066"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_159" name="diff_compartment_Calcium[15-16]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_49" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_52" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3067" name="k1" value="1e-12"/>
          <Constant key="Parameter_3068" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_52"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_160" name="R3[17]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_160">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_56" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_54" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3069" name="Km" value="0.19"/>
          <Constant key="Parameter_3070" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_3069"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_3070"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_54"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_161" name="R2[17]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_56" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_56" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3071" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3071"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_162" name="R1[17]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_56" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3072" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_3072"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_163" name="R7[17]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_56" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3073" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3073"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_164" name="R4[17]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_56" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3074" name="Km" value="1.18"/>
          <Constant key="Parameter_3075" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_3074"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_3075"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_165" name="R8[17]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3076" name="Km" value="0.16"/>
          <Constant key="Parameter_3077" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_3076"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_3077"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_166" name="R6[17]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_54" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3078" name="Km" value="29.09"/>
          <Constant key="Parameter_3079" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_3078"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_3079"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_54"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_167" name="R5[17]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_54" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_56" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3080" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3080"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_168" name="diff_compartment_Calcium[16-17]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_52" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3081" name="k1" value="1e-12"/>
          <Constant key="Parameter_3082" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_52"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_169" name="R3[18]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_169">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3083" name="Km" value="0.19"/>
          <Constant key="Parameter_3084" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_3083"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_3084"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_57"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_170" name="R2[18]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3085" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3085"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_171" name="R1[18]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3086" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_3086"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_172" name="R7[18]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_58" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3087" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3087"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_173" name="R4[18]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_58" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3088" name="Km" value="1.18"/>
          <Constant key="Parameter_3089" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_3088"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_3089"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_58"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_174" name="R8[18]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_58" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3090" name="Km" value="0.16"/>
          <Constant key="Parameter_3091" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_3090"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_3091"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_58"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_175" name="R6[18]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3092" name="Km" value="29.09"/>
          <Constant key="Parameter_3093" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_3092"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_3093"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_57"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_176" name="R5[18]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3094" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3094"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_177" name="diff_compartment_Calcium[17-18]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_58" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3095" name="k1" value="1e-12"/>
          <Constant key="Parameter_3096" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_58"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_178" name="R3[19]" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_178">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-12-10T15:05:10Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_62" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_60" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3097" name="Km" value="0.19"/>
          <Constant key="Parameter_3098" name="V" value="1.52"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_3097"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_3098"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_62"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_60"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_179" name="R2[19]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_62" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_62" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3099" name="constant" value="2.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_62"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3099"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_180" name="R1[19]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_62" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3100" name="v" value="0.212"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="Parameter_3100"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_181" name="R7[19]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_62" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3101" name="constant" value="13.58"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_62"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3101"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_182" name="R4[19]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_62" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3102" name="Km" value="1.18"/>
          <Constant key="Parameter_3103" name="V" value="4.88"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_3102"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_3103"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Metabolite_62"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_183" name="R8[19]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3104" name="Km" value="0.16"/>
          <Constant key="Parameter_3105" name="V" value="153"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_3104"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_3105"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_184" name="R6[19]" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_60" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3106" name="Km" value="29.09"/>
          <Constant key="Parameter_3107" name="V" value="32.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Parameter_3106"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_3107"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_60"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_185" name="R5[19]" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_60" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_62" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3108" name="constant" value="1.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_62"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_3108"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_186" name="diff_compartment_Calcium[18-19]" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_58" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3109" name="k1" value="1e-12"/>
          <Constant key="Parameter_3110" name="k2" value="1e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_58"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfModelParameterSets activeSet="ModelParameterSet_0">
      <ModelParameterSet key="ModelParameterSet_0" name="Initial State">
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]]" value="1e-13" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]],Vector=Metabolites[Calcium]" value="12.044281714000002" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]],Vector=Metabolites[Calcium]" value="6.022140857000001" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]],Vector=Metabolites[activePLC]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]],Vector=Metabolites[Calcium]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]],Vector=Metabolites[G-alpha]" value="0" type="Species" simulationType="reactions"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium]" value="9.9999999999999998e-13" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[0\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[0\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[0\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[0\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[0\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[0\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[0\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[0\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[0\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[0\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[0\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[0\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[0\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[0\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[0\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[0\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[0\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[0\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[0\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[0\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[1\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[1\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[1\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[1\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[1\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[1\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[1\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[1\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[1\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[1\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[1\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[1\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[0-1\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[0-1\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[0-1\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[2\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[2\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[2\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[2\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[2\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[2\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[2\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[2\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[2\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[2\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[2\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[2\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[1-2\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[1-2\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[1-2\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[3\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[3\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[3\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[3\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[3\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[3\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[3\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[3\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[3\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[3\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[3\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[3\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[2-3\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[2-3\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[2-3\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[4\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[4\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[4\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[4\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[4\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[4\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[4\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[4\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[4\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[4\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[4\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[4\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[3-4\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[3-4\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[3-4\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[5\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[5\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[5\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[5\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[5\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[5\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[5\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[5\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[5\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[5\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[5\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[5\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[4-5\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[4-5\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[4-5\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[6\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[6\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[6\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[6\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[6\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[6\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[6\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[6\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[6\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[6\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[6\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[6\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[5-6\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[5-6\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[5-6\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[7\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[7\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[7\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[7\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[7\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[7\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[7\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[7\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[7\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[7\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[7\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[7\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[6-7\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[6-7\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[6-7\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[8\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[8\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[8\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[8\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[8\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[8\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[8\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[8\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[8\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[8\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[8\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[8\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[7-8\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[7-8\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[7-8\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[9\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[9\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[9\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[9\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[9\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[9\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[9\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[9\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[9\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[9\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[9\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[9\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[8-9\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[8-9\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[8-9\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[10\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[10\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[10\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[10\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[10\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[10\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[10\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[10\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[10\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[10\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[10\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[10\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[9-10\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[9-10\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[9-10\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[11\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[11\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[11\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[11\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[11\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[11\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[11\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[11\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[11\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[11\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[11\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[11\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[10-11\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[10-11\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[10-11\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[12\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[12\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[12\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[12\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[12\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[12\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[12\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[12\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[12\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[12\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[12\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[12\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[11-12\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[11-12\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[11-12\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[13\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[13\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[13\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[13\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[13\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[13\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[13\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[13\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[13\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[13\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[13\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[13\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[12-13\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[12-13\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[12-13\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[14\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[14\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[14\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[14\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[14\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[14\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[14\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[14\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[14\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[14\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[14\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[14\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[13-14\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[13-14\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[13-14\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[15\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[15\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[15\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[15\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[15\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[15\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[15\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[15\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[15\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[15\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[15\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[15\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[14-15\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[14-15\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[14-15\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[16\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[16\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[16\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[16\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[16\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[16\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[16\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[16\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[16\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[16\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[16\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[16\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[15-16\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[15-16\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[15-16\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[17\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[17\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[17\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[17\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[17\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[17\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[17\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[17\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[17\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[17\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[17\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[17\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[16-17\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[16-17\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[16-17\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[18\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[18\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[18\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[18\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[18\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[18\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[18\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[18\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[18\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[18\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[18\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[18\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[17-18\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[17-18\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[17-18\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[19\]],ParameterGroup=Parameters,Parameter=Km" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R3\[19\]],ParameterGroup=Parameters,Parameter=V" value="1.52" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R2\[19\]],ParameterGroup=Parameters,Parameter=constant" value="2.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R1\[19\]],ParameterGroup=Parameters,Parameter=v" value="0.21199999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R7\[19\]],ParameterGroup=Parameters,Parameter=constant" value="13.58" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[19\]],ParameterGroup=Parameters,Parameter=Km" value="1.1799999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R4\[19\]],ParameterGroup=Parameters,Parameter=V" value="4.8799999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[19\]],ParameterGroup=Parameters,Parameter=Km" value="0.16" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R8\[19\]],ParameterGroup=Parameters,Parameter=V" value="153" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[19\]],ParameterGroup=Parameters,Parameter=Km" value="29.09" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R6\[19\]],ParameterGroup=Parameters,Parameter=V" value="32.240000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[R5\[19\]],ParameterGroup=Parameters,Parameter=constant" value="1.24" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[18-19\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[18-19\]],ParameterGroup=Parameters,Parameter=k1" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Reactions[diff_compartment_Calcium\[18-19\]],ParameterGroup=Parameters,Parameter=k2" value="9.9999999999999998e-13" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Values[diff_compartment_Calcium],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_0"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Metabolite_14"/>
      <StateTemplateVariable objectReference="Metabolite_17"/>
      <StateTemplateVariable objectReference="Metabolite_19"/>
      <StateTemplateVariable objectReference="Metabolite_20"/>
      <StateTemplateVariable objectReference="Metabolite_23"/>
      <StateTemplateVariable objectReference="Metabolite_25"/>
      <StateTemplateVariable objectReference="Metabolite_26"/>
      <StateTemplateVariable objectReference="Metabolite_29"/>
      <StateTemplateVariable objectReference="Metabolite_31"/>
      <StateTemplateVariable objectReference="Metabolite_32"/>
      <StateTemplateVariable objectReference="Metabolite_35"/>
      <StateTemplateVariable objectReference="Metabolite_37"/>
      <StateTemplateVariable objectReference="Metabolite_38"/>
      <StateTemplateVariable objectReference="Metabolite_41"/>
      <StateTemplateVariable objectReference="Metabolite_43"/>
      <StateTemplateVariable objectReference="Metabolite_44"/>
      <StateTemplateVariable objectReference="Metabolite_47"/>
      <StateTemplateVariable objectReference="Metabolite_49"/>
      <StateTemplateVariable objectReference="Metabolite_50"/>
      <StateTemplateVariable objectReference="Metabolite_53"/>
      <StateTemplateVariable objectReference="Metabolite_55"/>
      <StateTemplateVariable objectReference="Metabolite_56"/>
      <StateTemplateVariable objectReference="Metabolite_59"/>
      <StateTemplateVariable objectReference="Metabolite_62"/>
      <StateTemplateVariable objectReference="Metabolite_58"/>
      <StateTemplateVariable objectReference="Metabolite_34"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Metabolite_22"/>
      <StateTemplateVariable objectReference="Metabolite_46"/>
      <StateTemplateVariable objectReference="Metabolite_52"/>
      <StateTemplateVariable objectReference="Metabolite_28"/>
      <StateTemplateVariable objectReference="Metabolite_16"/>
      <StateTemplateVariable objectReference="Metabolite_40"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_61"/>
      <StateTemplateVariable objectReference="Metabolite_18"/>
      <StateTemplateVariable objectReference="Metabolite_12"/>
      <StateTemplateVariable objectReference="Metabolite_45"/>
      <StateTemplateVariable objectReference="Metabolite_36"/>
      <StateTemplateVariable objectReference="Metabolite_24"/>
      <StateTemplateVariable objectReference="Metabolite_48"/>
      <StateTemplateVariable objectReference="Metabolite_21"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_51"/>
      <StateTemplateVariable objectReference="Metabolite_33"/>
      <StateTemplateVariable objectReference="Metabolite_27"/>
      <StateTemplateVariable objectReference="Metabolite_54"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_15"/>
      <StateTemplateVariable objectReference="Metabolite_57"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_30"/>
      <StateTemplateVariable objectReference="Metabolite_60"/>
      <StateTemplateVariable objectReference="Metabolite_42"/>
      <StateTemplateVariable objectReference="Metabolite_39"/>
      <StateTemplateVariable objectReference="Compartment_1"/>
      <StateTemplateVariable objectReference="Compartment_2"/>
      <StateTemplateVariable objectReference="Compartment_3"/>
      <StateTemplateVariable objectReference="Compartment_4"/>
      <StateTemplateVariable objectReference="Compartment_5"/>
      <StateTemplateVariable objectReference="Compartment_6"/>
      <StateTemplateVariable objectReference="Compartment_7"/>
      <StateTemplateVariable objectReference="Compartment_8"/>
      <StateTemplateVariable objectReference="Compartment_9"/>
      <StateTemplateVariable objectReference="Compartment_10"/>
      <StateTemplateVariable objectReference="Compartment_11"/>
      <StateTemplateVariable objectReference="Compartment_12"/>
      <StateTemplateVariable objectReference="Compartment_13"/>
      <StateTemplateVariable objectReference="Compartment_14"/>
      <StateTemplateVariable objectReference="Compartment_15"/>
      <StateTemplateVariable objectReference="Compartment_16"/>
      <StateTemplateVariable objectReference="Compartment_17"/>
      <StateTemplateVariable objectReference="Compartment_18"/>
      <StateTemplateVariable objectReference="Compartment_19"/>
      <StateTemplateVariable objectReference="Compartment_20"/>
      <StateTemplateVariable objectReference="ModelValue_0"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 0 0 0 0 12.044281714000002 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.022140857000001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 1e-13 9.9999999999999998e-13 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_12" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_8" target="" append="1" confirmOverwrite="1"/>
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
      </Method>
    </Task>
    <Task key="Task_11" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="10000"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="100"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_10" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
          <ParameterGroup name="ScanItem">
            <Parameter name="Number of steps" type="unsignedInteger" value="10"/>
            <Parameter name="Type" type="unsignedInteger" value="0"/>
            <Parameter name="Object" type="cn" value=""/>
          </ParameterGroup>
          <ParameterGroup name="ScanItem">
            <Parameter name="Number of steps" type="unsignedInteger" value="5"/>
            <Parameter name="Type" type="unsignedInteger" value="2"/>
            <Parameter name="Object" type="cn" value="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[Calcium],Reference=InitialConcentration"/>
            <Parameter name="Minimum" type="float" value="0"/>
            <Parameter name="Maximum" type="float" value="10"/>
            <Parameter name="log" type="bool" value="0"/>
            <Parameter name="Distribution type" type="unsignedInteger" value="0"/>
          </ParameterGroup>
          <ParameterGroup name="ScanItem">
            <Parameter name="Number of steps" type="unsignedInteger" value="5"/>
            <Parameter name="Type" type="unsignedInteger" value="2"/>
            <Parameter name="Object" type="cn" value="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[G-alpha],Reference=InitialConcentration"/>
            <Parameter name="Minimum" type="float" value="0"/>
            <Parameter name="Maximum" type="float" value="1"/>
            <Parameter name="log" type="bool" value="0"/>
            <Parameter name="Distribution type" type="unsignedInteger" value="0"/>
          </ParameterGroup>
          <ParameterGroup name="ScanItem">
            <Parameter name="Number of steps" type="unsignedInteger" value="5"/>
            <Parameter name="Type" type="unsignedInteger" value="2"/>
            <Parameter name="Object" type="cn" value="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[activePLC],Reference=InitialConcentration"/>
            <Parameter name="Minimum" type="float" value="0"/>
            <Parameter name="Maximum" type="float" value="0"/>
            <Parameter name="log" type="bool" value="0"/>
            <Parameter name="Distribution type" type="unsignedInteger" value="0"/>
          </ParameterGroup>
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="1"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_9" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_7" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_8" name="Optimization" type="optimization" scheduled="false" updateModel="false">
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
        <Parameter name="Number of Iterations" type="unsignedInteger" value="100000"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
        <Parameter name="#LogVerbosity" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_7" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
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
        <ParameterGroup name="Experiment Set">
        </ParameterGroup>
        <ParameterGroup name="Validation Set">
          <Parameter name="Weight" type="unsignedFloat" value="1"/>
          <Parameter name="Threshold" type="unsignedInteger" value="5"/>
        </ParameterGroup>
      </Problem>
      <Method name="Evolutionary Programming" type="EvolutionaryProgram">
        <Parameter name="Number of Generations" type="unsignedInteger" value="200"/>
        <Parameter name="Population Size" type="unsignedInteger" value="20"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
        <Parameter name="Stop after # Stalled Generations" type="unsignedInteger" value="0"/>
        <Parameter name="#LogVerbosity" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_6" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_4" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value=""/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Use Reder" type="bool" value="1"/>
        <Parameter name="Use Smallbone" type="bool" value="1"/>
      </Method>
    </Task>
    <Task key="Task_5" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
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
    <Task key="Task_4" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
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
    <Task key="Task_3" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
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
    <Task key="Task_2" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_1" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
        <Parameter name="LimitCrossings" type="bool" value="0"/>
        <Parameter name="NumCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitOutTime" type="bool" value="0"/>
        <Parameter name="LimitOutCrossings" type="bool" value="0"/>
        <Parameter name="PositiveDirection" type="bool" value="1"/>
        <Parameter name="NumOutCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitUntilConvergence" type="bool" value="0"/>
        <Parameter name="ConvergenceTolerance" type="float" value="0"/>
        <Parameter name="Threshold" type="float" value="0"/>
        <Parameter name="DelayOutputUntilConvergence" type="bool" value="0"/>
        <Parameter name="OutputConvergenceTolerance" type="float" value="0"/>
        <ParameterText name="TriggerExpression" type="expression">
          
        </ParameterText>
        <Parameter name="SingleVariable" type="cn" value=""/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_13" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_0" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value=""/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_8" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
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
    <Report key="Report_0" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
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
    <PlotSpecification name="Concentrations, Volumes, and Global Quantity Values" type="Plot2D" active="1" taskTypes="">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[G-alpha]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
    <PlotSpecification name="Concentrations, Volumes, and Global Quantity Values 1" type="Plot2D" active="1" taskTypes="">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[G-alpha{compartment}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[0]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[0]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[0]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[0\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[1]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[1]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[1]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[1\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[2]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[2]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[2]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[2\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[3]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[3]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[3]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[3\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[4]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[4]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[4]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[4\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[5]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[5]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[5]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[5\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[6]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[6]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[6]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[6\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[7]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[7]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[7]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[7\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[8]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[8]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[8]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[8\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[9]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[9]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[9]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[9\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[10]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[10]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[10]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[10\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[11]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[11]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[11]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[11\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[12]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[12]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[12]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[12\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[13]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[13]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[13]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[13\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[14]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[14]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[14]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[14\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[15]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[15]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[15]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[15\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[16]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[16]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[16]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[16\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[17]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[17]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[17]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[17\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[18]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[18]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[18]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[18\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[activePLC{compartment[19]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]],Vector=Metabolites[activePLC],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Calcium{compartment[19]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]],Vector=Metabolites[Calcium],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[G-alpha{compartment[19]}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Kummer2000 - Oscillations in Calcium Signalling,Vector=Compartments[compartment\[19\]],Vector=Metabolites[G-alpha],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
  </ListOfPlots>
  <GUI>
  </GUI>
  <ListOfUnitDefinitions>
    <UnitDefinition key="Unit_0" name="meter" symbol="m">
      <Expression>
        m
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_2" name="second" symbol="s">
      <Expression>
        s
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_6" name="Avogadro" symbol="Avogadro">
      <Expression>
        Avogadro
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_8" name="item" symbol="#">
      <Expression>
        #
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_17" name="liter" symbol="l">
      <Expression>
        0.001*m^3
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_20" name="mole" symbol="mol">
      <Expression>
        Avogadro*#
      </Expression>
    </UnitDefinition>
  </ListOfUnitDefinitions>
</COPASI>
