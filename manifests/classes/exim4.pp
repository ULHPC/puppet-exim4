# File::      <tt>exim4.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: exim4
#
# Configure and manage exim4
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of exim4.
#
# $configtype:: *Default*: 'local'. The  main configuration type. It can be one
# of "internet", "smarthost", "satellite", "local" or "none".
#
# $localdelivery:: *Default*: 'mail_spool'. name of the default transport for local mail
# delivery. Use 'maildir_home' for delivery to ~/Maildir/.
#
# $smarthost:: *Default*: 'smtp.uni.lu'.  List of hosts to which all outgoing
# mail is passed to and that takes care of delivering it.
# Here are the smtp servers of the main FAI in France:
# * Orange           smtp.orange.fr
# * Free             smtp.free.fr
# * Club internet    mail.club-internet.fr
# * 9Telecom         smtp.neuf.fr
# * Alice            smtp.alice.fr or smtp.aliceadsl.fr
# * Cegetel          smtp.cegetel.net
# * Noos (Numericable) mail.noos.fr
#
# == Actions:
#
# Install and configure exim4
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     import exim4
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'exim4':
#             ensure     => 'present',
#             configtype => 'local'
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class exim4(
    $ensure        = $exim4::params::ensure,
    $configtype    = $exim4::params::configfile,
    $localdelivery = $exim4::params::localdelivery,
    $smarthost     = $exim4::params::smarthost
    )
inherits exim4::params
{
    info ("Configuring exim4 (with ensure = ${ensure}, configtype = ${configtype})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("exim4 'ensure' parameter must be set to either 'absent' or 'present'")
    }
    if ! ($configtype in [ 'none', 'local', 'smarthost', 'satellite', 'internet' ]) {
        fail("exim4 'configtype' parameter must be set to 'internet', 'smarthost', 'satellite', 'local', or 'none'")
    }
    if ($configtype in [ 'smarthost', 'internet' ]) {
        warning("configtype ${configtype} NOT YET IMPLEMENTED for exim4")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include exim4::debian }
        redhat, fedora, centos: { include exim4::redhat }
        default: {
            fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
    }
}

# ------------------------------------------------------------------------------
# = Class: exim4::common
#
# Base class to be inherited by the other exim4 classes
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class exim4::common {

    # Load the variables used in this module. Check the exim4-params.pp file
    require exim4::params

    package { 'exim4':
        ensure => $exim4::ensure,
        name   => $exim4::params::packagename,
    }

    service { 'exim4':
        ensure     => running,
        name       => $exim4::params::servicename,
        enable     => true,
        hasrestart => $exim4::params::hasrestart,
        pattern    => $exim4::params::processname,
        hasstatus  => $exim4::params::hasstatus,
        require    => Package['exim4'],
        subscribe  => File[$exim4::params::configfile],
    }

    file { $exim4::params::configfile:
        ensure  => $exim4::ensure,
        owner   => $exim4::params::configfile_owner,
        group   => $exim4::params::configfile_group,
        mode    => $exim4::params::configfile_mode,
        notify  => Service['exim4'],
        require => Package['exim4'],
    }

    # Create a ["blackhole" alias]{http://www.exim.org/exim-html-3.20/doc/html/spec_23.html#SEC634}
    mailalias { 'blackhole':
        ensure    => $exim4::ensure,
        recipient => ':blackhole:',
        require   => Package['exim4'],
    }

}


# ------------------------------------------------------------------------------
# = Class: exim4::debian
#
# Specialization class for Debian systems
class exim4::debian inherits exim4::common {

    package { $exim4::params::utils_packages:
        ensure  => $exim4::ensure,
        require => Package['exim4']
    }

    file { '/etc/mailname':
        ensure  => present,
        mode    => $exim4::params::configfile_mode,
        owner   => $exim4::params::configfile_owner,
        group   => $exim4::params::configfile_group,
        require => Package['exim4'],
        content => "${::fqdn}\n",
    }

    File[$exim4::params::configfile] {
        content => template('exim4/update-exim4.conf.conf.erb')
    }

}

# ------------------------------------------------------------------------------
# = Class: exim4::redhat
#
# Specialization class for Redhat systems
class exim4::redhat inherits exim4::common {

    package { $exim4::params::utils_packages:
        ensure  => $exim4::ensure,
        require => Package['exim4']
    }

}



