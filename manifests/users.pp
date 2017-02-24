# manage a users resource
class lighttpd::users {
  include ::lighttpd
  if $osfamily == 'RedHat' {
    file_line{'userdir':
      path   => "${lighttpd::conf_dir}/config.conf",
      line   => "include \"${lighttpd::conf_dir_name}/userdir.conf\"",
      notify => Service['lighttpd'],
    }
  }
  file{'/var/www/users':
    ensure  => directory,
    require => Package['lighttpd'],
    seltype => 'httpd_sys_content_t',
    owner   => root,
    group   => 0,
    mode    => '0644';
  }
}
