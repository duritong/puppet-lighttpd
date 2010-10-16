class lighttpd::debian inherits lighttpd::base {
  file{
    '/var/www/lighttpd':
      ensure => directory,
      require => Package['lighttpd'];
    '/var/www/index.lighttpd.html':
      ensure => absent,
      require => Package['lighttpd'];
  }
}
