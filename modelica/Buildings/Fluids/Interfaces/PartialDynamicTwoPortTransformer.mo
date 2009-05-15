within Buildings.Fluids.Interfaces;
partial model PartialDynamicTwoPortTransformer
  "Partial model transporting one fluid stream with storing mass or energy"
  extends Buildings.Fluids.Interfaces.PartialStaticTwoPortInterface;
  extends Buildings.Fluids.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true);
  import Modelica.Constants;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Documentation(info="<html>
<p>
This component transports one fluid stream. 
It provides the basic model for implementing a dynamic heater such as a boiler.
It is used by 
<a href=\"Modelica:Buildings.Fluids.Boilers.BoilerPolynomial\">
Buildings.Fluids.Boilers.BoilerPolynomial</a>.
The variable names follow the conventions used in 
<tt>Modelica_Fluid.HeatExchangers.BasicHX</tt>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 13, 2009, by Michael Wetter:<br>
Added model to compute flow friction.
</li>
<li>
January 29, 2009 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-70,60},{70,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-101,6},{100,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-4},{100,6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}));

  Buildings.Fluids.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    nPorts = 2,
    V=m_flow_nominal*tau/rho_nominal,
    final use_HeatTransfer=true,
    redeclare model HeatTransfer = 
        Modelica_Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final use_T_start=use_T_start,
    final T_start=T_start,
    final h_start=h_start,
    final X_start=X_start,
    final C_start=C_start) "Volume for fluid stream" 
                                    annotation (Placement(transformation(extent={{-9,0},{
            11,-20}},         rotation=0)));

  parameter Modelica.SIunits.Time tau = 300 "Time constant at nominal flow" 
     annotation (Dialog(group="Nominal condition"));
  // Assumptions
  parameter Modelica_Fluid.Types.Dynamics energyDynamics=system.energyDynamics
    "Formulation of energy balance" 
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Modelica_Fluid.Types.Dynamics massDynamics=energyDynamics
    "Formulation of mass balance" 
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  final parameter Modelica_Fluid.Types.Dynamics substanceDynamics=massDynamics
    "Formulation of substance balance" 
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  final parameter Modelica_Fluid.Types.Dynamics traceDynamics=massDynamics
    "Formulation of trace substance balance" 
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

  // Initialization
  parameter Medium.AbsolutePressure p_start = system.p_start
    "Start value of pressure" 
    annotation(Dialog(tab = "Initialization"));
  parameter Boolean use_T_start = true "= true, use T_start, otherwise h_start"
    annotation(Dialog(tab = "Initialization"), Evaluate=true);
  parameter Medium.Temperature T_start=
    if use_T_start then system.T_start else Medium.temperature_phX(p_start,h_start,X_start)
    "Start value of temperature" 
    annotation(Dialog(tab = "Initialization", enable = use_T_start));
  parameter Medium.SpecificEnthalpy h_start=
    if use_T_start then Medium.specificEnthalpy_pTX(p_start, T_start, X_start) else Medium.h_default
    "Start value of specific enthalpy" 
    annotation(Dialog(tab = "Initialization", enable = not use_T_start));
  parameter Medium.MassFraction X_start[Medium.nX] = Medium.X_default
    "Start value of mass fractions m_i/m" 
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Start value of trace substances" 
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSen(
    T(final quantity="ThermodynamicTemperature",
      final unit = "K", displayUnit = "degC", min=0))
    "Temperature sensor of metal" 
    annotation (Placement(transformation(extent={{5,30},{25,50}},   rotation=0)));

protected
  parameter Medium.ThermodynamicState sta_nominal=Medium.setState_pTX(
      T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
  parameter Modelica.SIunits.Density rho_nominal=Medium.density(sta_nominal)
    "Density, used to compute fluid volume";
public
  Buildings.Fluids.FixedResistances.FixedResistanceDpM preDro(
    redeclare package Medium = Medium,
    final use_dh=false,
    final m_flow_nominal=m_flow_nominal,
    final deltaM=deltaM,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=m_flow_small,
    final show_T=false,
    final show_V_flow=show_V_flow,
    final from_dp=from_dp,
    final linearized=linearizeFlowResistance,
    final dp_nominal=dp_nominal) "Pressure drop model" 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  assert(vol.use_HeatTransfer == true, "Wrong parameter for vol.");

  connect(temSen.port, vol.heatPort) annotation (Line(
      points={{5,40},{-9,40},{-9,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(vol.ports[2], port_b) annotation (Line(
      points={{3,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a, preDro.port_a) annotation (Line(
      points={{-100,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(preDro.port_b, vol.ports[1]) annotation (Line(
      points={{-40,0},{-1,0}},
      color={0,127,255},
      smooth=Smooth.None));
end PartialDynamicTwoPortTransformer;