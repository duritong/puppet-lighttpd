# manages the base stuff of
# a lighttpd server
class lighttpd::base {
  package{'lighttpd':
    ensure => installed,
  }

  service{'lighttpd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['lighttpd'],
  }

  file{
    '/etc/lighttpd/lighttpd.conf':
      source  => [  "puppet:///modules/site_lighttpd/${::fqdn}/lighttpd.conf",
                    'puppet:///modules/site_lighttpd/lighttpd.conf',
                    "puppet:///modules/lighttpd/${::operatingsystem}/lighttpd.conf",
                    'puppet:///modules/lighttpd/lighttpd.conf' ],
      require => Package['lighttpd'],
      notify  => Service['lighttpd'],
      owner   => 'root',
      group   => 0,
      mode    => '0644';
    # ToDo: put that in a common module to share with apache
    'default_lighttpd_index':
      ensure  => file,
      path    => '/var/www/lighttpd/index.html',
      content => template('lighttpd/default/default_index.erb'),
      require => Package['lighttpd'],
      before  => Service['lighttpd'],
      owner   => 'root',
      group   => 0,
      mode    => '0644';
    '/etc/cron.daily/clean_lighttpd_compress':
      content => "find /var/cache/lighttpd/compress -type f -mtime +10 | xargs -r rm\n",
      require => Package['lighttpd'],
      owner   => 'root',
      group   => 0,
      mode    => '0640';
  }
}
