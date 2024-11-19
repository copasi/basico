<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.44 (Build 293) (http://www.copasi.org) at 2024-11-19T18:11:01Z -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="44" versionDevel="293" copasiSourcesModified="0">
  <ListOfFunctions>
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
    <Function key="Function_41" name="HXT kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_41">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        (Vmax * (A-B)/Kglc)/(1+(A+B)/Kglc+(Ki*A*B)/(Kglc^2))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_275" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_274" name="B" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_273" name="Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_272" name="Kglc" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_266" name="Ki" order="4" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_42" name="HK kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_42">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*(A*B/(Kglc*Katp)- P*Q/(Kglc*Katp*Keq))/((1+A/Kglc+P/Kg6p)*(1+B/Katp+Q/Kadp))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_280" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_279" name="B" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_278" name="P" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_277" name="Q" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_276" name="Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_281" name="Kglc" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_282" name="Katp" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_283" name="Keq" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_284" name="Kg6p" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_285" name="Kadp" order="9" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_43" name="PGI kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_43">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*(A/Kg6p-P/(Kg6p*Keq))/(1+A/Kg6p+P/Kf6p)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_295" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_294" name="P" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_293" name="Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_292" name="Kg6p" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_291" name="Keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_290" name="Kf6p" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_44" name="PFK kinetics" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_44">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*(gR*(F6P/Kf6p)*(ATP/Katp)*(1+F6P/Kf6p+ATP/Katp+gR*F6P/Kf6p*ATP/Katp)/((1+F6P/Kf6p+ATP/Katp+gR*F6P/Kf6p*ATP/Katp)^2+(L0*((1+Ciatp*ATP/Kiatp)/(1+ATP/Kiatp))^2*((1+Camp*AMP/Kamp)/(1+AMP/Kamp))^2*((1+Cf26*F26BP/Kf26+Cf16*F16P/Kf16)/(1+F26BP/Kf26+F16P/Kf16))^2)*(1+Catp*ATP/Katp)^2))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_297" name="F6P" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_296" name="ATP" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_286" name="F16P" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_287" name="AMP" order="3" role="modifier"/>
        <ParameterDescription key="FunctionParameter_288" name="F26BP" order="4" role="modifier"/>
        <ParameterDescription key="FunctionParameter_289" name="Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_298" name="gR" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_299" name="Kf6p" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_300" name="Katp" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_301" name="L0" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_302" name="Ciatp" order="10" role="constant"/>
        <ParameterDescription key="FunctionParameter_303" name="Kiatp" order="11" role="constant"/>
        <ParameterDescription key="FunctionParameter_304" name="Camp" order="12" role="constant"/>
        <ParameterDescription key="FunctionParameter_305" name="Kamp" order="13" role="constant"/>
        <ParameterDescription key="FunctionParameter_306" name="Cf26" order="14" role="constant"/>
        <ParameterDescription key="FunctionParameter_307" name="Kf26" order="15" role="constant"/>
        <ParameterDescription key="FunctionParameter_308" name="Cf16" order="16" role="constant"/>
        <ParameterDescription key="FunctionParameter_309" name="Kf16" order="17" role="constant"/>
        <ParameterDescription key="FunctionParameter_310" name="Catp" order="18" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_45" name="ALD kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_45">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*(A/Kf16bp-(P*Q/(Kf16bp*Keq)))/(1+A/Kf16bp+P/Kdhap+Q/Kgap+A*Q/(Kf16bp*Kigap)+P*Q/(Kdhap*Kgap))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_329" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_328" name="P" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_327" name="Q" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_326" name="Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_325" name="Kf16bp" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_324" name="Keq" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_323" name="Kdhap" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_322" name="Kgap" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_321" name="Kigap" order="8" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_46" name="GAPDH kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_46">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        C*(Vmaxf*A*B/(Kgap*Knad)-Vmaxr*P*Q/(Kbpg*Knadh))/((1+A/Kgap+P/Kbpg)*(1+B/Knad+Q/Knadh))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_312" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_313" name="B" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_314" name="P" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_315" name="Q" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_316" name="C" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_317" name="Vmaxf" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_318" name="Kgap" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_319" name="Knad" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_320" name="Vmaxr" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_311" name="Kbpg" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_330" name="Knadh" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_47" name="PGK kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_47">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*((Keq*A*B-P*Q)/(Kp3g*Katp))/((1+A/Kbpg+P/Kp3g)*(1+B/Kadp+Q/Katp))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_341" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_340" name="B" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_339" name="P" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_338" name="Q" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_337" name="Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_336" name="Keq" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_335" name="Kp3g" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_334" name="Katp" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_333" name="Kbpg" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_332" name="Kadp" order="9" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="PGM kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_48">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*(A/Kp3g-P/(Kp3g*Keq))/(1+A/Kp3g+P/Kp2g)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_350" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_349" name="P" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_348" name="Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_347" name="Kp3g" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_346" name="Keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_345" name="Kp2g" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="ENO kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_49">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*(A/Kp2g-P/(Kp2g*Keq))/(1+A/Kp2g+P/Kpep)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_352" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_351" name="P" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_331" name="Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_342" name="Kp2g" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_343" name="Keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_344" name="Kpep" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="PYK kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_50">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*(A*B/(Kpep*Kadp)-P*Q/(Kpep*Kadp*Keq))/((1+A/Kpep+P/Kpyr)*(1+B/Kadp+Q/Katp))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_358" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_357" name="B" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_356" name="P" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_355" name="Q" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_354" name="Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_353" name="Kpep" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_359" name="Kadp" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_360" name="Keq" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_361" name="Kpyr" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_362" name="Katp" order="9" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="PDC kinetics" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_51">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*((A/Kpyr)^nH)/(1+(A/Kpyr)^nH)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_372" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_371" name="Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_370" name="Kpyr" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_369" name="nH" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="ADH kinetics" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_52">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*(A*B/(Ketoh*Kinad)-P*Q/(Ketoh*Kinad*Keq))/(1+B/Kinad+A*Knad/(Kinad*Ketoh)+P*Knadh/(Kinadh*Kacald)+Q/Kinadh+A*B/(Kinad*Ketoh)+B*P*Knadh/(Kinad*Kinadh*Kacald)+A*Q*Knad/(Kinad*Kinadh*Ketoh)+P*Q/(Kacald*Kinadh)+A*B*P/(Kinad*Kiacald*Ketoh)+A*P*Q/(Kietoh*Kinadh*Kacald))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_365" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_366" name="B" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_367" name="P" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_368" name="Q" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_364" name="Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_363" name="Ketoh" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_373" name="Kinad" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_374" name="Keq" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_375" name="Knad" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_376" name="Knadh" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_377" name="Kinadh" order="10" role="constant"/>
        <ParameterDescription key="FunctionParameter_378" name="Kacald" order="11" role="constant"/>
        <ParameterDescription key="FunctionParameter_379" name="Kiacald" order="12" role="constant"/>
        <ParameterDescription key="FunctionParameter_380" name="Kietoh" order="13" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="ATPase" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_53">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Katpase*ATP
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_394" name="ATP" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_393" name="Katpase" order="1" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="G3PDH kinetics" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_54">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Vmax*((A/Kdhap)*(B/Knadh)-(P/Kdhap)*(Q/Knadh)*(1/Keq))/((1+A/Kdhap+P/Kglycerol)*(1+B/Knadh+Q/Knad))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_391" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_392" name="B" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_390" name="P" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_389" name="Q" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_388" name="Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_387" name="Kdhap" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_386" name="Knadh" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_385" name="Keq" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_384" name="Kglycerol" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_383" name="Knad" order="9" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="Glycogen synthesis kinetics" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_55">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        KGLYCOGEN
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_402" name="KGLYCOGEN" order="0" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="Trehalose synthesis kinetics" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_56">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        Ktrehalose
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_401" name="Ktrehalose" order="0" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="Succinate kinetics" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_57">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        k*A
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_400" name="A" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_399" name="k" order="1" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_1" name="Yeast glycolysis model of Pritchard and Kell" simulationType="time" timeUnit="min" volumeUnit="ml" areaUnit="m²" lengthUnit="m" quantityUnit="mmol" type="deterministic" avogadroConstant="6.0221407599999999e+23">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Model_1">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2024-11-13T13:31:22Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <Comment>
      From Pritchard and Kell (2002) Eur. J. Biochem. , modified from Teusink et al. 
(2000) Eur J Biochem 267, 5313-5329. This version uses the Vmaxes found by 
the best fit (R1) of Table 1 of the Pritchard and Kell paper, and simulates a decrease of external glucose  concentration from 100 to 2 mM

(More model files at http://users.aber.ac.uk/lep/models.shtml)
    </Comment>
    <ListOfCompartments>
      <Compartment key="Compartment_0" name="compartment" simulationType="fixed" dimensionality="3" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Compartment_0">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_0" name="GLCo" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_0">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_1" name="GLCi" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_1">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_2" name="ATP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_2">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_3" name="G6P" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_3">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_4" name="ADP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_4">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_5" name="F6P" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_5">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_6" name="F16bP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_6">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_7" name="AMP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_7">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_8" name="F26bP" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_8">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_9" name="DHAP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_9">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_10" name="GAP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_10">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_11" name="NAD" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_11">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_12" name="BPG" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_12">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_13" name="NADH" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_13">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_14" name="P3G" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_14">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_15" name="P2G" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_15">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_16" name="PEP" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_16">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_17" name="PYR" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_17">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_18" name="AcAld" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_18">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_19" name="CO2" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_19">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_20" name="EtOH" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_20">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_21" name="Glycerol" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_21">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_22" name="Glycogen" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_22">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_23" name="Trehalose" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_23">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_24" name="Succinate" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_24">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
    </ListOfMetabolites>
    <ListOfReactions>
      <Reaction key="Reaction_0" name="HXT" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_0">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_6922" name="Vmax" value="97.24"/>
          <Constant key="Parameter_6925" name="Kglc" value="1.1918"/>
          <Constant key="Parameter_5512" name="Ki" value="0.91"/>
        </ListOfConstants>
        <KineticLaw function="Function_41" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_273">
              <SourceParameter reference="Parameter_6922"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_272">
              <SourceParameter reference="Parameter_6925"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_266">
              <SourceParameter reference="Parameter_5512"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="HK" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_1">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5513" name="Vmax" value="236.7"/>
          <Constant key="Parameter_5515" name="Kglc" value="0.08"/>
          <Constant key="Parameter_5511" name="Katp" value="0.15"/>
          <Constant key="Parameter_5514" name="Keq" value="2000"/>
          <Constant key="Parameter_4680" name="Kg6p" value="30"/>
          <Constant key="Parameter_4681" name="Kadp" value="0.23"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_280">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_279">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_5513"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_281">
              <SourceParameter reference="Parameter_5515"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_282">
              <SourceParameter reference="Parameter_5511"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Parameter_5514"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_4680"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Parameter_4681"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_2" name="PGI" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_2">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4683" name="Vmax" value="1056"/>
          <Constant key="Parameter_4679" name="Kg6p" value="1.4"/>
          <Constant key="Parameter_4684" name="Keq" value="0.29"/>
          <Constant key="Parameter_4682" name="Kf6p" value="0.3"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_295">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_4683"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_292">
              <SourceParameter reference="Parameter_4679"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_291">
              <SourceParameter reference="Parameter_4684"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_290">
              <SourceParameter reference="Parameter_4682"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_3" name="PFK" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_3">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_7" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_6928" name="Vmax" value="110"/>
          <Constant key="Parameter_6929" name="gR" value="5.12"/>
          <Constant key="Parameter_6931" name="Kf6p" value="0.1"/>
          <Constant key="Parameter_6927" name="Katp" value="0.71"/>
          <Constant key="Parameter_6932" name="L0" value="0.66"/>
          <Constant key="Parameter_6930" name="Ciatp" value="100"/>
          <Constant key="Parameter_4652" name="Kiatp" value="0.65"/>
          <Constant key="Parameter_4653" name="Camp" value="0.0845"/>
          <Constant key="Parameter_4655" name="Kamp" value="0.0995"/>
          <Constant key="Parameter_4651" name="Cf26" value="0.0174"/>
          <Constant key="Parameter_4657" name="Kf26" value="0.000682"/>
          <Constant key="Parameter_4659" name="Cf16" value="0.397"/>
          <Constant key="Parameter_4658" name="Kf16" value="0.111"/>
          <Constant key="Parameter_4656" name="Catp" value="3"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_297">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_296">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_287">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_288">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_289">
              <SourceParameter reference="Parameter_6928"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_298">
              <SourceParameter reference="Parameter_6929"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_299">
              <SourceParameter reference="Parameter_6931"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_300">
              <SourceParameter reference="Parameter_6927"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Parameter_6932"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Parameter_6930"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_303">
              <SourceParameter reference="Parameter_4652"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_304">
              <SourceParameter reference="Parameter_4653"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_305">
              <SourceParameter reference="Parameter_4655"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_306">
              <SourceParameter reference="Parameter_4651"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_307">
              <SourceParameter reference="Parameter_4657"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_308">
              <SourceParameter reference="Parameter_4659"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_309">
              <SourceParameter reference="Parameter_4658"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_310">
              <SourceParameter reference="Parameter_4656"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_4" name="ALD" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_4">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4654" name="Vmax" value="94.69"/>
          <Constant key="Parameter_7512" name="Kf16bp" value="0.3"/>
          <Constant key="Parameter_7513" name="Keq" value="0.069"/>
          <Constant key="Parameter_7515" name="Kdhap" value="2"/>
          <Constant key="Parameter_7511" name="Kgap" value="2.4"/>
          <Constant key="Parameter_7516" name="Kigap" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_45" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_329">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_328">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_327">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_326">
              <SourceParameter reference="Parameter_4654"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_325">
              <SourceParameter reference="Parameter_7512"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_324">
              <SourceParameter reference="Parameter_7513"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_323">
              <SourceParameter reference="Parameter_7515"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_322">
              <SourceParameter reference="Parameter_7511"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_321">
              <SourceParameter reference="Parameter_7516"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_5" name="TPI" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_5">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_7514" name="k1" value="450000"/>
          <Constant key="Parameter_6031" name="k2" value="1e+07"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="Parameter_7514"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="Parameter_6031"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_6" name="GAPDH" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_6">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_6032" name="C" value="1"/>
          <Constant key="Parameter_6034" name="Vmaxf" value="1152"/>
          <Constant key="Parameter_6030" name="Kgap" value="0.21"/>
          <Constant key="Parameter_6033" name="Knad" value="0.09"/>
          <Constant key="Parameter_6515" name="Vmaxr" value="6719"/>
          <Constant key="Parameter_6516" name="Kbpg" value="0.0098"/>
          <Constant key="Parameter_6518" name="Knadh" value="0.06"/>
        </ListOfConstants>
        <KineticLaw function="Function_46" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_312">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_313">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_314">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_315">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_316">
              <SourceParameter reference="Parameter_6032"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_317">
              <SourceParameter reference="Parameter_6034"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_318">
              <SourceParameter reference="Parameter_6030"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_319">
              <SourceParameter reference="Parameter_6033"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_320">
              <SourceParameter reference="Parameter_6515"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_311">
              <SourceParameter reference="Parameter_6516"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_330">
              <SourceParameter reference="Parameter_6518"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="PGK" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_7">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_14" stoichiometry="1"/>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_6514" name="Vmax" value="1288"/>
          <Constant key="Parameter_6517" name="Keq" value="3200"/>
          <Constant key="Parameter_7350" name="Kp3g" value="0.53"/>
          <Constant key="Parameter_7351" name="Katp" value="0.3"/>
          <Constant key="Parameter_7353" name="Kbpg" value="0.003"/>
          <Constant key="Parameter_7349" name="Kadp" value="0.2"/>
        </ListOfConstants>
        <KineticLaw function="Function_47" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_341">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_340">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_339">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_338">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_337">
              <SourceParameter reference="Parameter_6514"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_336">
              <SourceParameter reference="Parameter_6517"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_335">
              <SourceParameter reference="Parameter_7350"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_334">
              <SourceParameter reference="Parameter_7351"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_333">
              <SourceParameter reference="Parameter_7353"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_332">
              <SourceParameter reference="Parameter_7349"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="PGM" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_8">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_7352" name="Vmax" value="2585"/>
          <Constant key="Parameter_4931" name="Kp3g" value="1.2"/>
          <Constant key="Parameter_4932" name="Keq" value="0.19"/>
          <Constant key="Parameter_4934" name="Kp2g" value="0.08"/>
        </ListOfConstants>
        <KineticLaw function="Function_48" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_350">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_349">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_348">
              <SourceParameter reference="Parameter_7352"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_347">
              <SourceParameter reference="Parameter_4931"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_346">
              <SourceParameter reference="Parameter_4932"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_345">
              <SourceParameter reference="Parameter_4934"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="ENO" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_9">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4930" name="Vmax" value="201.6"/>
          <Constant key="Parameter_4933" name="Kp2g" value="0.04"/>
          <Constant key="Parameter_6782" name="Keq" value="6.7"/>
          <Constant key="Parameter_6783" name="Kpep" value="0.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_49" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_352">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_351">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_331">
              <SourceParameter reference="Parameter_4930"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_342">
              <SourceParameter reference="Parameter_4933"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_343">
              <SourceParameter reference="Parameter_6782"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_344">
              <SourceParameter reference="Parameter_6783"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="PYK" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_10">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_16" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_6785" name="Vmax" value="1000"/>
          <Constant key="Parameter_6781" name="Kpep" value="0.14"/>
          <Constant key="Parameter_6784" name="Kadp" value="0.53"/>
          <Constant key="Parameter_8037" name="Keq" value="6500"/>
          <Constant key="Parameter_8038" name="Kpyr" value="21"/>
          <Constant key="Parameter_8040" name="Katp" value="1.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_50" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_358">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_357">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_356">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_355">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_354">
              <SourceParameter reference="Parameter_6785"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_353">
              <SourceParameter reference="Parameter_6781"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_359">
              <SourceParameter reference="Parameter_6784"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_360">
              <SourceParameter reference="Parameter_8037"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_361">
              <SourceParameter reference="Parameter_8038"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_362">
              <SourceParameter reference="Parameter_8040"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="PDC" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_11">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8036" name="Vmax" value="857.8"/>
          <Constant key="Parameter_8039" name="Kpyr" value="4.33"/>
          <Constant key="Parameter_8012" name="nH" value="1.9"/>
        </ListOfConstants>
        <KineticLaw function="Function_51" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_372">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_371">
              <SourceParameter reference="Parameter_8036"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_370">
              <SourceParameter reference="Parameter_8039"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_369">
              <SourceParameter reference="Parameter_8012"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="ADH" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_12">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_20" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8013" name="Vmax" value="209.5"/>
          <Constant key="Parameter_8015" name="Ketoh" value="17"/>
          <Constant key="Parameter_8011" name="Kinad" value="0.92"/>
          <Constant key="Parameter_8014" name="Keq" value="6.9e-05"/>
          <Constant key="Parameter_6843" name="Knad" value="0.17"/>
          <Constant key="Parameter_6844" name="Knadh" value="0.11"/>
          <Constant key="Parameter_6846" name="Kinadh" value="0.031"/>
          <Constant key="Parameter_6842" name="Kacald" value="1.11"/>
          <Constant key="Parameter_6845" name="Kiacald" value="1.1"/>
          <Constant key="Parameter_6631" name="Kietoh" value="90"/>
        </ListOfConstants>
        <KineticLaw function="Function_52" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_365">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_366">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_367">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_368">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_364">
              <SourceParameter reference="Parameter_8013"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_363">
              <SourceParameter reference="Parameter_8015"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_373">
              <SourceParameter reference="Parameter_8011"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_374">
              <SourceParameter reference="Parameter_8014"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_375">
              <SourceParameter reference="Parameter_6843"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_376">
              <SourceParameter reference="Parameter_6844"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_377">
              <SourceParameter reference="Parameter_6846"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_378">
              <SourceParameter reference="Parameter_6842"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_379">
              <SourceParameter reference="Parameter_6845"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_380">
              <SourceParameter reference="Parameter_6631"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="ATPase" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_13">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_6632" name="Katpase" value="39.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_53" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_394">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_393">
              <SourceParameter reference="Parameter_6632"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="AK" reversible="true" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_14">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="2"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_6634" name="k1" value="45"/>
          <Constant key="Parameter_6630" name="k2" value="100"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="Parameter_6634"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_4"/>
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="Parameter_6630"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_2"/>
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="G3PDH" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_15">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_21" stoichiometry="1"/>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_6633" name="Vmax" value="47.11"/>
          <Constant key="Parameter_8672" name="Kdhap" value="0.4"/>
          <Constant key="Parameter_8673" name="Knadh" value="0.023"/>
          <Constant key="Parameter_8675" name="Keq" value="4300"/>
          <Constant key="Parameter_8671" name="Kglycerol" value="1"/>
          <Constant key="Parameter_8674" name="Knad" value="0.93"/>
        </ListOfConstants>
        <KineticLaw function="Function_54" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_391">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_392">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_390">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_389">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_388">
              <SourceParameter reference="Parameter_6633"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_387">
              <SourceParameter reference="Parameter_8672"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_386">
              <SourceParameter reference="Parameter_8673"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_385">
              <SourceParameter reference="Parameter_8675"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_384">
              <SourceParameter reference="Parameter_8671"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_383">
              <SourceParameter reference="Parameter_8674"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="Glycogen Branch" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_16">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
          <Product metabolite="Metabolite_22" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8147" name="KGLYCOGEN" value="6"/>
        </ListOfConstants>
        <KineticLaw function="Function_55" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_402">
              <SourceParameter reference="Parameter_8147"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_17" name="Trehalose Branch" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_17">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="2"/>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8148" name="Ktrehalose" value="2.4"/>
        </ListOfConstants>
        <KineticLaw function="Function_56" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_401">
              <SourceParameter reference="Parameter_8148"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_18" name="Succinate Branch" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_18">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_18" stoichiometry="2"/>
          <Substrate metabolite="Metabolite_11" stoichiometry="3"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_24" stoichiometry="1"/>
          <Product metabolite="Metabolite_13" stoichiometry="3"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_8150" name="k" value="21.4"/>
        </ListOfConstants>
        <KineticLaw function="Function_57" unitType="Default" scalingCompartment="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_400">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_399">
              <SourceParameter reference="Parameter_8150"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfModelParameterSets activeSet="ModelParameterSet_1">
      <ModelParameterSet key="ModelParameterSet_1" name="Initial State">
        <MiriamAnnotation>
<rdf:RDF
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_1">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[GLCo]" value="1.204428152e+21" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[GLCi]" value="5.8807548099884278e+19" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[ATP]" value="1.5206673031128102e+21" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[G6P]" value="1.6109468264427217e+21" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[ADP]" value="7.7203102717063502e+20" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[F6P]" value="3.7636958857947926e+20" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[F16bP]" value="3.7465669334010204e+21" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[AMP]" value="1.7637938131655383e+20" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[F26bP]" value="1.204428152e+19" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[DHAP]" value="6.0471479945693404e+20" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[GAP]" value="2.7208584532125434e+19" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[NAD]" value="9.0530258018790841e+20" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[BPG]" value="4.4375559385044941e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[NADH]" value="5.2217800652092269e+19" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[P3G]" value="5.3337410475265491e+20" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[P2G]" value="7.6900218676555137e+19" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[PEP]" value="3.808113626695689e+19" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[PYR]" value="1.0932067470215735e+21" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[AcAld]" value="1.0727876469286763e+20" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[CO2]" value="6.0221407600000002e+20" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[EtOH]" value="3.0110703800000002e+22" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[Glycerol]" value="9.0332111399999996e+19" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[Glycogen]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[Trehalose]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Compartments[compartment],Vector=Metabolites[Succinate]" value="0" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HXT]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HXT],ParameterGroup=Parameters,Parameter=Vmax" value="97.239999999999995" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HXT],ParameterGroup=Parameters,Parameter=Kglc" value="1.1918" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HXT],ParameterGroup=Parameters,Parameter=Ki" value="0.91000000000000003" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HK],ParameterGroup=Parameters,Parameter=Vmax" value="236.69999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HK],ParameterGroup=Parameters,Parameter=Kglc" value="0.080000000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HK],ParameterGroup=Parameters,Parameter=Katp" value="0.14999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HK],ParameterGroup=Parameters,Parameter=Keq" value="2000" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HK],ParameterGroup=Parameters,Parameter=Kg6p" value="30" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[HK],ParameterGroup=Parameters,Parameter=Kadp" value="0.23000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGI]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGI],ParameterGroup=Parameters,Parameter=Vmax" value="1056" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGI],ParameterGroup=Parameters,Parameter=Kg6p" value="1.3999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGI],ParameterGroup=Parameters,Parameter=Keq" value="0.28999999999999998" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGI],ParameterGroup=Parameters,Parameter=Kf6p" value="0.29999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Vmax" value="110" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=gR" value="5.1200000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Kf6p" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Katp" value="0.70999999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=L0" value="0.66000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Ciatp" value="100" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Kiatp" value="0.65000000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Camp" value="0.084500000000000006" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Kamp" value="0.099500000000000005" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Cf26" value="0.017399999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Kf26" value="0.00068199999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Cf16" value="0.39700000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Kf16" value="0.111" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PFK],ParameterGroup=Parameters,Parameter=Catp" value="3" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ALD]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ALD],ParameterGroup=Parameters,Parameter=Vmax" value="94.689999999999998" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ALD],ParameterGroup=Parameters,Parameter=Kf16bp" value="0.29999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ALD],ParameterGroup=Parameters,Parameter=Keq" value="0.069000000000000006" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ALD],ParameterGroup=Parameters,Parameter=Kdhap" value="2" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ALD],ParameterGroup=Parameters,Parameter=Kgap" value="2.3999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ALD],ParameterGroup=Parameters,Parameter=Kigap" value="10" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[TPI]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[TPI],ParameterGroup=Parameters,Parameter=k1" value="450000" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[TPI],ParameterGroup=Parameters,Parameter=k2" value="10000000" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[GAPDH]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[GAPDH],ParameterGroup=Parameters,Parameter=C" value="1" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[GAPDH],ParameterGroup=Parameters,Parameter=Vmaxf" value="1152" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[GAPDH],ParameterGroup=Parameters,Parameter=Kgap" value="0.20999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[GAPDH],ParameterGroup=Parameters,Parameter=Knad" value="0.089999999999999997" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[GAPDH],ParameterGroup=Parameters,Parameter=Vmaxr" value="6719" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[GAPDH],ParameterGroup=Parameters,Parameter=Kbpg" value="0.0097999999999999997" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[GAPDH],ParameterGroup=Parameters,Parameter=Knadh" value="0.059999999999999998" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGK],ParameterGroup=Parameters,Parameter=Vmax" value="1288" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGK],ParameterGroup=Parameters,Parameter=Keq" value="3200" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGK],ParameterGroup=Parameters,Parameter=Kp3g" value="0.53000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGK],ParameterGroup=Parameters,Parameter=Katp" value="0.29999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGK],ParameterGroup=Parameters,Parameter=Kbpg" value="0.0030000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGK],ParameterGroup=Parameters,Parameter=Kadp" value="0.20000000000000001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGM]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGM],ParameterGroup=Parameters,Parameter=Vmax" value="2585" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGM],ParameterGroup=Parameters,Parameter=Kp3g" value="1.2" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGM],ParameterGroup=Parameters,Parameter=Keq" value="0.19" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PGM],ParameterGroup=Parameters,Parameter=Kp2g" value="0.080000000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ENO]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ENO],ParameterGroup=Parameters,Parameter=Vmax" value="201.59999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ENO],ParameterGroup=Parameters,Parameter=Kp2g" value="0.040000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ENO],ParameterGroup=Parameters,Parameter=Keq" value="6.7000000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ENO],ParameterGroup=Parameters,Parameter=Kpep" value="0.5" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PYK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PYK],ParameterGroup=Parameters,Parameter=Vmax" value="1000" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PYK],ParameterGroup=Parameters,Parameter=Kpep" value="0.14000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PYK],ParameterGroup=Parameters,Parameter=Kadp" value="0.53000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PYK],ParameterGroup=Parameters,Parameter=Keq" value="6500" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PYK],ParameterGroup=Parameters,Parameter=Kpyr" value="21" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PYK],ParameterGroup=Parameters,Parameter=Katp" value="1.5" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PDC]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PDC],ParameterGroup=Parameters,Parameter=Vmax" value="857.79999999999995" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PDC],ParameterGroup=Parameters,Parameter=Kpyr" value="4.3300000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[PDC],ParameterGroup=Parameters,Parameter=nH" value="1.8999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Vmax" value="209.5" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Ketoh" value="17" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Kinad" value="0.92000000000000004" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Keq" value="6.8999999999999997e-05" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Knad" value="0.17000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Knadh" value="0.11" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Kinadh" value="0.031" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Kacald" value="1.1100000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Kiacald" value="1.1000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ADH],ParameterGroup=Parameters,Parameter=Kietoh" value="90" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ATPase]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[ATPase],ParameterGroup=Parameters,Parameter=Katpase" value="39.5" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[AK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[AK],ParameterGroup=Parameters,Parameter=k1" value="45" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[AK],ParameterGroup=Parameters,Parameter=k2" value="100" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[G3PDH]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[G3PDH],ParameterGroup=Parameters,Parameter=Vmax" value="47.109999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[G3PDH],ParameterGroup=Parameters,Parameter=Kdhap" value="0.40000000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[G3PDH],ParameterGroup=Parameters,Parameter=Knadh" value="0.023" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[G3PDH],ParameterGroup=Parameters,Parameter=Keq" value="4300" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[G3PDH],ParameterGroup=Parameters,Parameter=Kglycerol" value="1" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[G3PDH],ParameterGroup=Parameters,Parameter=Knad" value="0.93000000000000005" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[Glycogen Branch]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[Glycogen Branch],ParameterGroup=Parameters,Parameter=KGLYCOGEN" value="6" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[Trehalose Branch]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[Trehalose Branch],ParameterGroup=Parameters,Parameter=Ktrehalose" value="2.3999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[Succinate Branch]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Yeast glycolysis model of Pritchard and Kell,Vector=Reactions[Succinate Branch],ParameterGroup=Parameters,Parameter=k" value="21.399999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_1"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_18"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Metabolite_15"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_17"/>
      <StateTemplateVariable objectReference="Metabolite_12"/>
      <StateTemplateVariable objectReference="Metabolite_16"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_14"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_19"/>
      <StateTemplateVariable objectReference="Metabolite_20"/>
      <StateTemplateVariable objectReference="Metabolite_21"/>
      <StateTemplateVariable objectReference="Metabolite_22"/>
      <StateTemplateVariable objectReference="Metabolite_23"/>
      <StateTemplateVariable objectReference="Metabolite_24"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 9.0530258018790841e+20 7.7203102717063502e+20 1.6109468264427217e+21 1.0727876469286763e+20 6.0471479945693404e+20 2.7208584532125434e+19 7.6900218676555137e+19 3.7636958857947926e+20 5.8807548099884278e+19 1.0932067470215735e+21 4.4375559385044941e+17 3.808113626695689e+19 3.7465669334010204e+21 5.3337410475265491e+20 1.5206673031128102e+21 5.2217800652092269e+19 1.7637938131655383e+20 1.204428152e+21 1.204428152e+19 6.0221407600000002e+20 3.0110703800000002e+22 9.0332111399999996e+19 0 0 0 1 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_17" name="Steady-State" type="steadyState" scheduled="true" updateModel="false">
      <Report reference="Report_11" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_18" name="Time-Course" type="timeCourse" scheduled="true" updateModel="false">
      <Report reference="Report_12" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.02"/>
        <Parameter name="Duration" type="float" value="2"/>
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
    <Task key="Task_19" name="Scan" type="scan" scheduled="false" updateModel="false">
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
    <Task key="Task_20" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_13" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_21" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_14" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_22" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_15" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_23" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_16" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_17"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Use Reder" type="bool" value="1"/>
        <Parameter name="Use Smallbone" type="bool" value="1"/>
      </Method>
    </Task>
    <Task key="Task_24" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_17" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_25" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_18" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_26" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_19" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_27" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Report reference="Report_20" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_28" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
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
    <Task key="Task_29" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_21" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_17"/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
    <Task key="Task_30" name="Time-Course Sensitivities" type="timeSensitivities" scheduled="false" updateModel="false">
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
    <Report key="Report_11" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_12" name="Time-Course" taskType="timeCourse" separator="&#x09;" precision="6">
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
    <Report key="Report_13" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_14" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
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
    <Report key="Report_15" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
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
    <Report key="Report_16" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_17" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
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
    <Report key="Report_18" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_19" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
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
    <Report key="Report_20" name="Moieties" taskType="moieties" separator="&#x09;" precision="6">
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
    <Report key="Report_21" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
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
