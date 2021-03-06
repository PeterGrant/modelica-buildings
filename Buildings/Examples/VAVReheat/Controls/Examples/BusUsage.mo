within Buildings.Examples.VAVReheat.Controls.Examples;
model BusUsage "Demonstrates the usage of a signal bus"
  extends Modelica.Icons.Example;

public
  Modelica.Blocks.Sources.IntegerStep integerStep(
    height=1,
    offset=2,
    startTime=0.5)   annotation (Placement(transformation(extent={{-60,-40},{
            -40,-20}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.5)
                                                             annotation (Placement(
        transformation(extent={{-58,0},{-38,20}}, rotation=0)));
  Modelica.Blocks.Sources.Sine sine
                                   annotation (Placement(transformation(
          extent={{-60,40},{-40,60}}, rotation=0)));

  Modelica.Blocks.Examples.BusUsage_Utilities.Part part
            annotation (Placement(transformation(extent={{-60,-80},{-40,-60}},
          rotation=0)));
  Modelica.Blocks.Math.Gain gain
    annotation (Placement(transformation(extent={{-40,70},{-60,90}}, rotation=
           0)));
protected
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus
    annotation (Placement(transformation(
        origin={30,10},
        extent={{-20,20},{20,-20}},
        rotation=90)));
equation

  connect(booleanStep.y, controlBus.booleanSignal) annotation (Line(
      points={{-37,10},{30,10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(integerStep.y, controlBus.integerSignal) annotation (Line(
      points={{-39,-30},{0,-30},{0,10},{30,10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(part.subControlBus, controlBus.subControlBus) annotation (Line(
      points={{-40,-70},{30,-70},{30,10}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sine.y, controlBus.test) annotation (Line(
      points={{-39,50},{-18,50},{-18,48},{30,48},{30,10}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(controlBus.test, gain.u) annotation (Line(
      points={{30,10},{28,10},{28,84},{-38,84},{-38,80}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Documentation(info="<html>
<p><b>Signal bus concept</b></p>
<p>
In technical systems, such as vehicles, robots or satellites, many signals
are exchanged between components. In a simulation system, these signals
are  usually modelled by signal connections of input/output blocks.
Unfortunately, the signal connection structure may become very complicated,
especially for hierarchical models.
</p>

<p>
The same is also true for real technical systems. To reduce complexity
and get higher flexibility, many technical systems use data buses to
exchange data between components. For the same reasons, it is often better
to use a \"signal bus\" concept also in a Modelica model. This is demonstrated
at hand of this model (Modelica.Blocks.Examples.BusUsage):
</p>

<p align=\"center\">
<img src=\"../Images/Blocks/BusUsage.png\">
</p>

<ul>
<li> Connector instance \"controlBus\" is a hierarchical connector that is
     used to exchange signals between different components. It is
     defined as \"expandable connector\" in order that <b>no</b> central definition
     of the connector is needed but is automatically constructed by the
     signals connected to it (see also Modelica specification 2.2.1).</li>
<li> Input/output signals can be directly connected to the \"controlBus\".</li>
<li> A component, such as \"part\", can be directly connected to the \"controlBus\",
     provided it has also a bus connector, or the \"part\" connector is a
     sub-connector contained in the \"controlBus\". </li>
</ul>

<p>
The control and sub-control bus icons are provided within Modelica.Icons.
In <a href=\"Modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces\">Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces</a>
the buses for this example are defined. Both the \"ControlBus\" and the \"SubControlBus\" are
<b>expandable</b> connectors that do not define any variable. For example,
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus#text\">Interfaces.ControlBus</a>
is defined as:
</p>
<pre>  <b>expandable connector</b> ControlBus
      <b>extends</b> Modelica.Icons.ControlBus;
      <b>annotation</b> (Icon(Rectangle(extent=[-20, 2; 22, -2],
                       style(rgbcolor={255,204,51}, thickness=0.5))));
  <b>end</b> ControlBus;
</pre>
<p>
Note, the \"annotation\" in the connector is important since the color
and thickness of a connector line are taken from the first
line element in the icon annotation of a connector class. Above, a small rectangle in the
color of the bus is defined (and therefore this rectangle is not
visible). As a result, when connecting from an instance of this
connector to another connector instance, the connecting line has
the color of the \"ControlBus\" with double width (due to \"thickness=0.5\").
</p>

<p>
An <b>expandable</b> connector is a connector where the content of the connector
is constructed by the variables connected to instances of this connector.
For example, if \"sine.y\" is connected to the \"controlBus\", the following
menu pops-up in Dymola:
</p>

<p align=\"center\">
<img src=\"../Images/Blocks/BusUsage2.png\">
</p>

<p>
The \"Add variable/New name\" field allows the user to define the name of the signal on
the \"controlBus\". When typing \"realSignal1\" as \"New name\", a connection of the form:
</p>

<pre>     <b>connect</b>(sine.y, controlBus.realSignal1)
</pre>

<p>
is generated and the \"controlBus\" contains the new signal \"realSignal1\". Modelica tools
may give more support in order to list potential signals for a connection.
For example, in Dymola all variables are listed in the menu that are contained in
connectors which are derived by inheritance from \"controlBus\". Therefore, in
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.InternalConnectors\">BusUsage_Utilities.Interfaces.InternalConnectors</a>
the expected implementation of the \"ControlBus\" and of the \"SubControlBus\" are given.
For example \"Internal.ControlBus\" is defined as:
</p>

<pre>  <b>expandable connector</b> StandardControlBus
    <b>extends</b> BusUsage_Utilities.Interfaces.ControlBus;

    <b>import</b> SI = Modelica.SIunits;
    SI.AngularVelocity    realSignal1   \"First Real signal\";
    SI.Velocity           realSignal2   \"Second Real signal\";
    Integer               integerSignal \"Integer signal\";
    Boolean               booleanSignal \"Boolean signal\";
    StandardSubControlBus subControlBus \"Combined signal\";
  <b>end</b> StandardControlBus;
</pre>

<p>
Consequently, when connecting now from \"sine.y\" to \"controlBus\", the menu
looks differently:
</p>
<p align=\"center\">
<img src=\"../Images/Blocks/BusUsage3.png\">
</p>
<p>
Note, even if the signals from \"Internal.StandardControlBus\" are listed, these are
just potential signals. The user might still add different signal names.
</p>

</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),
                 graphics),
    experiment(StopTime=2));
end BusUsage;
