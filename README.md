# Exim4 Puppet Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/ULHPC/exim4.svg)](https://forge.puppetlabs.com/ULHPC/exim4)
[![License](http://img.shields.io/:license-GPL3.0-blue.svg)](LICENSE)
![Supported Platforms](http://img.shields.io/badge/platform-debian-lightgrey.svg)

Configure and manage exim4

      Copyright (c) 2026 ULHPC Team <hpc-sysadmins@uni.lu>


| [Project Page](https://github.com/ULHPC/puppet-exim4) | [Sources](https://github.com/ULHPC/puppet-exim4) | [Issues](https://github.com/ULHPC/puppet-exim4/issues) |

## Synopsis

Configure and manage exim4.

This module implements the following elements:

* __Puppet classes__:
	- `exim4`: main class
	- `exim4::common`
	- `exim4::debian`: specific implementation under Debian
	- `exim4::redhat`: specific implementation under Redhat-like system
  - `exim4::params`: class parameters

* __Puppet definitions__:

All these components are configured through a set of variables you will find in
[`manifests/params.pp`](manifests/params.pp).

## Dependencies

See [`metadata.json`](metadata.json). In particular, this module depends on

* [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)

## Overview and Usage

### Class `exim4`

This is the main class defined in this module.
It accepts the following parameters:

* `$ensure`: default to 'present', can be 'absent'

Use it as follows:

     include ' exim4'

## Librarian-Puppet / R10K Setup

You can of course configure the exim4 module in your `Puppetfile` to make it available with [Librarian puppet](http://librarian-puppet.com/) or
[r10k](https://github.com/adrienthebo/r10k) by adding the following entry:

     # Modules from the Puppet Forge
     mod "ULHPC/exim4"

or, if you prefer to work on the git version:

     mod "ulhpc/exim4",
         :git => 'https://github.com/ULHPC/puppet-exim4',
         :ref => 'main'

## Developments / Issues / Contributing to the code

This Puppet Module has been implemented in the context of the [UL HPC](http://hpc.uni.lu) Platform of the [University of Luxembourg](http://www.uni.lu).
It relies on [Vox Pupuli modulesync](https://github.com/voxpupuli/modulesync) for its organization.

You can submit bugs / issues / feature requests using the [ulhpc-exim4 Puppet Module Tracker](https://github.com/ULHPC/puppet-exim4/issues).
You are more than welcome to contribute to its development by [sending a pull request](https://help.github.com/articles/using-pull-requests).

## Licence

This project and the sources proposed within this repository are released under the terms of the [GPL-3.0](LICENCE) licence.


[![Licence](https://www.gnu.org/graphics/gplv3-88x31.png)](LICENSE)
