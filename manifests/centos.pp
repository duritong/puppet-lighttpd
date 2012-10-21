# manage centos specific things for
# lighttpd
class lighttpd::centos inherits lighttpd::base {
  File{
    require => Package['lighttpd'],
    before  => Service['lighttpd'],
  }
  file{
    "${lighttpd::conf_dir}/config.conf":
      ensure  => file,
      owner   => 'root',
      group   => 0,
      mode    => '0644';
    '/var/cache/lighttpd':
      ensure  => directory;
    '/var/cache/lighttpd/compress':
      ensure  => directory,
      owner   => 'lighttpd',
      group   => 'lighttpd',
      mode    => '0640';
  }
}
