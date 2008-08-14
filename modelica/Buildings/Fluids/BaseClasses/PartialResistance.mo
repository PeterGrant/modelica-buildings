partial model PartialResistance "Partial model for a hydraulic resistance" 
    extends Modelica_Fluid.Interfaces.PartialTwoPortTransport(
          medium_a(T(start = Medium.T_default), h(start=Medium.h_default),
                   p(start=Medium.p_default)),
          medium_b(T(start = Medium.T_default), h(start=Medium.h_default),
                   p(start=Medium.p_default)));
    extends Buildings.BaseClasses.BaseIcon;
  
  annotation (Icon(
      Rectangle(extent=[-100,40; 100,-40],   style(
          color=0,
          gradient=2,
          fillColor=8)),
      Rectangle(extent=[-100,22; 100,-24],   style(
          color=69,
          gradient=2,
          fillColor=69))), Documentation(info="<html>
<p>
Partial model for a flow resistance, possible with variable flow coefficient.
</p>
</html>"), revisions="<html>
<ul>
<li>
July 20, 2007 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>");
  
  parameter Boolean from_dp = true 
    "= true, use m_flow = f(dp) else dp = f(m_flow)" 
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Modelica.SIunits.MassFlowRate m_small_flow 
    "Mass flow rate where transition to laminar occurs";
  parameter Boolean linearized = false 
    "= true, use linear relation between m_flow and dp for any flow rate" 
    annotation(Dialog(tab="Advanced"));
protected 
  Real k(unit="(kg*m)^(1/2)", start=1) "Flow coefficient, k=m_flow/sqrt(dp)";
  Real kInv(unit="1/kg/m", start=1) 
    "Flow coefficient for inverse flow computation, kInv=dp/m_flow^2";
  
  Modelica.SIunits.AbsolutePressure dp_small 
    "Turbulent flow if |dp| >= dp_small, not a parameter because k can be a function of time";
  parameter Medium.ThermodynamicState sta0(T=Medium.T_default, p=Medium.p_default);
  
  parameter Modelica.SIunits.DynamicViscosity eta0=Medium.dynamicViscosity(sta0) 
    "Dynamic viscosity, used to compute laminar/turbulent transition";
  parameter Modelica.SIunits.SpecificEnthalpy h0=Medium.h_default 
    "Initial value for solver for specific enthalpy";           //specificEnthalpy(sta0) 
  
initial equation 
                 // this equation can be deleted, it here for debugging during library transition 
  assert(abs(eta0-Medium.dynamicViscosity(medium_a)) < 0.1*eta0, "Wrong parameter for eta.\n"
    + "  medium_a.T                              = " + realString(medium_a.T) + "\n"
    + "  medium_a.p                              = " + realString(medium_a.p) + "\n"
    + "  Medium.dynamicViscosity(medium_a)       = " + realString(Medium.dynamicViscosity(medium_a)) + "\n"
    + "  eta0                                    = " + realString(eta0) + "\n"
    + "  Medium.dynamicViscosity(medium_a)/ eta0 = " + realString(Medium.dynamicViscosity(medium_a)/eta0));
  
equation 
  1=k*k*kInv;
  dp_small = kInv * m_small_flow^2;
  if linearized then
     m_flow = k * dp;
  else
    if from_dp then
       m_flow = Buildings.Fluids.Utilities.massFlowRate_dp(             dp=dp, dp_small=dp_small, k=k);
    else
       dp = Buildings.Fluids.Utilities.pressureLoss_m_flow(             m_flow=m_flow,m_small_flow=m_small_flow,k=kInv);
    end if;
  end if;
end PartialResistance;