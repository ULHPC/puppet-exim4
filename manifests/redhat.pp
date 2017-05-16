# File::      <tt>exim4.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: exim4::redhat
#
# Specialization class for Redhat systems
class exim4::redhat inherits exim4::common {

    package { $exim4::params::utils_packages:
        ensure  => $exim4::ensure,
        require => Package['exim4']
    }
    File[$exim4::params::configfile] {
        content => template('exim4/exim.conf.erb')
    }

    if ($exim4::ensure == 'present') {
      package { [ 'postfix', 'ssmtp' ] :
        ensure => 'absent'
    }

}
