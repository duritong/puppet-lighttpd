class lighttpd::users {
  include ::lighttpd
  file{'/var/www/users':
    ensure => directory,
    require => Package['lighttpd'],
    owner => root, group => 0, mode => 0644;
  }
}
