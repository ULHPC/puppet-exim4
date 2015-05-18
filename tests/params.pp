# File::      <tt>params.pp</tt>
# Author::    ULHPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 ULHPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# You need the 'future' parser to be able to execute this manifest (that's
# required for the each loop below).
#
# Thus execute this manifest in your vagrant box as follows:
#
#      sudo puppet apply -t --parser future /vagrant/tests/params.pp
#
#

include 'exim4::params'

$names = ["ensure", "protocol", "port", "configtype", "localdelivery", "smarthost", "local_interfaces", "packagename", "utils_packages", "servicename", "processname", "hasstatus", "hasrestart", "configfile", "configfile_mode", "configfile_owner", "configfile_group"]

notice("exim4::params::ensure = ${exim4::params::ensure}")
notice("exim4::params::protocol = ${exim4::params::protocol}")
notice("exim4::params::port = ${exim4::params::port}")
notice("exim4::params::configtype = ${exim4::params::configtype}")
notice("exim4::params::localdelivery = ${exim4::params::localdelivery}")
notice("exim4::params::smarthost = ${exim4::params::smarthost}")
notice("exim4::params::local_interfaces = ${exim4::params::local_interfaces}")
notice("exim4::params::packagename = ${exim4::params::packagename}")
notice("exim4::params::utils_packages = ${exim4::params::utils_packages}")
notice("exim4::params::servicename = ${exim4::params::servicename}")
notice("exim4::params::processname = ${exim4::params::processname}")
notice("exim4::params::hasstatus = ${exim4::params::hasstatus}")
notice("exim4::params::hasrestart = ${exim4::params::hasrestart}")
notice("exim4::params::configfile = ${exim4::params::configfile}")
notice("exim4::params::configfile_mode = ${exim4::params::configfile_mode}")
notice("exim4::params::configfile_owner = ${exim4::params::configfile_owner}")
notice("exim4::params::configfile_group = ${exim4::params::configfile_group}")

#each($names) |$v| {
#    $var = "exim4::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
