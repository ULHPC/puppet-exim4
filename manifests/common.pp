# File::      <tt>exim4.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
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


