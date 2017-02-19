# manage a users resource
class lighttpd::users {
  include ::lighttpd
  file{'/var/www/users':
    ensure  => directory,
    require => Package['lighttpd'],
    seltype => 'httpd_sys_content_t',
    owner   => root,
    group   => 0,
    mode    => '0644';
  }
}
