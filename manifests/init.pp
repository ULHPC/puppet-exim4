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
  $configtype    = $exim4::params::configtype,
  $localdelivery = $exim4::params::localdelivery,
  $smarthost     = $exim4::params::smarthost,
  $nodnslookup   = $exim4::params::nodnslookup,

) inherits exim4::params
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
      'debian', 'ubuntu':         { include ::exim4::debian }
      'redhat', 'fedora', 'centos': { include ::exim4::redhat }
      default: {
        fail("Module ${module_name} is not supported on ${::operatingsystem}")
      }
    }
  }
