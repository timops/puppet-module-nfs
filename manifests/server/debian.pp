# Debian specific stuff
class nfs::server::debian {

  class { 'nfs::client::debian': }

  package { 'nfs-kernel-server': ensure => 'installed' }

  # concat definition depends on this, and this depends on concat == DAG cycle.  Moved to server.pp to eliminate this problem.
  #service { 'nfs-kernel-server':
  #  ensure    => running,
  #  subscribe => Concat['/etc/exports'],
  #}
}
