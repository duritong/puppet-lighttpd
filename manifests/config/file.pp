# manages a config file for lighty
define lighttpd::config::file(
  $ensure = present,
  $conf_source = 'absent',
  $content = 'absent'
){
  file{"${lighttpd::conf_dir_name}/${name}.conf":
    ensure  => $ensure,
    require => Package['lighttpd'],
    notify  => Service['lighttpd'],
    owner   => 'root',
    group   => 0,
    mode    => '0644';
  }

  file_line{$name:
    ensure  => $ensure,
    path    => "${lighttpd::conf_dir}/config.conf",
    line    => "include \"${lighttpd::conf_dir_name}/${name}.conf\"",
    notify  => Service['lighttpd'],
  }

  case $content {
    'absent': {
      File["${lighttpd::conf_dir_name}/${name}.conf"]{
        source => $conf_source ? {
          'absent'  => [
            "puppet:///modules/site_lighttpd/${lighttpd::conf_dir_name}/${::fqdn}/${name}.conf",
            "puppet:///modules/site_lighttpd/${lighttpd::conf_dir_name}/${lighttpd::cluster_node}/${name}.conf",
            "puppet:///modules/site_lighttpd/${lighttpd::conf_dir_name}/${::operatingsystem}.${::lsbdistcodename}/${name}.conf",
            "puppet:///modules/site_lighttpd/${lighttpd::conf_dir_name}/${::operatingsystem}/${name}.conf",
            "puppet:///modules/site_lighttpd/${lighttpd::conf_dir_name}/${name}.conf",
            "puppet:///modules/lighttpd/${lighttpd::conf_dir_name}/${name}.conf",
            "puppet:///modules/lighttpd/${lighttpd::conf_dir_name}/${::operatingsystem}.${::lsbdistcodename}/${name}.conf",
            "puppet:///modules/lighttpd/${lighttpd::conf_dir_name}/${::operatingsystem}/${name}.conf",
            "puppet:///modules/lighttpd/${lighttpd::conf_dir_name}/${name}.conf"
          ],
        default => "puppet:///${conf_source}",
        }
      }
    }
    default: {
      File["${lighttpd::conf_dir_name}/${name}.conf"]{
        content => $content,
      }
    }
  }
}
