within Buildings.Fluid.Sensors;
model EnthalpyFlowRate "Ideal enthalphy flow rate sensor"
  extends Buildings.Fluid.Sensors.BaseClasses.PartialDynamicFlowSensor(tau=0);
  extends Modelica.Icons.RotationalSensor;

  Modelica.Blocks.Interfaces.RealOutput H_flow(unit="W")
    "Enthalpy flow rate, positive if from port_a to port_b"
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  parameter Modelica.SIunits.SpecificEnthalpy h_out_start=
    Medium.specificEnthalpy_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
    "Initial or guess value of measured specific enthalpy"
    annotation (Dialog(group="Initialization"));

  Modelica.SIunits.SpecificEnthalpy hMed_out(start=h_out_start)
    "Medium enthalpy to which the sensor is exposed";
  Modelica.SIunits.SpecificEnthalpy h_out(start=h_out_start)
    "Medium enthalpy that is used to compute the enthalpy flow rate";

initial equation
  if dynamic then
    if initType == Modelica.Blocks.Types.Init.SteadyState then
      der(h_out) = 0;
    elseif initType == Modelica.Blocks.Types.Init.InitialState or
           initType == Modelica.Blocks.Types.Init.InitialOutput then
      h_out = h_out_start;
    end if;
  end if;

equation
  if allowFlowReversal then
    hMed_out = Modelica.Fluid.Utilities.regStep(port_a.m_flow,
                 port_b.h_outflow,
                 port_a.h_outflow, m_flow_small);
  else
    hMed_out = port_b.h_outflow;
  end if;
  // Specific enthalpy measured by sensor
  if dynamic then
    der(h_out) = (hMed_out-h_out)*k/tau;
  else
    h_out = hMed_out;
  end if;
  // Sensor output signal
  H_flow = port_a.m_flow * h_out;

annotation (defaultComponentName="senEntFlo",
  Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics),
  Icon(graphics={
        Line(points={{-100,0},{-70,0}}, color={0,128,255}),
        Line(points={{70,0},{100,0}}, color={0,128,255}),
        Line(points={{0,100},{0,70}}, color={0,0,127}),
        Text(
          extent={{180,151},{20,99}},
          lineColor={0,0,0},
          textString="H_flow")}),
  Documentation(info="<html>
<p>
This component monitors the enthalphy flow rate of the medium in the flow
between fluid ports. The sensor is ideal, i.e., it does not influence the fluid.
</p>
<p>
If the parameter <code>tau</code> is non-zero, then the measured
specific enthalpy <i>h<sub>out</sub></i> that is used to 
compute the enthalpy flow rate 
<i>H&#775; = m&#775; h<sub>out</sub></i> 
is computed using a first order differential equation. 
See <a href=\"modelica://Buildings.Fluid.Sensors.UsersGuide\">
Buildings.Fluid.Sensors.UsersGuide</a> for an explanation.
</p>
<p>
For a sensor that measures the latent enthalpy flow rate, use
<a href=\"modelica://Buildings.Fluid.Sensors.LatentEnthalpyFlowRate\">
Buildings.Fluid.Sensors.LatentEnthalpyFlowRate</a>.
</p>
</html>
", revisions="<html>
<html>
<p>
<ul>
<li>
June 3, 2011 by Michael Wetter:<br>
Revised implementation to add dynamics in such a way that 
the time constant increases as the mass flow rate tends to zero.
This can improve the numerics.
</li>
<li>
April 9, 2008 by Michael Wetter:<br>
First implementation.
Implementation is based on enthalpy sensor of <code>Modelica.Fluid</code>.
</li>
</ul>
</html>"));
end EnthalpyFlowRate;
