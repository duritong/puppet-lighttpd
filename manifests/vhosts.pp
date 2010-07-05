class lighttpd::vhosts {
  file{'/etc/lighttpd/vhosts.d':
    source => "puppet://$server/modules/common/empty",
    ensure => directory,
    purge => true,
    recurse => true,
    require => Package['lighttpd'],
    notify => Service['lighttpd'],
    owner => root, group => 0, mode => 0644;
  }
}
