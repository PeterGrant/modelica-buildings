within Buildings.Fluids.Actuators.Examples;
model TwoWayValvesMotor

    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),
                        graphics),
                         Commands(file=
            "TwoWayValvesMotor.mos" "run"),
    Documentation(info="<html>
<p>
Test model for two way valves. Note that the 
leakage flow rate has been set to a large value
and the rangeability to a small value
for better visualization of the valve characteristics.
To use common values, use the default values.
</p>
</html>", revisions="<html>
<ul>
<li>
June 16, 2008 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"));

 package Medium = Buildings.Media.ConstantPropertyLiquidWater;

  Buildings.Fluids.Actuators.Valves.TwoWayLinear valLin(
    redeclare package Medium = Medium,
    l=0.05,
    m_flow_nominal=2) "Valve model, linear opening characteristics" 
         annotation (Placement(transformation(extent={{0,10},{20,30}}, rotation=
           0)));
  Modelica_Fluid.Sources.Boundary_pT sou(             redeclare package Medium
      = Medium,
    nPorts=3,
    use_p_in=true,
    T=293.15)                                       annotation (Placement(
        transformation(extent={{-60,-20},{-40,0}}, rotation=0)));
  Modelica_Fluid.Sources.Boundary_pT sin(             redeclare package Medium
      = Medium,
    nPorts=3,
    use_p_in=true,
    T=293.15)                                       annotation (Placement(
        transformation(extent={{70,-20},{50,0}}, rotation=0)));
    Modelica.Blocks.Sources.Constant PSin(k=3E5) 
      annotation (Placement(transformation(extent={{60,60},{80,80}}, rotation=0)));
    Modelica.Blocks.Sources.Constant PSou(k=306000) 
      annotation (Placement(transformation(extent={{-100,-12},{-80,8}},
          rotation=0)));
  Buildings.Fluids.Actuators.Valves.TwoWayQuickOpening valQui(
    redeclare package Medium = Medium,
    l=0.05,
    m_flow_nominal=2) "Valve model, quick opening characteristics" 
         annotation (Placement(transformation(extent={{0,-20},{20,0}}, rotation=
           0)));
  Buildings.Fluids.Actuators.Valves.TwoWayEqualPercentage valEqu(
    redeclare package Medium = Medium,
    l=0.05,
    R=10,
    delta0=0.1,
    m_flow_nominal=2) "Valve model, equal percentage opening characteristics" 
         annotation (Placement(transformation(extent={{0,-50},{20,-30}},
          rotation=0)));
  Modelica.Blocks.Sources.TimeTable ySet(table=[0,0; 60,0; 60,1; 120,1; 180,0.5;
        240,0.5; 300,0; 360,0; 360,0.25; 420,0.25; 480,1; 540,1.5; 600,-0.25])
    "Set point for actuator" annotation (Placement(transformation(extent={{-100,
            60},{-80,80}}, rotation=0)));
  Actuators.Motors.IdealMotor mot(                 tOpe=60) "Motor model" 
    annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=0)));
  inner Modelica_Fluid.System system 
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
equation
  connect(PSin.y, sin.p_in) annotation (Line(points={{81,70},{86,70},{86,-2},{
          72,-2}}, color={0,0,127}));
  connect(PSou.y, sou.p_in) 
    annotation (Line(points={{-79,-2},{-74.5,-2},{-62,-2}},
                                                 color={0,0,127}));
  connect(ySet.y, mot.u) 
    annotation (Line(points={{-79,70},{-62,70}}, color={0,0,127}));
  connect(mot.y, valEqu.y) annotation (Line(points={{-39,70},{-12,70},{-12,-28},
          {10,-28},{10,-32}},
                     color={0,0,127}));
  connect(mot.y, valQui.y) annotation (Line(points={{-39,70},{-12,70},{-12,2},{
          10,2},{10,-2}},
                    color={0,0,127}));
  connect(mot.y, valLin.y) annotation (Line(points={{-39,70},{-12,70},{-12,34},
          {10,34},{10,28}},
                    color={0,0,127}));
  connect(sou.ports[1], valLin.port_a) annotation (Line(
      points={{-40,-7.33333},{-20,-7.33333},{-20,20},{0,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou.ports[2], valQui.port_a) annotation (Line(
      points={{-40,-10},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou.ports[3], valEqu.port_a) annotation (Line(
      points={{-40,-12.6667},{-20,-12.6667},{-20,-40},{0,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valLin.port_b, sin.ports[1]) annotation (Line(
      points={{20,20},{36,20},{36,-7.33333},{50,-7.33333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valQui.port_b, sin.ports[2]) annotation (Line(
      points={{20,-10},{50,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valEqu.port_b, sin.ports[3]) annotation (Line(
      points={{20,-40},{36,-40},{36,-12.6667},{50,-12.6667}},
      color={0,127,255},
      smooth=Smooth.None));
end TwoWayValvesMotor;