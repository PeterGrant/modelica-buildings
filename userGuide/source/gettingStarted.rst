.. highlight:: rest

.. _gettingStarted:

Getting Started
===============


Literature for Users
--------------------
We recommend new users of Modelica to study the books by Michael Tiller [Til2001]_ and Peter Fritzson ([Fri2011]_ and [Fri2004]_), and the tutorials that are listed at https://www.modelica.org/publications.

Although the `Modelica Language Tutorial <https://www.modelica.org/documents/ModelicaTutorial14.pdf>`_ is for an older version (Modelica 1.4), it is still instructive and relevant to understand the concepts of the language.

Links to papers that describe or used the `Buildings` library are available at http://simulationresearch.lbl.gov/modelica/Publications. The model documentation from the download page contains user guides that describe the individual packages of the `Buildings` library.


Literature for Developers
-------------------------

It is essential that users who develop new thermo-fluid models to  understand the concept of stream connectors. Stream connectors are explained in the Modelica language definition, available at https://www.modelica.org/documents, and in the paper Franke et al. [Fra2009a]_. 
The `Buildings` library uses similar modeling principles, and the same base classes, as the `Modelica.Fluid` library. Hence, we also recommend reading the paper about the standardization of thermo-fluid models in Modelica.Fluid [Fra2009b]_.


Software Requirements
---------------------
Check the software requirements for the different versions of the Buildings library at http://simulationresearch.lbl.gov/modelica/Download


Running the First Simulations
-----------------------------

To start using Modelica, run the example models of the `Buildings` library. Make variations in these examples by changing values of model parameters or by replacing existing component models by new ones. The example models can be found in the packages `Examples`, and detailed tutorials with step-by-step instructions for how to build system models can be found in the `Tutorial package <http://simulationresearch.lbl.gov/modelica/releases/latest/help/Buildings_Examples_Tutorial.html>`_.

Note that heat transfer models, which can be found in `Buildings.HeatTransfer.*.Examples` are easier to understand than fluid flow models because; 

* handling fluid flow adds more complexity due to flow reversal (i.e., if the mass flow rate changes its direction), 
* fluid flow models may need to handle multiple species such as air and water vapor, as well as trace substances such as CO2, and 
* fluid flow models use packages that define medium models, such as dry air, moist air, water or other fluids.


References
----------

.. [Fri2004] Peter Fritzson. *Principles of Object-Oriented Modeling and Simulation with Modelica 2.1.* John Wiley & Sons, 2004.

.. [Fri2011] Peter Fritzson. *Introduction to Modeling and Simulation of Technical and Physical Systems with Modelica.* Wiley-IEEE Press, ISBN 978-1-1180-1068-6, 2011.

.. [Fra2009a] R. Franke, F. Casella, M. Otter, M. Sielemann, H. Elmqvist, S. E. Mattsson, and H. Olsson. `Stream connectors – an extension of modelica for device-oriented modeling of convective transport phenomena <https://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0078/0078.pdf>`_. In F. Casella, editor, Proc. of the 7-th International Modelica Conference, Como, Italy, Sept. 2009. 

.. [Fra2009b] R. Franke, F. Casella, M. Otter, K. Proelss, M. Sielemann, and M. Wetter. `Standardization of thermo-fluid modeling in Modelica.Fluid     <https://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0077/0077.pdf>`_.     In F. Casella, editor, Proc. of the 7-th International Modelica Conference, Como, Italy, Sept. 2009.

.. [Til2001] Michael M. Tiller. *Introduction to Physical Modeling with Modelica.* Kluwer Academic Publisher, 2001.

.. ###############################################################################################################

