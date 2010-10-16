class lighttpd::debian inherits lighttpd::base {
  file{
    '/var/www/lighttpd':
      ensure => directory;
    '/var/www/index.lighttpd.html':
      ensure => absent,
  }
}
