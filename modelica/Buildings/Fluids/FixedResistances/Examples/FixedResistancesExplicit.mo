within Buildings.Fluids.FixedResistances.Examples;
model FixedResistancesExplicit "Test of multiple resistances in series"
  import Buildings;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{160,160}}),
                      graphics),
                       Commands(file=
          "FixedResistancesExplicit.mos" "run"),
    Documentation(info="<html>
This model tests whether inverse functions are being used by the code
translator. In Dymola 7.2, there should only be one non-linear equation system
in one variable after the symbolic manipulations.
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{160,
            160}})));
 package Medium = Modelica.Media.Air.SimpleAir;
  Modelica_Fluid.Sources.Boundary_ph sou(             redeclare package Medium
      =        Medium,
    nPorts=1,
    p(displayUnit="Pa") = 101335,
    use_p_in=true)                    annotation (Placement(transformation(
          extent={{-60,90},{-40,110}},rotation=0)));
  Modelica_Fluid.Sources.Boundary_ph sin(             redeclare package Medium
      =        Medium,
    nPorts=1,
    use_p_in=false,
    p=101325)                         annotation (Placement(transformation(
          extent={{120,90},{100,110}},
                                    rotation=0)));

    Buildings.Fluids.FixedResistances.FixedResistanceDpM res(
    redeclare package Medium = Medium,
    from_dp = false,
    m_flow_nominal=2,
    dp_nominal=5) 
             annotation (Placement(transformation(extent={{-20,90},{0,110}},
          rotation=0)));
  inner Modelica_Fluid.System system(p_ambient=101325) 
                                   annotation (Placement(transformation(extent={{140,-80},
            {160,-60}},        rotation=0)));
    Buildings.Fluids.FixedResistances.FixedResistanceDpM res1(
    redeclare package Medium = Medium,
    from_dp = false,
    m_flow_nominal=2,
    dp_nominal=5) 
             annotation (Placement(transformation(extent={{20,90},{40,110}},
          rotation=0)));
    Buildings.Fluids.FixedResistances.FixedResistanceDpM res2(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    dp_nominal=5,
    from_dp=true) 
             annotation (Placement(transformation(extent={{20,50},{40,70}},
          rotation=0)));
    Buildings.Fluids.FixedResistances.FixedResistanceDpM res3(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    dp_nominal=5,
    from_dp=true) 
             annotation (Placement(transformation(extent={{-20,50},{0,70}},
          rotation=0)));
    Buildings.Fluids.FixedResistances.FixedResistanceDpM res4(
    redeclare package Medium = Medium,
    from_dp = false,
    m_flow_nominal=2,
    dp_nominal=5) 
             annotation (Placement(transformation(extent={{-20,-20},{0,0}},
          rotation=0)));
    Buildings.Fluids.FixedResistances.FixedResistanceDpM res5(
    redeclare package Medium = Medium,
    from_dp = false,
    m_flow_nominal=2,
    dp_nominal=5) 
             annotation (Placement(transformation(extent={{20,-20},{40,0}},
          rotation=0)));
    Buildings.Fluids.FixedResistances.FixedResistanceDpM res6(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    dp_nominal=5,
    from_dp=true) 
             annotation (Placement(transformation(extent={{20,-60},{40,-40}},
          rotation=0)));
    Buildings.Fluids.FixedResistances.FixedResistanceDpM res7(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    dp_nominal=5,
    from_dp=true) 
             annotation (Placement(transformation(extent={{-20,-60},{0,-40}},
          rotation=0)));
  Modelica_Fluid.Sources.MassFlowSource_h bou(
    redeclare package Medium = Medium,
    m_flow=1,
    nPorts=1) annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica_Fluid.Sources.MassFlowSource_h bou1(
    redeclare package Medium = Medium,
    m_flow=1,
    nPorts=1) 
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica_Fluid.Sources.Boundary_pT sin1(            redeclare package Medium
      =        Medium, T=273.15 + 10,
    nPorts=2,
    use_p_in=false,
    p=101325)                         annotation (Placement(transformation(
          extent={{120,-40},{100,-20}},
                                    rotation=0)));
  Modelica_Fluid.Sources.Boundary_ph sin2(            redeclare package Medium
      =        Medium,
    nPorts=1,
    use_p_in=false,
    p=101325)                         annotation (Placement(transformation(
          extent={{120,50},{100,70}},
                                    rotation=0)));
  Modelica_Fluid.Sources.Boundary_ph sou1(            redeclare package Medium
      =        Medium,
    nPorts=1,
    p(displayUnit="Pa") = 101335,
    use_p_in=true)                    annotation (Placement(transformation(
          extent={{-58,50},{-38,70}}, rotation=0)));
    Modelica.Blocks.Sources.Ramp P(
      duration=1,
    height=20,
    offset=101315) 
                 annotation (Placement(transformation(extent={{-100,90},{-80,
            110}},
          rotation=0)));
  Modelica_Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium) "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{60,90},{80,110}})));
  Modelica_Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Medium) "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica_Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium =
        Medium) "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Modelica_Fluid.Sensors.MassFlowRate senMasFlo3(redeclare package Medium =
        Medium) "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Buildings.Utilities.Diagnostics.AssertEquality assertEquality
    annotation (Placement(transformation(extent={{120,120},{140,140}})));
  Buildings.Utilities.Diagnostics.AssertEquality assertEquality1
    annotation (Placement(transformation(extent={{120,0},{140,20}})));
