# manage vhosts
class lighttpd::vhosts {
  file{
    '/etc/lighttpd/vhosts.d':
      ensure  => directory,
      purge   => true,
      recurse => true,
      require => Package['lighttpd'],
      notify  => Service['lighttpd'],
      owner   => root,
      group   => 0,
      mode    => '0644';
    '/var/www/vhosts':
      ensure  => directory,
      require => Package['lighttpd'],
      owner   => root,
      group   => 0,
      mode    => '0644';
  }
}
