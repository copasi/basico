<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.5.31 (development) (http://www.copasi.org) at 2010-07-14 13:36:46 UTC -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="1" versionMinor="0" versionDevel="31">
  <ListOfFunctions>
    <Function key="Function_50" name="function_4_MAPKKK activation_1" type="UserDefined" reversible="false">
      <Expression>
        V1*MKKK/((1+(MAPK_PP/Ki)^n)*(K1+MKKK))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_265" name="K1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_261" name="Ki" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_250" name="MAPK_PP" order="2" role="modifier"/>
        <ParameterDescription key="FunctionParameter_243" name="MKKK" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_260" name="V1" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_263" name="n" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="function_4_MAPKKK inactivation_1" type="UserDefined" reversible="false">
      <Expression>
        V2*MKKK_P/(KK2+MKKK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_246" name="KK2" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_262" name="MKKK_P" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_266" name="V2" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="function_4_phosphorylation of MAPKK_1" type="UserDefined" reversible="false">
      <Expression>
        k3*MKKK_P*MKK/(KK3+MKK)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_270" name="KK3" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_268" name="MKK" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_264" name="MKKK_P" order="2" role="modifier"/>
        <ParameterDescription key="FunctionParameter_258" name="k3" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="function_4_phosphorylation of MAPKK-P_1" type="UserDefined" reversible="false">
      <Expression>
        k4*MKKK_P*MKK_P/(KK4+MKK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_274" name="KK4" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_267" name="MKKK_P" order="1" role="modifier"/>
        <ParameterDescription key="FunctionParameter_272" name="MKK_P" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_271" name="k4" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="function_4_dephosphorylation of MAPKK-PP_1" type="UserDefined" reversible="false">
      <Expression>
        V5*MKK_PP/(KK5+MKK_PP)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_276" name="KK5" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_254" name="MKK_PP" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_275" name="V5" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="function_4_dephosphorylation of MAPKK-P_1" type="UserDefined" reversible="false">
      <Expression>
        V6*MKK_P/(KK6+MKK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_279" name="KK6" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_273" name="MKK_P" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_277" name="V6" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="function_4_phosphorylation of MAPK_1" type="UserDefined" reversible="false">
      <Expression>
        k7*MKK_PP*MAPK/(KK7+MAPK)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_284" name="KK7" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_282" name="MAPK" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_269" name="MKK_PP" order="2" role="modifier"/>
        <ParameterDescription key="FunctionParameter_280" name="k7" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="function_4_phosphorylation of MAPK-P_1" type="UserDefined" reversible="false">
      <Expression>
        k8*MKK_PP*MAPK_P/(KK8+MAPK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_288" name="KK8" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_286" name="MAPK_P" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_281" name="MKK_PP" order="2" role="modifier"/>
        <ParameterDescription key="FunctionParameter_285" name="k8" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_58" name="function_4_dephosphorylation of MAPK-PP_1" type="UserDefined" reversible="false">
      <Expression>
        V9*MAPK_PP/(KK9+MAPK_PP)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_290" name="KK9" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_278" name="MAPK_PP" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_289" name="V9" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_59" name="function_4_dephosphorylation of MAPK-P_1" type="UserDefined" reversible="false">
      <Expression>
        V10*MAPK_P/(KK10+MAPK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_293" name="KK10" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_287" name="MAPK_P" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_291" name="V10" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_1" name="Kholodenko MAPK model " simulationType="time" timeUnit="s" volumeUnit="l" areaUnit="m²" lengthUnit="m" quantityUnit="nmol" type="deterministic">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Model_1">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2010-07-14T14:18:42Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <Comment>
      <html xmlns="http://www.w3.org/1999/xhtml"><head><meta name="qrichtext" content="1" /></head><body style="font-size:8pt;font-family:Droid Sans">
<p dir="ltr">This is the MAPK signaling cascade model from Kholodenko (2000). It is used here as an example of parameter estimation. A data file (MAPKdata.txt) is used as a target behavior and the task is to change six parameters of the model to match the data as well as possible.</p>
<p dir="ltr">Select the Task Parameter Estimation and make sure the method is &quot;Current Solution Statistics&quot; just to see how badly the current parameter values fit the data. Then select a different optimization method, run and when it ends check whether the model fits the data.</p>
<p dir="ltr"><span style="font-size:6pt">This model originates from BioModels Database: A Database of Annotated Published Models. It is copyright (c) 2005-2008 The BioModels Team. <br />For more information see the </span><a href="http://www.ebi.ac.uk/biomodels/legal.html"><span style="font-size:6pt">terms of use</span></a><span style="font-size:6pt">.</span></p>
</body></html>
    </Comment>
    <ListOfCompartments>
      <Compartment key="Compartment_0" name="uVol" simulationType="fixed" dimensionality="3">
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_0" name="MAPKKK" simulationType="reactions" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_1" name="MAPKKK-P" simulationType="reactions" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_2" name="MAPKK" simulationType="reactions" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_3" name="MAPKK-P" simulationType="reactions" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_4" name="MAPKK-PP" simulationType="reactions" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_5" name="MAPK" simulationType="reactions" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_6" name="MAPK-P" simulationType="reactions" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_7" name="MAPK-PP" simulationType="reactions" compartment="Compartment_0">
      </Metabolite>
    </ListOfMetabolites>
    <ListOfReactions>
      <Reaction key="Reaction_0" name="MAPKKK activation" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_633" name="V1" value="2.5"/>
          <Constant key="Parameter_634" name="Ki" value="9"/>
          <Constant key="Parameter_635" name="n" value="1"/>
          <Constant key="Parameter_636" name="K1" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_50">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_265">
              <SourceParameter reference="Parameter_636"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_261">
              <SourceParameter reference="Parameter_634"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_250">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_243">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_260">
              <SourceParameter reference="Parameter_633"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_263">
              <SourceParameter reference="Parameter_635"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="MAPKKK inactivation" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_637" name="V2" value="0.25"/>
          <Constant key="Parameter_638" name="KK2" value="8"/>
        </ListOfConstants>
        <KineticLaw function="Function_51">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_246">
              <SourceParameter reference="Parameter_638"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_262">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_266">
              <SourceParameter reference="Parameter_637"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_2" name="phosphorylation of MAPKK" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_639" name="k3" value="0.025"/>
          <Constant key="Parameter_640" name="KK3" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_52">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Parameter_640"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_268">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_264">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_258">
              <SourceParameter reference="Parameter_639"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_3" name="phosphorylation of MAPKK-P" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_641" name="k4" value="0.025"/>
          <Constant key="Parameter_642" name="KK4" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_53">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_274">
              <SourceParameter reference="Parameter_642"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_267">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_272">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_271">
              <SourceParameter reference="Parameter_641"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_4" name="dephosphorylation of MAPKK-PP" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_643" name="V5" value="0.75"/>
          <Constant key="Parameter_644" name="KK5" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_54">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Parameter_644"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_254">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="Parameter_643"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_5" name="dephosphorylation of MAPKK-P" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_645" name="V6" value="0.75"/>
          <Constant key="Parameter_646" name="KK6" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_55">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_279">
              <SourceParameter reference="Parameter_646"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_273">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Parameter_645"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_6" name="phosphorylation of MAPK" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_647" name="k7" value="0.025"/>
          <Constant key="Parameter_648" name="KK7" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_56">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Parameter_648"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_282">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_280">
              <SourceParameter reference="Parameter_647"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="phosphorylation of MAPK-P" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_649" name="k8" value="0.025"/>
          <Constant key="Parameter_650" name="KK8" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_57">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_288">
              <SourceParameter reference="Parameter_650"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_286">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_281">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="Parameter_649"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="dephosphorylation of MAPK-PP" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_651" name="V9" value="0.5"/>
          <Constant key="Parameter_652" name="KK9" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_58">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_290">
              <SourceParameter reference="Parameter_652"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_289">
              <SourceParameter reference="Parameter_651"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="dephosphorylation of MAPK-P" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_653" name="V10" value="0.5"/>
          <Constant key="Parameter_654" name="KK10" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_59">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="Parameter_654"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_287">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_291">
              <SourceParameter reference="Parameter_653"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_1"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 6022141500000001 6022141500000001 5.419927350000001e+16 1.68619962e+17 1.68619962e+17 6022141500000001 6022141500000001 6022141500000001 1 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_12" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_8" target="" append="1"/>
      <Problem>
        <Parameter name="JacobianRequested" type="bool" value="1"/>
        <Parameter name="StabilityAnalysisRequested" type="bool" value="1"/>
      </Problem>
      <Method name="Enhanced Newton" type="EnhancedNewton">
        <Parameter name="Resolution" type="unsignedFloat" value="1e-09"/>
        <Parameter name="Derivation Factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Use Newton" type="bool" value="1"/>
        <Parameter name="Use Integration" type="bool" value="1"/>
        <Parameter name="Use Back Integration" type="bool" value="1"/>
        <Parameter name="Accept Negative Concentrations" type="bool" value="0"/>
        <Parameter name="Iteration Limit" type="unsignedInteger" value="50"/>
        <Parameter name="Maximum duration for forward integration" type="unsignedFloat" value="1e+09"/>
        <Parameter name="Maximum duration for backward integration" type="unsignedFloat" value="1e+06"/>
      </Method>
    </Task>
    <Task key="Task_13" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-06"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-12"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_14" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="1"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_15" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_9" target="" append="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_16" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_10" target="" append="1"/>
      <Problem>
        <Parameter name="Subtask" type="cn" value="Vector=TaskList[Steady-State]"/>
        <ParameterText name="ObjectiveExpression" type="expression">
          -&lt;CN=Root,Vector=TaskList[Steady-State],Eigen Values=Eigenvalues of Jacobian,Reference=Maximum imaginary part&gt;
        </ParameterText>
        <Parameter name="Maximize" type="bool" value="0"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
      </Problem>
      <Method name="Random Search" type="RandomSearch">
        <Parameter name="Number of Iterations" type="unsignedInteger" value="100000"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_17" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_11" target="" append="1"/>
      <Problem>
        <Parameter name="Maximize" type="bool" value="0"/>
        <ParameterGroup name="OptimizationItemList">
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <Parameter name="LowerBound" type="cn" value="0.25"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=Kholodenko MAPK model ,Vector=Reactions[MAPKKK activation],ParameterGroup=Parameters,Parameter=V1,Reference=Value"/>
            <Parameter name="StartValue" type="float" value="0.252586"/>
            <Parameter name="UpperBound" type="cn" value="4.75"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <Parameter name="LowerBound" type="cn" value="0.025"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=Kholodenko MAPK model ,Vector=Reactions[MAPKKK inactivation],ParameterGroup=Parameters,Parameter=V2,Reference=Value"/>
            <Parameter name="StartValue" type="float" value="0.410616"/>
            <Parameter name="UpperBound" type="cn" value="0.475"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <Parameter name="LowerBound" type="cn" value="0.075"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=Kholodenko MAPK model ,Vector=Reactions[dephosphorylation of MAPKK-PP],ParameterGroup=Parameters,Parameter=V5,Reference=Value"/>
            <Parameter name="StartValue" type="float" value="0.50374"/>
            <Parameter name="UpperBound" type="cn" value="1.425"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <Parameter name="LowerBound" type="cn" value="0.075"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=Kholodenko MAPK model ,Vector=Reactions[dephosphorylation of MAPKK-P],ParameterGroup=Parameters,Parameter=V6,Reference=Value"/>
            <Parameter name="StartValue" type="float" value="0.987345"/>
            <Parameter name="UpperBound" type="cn" value="1.425"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <Parameter name="LowerBound" type="cn" value="0.05"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=Kholodenko MAPK model ,Vector=Reactions[dephosphorylation of MAPK-PP],ParameterGroup=Parameters,Parameter=V9,Reference=Value"/>
            <Parameter name="StartValue" type="float" value="0.695592"/>
            <Parameter name="UpperBound" type="cn" value="0.95"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Experiments">
            </ParameterGroup>
            <Parameter name="LowerBound" type="cn" value="0.05"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=Kholodenko MAPK model ,Vector=Reactions[dephosphorylation of MAPK-P],ParameterGroup=Parameters,Parameter=V10,Reference=Value"/>
            <Parameter name="StartValue" type="float" value="0.745066"/>
            <Parameter name="UpperBound" type="cn" value="0.95"/>
          </ParameterGroup>
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
        <ParameterGroup name="Experiment Set">
          <ParameterGroup name="Experiment">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="MAPKdata.txt"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_0"/>
            <Parameter name="Last Row" type="unsignedInteger" value="11"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="3"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=Kholodenko MAPK model ,Vector=Compartments[uVol],Vector=Metabolites[MAPKKK-P],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=Kholodenko MAPK model ,Vector=Compartments[uVol],Vector=Metabolites[MAPK-P],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="Seperator" type="string" value="&#x09;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
        </ParameterGroup>
        <Parameter name="Steady-State" type="cn" value="Vector=TaskList[Steady-State]"/>
        <Parameter name="Time-Course" type="cn" value="Vector=TaskList[Time-Course]"/>
      </Problem>
      <Method name="Current Solution Statistics" type="CurrentSolutionStatistics">
      </Method>
    </Task>
    <Task key="Task_18" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_12" target="" append="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_10"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1e-09"/>
      </Method>
    </Task>
    <Task key="Task_19" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_13" target="" append="1"/>
      <Problem>
        <Parameter name="ExponentNumber" type="unsignedInteger" value="3"/>
        <Parameter name="DivergenceRequested" type="bool" value="1"/>
        <Parameter name="TransientTime" type="float" value="0"/>
      </Problem>
      <Method name="Wolf Method" type="WolfMethod">
        <Parameter name="Orthonormalization Interval" type="unsignedFloat" value="1"/>
        <Parameter name="Overall time" type="unsignedFloat" value="1000"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-06"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-12"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_20" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_14" target="" append="1"/>
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
        </ParameterGroup>
      </Problem>
      <Method name="Sensitivities Method" type="SensitivitiesMethod">
        <Parameter name="Delta factor" type="unsignedFloat" value="1e-06"/>
        <Parameter name="Delta minimum" type="unsignedFloat" value="1e-12"/>
      </Method>
    </Task>
    <Task key="Task_21" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_0" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_7" target="" append="1"/>
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
      </Problem>
      <Method name="ILDM (LSODA,Deuflhard)" type="TimeScaleSeparation(ILDM,Deuflhard)">
        <Parameter name="Deuflhard Tolerance" type="unsignedFloat" value="1e-06"/>
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_8" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          Automatically generated report.
        </body>
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_9" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          Automatically generated report.
        </body>
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_10" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          Automatically generated report.
        </body>
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
    <Report key="Report_11" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          Automatically generated report.
        </body>
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
    <Report key="Report_12" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          Automatically generated report.
        </body>
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_13" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          Automatically generated report.
        </body>
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_14" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          Automatically generated report.
        </body>
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_7" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          Automatically generated report.
        </body>
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Result"/>
      </Footer>
    </Report>
  </ListOfReports>
  <ListOfPlots>
    <PlotSpecification name="Progress of Fit" type="Plot2D" active="1">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="1"/>
      <ListOfPlotItems>
        <PlotItem name="sum of squares" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Function Evaluations"/>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Value"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
    <PlotSpecification name="Experiment" type="Plot2D" active="1">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[MAPKKK-P](Measured Value)" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="2"/>
          <Parameter name="Recording Activity" type="string" value="after"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Independent Value"/>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Measured Value"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[MAPKKK-P](Fitted Value)" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="after"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Independent Value"/>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Fitted Value"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[MAPKKK-P](Weighted Error)" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="2"/>
          <Parameter name="Recording Activity" type="string" value="after"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Independent Value"/>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Weighted Error"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[MAPK-P](Measured Value)" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="2"/>
          <Parameter name="Recording Activity" type="string" value="after"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Independent Value"/>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[1],Reference=Measured Value"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[MAPK-P](Fitted Value)" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="after"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Independent Value"/>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[1],Reference=Fitted Value"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[MAPK-P](Weighted Error)" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="2"/>
          <Parameter name="Recording Activity" type="string" value="after"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[0],Reference=Independent Value"/>
            <ChannelSpec cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,ParameterGroup=Experiment Set,ParameterGroup=Experiment,Vector=Fitted Points[1],Reference=Weighted Error"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
  </ListOfPlots>
  <GUI>
  </GUI>
  <SBMLReference file="BIOMD0000000010.xml">
    <SBMLMap SBMLid="J0" COPASIkey="Reaction_0"/>
    <SBMLMap SBMLid="J1" COPASIkey="Reaction_1"/>
    <SBMLMap SBMLid="J2" COPASIkey="Reaction_2"/>
    <SBMLMap SBMLid="J3" COPASIkey="Reaction_3"/>
    <SBMLMap SBMLid="J4" COPASIkey="Reaction_4"/>
    <SBMLMap SBMLid="J5" COPASIkey="Reaction_5"/>
    <SBMLMap SBMLid="J6" COPASIkey="Reaction_6"/>
    <SBMLMap SBMLid="J7" COPASIkey="Reaction_7"/>
    <SBMLMap SBMLid="J8" COPASIkey="Reaction_8"/>
    <SBMLMap SBMLid="J9" COPASIkey="Reaction_9"/>
    <SBMLMap SBMLid="MAPK" COPASIkey="Metabolite_5"/>
    <SBMLMap SBMLid="MAPK_P" COPASIkey="Metabolite_6"/>
    <SBMLMap SBMLid="MAPK_PP" COPASIkey="Metabolite_7"/>
    <SBMLMap SBMLid="MKK" COPASIkey="Metabolite_2"/>
    <SBMLMap SBMLid="MKKK" COPASIkey="Metabolite_0"/>
    <SBMLMap SBMLid="MKKK_P" COPASIkey="Metabolite_1"/>
    <SBMLMap SBMLid="MKK_P" COPASIkey="Metabolite_3"/>
    <SBMLMap SBMLid="MKK_PP" COPASIkey="Metabolite_4"/>
    <SBMLMap SBMLid="uVol" COPASIkey="Compartment_0"/>
  </SBMLReference>
</COPASI>
