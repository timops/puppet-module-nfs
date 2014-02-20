/*

== Define nfs::client::mount

Set up NFS server and exports. NFSv3 supported.


=== Parameters

=== Examples

=== Authors

Harald Skoglund <haraldsk@redpill-linpro.com>

=== Copyright

Copyright 2012 Redpill Linpro, unless otherwise noted.

*/

define nfs::client::mount (
  $ensure = 'mounted',
  $server,
  $share,
  $mount = undef,
  $remounts = false,
  $atboot = false,
  $options = '_netdev',
  $bindmount = undef,
) {

  include nfs::client

  if $mount == undef {
    $_mount = $share
  } else {
   $_mount = $mount
  }

  nfs::mkdir{"${_mount}": }

  mount {"shared $share by $::clientcert":
    ensure   => $ensure,
    device   => "${server}:${share}",
    fstype   => 'nfs',
    name     => "${_mount}",
    options  => $options,
    remounts => $remounts,
    atboot   => $atboot,
    require  => Nfs::Mkdir["${_mount}"],
  }
}
