model TestMoistAirNonsaturated 
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
     redeclare package Medium = 
          Buildings.Media.PerfectGases.MoistAirNonsaturated);
  
      annotation (Diagram, Commands(file="TestMoistAirNonsaturated.mos" "run"),
    Documentation(preferedView="info", info="<html>
This is a simple test for the medium model. It uses the test model described in
<a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium\">
Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium</a>.
</html>", revisions="<html>
<ul>
<li>
May 12, 2008, by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"));
end TestMoistAirNonsaturated;