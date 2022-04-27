# File::      <tt>exim4-params.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPL v3
#
# ------------------------------------------------------------------------------
# = Class: exim4::params
#
# In this class are defined as variables values that are used in other
# exim4 classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# The usage of a dedicated param classe is advised to better deal with
# parametrized classes, see
# http://docs.puppetlabs.com/guides/parameterized_classes.html
#
# [Remember: No empty lines between comments and class definition]
#
class exim4::params {

    ######## DEFAULTS FOR VARIABLES USERS CAN SET ##########################
    # (Here are set the defaults, provide your custom variables externally)
    # (The default used is in the line with '')
    ###########################################

    # ensure the presence (or absence) of exim4
    $ensure = 'present'

    # The Protocol used. Used by monitor and firewall class. Default is 'tcp'
    $protocol = 'tcp'

    # The port number. Used by monitor and firewall class. The default is 22.
    $port = 25

    # cf update-exim4.conf(8): The  main configuration type. One of "internet",
    # "smarthost", "satellite", "local"  or "none".
    # Sets macro DC_eximconfig_configtype.
    $configtype = 'local'

    # cf update-exim4.conf(8): name of the default transport for local mail
    # delivery. Defaults to mail_spool if unset, use maildir_home for delivery
    # to ~/Maildir/.
    # Sets macro LOCAL_DELIVERY.
    $localdelivery = 'mail_spool'

    # cf update-exim4.conf(8): List of hosts to which all outgoing mail is
    # passed to and that takes care of delivering it. Each of the hosts is
    # tried, in the order specified (See exim specification, chapter 20.5).
    # All deliveries go out to TCP port 25 unless a different port  is
    # specified after the host name, separated from the host name by two colons.
    # Colons in IPv6 addresses need to be doubled.
    # If a port number follows, IP addresses may be enclosed in brackets, which
    # might be the only possibility to specify delivery to an IPv6 address  and
    # a  different port. Examples:
    # .      host.domain.example deliver to host looked up on DNS, tcp/25
    # .      host.domain.example::587 deliver to host looked up on DNS, tcp/587
    # .      192.168.2.4 deliver to IPv4 host, tcp/25
    # .      192.168.2.4::587 deliver to IPv4 host, tcp/587
    # .      [192.168.2.4]::587 deliver to IPv4 host, tcp/587
    # .      2001::0db8::f::4::::2 deliver to IPv6 host, tcp/25
    # .      [2001::0db8::f::4::::2]::587 deliver to IPv6 host, tcp/587
    # This is used as value of the DCsmarthost macro.
    $smarthost = 'smtp.domain.com'

    # cf update-exim4.conf(8): List of IP addresses the Exim daemon should
    # listen on.  If  this  is  left  empty,  Exim  listens  on  all
    # interfaces.
    # Sets macro MAIN_LOCAL_INTERFACES only if there is a non-empty value.
    $local_interfaces = [ '127.0.0.1', '::1' ]

    # cf exim4.conf:
    # This router routes addresses that are not in local domains by doing a DNS
    # lookup on the domain name. If you want to disable this feature, set nodnslookup
    # to false will prevents exim from lookup on the domain name.
    # Defaults: false (to keep backwards compatibility)
    $nodnslookup = false

    # cf exim4.conf
    # Rewrite rules, following the Exim syntax as documented here
    # <https://www.exim.org/exim-html-current/doc/html/spec_html/ch-address_rewriting.html>
    $rewriterules = [ ]

    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    $packagename = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => 'exim4',
        default                 => 'exim',
    }

    $utils_packages = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => [ 'exim4-config' ],
        default                 => [ 'mailx' ],
    }


    $servicename = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => 'exim4',
        default                 => 'exim'
    }

    # used for pattern in a service ressource
    $processname = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => 'exim4',
        default                 => 'exim',
    }

    $hasstatus = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/              => false,
        /(?i-mx:centos|fedora|redhat|rocky)/ => true,
        default => true,
    }

    $hasrestart = $::operatingsystem ? {
        default => true,
    }

    # Configuration file
    $configfile = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => '/etc/exim4/update-exim4.conf.conf',
        default                 => '/etc/exim/exim.conf',
    }

    $local_configfile = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => '/etc/exim4/update-exim4.local.conf',
        default                 => '/etc/exim/exim.conf.local',
    }

    $configfile_mode = $::operatingsystem ? {
        default => '0644',
    }

    $configfile_owner = $::operatingsystem ? {
        default => 'root',
    }

    $configfile_group = $::operatingsystem ? {
        default => 'root',
    }

    # $configdir = $::operatingsystem ? {
    #     default => "/etc/exim4",
    # }
    # $configdir_mode = $::operatingsystem ? {
    #     default => '0755',
    # }

    # $configdir_owner = $::operatingsystem ? {
    #     default => 'root',
    # }

    # $configdir_group = $::operatingsystem ? {
    #     default => 'root',
    # }

    # $pkgmanager = $::operatingsystem ? {
    #     /(?i-mx:ubuntu|debian)/          => [ '/usr/bin/apt-get' ],
    #     /(?i-mx:centos|fedora|redhat)/ => [ '/bin/rpm', '/usr/bin/up2date', '/usr/bin/yum' ],
    #     default => []
    # }


}
