# == Class: nfs::client
#
# Set up NFS client and mounts. NFSv3 and NFSv4 supported.
#
#
# === Examples
#
#  class { 'nfs::client': }
#
#
# === Authors
#
# Harald Skoglund <haraldsk@redpill-linpro.com>
#
# === Copyright
#
# Copyright 2012 Redpill Linpro, unless otherwise noted.
#

class nfs::client inherits nfs::params {

  class{ "nfs::client::${osfamily}": }

}
