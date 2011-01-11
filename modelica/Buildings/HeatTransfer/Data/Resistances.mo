within Buildings.HeatTransfer.Data;
package Resistances "Package with thermal resistances"
  record Generic "Thermal properties of heat resistances"
      extends Buildings.HeatTransfer.Data.BaseClasses.Material(
      final c=0,
      final d=0,
      final k=0,
      final x=0,
      final nStaRef=0,
      final nSta=1,
      final steadyState=true);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,50},{100,-100}},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}), Text(
            extent={{-98,-72},{96,-94}},
            lineColor={0,0,255},
            textString="R=%R")}));
  end Generic;

  record Carpet = Buildings.HeatTransfer.Data.Resistances.Generic (R=0.2165) "Carpet";
end Resistances;