# FEATS

[![FIWARE Chapter](https://nexus.lab.fiware.org/repository/raw/public/badges/chapters/robotics.svg)](https://github.com/FIWARE/catalogue)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-green)](https://opensource.org/licenses/MIT)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/4842/badge)](https://bestpractices.coreinfrastructure.org/projects/4842)
[![Documentation Status](https://readthedocs.org/projects/feats-dih2/badge/?version=latest)](https://feats-dih2.readthedocs.io/en/latest/?badge=latest)

Fiware-Enabled Autonomous Transport System (FEATS) is a project whose scope is automated material transport within a production facility using an Autonomous Mobile Robot (AMR).
This repository contains the source code for the [CoFFEE](https://github.com/Dalma-Systems/coffee/) and [FI-BREW](https://github.com/Dalma-Systems/fi-brew/) components of the FEATS project, as well as an executable of the [LATTE](https://github.com/Dalma-Systems/latte/) component, for test / usage demonstration purposes.
The FEATS project is composed of these 3 components, and as such each of these has its own repository. Those repositories are included here in the form of Git submodules.

This project is part of [DIH<sup>2</sup>](http://www.dih-squared.eu/). For more information check the RAMP Catalogue entry for the
[components](https://github.com/ramp-eu).

This project is part of [FIWARE](https://www.fiware.org/). For more information check the [FIWARE Catalogue](https://github.com/Fiware/catalogue/).


 :books: [Documentation](https://feats-dih2.readthedocs.io/en/latest/) | :coffee: [CoFFEE](https://github.com/Dalma-Systems/coffee/) | :cup_with_straw: [FI-BREW](https://github.com/Dalma-Systems/fi-brew/) | :milk_glass: [LATTE](https://github.com/Dalma-Systems/latte/)
 --- | --- | --- | ---

## Table of Contents
- [FEATS](#feats)
  - [Table of Contents](#table-of-contents)
  - [Background](#background)
  - [Build & Install](#build--install)
  - [API Overview](#api-overview)
  - [Documentation](#documentation)
  - [License](#license)

## Background

The challenge for FEATS’ project was to gather an ERP system, automatic warehouse and autonomous mobile robot (AMR) under the same standard language in order to automate the process of transporting raw material from the warehouse to each workstation with minimum human intervention. 
From the manufacturing company’s point of view, FEATS is a smart robotics-based intralogistics service where they need to provide some inputs to get an autonomous material delivery from point A to point B.
This smart robotics-based intralogistics service comprises all FIWARE ready components developed within the scope of the DIH2 program, namely: [CoFFEE](https://github.com/Dalma-Systems/coffee/) (communicates with ERP system), [FIROS](https://github.com/iml130/firos) (communicates with the AMR), [FI-BREW](https://github.com/Dalma-Systems/fi-brew/) (communicates with automatic warehouse) and [LATTE](https://github.com/Dalma-Systems/latte/) (smart agent that manages and controls all actions).

## Build & Install
Information about how to install the components of FEATS can be found in the corresponding section of the Read The Docs [page](https://feats-dih2.readthedocs.io/en/latest/).

## API Overview
An example of the usage of the system can be found in the corresponding section of the Read The Docs [page](https://feats-dih2.readthedocs.io/en/latest/).

## Documentation
The full documentation can be found in the corresponding section of the Read The Docs [page](https://feats-dih2.readthedocs.io/en/latest/). You may also check out our video tutorial, which follows the step-by-step guide and can help clarify some issues:

[![FEATS tutorial video](http://img.youtube.com/vi/DiTcbAgMMZY/0.jpg)](https://youtu.be/DiTcbAgMMZY)

## License

[Apache](LICENSE) © 2021 [Dalma Systems](https://www.dalmarobotics.com)
