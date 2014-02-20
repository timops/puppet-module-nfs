# == Class: nfs::server
#
# Set up NFS server and exports. NFSv3 and NFSv4 supported.
#
#
# === Parameters
#
# [nfs_v4]
#   NFSv4 support. Will set up automatic bind mounts to export root.
#   Disabled by default.
#
# [nfs_v4_export_root]
#   Export root, where we bind mount shares, default /export
#
# [nfs_v4_idmap_domain]
#  Domain setting for idmapd, must be the same across server
#  and clients.
#  Default is to use $domain fact.
#
# === Examples
#
#
#  class { nfs::server: }
#
# === Authors
#
# Harald Skoglund <haraldsk@redpill-linpro.com>
#
# === Copyright
#
# Copyright 2012 Redpill Linpro, unless otherwise noted.
#

class nfs::server inherits nfs::params {

  class { "nfs::server::${osfamily}": }

  include nfs::server::configure
}

class nfs::server::configure {

  concat { '/etc/exports': require => Class["nfs::server::${nfs::server::osfamily}"] }

  service { 'nfs-kernel-server':
    ensure    => running,
    subscribe => Concat['/etc/exports'],
  }

  concat::fragment { 'nfs_exports_header':
      target  => '/etc/exports',
      content => "# This file is configured through the nfs::server puppet module\n",
      order   => 01,
  }
}
