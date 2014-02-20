class nfs::client::debian {

  include nfs::client::debian::install,
    nfs::client::debian::configure,
    nfs::client::debian::service

}

class nfs::client::debian::install {

  case $::lsbdistcodename {
    'lucid': {
      package { 'portmap':
        ensure => installed,
      }
    } default: {
      package { 'rpcbind':
        ensure => installed,
      }
    }
  }

  package { ['nfs-common', 'nfs4-acl-tools']:
    ensure => installed,
  }
}

class nfs::client::debian::configure {
  Augeas {
    require => Class['nfs::client::debian::install']
  }

}

class nfs::client::debian::service {

  Service {
    require => Class['nfs::client::debian::configure']
  }

  service { "portmap":
    ensure    => running,
    enable    => true,
    hasstatus => false,
  } 

  service { 'idmapd':
      ensure => stopped,
  }
}
