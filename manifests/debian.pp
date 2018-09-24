# File::      <tt>exim4.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: exim4::debian
#
# Specialization class for Debian systems
class exim4::debian inherits exim4::common {

    package { $exim4::params::utils_packages:
        ensure  => $exim4::ensure,
        require => Package['exim4'],
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
