-*- mode: markdown; mode: visual-line;  -*-

# Exim4 Puppet Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/ulhpc/exim4.svg)](https://forge.puppetlabs.com/ulhpc/exim4)
[![License](http://img.shields.io/:license-GPL3.0-blue.svg)](LICENSE)
![Supported Platforms](http://img.shields.io/badge/platform-debian-lightgrey.svg)
[![Documentation Status](https://readthedocs.org/projects/ulhpc-puppet-exim4/badge/?version=latest)](https://readthedocs.org/projects/ulhpc-puppet-exim4/?badge=latest)

Configure and manage exim4

      Copyright (c) 2015 ULHPC Management Team <hpc-sysadmins@uni.lu>


| [Project Page](https://github.com/ULHPC/puppet-exim4) | [Sources](https://github.com/ULHPC/puppet-exim4) | [Documentation](httpd://ulhpc-puppet-exim4.readthedocs.org/en/latest/) | [Issues](https://github.com/ULHPC/puppet-exim4/issues) |

## Synopsis

Configure and manage exim4.

This module implements the following elements:

* __Puppet classes__:
	- `exim4`: main class
	- `exim4::common`
	- `exim4::debian`: specific implementation under Debian 
	- `exim4::redhat`: specific implementation under Redhat-like system
    - `exim4::params`: class parameters

All these components are configured through a set of variables you will find in
[`manifests/params.pp`](manifests/params.pp).

_Note_: the various operations that can be conducted from this repository are piloted from a [`Rakefile`](https://github.com/ruby/rake) and assumes you have a running [Ruby](https://www.ruby-lang.org/en/) installation.
See `docs/contributing.md` for more details on the steps you shall follow to have this `Rakefile` working properly.

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

See also [`tests/init.pp`](tests/init.pp)



## Librarian-Puppet / R10K Setup

You can of course configure the exim4 module in your `Puppetfile` to make it available with [Librarian puppet](http://librarian-puppet.com/) or
[r10k](https://github.com/adrienthebo/r10k) by adding the following entry:

     # Modules from the Puppet Forge
     mod "ulhpc-exim4"

or, if you prefer to work on the git version:

     mod "ulhpc-exim4",
         :git => 'https://github.com/ULHPC/puppet-exim4',
         :ref => 'production'

## Issues / Feature request

You can submit bug / issues / feature request using the [ulhpc-exim4 Puppet Module Tracker](https://github.com/ULHPC/puppet-exim4/issues).

## Developments / Contributing to the code

If you want to contribute to the code, you shall be aware of the way this module is organized.
These elements are detailed on [`docs/contributing.md`](contributing.md).

You are more than welcome to contribute to its development by [sending a pull request](https://help.github.com/articles/using-pull-requests).

## Puppet modules tests within a Vagrant box

The best way to test this module in a non-intrusive way is to rely on [Vagrant](http://www.vagrantup.com/).
The `Vagrantfile` at the root of the repository pilot the provisioning various vagrant boxes available on [Vagrant cloud](https://atlas.hashicorp.com/boxes/search?utf8=%E2%9C%93&sort=&provider=virtualbox&q=svarrette) you can use to test this module.

See [`docs/vagrant.md`](vagrant.md) for more details.

## Online Documentation

[Read the Docs](https://readthedocs.org/) aka RTFD hosts documentation for the open source community and the [ulhpc-exim4]() puppet module has its documentation (see the `docs/` directly) hosted on [readthedocs](http://ulhpc-puppet-exim4.rtfd.org).

See [`docs/rtfd.md`](rtfd.md) for more details.
