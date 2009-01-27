class lighttpd::munin {
  file{'/etc/lighttpd/conf.d/status.conf':
    content => 'server.modules += ( "mod_status" )
$HTTP["remoteip"] == "127.0.0.1" {
  status.status-url = "/server-status"
  status.config-url = "/server-config"
}
',
    require => Package['lighttpd'],
    notify => Service['lighttpd'],
    owner => root, group => 0, mode => 0644;
  }
  munin::plugin::deploy{'lighttpd_': 
    source => "lighttpd/munin/lighttpd_", 
    ensure => absent,
    require => File['/etc/lighttpd/conf.d/status.conf'],
  }
  munin::plugin{'lighttpd_total_accesses': 
    require => Munin::Plugin::Deploy['lighttpd_'],
    ensure => 'lighttpd_',
  }
  munin::plugin{'lighttpd_total_kbytes': 
    require => Munin::Plugin::Deploy['lighttpd_'],
    ensure => 'lighttpd_',
  }
  munin::plugin{'lighttpd_uptime': 
    require => Munin::Plugin::Deploy['lighttpd_'],
    ensure => 'lighttpd_',
  }
  munin::plugin{'lighttpd_busyservers': 
    require => Munin::Plugin::Deploy['lighttpd_'],
    ensure => 'lighttpd_',
  }
}
