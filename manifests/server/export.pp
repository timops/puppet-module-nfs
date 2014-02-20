define nfs::server::export (
  $v3_export_name = $name,
  $clients = 'localhost(ro)',
  $bind = 'rbind',
  $ensure = 'mounted',
  $mount = undef,
  $remounts = false,
  $atboot = false,
  $options = '_netdev',
  $bindmount = undef,
) {

  nfs::server::export::configure { "${v3_export_name}":
      ensure  => $ensure,
      clients => $clients,
  }

  #@@nfs::client::mount { "shared ${v3_export_name} by ${::clientcert}":
  #  ensure          => $ensure,
  #  mount           => $mount,
  #  remounts        => $remounts,
  #  atboot          => $atboot,
  #  options         =>  $options,
  #  tag             => $tag,
  #  share           => "${v3_export_name}",
  #  server          => "${::clientcert}",
  #}
}

define nfs::server::export::configure (
  $ensure = 'present',
  $clients
) {

  if $ensure != 'absent' {
    $line = "${name} ${clients}\n"

    concat::fragment{ "${name}":
        target  => '/etc/exports',
        content => "${line}",
    }
  }
}