equation
  connect(res.port_b, res1.port_a) annotation (Line(
      points={{0,100},{20,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res3.port_b, res2.port_a) annotation (Line(
      points={{0,60},{20,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res4.port_b, res5.port_a) annotation (Line(
      points={{0,-10},{20,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res7.port_b, res6.port_a) annotation (Line(
      points={{0,-50},{20,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou.ports[1], res.port_a) annotation (Line(
      points={{-40,100},{-20,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], res4.port_a) annotation (Line(
      points={{-60,-10},{-20,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou1.ports[1], res7.port_a) annotation (Line(
      points={{-60,-50},{-20,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou1.ports[1], res3.port_a) annotation (Line(
      points={{-38,60},{-20,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(P.y, sou.p_in) annotation (Line(
      points={{-79,100},{-72,100},{-72,108},{-62,108}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P.y, sou1.p_in) annotation (Line(
      points={{-79,100},{-70,100},{-70,68},{-60,68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(res1.port_b, senMasFlo.port_a) annotation (Line(
      points={{40,100},{60,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res2.port_b, senMasFlo1.port_a) annotation (Line(
      points={{40,60},{60,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res5.port_b, senMasFlo2.port_a) annotation (Line(
      points={{40,-10},{60,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res6.port_b, senMasFlo3.port_a) annotation (Line(
      points={{40,-50},{60,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo2.port_b, sin1.ports[1]) annotation (Line(
      points={{80,-10},{90,-10},{90,-28},{100,-28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo3.port_b, sin1.ports[2]) annotation (Line(
      points={{80,-50},{90,-50},{90,-32},{100,-32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo.port_b, sin.ports[1]) annotation (Line(
      points={{80,100},{100,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.port_b, sin2.ports[1]) annotation (Line(
      points={{80,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo2.m_flow, assertEquality1.u1) annotation (Line(
      points={{70,1},{70,16},{118,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo3.m_flow, assertEquality1.u2) annotation (Line(
      points={{70,-39},{72,-39},{72,-30},{84,-30},{84,4},{118,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo.m_flow, assertEquality.u1) annotation (Line(
      points={{70,111},{70,136},{118,136}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo1.m_flow, assertEquality.u2) annotation (Line(
      points={{70,71},{70,80},{88,80},{88,124},{118,124}},
      color={0,0,127},
      smooth=Smooth.None));
end FixedResistancesExplicit;