within Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses;
model BoreholeSegment "Vertical segment of a borehole"
  extends Buildings.Fluid.Interfaces.PartialFourPortInterface(
     redeclare final package Medium1 = Medium,
     redeclare final package Medium2 = Medium,
     final m1_flow_nominal = m_flow_nominal,
     final m2_flow_nominal = m_flow_nominal,
     final m1_flow_small =   m_flow_small,
     final m2_flow_small =   m_flow_small,
     final allowFlowReversal1=allowFlowReversal,
     final allowFlowReversal2=allowFlowReversal);
  extends Buildings.Fluid.Interfaces.TwoPortFlowResistanceParameters;
  extends Buildings.Fluid.Interfaces.LumpedVolumeDeclarations(T_start=TFil_start);
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component" annotation (choicesAllMatching=true);
  replaceable parameter Buildings.HeatTransfer.Data.Soil.Generic
                                             matSoi
    "Thermal properties of soil"
    annotation (choicesAllMatching=true, Dialog(group="Soil"),
    Placement(transformation(extent={{2,70},{22,90}})));
  replaceable parameter Buildings.HeatTransfer.Data.BoreholeFillings.Generic matFil
    "Thermal properties of the filling material"
    annotation (choicesAllMatching=true, Dialog(group="Filling material"),
    Placement(transformation(extent={{-68,70},{-48,90}})));

  parameter Medium.MassFlowRate m_flow_nominal "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Medium.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));
  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Radius rTub=0.02 "Radius of the tubes"
    annotation (Dialog(group="Tubes"));
  parameter Modelica.SIunits.ThermalConductivity kTub=0.5
    "Thermal conductivity of the tubes" annotation (Dialog(group="Tubes"));
  parameter Modelica.SIunits.Length eTub=0.002 "Thickness of the tubes"
    annotation (Dialog(group="Tubes"));
  parameter Modelica.SIunits.Temperature TFil_start=283.15
    "Initial temperature of the filling material"
    annotation (Dialog(group="Filling material"));
  parameter Modelica.SIunits.Radius rExt=3
    "Radius of the soil used for the external boundary condition"
    annotation (Dialog(group="Soil"));
  parameter Modelica.SIunits.Temperature TExt_start=283.15
    "Initial far field temperature" annotation (Dialog(group="Soil"));
  parameter Integer nSta(min=1) = 10 "Number of state variables in the soil"
    annotation (Dialog(group="Soil"));
  parameter Modelica.SIunits.Time samplePeriod=604800
    "Sample period for the external boundary condition"
    annotation (Dialog(group="Soil"));
  parameter Modelica.SIunits.Radius rBor=0.1 "Radius of the borehole";
  parameter Modelica.SIunits.Height hSeg "Height of the element";
  parameter Modelica.SIunits.Length xC=0.05
    "Shank spacing, defined as the distance between the center of a pipe and the center of the borehole";
  parameter Real B0=17.44 "Shape coefficient for grout resistance";
  parameter Real B1=-0.6052 "Shape coefficient for grout resistance";

 parameter Boolean allowFlowReversal = true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

 Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses.HexInternalElement pipFil(
    redeclare final package Medium = Medium,
    final matFil=matFil,
    final hSeg=hSeg,
    final rTub=rTub,
    final eTub=eTub,
    final kTub=kTub,
    final kSoi=matSoi.k,
    final xC=xC,
    final rBor=rBor,
    final TFil_start=TFil_start,
    final B0=B0,
    final B1=B1,
    final m1_flow_nominal=m_flow_nominal,
    final m2_flow_nominal=m_flow_nominal,
    final dp1_nominal=dp_nominal,
    final dp2_nominal=0,
    final from_dp1=from_dp,
    final from_dp2=from_dp,
    final linearizeFlowResistance1=linearizeFlowResistance,
    final linearizeFlowResistance2=linearizeFlowResistance,
    final deltaM1=deltaM,
    final deltaM2=deltaM,
    final m1_flow_small=m_flow_small,
    final m2_flow_small=m_flow_small,
    final allowFlowReversal1=allowFlowReversal,
    final allowFlowReversal2=allowFlowReversal,
    final homotopyInitialization=homotopyInitialization,
    final show_V_flow=show_V_flow,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p1_start=p_start,
    T1_start=T_start,
    X1_start=X_start,
    C1_start=C_start,
    C1_nominal=C_nominal,
    final p2_start=p_start,
    T2_start=T_start,
    X2_start=X_start,
    C2_start=C_start,
    C2_nominal=C_nominal)
    "Internal part of the borehole including the pipes and the filling material"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Buildings.HeatTransfer.Conduction.SingleLayerCylinder soi(
    final material=matSoi,
    final h=hSeg,
    final nSta=nSta,
    final r_a=rBor,
    final r_b=rExt,
    final steadyStateInitial=false,
    final TInt_start=TFil_start,
    final TExt_start=TExt_start) "Heat conduction in the soil"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses.SingleUTubeBoundaryCondition
    TBouCon(
    final matSoi=matSoi,
    final rExt=rExt,
    final hSeg=hSeg,
    final TExt_start=TExt_start,
    final samplePeriod=samplePeriod)
    "Thermal boundary condition for the far-field"
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
protected
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFlo
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  connect(pipFil.port_b1, port_b1)
                                annotation (Line(
      points={{-50,6},{-40,6},{-40,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipFil.port_a2, port_a2)
                                annotation (Line(
      points={{-50,-6},{-40,-6},{-40,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipFil.port_b2, port_b2)
                                annotation (Line(
      points={{-70,-6},{-80,-6},{-80,-60},{-100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipFil.port, heaFlo.port_a)
                                     annotation (Line(
      points={{-50,6.10623e-16},{-45,6.10623e-16},{-45,1.22125e-15},{-40,
          1.22125e-15},{-40,6.10623e-16},{-30,6.10623e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heaFlo.port_b, soi.port_a) annotation (Line(
      points={{-10,6.10623e-16},{-7.5,6.10623e-16},{-7.5,1.22125e-15},{-5,
          1.22125e-15},{-5,6.10623e-16},{-5.55112e-16,6.10623e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(soi.port_b, TBouCon.port) annotation (Line(
      points={{20,6.10623e-16},{30,6.10623e-16},{30,20},{80,20},{80,6.10623e-16},
          {67.6,6.10623e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_a1, pipFil.port_a1) annotation (Line(
      points={{-100,60},{-80,60},{-80,6},{-70,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heaFlo.Q_flow, TBouCon.Q_flow) annotation (Line(
      points={{-20,-10},{-20,-20},{40,-20},{40,-8},{48,-8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    Icon(graphics={
        Rectangle(
          extent={{-72,80},{68,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{88,54},{-88,64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{88,-64},{-88,-54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,80},{68,68}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-72,-68},{68,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward)}),
    Documentation(info="<html>
<p>
Horizontal layer that is used to model a U-tube borehole heat exchanger. 
This model combines three models, each simulating a different aspect 
of a borehole heat exchanger. 
</p>
<p>
The instance <code>pipFil</code> computes the heat transfer in the pipes and the filling material. 
This computation is done using the model
<a href=\"modelica://Buildings.Fluid.Boreholes.BaseClasses.HexInternalElement\">
Buildings.Fluid.Boreholes.BaseClasses.HexInternalElement</a>.
</p>
<p>
The instance <code>soi</code> computes transient and steady state heat transfer in the soil using a vertical cylinder.
The computation is done using the model <a href=\"modelica://Buildings.HeatTransfer.Conduction.SingleLayerCylinder\">
Buildings.HeatTransfer.Conduction.SingleLayerCylinder</a>.
</p>
<p>
The model <code>TBouCon</code> computes the far-field temperature boundary condition, i.e., the temperature at the outer
surface of the above cylindrical heat transfer computation.
The computation is done using the model
<a href=\"modelica://Buildings.Fluid.Boreholes.BaseClasses.TemperatureBoundaryCondition\">
Buildings.Fluid.Boreholes.BaseClasses.TemperatureBoundaryCondition</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
July 28 2011, by Pierre Vigouroux:<br>
First implementation.
</li>
</ul>
</html>"));
end BoreholeSegment;
