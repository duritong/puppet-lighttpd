class lighttpd::centos inherits lighttpd::base {
  file{
    '/var/cache/lighttpd':
      ensure => directory,
      require => Package['lighttpd'];
    '/var/cache/lighttpd/compress':
      ensure => directory,
      require => Package['lighttpd'],
      owner => lighttpd, group => lighttpd, mode => 0640;
  }
}
