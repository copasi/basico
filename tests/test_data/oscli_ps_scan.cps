<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.42 (Build 284) (http://www.copasi.org) at 2023-12-05T13:26:08Z -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="42" versionDevel="284" copasiSourcesModified="0">
  <ListOfFunctions>
    <Function key="Function_41" name="Function for J0" type="UserDefined" reversible="unspecified">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_41">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        J0_v0/compartment
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_275" name="J0_v0" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_274" name="compartment" order="1" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_42" name="Function for J1" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_42">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        J1_k3*S1/compartment
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_272" name="J1_k3" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_273" name="S1" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_266" name="compartment" order="2" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_43" name="Function for J2" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_43">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        (J2_k1*S1-J2_k_1*S2)*(1+J2_c*S2^J2_q)/compartment
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_278" name="J2_c" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_277" name="J2_k1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_276" name="J2_k_1" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_279" name="J2_q" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_280" name="S1" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_281" name="S2" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_282" name="compartment" order="6" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_44" name="Function for J3" type="UserDefined" reversible="false">
      <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Function_44">
</rdf:Description>
</rdf:RDF>
      </MiriamAnnotation>
      <Expression>
        J3_k2*S2/compartment
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_289" name="J3_k2" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_288" name="S2" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_287" name="compartment" order="2" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_0" name="Oscli (Heinrich model)" simulationType="time" timeUnit="s" volumeUnit="l" areaUnit="m²" lengthUnit="m" quantityUnit="mol" type="deterministic" avogadroConstant="6.0221407599999999e+23">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Model_0">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2023-11-06T10:07:40Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <ListOfUnsupportedAnnotations>
      <UnsupportedAnnotation name="http://projects.eml.org/bcb/sbml/level2">
<layout:listOfLayouts xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:layout="http://projects.eml.org/bcb/sbml/level2">
  <layout:layout layout:id="JDesigner2_0">
    <annotation>
      <listOfRenderStyles xmlns="http://sys-bio.org/xml/render/level1">
        <renderStyle id="RenderStyle_0">
          <fillStyle fillType="Solid" startColor="ffffffef" />
          <listOfSpeciesStyles>
            <speciesStyle id="sStyle_0" reference="sGlyph_0">
              <listOfShapes>
                <shape kind="RoundedRectangle">
                  <fillStyle fillType="LinearGradient" startColor="ffccffff" endColor="ffffffff" gradientStyle="Horizontal" />
                  <boundingBox>
                    <position x="0" y="0" />
                    <dimensions width="24" height="24" />
                  </boundingBox>
                  <edgeStyle color="ff969696" thickness="1" style="Solid" />
                </shape>
              </listOfShapes>
            </speciesStyle>
            <speciesStyle id="sStyle_1" reference="sGlyph_1">
              <listOfShapes>
                <shape kind="RoundedRectangle">
                  <fillStyle fillType="LinearGradient" startColor="ffccffff" endColor="ffffffff" gradientStyle="Horizontal" />
                  <boundingBox>
                    <position x="0" y="0" />
                    <dimensions width="24" height="24" />
                  </boundingBox>
                  <edgeStyle color="ff969696" thickness="1" style="Solid" />
                </shape>
              </listOfShapes>
            </speciesStyle>
            <speciesStyle id="sStyle_2" reference="sGlyph_2">
              <listOfShapes>
                <shape kind="RoundedRectangle">
                  <fillStyle fillType="LinearGradient" startColor="ffccffff" endColor="ffffffff" gradientStyle="Horizontal" />
                  <boundingBox>
                    <position x="0" y="0" />
                    <dimensions width="24" height="24" />
                  </boundingBox>
                  <edgeStyle color="ff000000" thickness="3" style="Solid" />
                </shape>
              </listOfShapes>
            </speciesStyle>
            <speciesStyle id="sStyle_3" reference="sGlyph_3">
              <listOfShapes>
                <shape kind="RoundedRectangle">
                  <fillStyle fillType="LinearGradient" startColor="ffccffff" endColor="ffffffff" gradientStyle="Horizontal" />
                  <boundingBox>
                    <position x="0" y="0" />
                    <dimensions width="24" height="24" />
                  </boundingBox>
                  <edgeStyle color="ff000000" thickness="3" style="Solid" />
                </shape>
              </listOfShapes>
            </speciesStyle>
            <speciesStyle id="sStyle_4" reference="sGlyph_4">
              <listOfShapes>
                <shape kind="RoundedRectangle">
                  <fillStyle fillType="LinearGradient" startColor="ffccffff" endColor="ffffffff" gradientStyle="Horizontal" />
                  <boundingBox>
                    <position x="0" y="0" />
                    <dimensions width="24" height="24" />
                  </boundingBox>
                  <edgeStyle color="ff000000" thickness="3" style="Solid" />
                </shape>
              </listOfShapes>
            </speciesStyle>
          </listOfSpeciesStyles>
          <listOfReactionStyles>
            <reactionStyle id="rStyle_0" reference="rGlyph_0">
              <arrow kind="default">
                <fillStyle fillType="Solid" startColor="ffc0c0c0" />
                <lineStyle color="ff000000" thickness="2" style="Solid" />
              </arrow>
              <lineStyle color="ffff6600" thickness="2" style="Solid" />
            </reactionStyle>
            <reactionStyle id="rStyle_1" reference="rGlyph_1">
              <arrow kind="default">
                <fillStyle fillType="Solid" startColor="ffc0c0c0" />
                <lineStyle color="ff000000" thickness="2" style="Solid" />
              </arrow>
              <lineStyle color="ffff6600" thickness="2" style="Solid" />
            </reactionStyle>
            <reactionStyle id="rStyle_2" reference="rGlyph_2">
              <arrow kind="default">
                <fillStyle fillType="Solid" startColor="ffc0c0c0" />
                <lineStyle color="ff000000" thickness="2" style="Solid" />
              </arrow>
              <lineStyle color="ffff6600" thickness="2" style="Solid" />
            </reactionStyle>
            <reactionStyle id="rStyle_3" reference="rGlyph_3">
              <arrow kind="default">
                <fillStyle fillType="Solid" startColor="ffc0c0c0" />
                <lineStyle color="ff000000" thickness="2" style="Solid" />
              </arrow>
              <lineStyle color="ffff6600" thickness="2" style="Solid" />
            </reactionStyle>
          </listOfReactionStyles>
          <listOfTextStyles>
            <textStyle>
              <fontStyle id="tStyle_0" reference="tGlyph_0" font="Arial" calculateSize="False" size="8">
                <fillStyle fillType="Solid" startColor="ff000000" />
              </fontStyle>
            </textStyle>
            <textStyle>
              <fontStyle id="tStyle_1" reference="tGlyph_1" font="Arial" calculateSize="False" size="8">
                <fillStyle fillType="Solid" startColor="ff000000" />
              </fontStyle>
            </textStyle>
            <textStyle>
              <fontStyle id="tStyle_2" reference="tGlyph_2" font="Arial" calculateSize="False" size="8">
                <fillStyle fillType="Solid" startColor="ff000000" />
              </fontStyle>
            </textStyle>
            <textStyle>
              <fontStyle id="tStyle_3" reference="tGlyph_3" font="Arial" calculateSize="False" size="8">
                <fillStyle fillType="Solid" startColor="ff000000" />
              </fontStyle>
            </textStyle>
            <textStyle>
              <fontStyle id="tStyle_4" reference="tGlyph_4" font="Arial" calculateSize="False" size="8">
                <fillStyle fillType="Solid" startColor="ff000000" />
              </fontStyle>
            </textStyle>
          </listOfTextStyles>
        </renderStyle>
      </listOfRenderStyles>
      <render:listOfRenderInformation xmlns:render="http://projects.eml.org/bcb/sbml/render/level2">
        <render:renderInformation render:id="ConvertedRenderStyle" render:programName="SBML Layout Viewer - SBW version" render:programVersion="2.7.5569.27733 Compiled on: 4/1/2015 3:24:26 PM" render:backgroundColor="#FFFFFFFF">
          <render:listOfColorDefinitions>
            <render:colorDefinition render:id="Color_0" render:value="#969696" />
            <render:colorDefinition render:id="Color_1" render:value="#000000" />
            <render:colorDefinition render:id="Color_2" render:value="#ff6600" />
          </render:listOfColorDefinitions>
          <render:listOfGradientDefinitions>
            <render:linearGradient render:id="LinearGradient_0" render:y2="0">
              <render:stop render:offset="0" render:stop-color="#ccffff" />
              <render:stop render:offset="100%" render:stop-color="#ffffff" />
            </render:linearGradient>
          </render:listOfGradientDefinitions>
          <render:listOfLineEndings>
            <render:lineEnding render:id="product">
              <layout:boundingBox>
                <layout:position layout:x="-10" layout:y="-5" />
                <layout:dimensions layout:width="10" layout:height="10" />
              </layout:boundingBox>
              <render:g render:stroke="Color_2" render:stroke-width="0.001" render:fill="Color_2" render:font-weight="normal" render:font-style="normal" render:text-anchor="start" render:vtext-anchor="top" render:font-size="0">
                <render:polygon render:fill="Color_2">
                  <render:listOfElements>
                    <render:element xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="RenderPoint" render:x="0" render:y="0" />
                    <render:element xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="RenderPoint" render:x="100%" render:y="50%" />
                    <render:element xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="RenderPoint" render:x="0" render:y="100%" />
                    <render:element xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="RenderPoint" render:x="33%" render:y="50%" />
                    <render:element xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="RenderPoint" render:x="0" render:y="0" />
                  </render:listOfElements>
                </render:polygon>
              </render:g>
            </render:lineEnding>
            <render:lineEnding render:id="activator">
              <layout:boundingBox>
                <layout:position layout:x="-8" layout:y="-4" />
                <layout:dimensions layout:width="8" layout:height="8" />
              </layout:boundingBox>
              <render:g render:stroke="Color_2" render:stroke-width="1" render:fill="#ffffff" render:font-weight="normal" render:font-style="normal" render:text-anchor="start" render:vtext-anchor="top" render:font-size="0">
                <render:ellipse render:stroke="Color_2" render:stroke-width="1" render:fill="#ffffff" render:cx="50%" render:cy="50%" render:rx="50%" />
              </render:g>
            </render:lineEnding>
          </render:listOfLineEndings>
          <render:listOfStyles>
            <render:style render:idList="sGlyph_0 sGlyph_1">
              <render:g render:stroke-width="0" render:fill-rule="nonzero" render:font-family="sans-serif" render:font-weight="normal" render:font-style="normal" render:text-anchor="start" render:vtext-anchor="top" render:font-size="0">
                <render:rectangle render:stroke="Color_0" render:stroke-width="1" render:fill="LinearGradient_0" render:x="0" render:y="0" render:width="24" render:height="24" render:rx="5" render:ry="5" />
              </render:g>
            </render:style>
            <render:style render:idList="sGlyph_2 sGlyph_3 sGlyph_4">
              <render:g render:stroke-width="0" render:fill-rule="nonzero" render:font-family="sans-serif" render:font-weight="normal" render:font-style="normal" render:text-anchor="start" render:vtext-anchor="top" render:font-size="0">
                <render:rectangle render:stroke="Color_1" render:stroke-width="3" render:fill="LinearGradient_0" render:x="0" render:y="0" render:width="24" render:height="24" render:rx="5" render:ry="5" />
              </render:g>
            </render:style>
            <render:style render:roleList="product">
              <render:g render:stroke="Color_2" render:stroke-width="2" render:fill-rule="nonzero" render:endHead="product" render:font-family="sans-serif" render:font-weight="normal" render:font-style="normal" render:text-anchor="start" render:vtext-anchor="top" render:font-size="0" />
            </render:style>
            <render:style render:roleList="sidesubstrate substrate" render:idList="rGlyph_0 rGlyph_1 rGlyph_2 rGlyph_3">
              <render:g render:stroke="Color_2" render:stroke-width="2" render:fill-rule="nonzero" render:font-family="sans-serif" render:font-weight="normal" render:font-style="normal" render:text-anchor="start" render:vtext-anchor="top" render:font-size="0" />
            </render:style>
            <render:style render:roleList="activator">
              <render:g render:stroke="Color_2" render:stroke-width="2" render:fill-rule="nonzero" render:endHead="activator" render:font-family="sans-serif" render:font-weight="normal" render:font-style="normal" render:text-anchor="start" render:vtext-anchor="top" render:font-size="0" />
            </render:style>
            <render:style render:idList="tGlyph_0 tGlyph_1 tGlyph_2 tGlyph_3 tGlyph_4">
              <render:g render:stroke="Color_1" render:stroke-width="0" render:fill-rule="nonzero" render:font-family="Arial" render:font-weight="normal" render:font-style="normal" render:text-anchor="middle" render:vtext-anchor="top" render:font-size="11" />
            </render:style>
          </render:listOfStyles>
        </render:renderInformation>
      </render:listOfRenderInformation>
    </annotation>
    <layout:dimensions layout:width="451.503471374512" layout:height="320.5" />
    <layout:listOfSpeciesGlyphs>
      <layout:speciesGlyph layout:id="sGlyph_0" layout:species="S1">
        <layout:boundingBox>
          <layout:position layout:x="206" layout:y="106" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:speciesGlyph>
      <layout:speciesGlyph layout:id="sGlyph_1" layout:species="S2">
        <layout:boundingBox>
          <layout:position layout:x="123" layout:y="176" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:speciesGlyph>
      <layout:speciesGlyph layout:id="sGlyph_2" layout:species="X0">
        <layout:boundingBox>
          <layout:position layout:x="104" layout:y="46" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:speciesGlyph>
      <layout:speciesGlyph layout:id="sGlyph_3" layout:species="X1">
        <layout:boundingBox>
          <layout:position layout:x="324" layout:y="177" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:speciesGlyph>
      <layout:speciesGlyph layout:id="sGlyph_4" layout:species="X2">
        <layout:boundingBox>
          <layout:position layout:x="236" layout:y="250" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:speciesGlyph>
    </layout:listOfSpeciesGlyphs>
    <layout:listOfReactionGlyphs>
      <layout:reactionGlyph layout:id="rGlyph_0" layout:reaction="J0">
        <layout:boundingBox>
          <layout:position layout:x="0" layout:y="0" />
          <layout:dimensions layout:width="0" layout:height="0" />
        </layout:boundingBox>
        <layout:listOfSpeciesReferenceGlyphs>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J0_0" render:objectRole="product" layout:speciesReference="S1" layout:speciesGlyph="sGlyph_0" layout:role="product">
            <layout:curve>
              <layout:listOfCurveSegments>
                <layout:curveSegment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="LineSegment">
                  <layout:start layout:x="134" layout:y="69.0588235294118" />
                  <layout:end layout:x="200" layout:y="106.941176470588" />
                </layout:curveSegment>
              </layout:listOfCurveSegments>
            </layout:curve>
          </layout:speciesReferenceGlyph>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J0_2" render:objectRole="substrate" layout:speciesReference="X0" layout:speciesGlyph="sGlyph_2" layout:role="substrate">
            <layout:boundingBox>
              <layout:position layout:x="0" layout:y="0" />
              <layout:dimensions layout:width="0" layout:height="0" />
            </layout:boundingBox>
          </layout:speciesReferenceGlyph>
        </layout:listOfSpeciesReferenceGlyphs>
      </layout:reactionGlyph>
      <layout:reactionGlyph layout:id="rGlyph_1" layout:reaction="J1">
        <layout:boundingBox>
          <layout:position layout:x="0" layout:y="0" />
          <layout:dimensions layout:width="0" layout:height="0" />
        </layout:boundingBox>
        <layout:listOfSpeciesReferenceGlyphs>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J1_0" render:objectRole="product" layout:speciesReference="X1" layout:speciesGlyph="sGlyph_3" layout:role="product">
            <layout:curve>
              <layout:listOfCurveSegments>
                <layout:curveSegment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="LineSegment">
                  <layout:start layout:x="236" layout:y="129.220338983051" />
                  <layout:end layout:x="318" layout:y="177.779661016949" />
                </layout:curveSegment>
              </layout:listOfCurveSegments>
            </layout:curve>
          </layout:speciesReferenceGlyph>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J1_2" render:objectRole="substrate" layout:speciesReference="S1" layout:speciesGlyph="sGlyph_0" layout:role="substrate">
            <layout:boundingBox>
              <layout:position layout:x="0" layout:y="0" />
              <layout:dimensions layout:width="0" layout:height="0" />
            </layout:boundingBox>
          </layout:speciesReferenceGlyph>
        </layout:listOfSpeciesReferenceGlyphs>
      </layout:reactionGlyph>
      <layout:reactionGlyph layout:id="rGlyph_2" layout:reaction="J2">
        <layout:boundingBox>
          <layout:position layout:x="0" layout:y="0" />
          <layout:dimensions layout:width="0" layout:height="0" />
        </layout:boundingBox>
        <layout:listOfSpeciesReferenceGlyphs>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J2_0" render:objectRole="product" layout:speciesReference="S2" layout:speciesGlyph="sGlyph_1" layout:role="product">
            <layout:curve>
              <layout:listOfCurveSegments>
                <layout:curveSegment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="LineSegment">
                  <layout:start layout:x="200" layout:y="133.120481927711" />
                  <layout:end layout:x="153" layout:y="172.879518072289" />
                </layout:curveSegment>
              </layout:listOfCurveSegments>
            </layout:curve>
          </layout:speciesReferenceGlyph>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J2_2" render:objectRole="substrate" layout:speciesReference="S1" layout:speciesGlyph="sGlyph_0" layout:role="substrate">
            <layout:boundingBox>
              <layout:position layout:x="0" layout:y="0" />
              <layout:dimensions layout:width="0" layout:height="0" />
            </layout:boundingBox>
          </layout:speciesReferenceGlyph>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J2_3" render:objectRole="activator" layout:speciesReference="S2" layout:speciesGlyph="sGlyph_1" layout:role="activator">
            <layout:curve>
              <layout:listOfCurveSegments>
                <layout:curveSegment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="LineSegment">
                  <layout:start layout:x="118" layout:y="172.371428571429" />
                  <layout:end layout:x="100" layout:y="157" />
                </layout:curveSegment>
                <layout:curveSegment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="LineSegment">
                  <layout:start layout:x="100" layout:y="157" />
                  <layout:end layout:x="137" layout:y="132" />
                </layout:curveSegment>
                <layout:curveSegment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="LineSegment">
                  <layout:start layout:x="137" layout:y="132" />
                  <layout:end layout:x="171" layout:y="143" />
                </layout:curveSegment>
              </layout:listOfCurveSegments>
            </layout:curve>
          </layout:speciesReferenceGlyph>
        </layout:listOfSpeciesReferenceGlyphs>
      </layout:reactionGlyph>
      <layout:reactionGlyph layout:id="rGlyph_3" layout:reaction="J3">
        <layout:boundingBox>
          <layout:position layout:x="0" layout:y="0" />
          <layout:dimensions layout:width="0" layout:height="0" />
        </layout:boundingBox>
        <layout:listOfSpeciesReferenceGlyphs>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J3_0" render:objectRole="product" layout:speciesReference="X2" layout:speciesGlyph="sGlyph_4" layout:role="product">
            <layout:curve>
              <layout:listOfCurveSegments>
                <layout:curveSegment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="LineSegment">
                  <layout:start layout:x="153" layout:y="199.858407079646" />
                  <layout:end layout:x="230" layout:y="250.141592920354" />
                </layout:curveSegment>
              </layout:listOfCurveSegments>
            </layout:curve>
          </layout:speciesReferenceGlyph>
          <layout:speciesReferenceGlyph xmlns:render="http://projects.eml.org/bcb/sbml/render/level2" layout:id="SpeciesReference_J3_2" render:objectRole="substrate" layout:speciesReference="S2" layout:speciesGlyph="sGlyph_1" layout:role="substrate">
            <layout:boundingBox>
              <layout:position layout:x="0" layout:y="0" />
              <layout:dimensions layout:width="0" layout:height="0" />
            </layout:boundingBox>
          </layout:speciesReferenceGlyph>
        </layout:listOfSpeciesReferenceGlyphs>
      </layout:reactionGlyph>
    </layout:listOfReactionGlyphs>
    <layout:listOfTextGlyphs>
      <layout:textGlyph layout:id="tGlyph_0" layout:text="S1" layout:graphicalObject="sGlyph_0">
        <layout:boundingBox>
          <layout:position layout:x="206" layout:y="106" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:textGlyph>
      <layout:textGlyph layout:id="tGlyph_1" layout:text="S2" layout:graphicalObject="sGlyph_1">
        <layout:boundingBox>
          <layout:position layout:x="123" layout:y="176" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:textGlyph>
      <layout:textGlyph layout:id="tGlyph_2" layout:text="X0" layout:graphicalObject="sGlyph_2">
        <layout:boundingBox>
          <layout:position layout:x="104" layout:y="46" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:textGlyph>
      <layout:textGlyph layout:id="tGlyph_3" layout:text="X1" layout:graphicalObject="sGlyph_3">
        <layout:boundingBox>
          <layout:position layout:x="324" layout:y="177" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:textGlyph>
      <layout:textGlyph layout:id="tGlyph_4" layout:text="X2" layout:graphicalObject="sGlyph_4">
        <layout:boundingBox>
          <layout:position layout:x="236" layout:y="250" />
          <layout:dimensions layout:width="24" layout:height="24" />
        </layout:boundingBox>
      </layout:textGlyph>
    </layout:listOfTextGlyphs>
  </layout:layout>
</layout:listOfLayouts>
      </UnsupportedAnnotation>
      <UnsupportedAnnotation name="http://www.sys-bio.org/sbml/jd2">
<jd2:JDesignerLayout xmlns:jd2="http://www.sys-bio.org/sbml/jd2" version="2.0" MajorVersion="2" MinorVersion="3" BuildVersion="45">
  <jd2:header>
    <jd2:VersionHeader JDesignerVersion="1.0" />
    <jd2:ModelHeader ModelTitle="Oscli (Heinrich model)" />
    <jd2:TimeCourseDetails timeStart="0" timeEnd="15" numberOfPoints="300" />
  </jd2:header>
  <jd2:JDGraphicsHeader BackGroundColor="FFFFFFEF" />
  <jd2:listOfCompartments>
    <jd2:compartment id="compartment" size="1" visible="false">
      <jd2:boundingBox x="0" y="0" w="0" h="0" />
      <jd2:membraneStyle thickness="12" color="FF00A5FF" />
      <jd2:interiorStyle color="FFEEEEFF" />
      <jd2:text value="compartment" visible="true">
        <jd2:position rx="-31" ry="-16" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:text>
    </jd2:compartment>
  </jd2:listOfCompartments>
  <jd2:listOfSpecies>
    <jd2:species id="S1" boundaryCondition="false" compartment="compartment" initialConcentration="0">
      <jd2:positionLocked value="false" />
      <jd2:boundingBox x="206" y="106" />
      <jd2:displayValue visible="false">
        <jd2:position rx="0" ry="0" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:displayValue>
      <jd2:text value="S1" visible="true">
        <jd2:position rx="4" ry="6" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:text>
      <jd2:complex id="DefaultMolecule" w="24" h="24" boundarySpeciesStyle="bsBox" boundaryStyleColor="FF0000FF" captionPosition="npCenter" aliasBoundaryColor="FFFF0000" aliasBoundaryThickness="3">
        <jd2:subunit shape="suRoundSquare">
          <jd2:boundingBox rx="0" ry="0" w="24" h="24" />
          <jd2:text value="S1" visible="false">
            <jd2:position rx="6" ry="5" />
            <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
          </jd2:text>
          <jd2:color scheme="gtHorizLinear" startColor="FFCCFFFF" endColor="FFFFFFFF" />
          <jd2:edgeStyle color="FF969696" thickness="1" stroke="dsSolid" />
        </jd2:subunit>
      </jd2:complex>
    </jd2:species>
    <jd2:species id="S2" boundaryCondition="false" compartment="compartment" initialConcentration="1">
      <jd2:positionLocked value="false" />
      <jd2:boundingBox x="123" y="176" />
      <jd2:displayValue visible="false">
        <jd2:position rx="0" ry="0" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:displayValue>
      <jd2:text value="S2" visible="true">
        <jd2:position rx="4" ry="6" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:text>
      <jd2:complex id="DefaultMolecule" w="24" h="24" boundarySpeciesStyle="bsBox" boundaryStyleColor="FF0000FF" captionPosition="npCenter" aliasBoundaryColor="FFFF0000" aliasBoundaryThickness="3">
        <jd2:subunit shape="suRoundSquare">
          <jd2:boundingBox rx="0" ry="0" w="24" h="24" />
          <jd2:text value="S1" visible="false">
            <jd2:position rx="6" ry="5" />
            <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
          </jd2:text>
          <jd2:color scheme="gtHorizLinear" startColor="FFCCFFFF" endColor="FFFFFFFF" />
          <jd2:edgeStyle color="FF969696" thickness="1" stroke="dsSolid" />
        </jd2:subunit>
      </jd2:complex>
    </jd2:species>
    <jd2:species id="X0" boundaryCondition="true" compartment="compartment" initialConcentration="1">
      <jd2:positionLocked value="false" />
      <jd2:boundingBox x="104" y="46" />
      <jd2:displayValue visible="false">
        <jd2:position rx="0" ry="0" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:displayValue>
      <jd2:text value="X0" visible="true">
        <jd2:position rx="4" ry="6" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:text>
      <jd2:complex id="DefaultMolecule" w="24" h="24" boundarySpeciesStyle="bsBox" boundaryStyleColor="FF0000FF" captionPosition="npCenter" aliasBoundaryColor="FFFF0000" aliasBoundaryThickness="3">
        <jd2:subunit shape="suRoundSquare">
          <jd2:boundingBox rx="0" ry="0" w="24" h="24" />
          <jd2:text value="S1" visible="false">
            <jd2:position rx="6" ry="5" />
            <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
          </jd2:text>
          <jd2:color scheme="gtHorizLinear" startColor="FFCCFFFF" endColor="FFFFFFFF" />
          <jd2:edgeStyle color="FF969696" thickness="1" stroke="dsSolid" />
        </jd2:subunit>
      </jd2:complex>
    </jd2:species>
    <jd2:species id="X1" boundaryCondition="true" compartment="compartment" initialConcentration="0">
      <jd2:positionLocked value="false" />
      <jd2:boundingBox x="324" y="177" />
      <jd2:displayValue visible="false">
        <jd2:position rx="0" ry="0" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:displayValue>
      <jd2:text value="X1" visible="true">
        <jd2:position rx="4" ry="6" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:text>
      <jd2:complex id="DefaultMolecule" w="24" h="24" boundarySpeciesStyle="bsBox" boundaryStyleColor="FF0000FF" captionPosition="npCenter" aliasBoundaryColor="FFFF0000" aliasBoundaryThickness="3">
        <jd2:subunit shape="suRoundSquare">
          <jd2:boundingBox rx="0" ry="0" w="24" h="24" />
          <jd2:text value="S1" visible="false">
            <jd2:position rx="6" ry="5" />
            <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
          </jd2:text>
          <jd2:color scheme="gtHorizLinear" startColor="FFCCFFFF" endColor="FFFFFFFF" />
          <jd2:edgeStyle color="FF969696" thickness="1" stroke="dsSolid" />
        </jd2:subunit>
      </jd2:complex>
    </jd2:species>
    <jd2:species id="X2" boundaryCondition="true" compartment="compartment" initialConcentration="0">
      <jd2:positionLocked value="false" />
      <jd2:boundingBox x="236" y="250" />
      <jd2:displayValue visible="false">
        <jd2:position rx="0" ry="0" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:displayValue>
      <jd2:text value="X2" visible="true">
        <jd2:position rx="4" ry="6" />
        <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
      </jd2:text>
      <jd2:complex id="DefaultMolecule" w="24" h="24" boundarySpeciesStyle="bsBox" boundaryStyleColor="FF0000FF" captionPosition="npCenter" aliasBoundaryColor="FFFF0000" aliasBoundaryThickness="3">
        <jd2:subunit shape="suRoundSquare">
          <jd2:boundingBox rx="0" ry="0" w="24" h="24" />
          <jd2:text value="S1" visible="false">
            <jd2:position rx="6" ry="5" />
            <jd2:font fontName="Arial" fontSize="8" fontColor="FF000000" />
          </jd2:text>
          <jd2:color scheme="gtHorizLinear" startColor="FFCCFFFF" endColor="FFFFFFFF" />
          <jd2:edgeStyle color="FF969696" thickness="1" stroke="dsSolid" />
        </jd2:subunit>
      </jd2:complex>
    </jd2:species>
  </jd2:listOfSpecies>
  <jd2:listOfReactions>
    <jd2:reaction id="J0" reversible="false">
      <jd2:listOfReactants>
        <jd2:speciesReference species="X0" stoichiometry="1" />
      </jd2:listOfReactants>
      <jd2:listOfProducts>
        <jd2:speciesReference species="S1" stoichiometry="1" />
      </jd2:listOfProducts>
      <jd2:listOfModifierEdges />
      <jd2:kineticLaw type="explicit">
        <jd2:rateEquation value="J0_v0" />
      </jd2:kineticLaw>
      <jd2:display arrowStyle="ar1" arrowFillColor="FFC0C0C0" lineColor="FFFF6600" lineThickness="2">
        <jd2:lineType type="ltLine">
          <jd2:edge>
            <jd2:pt x="116" y="58" type="substrate" speciesRef="X0" />
            <jd2:pt x="218" y="118" type="product" speciesRef="S1" />
          </jd2:edge>
        </jd2:lineType>
      </jd2:display>
    </jd2:reaction>
    <jd2:reaction id="J1" reversible="false">
      <jd2:listOfReactants>
        <jd2:speciesReference species="S1" stoichiometry="1" />
      </jd2:listOfReactants>
      <jd2:listOfProducts>
        <jd2:speciesReference species="X1" stoichiometry="1" />
      </jd2:listOfProducts>
      <jd2:listOfModifierEdges />
      <jd2:kineticLaw type="explicit">
        <jd2:rateEquation value="J1_k3*S1" />
      </jd2:kineticLaw>
      <jd2:display arrowStyle="ar1" arrowFillColor="FFC0C0C0" lineColor="FFFF6600" lineThickness="2">
        <jd2:lineType type="ltLine">
          <jd2:edge>
            <jd2:pt x="218" y="118" type="substrate" speciesRef="S1" />
            <jd2:pt x="336" y="189" type="product" speciesRef="X1" />
          </jd2:edge>
        </jd2:lineType>
      </jd2:display>
    </jd2:reaction>
    <jd2:reaction id="J2" reversible="false">
      <jd2:listOfReactants>
        <jd2:speciesReference species="S1" stoichiometry="1" />
      </jd2:listOfReactants>
      <jd2:listOfProducts>
        <jd2:speciesReference species="S2" stoichiometry="1" />
      </jd2:listOfProducts>
      <jd2:listOfModifierEdges>
        <jd2:modifierEdge>
          <jd2:speciesReference species="S2" />
          <jd2:destinationReaction name="J2" regulatorType="rtPositive" relativePosition="0.485714285714286" destinationArcId="0" destinationLineSegmentId="0" />
          <jd2:display lineThickness="2" lineColor="FF0000FF" lineDashStyle="dsSolid" positiveMarkerStyle="rmEmptyCircle">
            <jd2:lineType type="ltSegmentedLine">
              <jd2:pt x="135" y="188" type="modifier" speciesRef="S2" />
              <jd2:pt x="100" y="157" />
              <jd2:pt x="137" y="132" />
              <jd2:pt x="171" y="143" />
            </jd2:lineType>
          </jd2:display>
        </jd2:modifierEdge>
      </jd2:listOfModifierEdges>
      <jd2:kineticLaw type="explicit">
        <jd2:rateEquation value="(J2_k1*S1-J2_k_1*S2)*(1+J2_c*pow(S2,J2_q))" />
      </jd2:kineticLaw>
      <jd2:display arrowStyle="ar1" arrowFillColor="FFC0C0C0" lineColor="FFFF6600" lineThickness="2">
        <jd2:lineType type="ltLine">
          <jd2:edge>
            <jd2:pt x="218" y="118" type="substrate" speciesRef="S1" />
            <jd2:pt x="135" y="188" type="product" speciesRef="S2" />
          </jd2:edge>
        </jd2:lineType>
      </jd2:display>
    </jd2:reaction>
    <jd2:reaction id="J3" reversible="false">
      <jd2:listOfReactants>
        <jd2:speciesReference species="S2" stoichiometry="1" />
      </jd2:listOfReactants>
      <jd2:listOfProducts>
        <jd2:speciesReference species="X2" stoichiometry="1" />
      </jd2:listOfProducts>
      <jd2:listOfModifierEdges />
      <jd2:kineticLaw type="explicit">
        <jd2:rateEquation value="J3_k2*S2" />
      </jd2:kineticLaw>
      <jd2:display arrowStyle="ar1" arrowFillColor="FFC0C0C0" lineColor="FFFF6600" lineThickness="2">
        <jd2:lineType type="ltLine">
          <jd2:edge>
            <jd2:pt x="135" y="188" type="substrate" speciesRef="S2" />
            <jd2:pt x="248" y="262" type="product" speciesRef="X2" />
          </jd2:edge>
        </jd2:lineType>
      </jd2:display>
    </jd2:reaction>
  </jd2:listOfReactions>
</jd2:JDesignerLayout>
      </UnsupportedAnnotation>
    </ListOfUnsupportedAnnotations>
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
      <Metabolite key="Metabolite_4" name="S1" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_4">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_3" name="S2" simulationType="reactions" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_3">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_2" name="X0" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_2">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_1" name="X1" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_1">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_0" name="X2" simulationType="fixed" compartment="Compartment_0" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Metabolite_0">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_6" name="J0_v0" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_6">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_5" name="J1_k3" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_5">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_4" name="J2_k1" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_4">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_3" name="J2_k_1" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_3">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_2" name="J2_c" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_2">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_1" name="J2_q" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_1">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_0" name="J3_k2" simulationType="fixed" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelValue_0">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
      </ModelValue>
    </ListOfModelValues>
    <ListOfReactions>
      <Reaction key="Reaction_3" name="J0" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_3">
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
          <Constant key="Parameter_5721" name="J0_v0" value="8"/>
        </ListOfConstants>
        <KineticLaw function="Function_41" unitType="Default" scalingCompartment="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_2" name="J1" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_2">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_6902" name="J1_k3" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_42" unitType="Default" scalingCompartment="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_272">
              <SourceParameter reference="ModelValue_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_273">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_266">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="J2" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_1">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5719" name="J2_c" value="1"/>
          <Constant key="Parameter_5722" name="J2_k1" value="1"/>
          <Constant key="Parameter_5720" name="J2_k_1" value="0"/>
          <Constant key="Parameter_7340" name="J2_q" value="3"/>
        </ListOfConstants>
        <KineticLaw function="Function_43" unitType="Default" scalingCompartment="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="ModelValue_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="ModelValue_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_279">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_280">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_281">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_282">
              <SourceParameter reference="Compartment_0"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_0" name="J3" reversible="false" fast="false" addNoise="false">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#Reaction_0">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_7338" name="J3_k2" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_44" unitType="Default" scalingCompartment="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_289">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_288">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_287">
              <SourceParameter reference="Compartment_0"/>
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
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model)" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S1]" value="9.453910141287282e+23" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S2]" value="9.6354252160000006e+23" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X0]" value="6.0221407599999999e+23" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X1]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X2]" value="0" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J0_v0]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J1_k3]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k1]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k_1]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_c]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_q]" value="3" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J3_k2]" value="5" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J0]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J0],ParameterGroup=Parameters,Parameter=J0_v0" value="8" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J0_v0],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J1],ParameterGroup=Parameters,Parameter=J1_k3" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J1_k3],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_c" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_c],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_k1" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k1],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_k_1" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k_1],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_q" value="3" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_q],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J3],ParameterGroup=Parameters,Parameter=J3_k2" value="5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J3_k2],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_3" name="oscillating">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_3">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model)" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S1]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S2]" value="6.0221407599999999e+23" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X0]" value="6.0221407599999999e+23" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X1]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X2]" value="0" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J0_v0]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J1_k3]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k1]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k_1]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_c]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_q]" value="3" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J3_k2]" value="5" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J0]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J0],ParameterGroup=Parameters,Parameter=J0_v0" value="8" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J0_v0],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J1],ParameterGroup=Parameters,Parameter=J1_k3" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J1_k3],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_c" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_c],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_k1" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k1],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_k_1" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k_1],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_q" value="3" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_q],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J3],ParameterGroup=Parameters,Parameter=J3_k2" value="5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J3_k2],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
      <ModelParameterSet key="ModelParameterSet_2" name="steadystate">
        <MiriamAnnotation>
<rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="#ModelParameterSet_2">
</rdf:Description>
</rdf:RDF>
        </MiriamAnnotation>
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model)" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S1]" value="9.453910141287282e+23" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S2]" value="9.6354252160000006e+23" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X0]" value="6.0221407599999999e+23" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X1]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X2]" value="0" type="Species" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J0_v0]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J1_k3]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k1]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k_1]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_c]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_q]" value="3" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Values[J3_k2]" value="5" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J0]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J0],ParameterGroup=Parameters,Parameter=J0_v0" value="8" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J0_v0],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J1],ParameterGroup=Parameters,Parameter=J1_k3" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J1_k3],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_c" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_c],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_k1" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k1],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_k_1" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_k_1],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J2],ParameterGroup=Parameters,Parameter=J2_q" value="3" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J2_q],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=Oscli (Heinrich model),Vector=Reactions[J3],ParameterGroup=Parameters,Parameter=J3_k2" value="5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Values[J3_k2],Reference=InitialValue>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_0"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
      <StateTemplateVariable objectReference="ModelValue_6"/>
      <StateTemplateVariable objectReference="ModelValue_5"/>
      <StateTemplateVariable objectReference="ModelValue_4"/>
      <StateTemplateVariable objectReference="ModelValue_3"/>
      <StateTemplateVariable objectReference="ModelValue_2"/>
      <StateTemplateVariable objectReference="ModelValue_1"/>
      <StateTemplateVariable objectReference="ModelValue_0"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 9.453910141287282e+23 9.6354252160000006e+23 6.0221407599999999e+23 0 0 1 8 0 1 0 1 3 5 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_2" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_0" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_3" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Report reference="Report_1" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="500"/>
        <Parameter name="StepSize" type="float" value="0.012"/>
        <Parameter name="Duration" type="float" value="6"/>
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
    <Task key="Task_4" name="Scan" type="scan" scheduled="false" updateModel="true">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
          <ParameterGroup name="ScanItem">
            <Parameter name="Number of steps" type="unsignedInteger" value="2"/>
            <Parameter name="Type" type="unsignedInteger" value="4"/>
            <Parameter name="Object" type="cn" value=""/>
            <ParameterGroup name="ParameterSet CNs">
              <Parameter name="0" type="cn" value="CN=Root,Model=Oscli (Heinrich model),Vector=ParameterSets[oscillating]"/>
              <Parameter name="1" type="cn" value="CN=Root,Model=Oscli (Heinrich model),Vector=ParameterSets[steadystate]"/>
            </ParameterGroup>
          </ParameterGroup>
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="1"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
        <Parameter name="Continue on Error" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_15" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_2" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_16" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_3" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Subtask" type="cn" value="CN=Root,Vector=TaskList[Time-Course]"/>
        <ParameterText name="ObjectiveExpression" type="expression">
          &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S1],Reference=Rate> + &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S2],Reference=Rate> + &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X0],Reference=Rate> + &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X1],Reference=Rate> + &lt;CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[X2],Reference=Rate>
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
    <Task key="Task_5" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_4" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_6" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_5" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_2"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Use Reder" type="bool" value="1"/>
        <Parameter name="Use Smallbone" type="bool" value="1"/>
      </Method>
    </Task>
    <Task key="Task_7" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_6" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_8" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_7" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_14" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_8" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_9" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Report reference="Report_9" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_10" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
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
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="100000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_11" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_10" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_2"/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
    <Task key="Task_12" name="Time-Course Sensitivities" type="timeSensitivities" scheduled="false" updateModel="false">
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
    <Report key="Report_0" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_1" name="Time-Course" taskType="timeCourse" separator="&#x09;" precision="6">
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
    <Report key="Report_2" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_3" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
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
    <Report key="Report_4" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
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
    <Report key="Report_5" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_6" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
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
    <Report key="Report_7" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_8" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
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
    <Report key="Report_9" name="Moieties" taskType="moieties" separator="&#x09;" precision="6">
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
    <Report key="Report_10" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
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
    <PlotSpecification name="TC" type="Plot2D" active="1" taskTypes="Time-Course, Scan">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <Parameter name="plot engine" type="string" value="QCustomPlot"/>
      <Parameter name="x axis" type="string" value="time [s]"/>
      <Parameter name="y axis" type="string" value="concentration [mol/l]"/>
      <Parameter name="z axis" type="string" value=""/>
      <ListOfPlotItems>
        <PlotItem name="[S1]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2.2000000000000002"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Oscli (Heinrich model),Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S1],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[S2]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2.2000000000000002"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Oscli (Heinrich model),Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S2],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
    <PlotSpecification name="TC (QWT)" type="Plot2D" active="1" taskTypes="Time-Course, Scan">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <Parameter name="plot engine" type="string" value="QWT"/>
      <Parameter name="x axis" type="string" value="time [s]"/>
      <Parameter name="y axis" type="string" value="concentration [mol/l]"/>
      <Parameter name="z axis" type="string" value=""/>
      <ListOfPlotItems>
        <PlotItem name="[S1]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2.2000000000000002"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Oscli (Heinrich model),Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S1],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[S2]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="2.2000000000000002"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=Oscli (Heinrich model),Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=Oscli (Heinrich model),Vector=Compartments[compartment],Vector=Metabolites[S2],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
  </ListOfPlots>
  <GUI>
  </GUI>
  <ListOfLayouts xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <Layout key="Layout_6" name="JDesigner2_0">
      <Dimensions width="451.503471374512" height="320.5"/>
      <ListOfMetabGlyphs>
        <MetaboliteGlyph key="Layout_5" name="sGlyph_0" metabolite="Metabolite_4">
          <BoundingBox>
            <Position x="206" y="106"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </MetaboliteGlyph>
        <MetaboliteGlyph key="Layout_4" name="sGlyph_1" metabolite="Metabolite_3">
          <BoundingBox>
            <Position x="123" y="176"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </MetaboliteGlyph>
        <MetaboliteGlyph key="Layout_3" name="sGlyph_2" metabolite="Metabolite_2">
          <BoundingBox>
            <Position x="104" y="46"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </MetaboliteGlyph>
        <MetaboliteGlyph key="Layout_18" name="sGlyph_3" metabolite="Metabolite_1">
          <BoundingBox>
            <Position x="324" y="177"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </MetaboliteGlyph>
        <MetaboliteGlyph key="Layout_20" name="sGlyph_4" metabolite="Metabolite_0">
          <BoundingBox>
            <Position x="236" y="250"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </MetaboliteGlyph>
      </ListOfMetabGlyphs>
      <ListOfReactionGlyphs>
        <ReactionGlyph key="Layout_19" name="rGlyph_0" reaction="Reaction_3">
          <Curve>
          </Curve>
          <ListOfMetaboliteReferenceGlyphs>
            <MetaboliteReferenceGlyph key="Layout_14" name="SpeciesReference_J0_0" metaboliteGlyph="Layout_5" role="product" objectRole="product">
              <Curve>
                <ListOfCurveSegments>
                  <CurveSegment xsi:type="LineSegment">
                    <Start x="134" y="69.058823529411796"/>
                    <End x="200" y="106.941176470588"/>
                  </CurveSegment>
                </ListOfCurveSegments>
              </Curve>
            </MetaboliteReferenceGlyph>
            <MetaboliteReferenceGlyph key="Layout_17" name="SpeciesReference_J0_2" metaboliteGlyph="Layout_3" role="substrate" objectRole="substrate">
              <BoundingBox>
                <Position x="0" y="0"/>
                <Dimensions width="0" height="0"/>
              </BoundingBox>
            </MetaboliteReferenceGlyph>
          </ListOfMetaboliteReferenceGlyphs>
        </ReactionGlyph>
        <ReactionGlyph key="Layout_16" name="rGlyph_1" reaction="Reaction_2">
          <Curve>
          </Curve>
          <ListOfMetaboliteReferenceGlyphs>
            <MetaboliteReferenceGlyph key="Layout_15" name="SpeciesReference_J1_0" metaboliteGlyph="Layout_18" role="product" objectRole="product">
              <Curve>
                <ListOfCurveSegments>
                  <CurveSegment xsi:type="LineSegment">
                    <Start x="236" y="129.22033898305099"/>
                    <End x="318" y="177.77966101694901"/>
                  </CurveSegment>
                </ListOfCurveSegments>
              </Curve>
            </MetaboliteReferenceGlyph>
            <MetaboliteReferenceGlyph key="Layout_11" name="SpeciesReference_J1_2" metaboliteGlyph="Layout_5" role="substrate" objectRole="substrate">
              <BoundingBox>
                <Position x="0" y="0"/>
                <Dimensions width="0" height="0"/>
              </BoundingBox>
            </MetaboliteReferenceGlyph>
          </ListOfMetaboliteReferenceGlyphs>
        </ReactionGlyph>
        <ReactionGlyph key="Layout_13" name="rGlyph_2" reaction="Reaction_1">
          <Curve>
          </Curve>
          <ListOfMetaboliteReferenceGlyphs>
            <MetaboliteReferenceGlyph key="Layout_12" name="SpeciesReference_J2_0" metaboliteGlyph="Layout_4" role="product" objectRole="product">
              <Curve>
                <ListOfCurveSegments>
                  <CurveSegment xsi:type="LineSegment">
                    <Start x="200" y="133.12048192771101"/>
                    <End x="153" y="172.87951807228899"/>
                  </CurveSegment>
                </ListOfCurveSegments>
              </Curve>
            </MetaboliteReferenceGlyph>
            <MetaboliteReferenceGlyph key="Layout_8" name="SpeciesReference_J2_2" metaboliteGlyph="Layout_5" role="substrate" objectRole="substrate">
              <BoundingBox>
                <Position x="0" y="0"/>
                <Dimensions width="0" height="0"/>
              </BoundingBox>
            </MetaboliteReferenceGlyph>
            <MetaboliteReferenceGlyph key="Layout_10" name="SpeciesReference_J2_3" metaboliteGlyph="Layout_4" role="activator" objectRole="activator">
              <Curve>
                <ListOfCurveSegments>
                  <CurveSegment xsi:type="LineSegment">
                    <Start x="118" y="172.37142857142899"/>
                    <End x="100" y="157"/>
                  </CurveSegment>
                  <CurveSegment xsi:type="LineSegment">
                    <Start x="100" y="157"/>
                    <End x="137" y="132"/>
                  </CurveSegment>
                  <CurveSegment xsi:type="LineSegment">
                    <Start x="137" y="132"/>
                    <End x="171" y="143"/>
                  </CurveSegment>
                </ListOfCurveSegments>
              </Curve>
            </MetaboliteReferenceGlyph>
          </ListOfMetaboliteReferenceGlyphs>
        </ReactionGlyph>
        <ReactionGlyph key="Layout_9" name="rGlyph_3" reaction="Reaction_0">
          <Curve>
          </Curve>
          <ListOfMetaboliteReferenceGlyphs>
            <MetaboliteReferenceGlyph key="Layout_25" name="SpeciesReference_J3_0" metaboliteGlyph="Layout_20" role="product" objectRole="product">
              <Curve>
                <ListOfCurveSegments>
                  <CurveSegment xsi:type="LineSegment">
                    <Start x="153" y="199.85840707964601"/>
                    <End x="230" y="250.14159292035399"/>
                  </CurveSegment>
                </ListOfCurveSegments>
              </Curve>
            </MetaboliteReferenceGlyph>
            <MetaboliteReferenceGlyph key="Layout_24" name="SpeciesReference_J3_2" metaboliteGlyph="Layout_4" role="substrate" objectRole="substrate">
              <BoundingBox>
                <Position x="0" y="0"/>
                <Dimensions width="0" height="0"/>
              </BoundingBox>
            </MetaboliteReferenceGlyph>
          </ListOfMetaboliteReferenceGlyphs>
        </ReactionGlyph>
      </ListOfReactionGlyphs>
      <ListOfTextGlyphs>
        <TextGlyph key="Layout_23" name="tGlyph_0" graphicalObject="Layout_5" text="S1">
          <BoundingBox>
            <Position x="206" y="106"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </TextGlyph>
        <TextGlyph key="Layout_22" name="tGlyph_1" graphicalObject="Layout_4" text="S2">
          <BoundingBox>
            <Position x="123" y="176"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </TextGlyph>
        <TextGlyph key="Layout_21" name="tGlyph_2" graphicalObject="Layout_3" text="X0">
          <BoundingBox>
            <Position x="104" y="46"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </TextGlyph>
        <TextGlyph key="Layout_2" name="tGlyph_3" graphicalObject="Layout_18" text="X1">
          <BoundingBox>
            <Position x="324" y="177"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </TextGlyph>
        <TextGlyph key="Layout_0" name="tGlyph_4" graphicalObject="Layout_20" text="X2">
          <BoundingBox>
            <Position x="236" y="250"/>
            <Dimensions width="24" height="24"/>
          </BoundingBox>
        </TextGlyph>
      </ListOfTextGlyphs>
      <ListOfRenderInformation>
        <RenderInformation key="LocalRenderInformation_0" backgroundColor="#FFFFFFFF">
          <ListOfColorDefinitions>
            <ColorDefinition id="Color_0" value="#969696"/>
            <ColorDefinition id="Color_1" value="#000000"/>
            <ColorDefinition id="Color_2" value="#ff6600"/>
          </ListOfColorDefinitions>
          <ListOfGradientDefinitions>
            <LinearGradient id="LinearGradient_0" spreadMethod="pad" x1="0" y1="0" x2="100%" y2="0" z2="100%">
              <Stop offset="0" stop-color="#ccffff"/>
              <Stop offset="100%" stop-color="#ffffff"/>
            </LinearGradient>
          </ListOfGradientDefinitions>
          <ListOfLineEndings>
            <LineEnding id="product" enableRotationalMapping="true">
              <BoundingBox>
                <Position x="-10" y="-5"/>
                <Dimensions width="10" height="10"/>
              </BoundingBox>
              <Group stroke="Color_2" stroke-width="0.001" fill="Color_2" font-size="0" text-anchor="start" vtext-anchor="top">
                <Polygon fill="Color_2">
                  <ListOfElements>
                    <Element x="0" y="0"/>
                    <Element x="100%" y="50%"/>
                    <Element x="0" y="100%"/>
                    <Element x="33%" y="50%"/>
                    <Element x="0" y="0"/>
                  </ListOfElements>
                </Polygon>
              </Group>
            </LineEnding>
            <LineEnding id="activator" enableRotationalMapping="true">
              <BoundingBox>
                <Position x="-8" y="-4"/>
                <Dimensions width="8" height="8"/>
              </BoundingBox>
              <Group stroke="Color_2" stroke-width="1" fill="#ffffff" font-size="0" text-anchor="start" vtext-anchor="top">
                <Ellipse stroke="Color_2" stroke-width="1" fill="#ffffff" cx="50%" cy="50%" rx="50%" ry="50%"/>
              </Group>
            </LineEnding>
          </ListOfLineEndings>
          <ListOfStyles>
            <Style key="LocalStyle_5" keyList="Layout_4 Layout_5">
              <Group stroke-width="0" fill="none" fill-rule="nonzero" font-size="0" font-family="sans-serif" text-anchor="start" vtext-anchor="top">
                <Rectangle stroke="Color_0" stroke-width="1" fill="LinearGradient_0" x="0" y="0" width="24" height="24" rx="5" ry="5"/>
              </Group>
            </Style>
            <Style key="LocalStyle_4" keyList="Layout_18 Layout_20 Layout_3">
              <Group stroke-width="0" fill="none" fill-rule="nonzero" font-size="0" font-family="sans-serif" text-anchor="start" vtext-anchor="top">
                <Rectangle stroke="Color_1" stroke-width="3" fill="LinearGradient_0" x="0" y="0" width="24" height="24" rx="5" ry="5"/>
              </Group>
            </Style>
            <Style key="LocalStyle_3" roleList="product">
              <Group stroke="Color_2" stroke-width="2" fill="none" fill-rule="nonzero" font-size="0" font-family="sans-serif" text-anchor="start" vtext-anchor="top" endHead="product">
              </Group>
            </Style>
            <Style key="LocalStyle_2" roleList="sidesubstrate substrate" keyList="Layout_13 Layout_16 Layout_19 Layout_9">
              <Group stroke="Color_2" stroke-width="2" fill="none" fill-rule="nonzero" font-size="0" font-family="sans-serif" text-anchor="start" vtext-anchor="top">
              </Group>
            </Style>
            <Style key="LocalStyle_1" roleList="activator">
              <Group stroke="Color_2" stroke-width="2" fill="none" fill-rule="nonzero" font-size="0" font-family="sans-serif" text-anchor="start" vtext-anchor="top" endHead="activator">
              </Group>
            </Style>
            <Style key="LocalStyle_0" keyList="Layout_0 Layout_2 Layout_21 Layout_22 Layout_23">
              <Group stroke="Color_1" stroke-width="0" fill="none" fill-rule="nonzero" font-size="11" font-family="Arial" text-anchor="middle" vtext-anchor="top">
              </Group>
            </Style>
          </ListOfStyles>
        </RenderInformation>
      </ListOfRenderInformation>
    </Layout>
  </ListOfLayouts>
  <SBMLReference file="oscli.xml">
    <SBMLMap SBMLid="J0" COPASIkey="Reaction_3"/>
    <SBMLMap SBMLid="J0_v0" COPASIkey="ModelValue_6"/>
    <SBMLMap SBMLid="J1" COPASIkey="Reaction_2"/>
    <SBMLMap SBMLid="J1_k3" COPASIkey="ModelValue_5"/>
    <SBMLMap SBMLid="J2" COPASIkey="Reaction_1"/>
    <SBMLMap SBMLid="J2_c" COPASIkey="ModelValue_2"/>
    <SBMLMap SBMLid="J2_k1" COPASIkey="ModelValue_4"/>
    <SBMLMap SBMLid="J2_k_1" COPASIkey="ModelValue_3"/>
    <SBMLMap SBMLid="J2_q" COPASIkey="ModelValue_1"/>
    <SBMLMap SBMLid="J3" COPASIkey="Reaction_0"/>
    <SBMLMap SBMLid="J3_k2" COPASIkey="ModelValue_0"/>
    <SBMLMap SBMLid="S1" COPASIkey="Metabolite_4"/>
    <SBMLMap SBMLid="S2" COPASIkey="Metabolite_3"/>
    <SBMLMap SBMLid="X0" COPASIkey="Metabolite_2"/>
    <SBMLMap SBMLid="X1" COPASIkey="Metabolite_1"/>
    <SBMLMap SBMLid="X2" COPASIkey="Metabolite_0"/>
    <SBMLMap SBMLid="compartment" COPASIkey="Compartment_0"/>
  </SBMLReference>
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
