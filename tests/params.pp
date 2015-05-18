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

$names = ['ensure', 'protocol', 'port', 'packagename']

notice("exim4::params::ensure = ${exim4::params::ensure}")
notice("exim4::params::protocol = ${exim4::params::protocol}")
notice("exim4::params::port = ${exim4::params::port}")
notice("exim4::params::packagename = ${exim4::params::packagename}")

#each($names) |$v| {
#    $var = "exim4::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
