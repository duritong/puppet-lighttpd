class lighttpd::munin {
  lighttpd::config::file{'status':
    content => 'server.modules += ( "mod_status" )
$HTTP["remoteip"] =~ "^(::ffff:)?127.0.0.1$" {
  status.status-url = "/server-status"
  status.config-url = "/server-config"
}
',
  }
  munin::plugin::deploy{'lighttpd_': 
    source => "lighttpd/munin/lighttpd_", 
    ensure => absent,
    require => Lighttpd::Config::File['status'],
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
