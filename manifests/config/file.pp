# manages a config file for lighty
define lighttpd::config::file(
  $ensure = present,
  $conf_source = 'absent',
  $content = 'absent'
){
  $conf_dir = $::operatingsystem ? {
    debian  => '/etc/lighttpd/conf-available',
    ubuntu  => '/etc/lighttpd/conf-available',
    default => '/etc/lighttpd/conf.d'
  }
  file{"${conf_dir}/${name}.conf":
    ensure  => $ensure,
    require => Package['lighttpd'],
    notify  => Service['lighttpd'],
    owner   => 'root',
    group   => 0,
    mode    => '0644';
  }

  case $content {
    'absent': {
      File["${conf_dir}/${name}.conf"]{
        source => $conf_source ? {
          'absent'  => [
            "puppet:///modules/site_lighttpd/conf.d/${::fqdn}/${name}.conf",
            "puppet:///modules/site_lighttpd/conf.d/${lighttpd::cluster_node}/${name}.conf",
            "puppet:///modules/site_lighttpd/conf.d/${::operatingsystem}.${::lsbdistcodename}/${name}.conf",
            "puppet:///modules/site_lighttpd/conf.d/${::operatingsystem}/${name}.conf",
            "puppet:///modules/site_lighttpd/conf.d/${name}.conf",
            "puppet:///modules/lighttpd/conf.d/${name}.conf",
            "puppet:///modules/lighttpd/conf.d/${::operatingsystem}.${::lsbdistcodename}/${name}.conf",
            "puppet:///modules/lighttpd/conf.d/${::operatingsystem}/${name}.conf",
            "puppet:///modules/lighttpd/conf.d/${name}.conf"
          ],
        default => "puppet:///${conf_source}",
        }
      }
    }
    default: {
      File["${conf_dir}/${name}.conf"]{
        content => $content,
      }
    }
  }
}
