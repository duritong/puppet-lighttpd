# setup munin plugins for lighttpd
class lighttpd::munin {
  munin::plugin::deploy{'lighttpd_':
    ensure  => absent, # this is not a direct plugin
    source  => 'lighttpd/munin/lighttpd_',
  } -> munin::plugin{
    [ 'lighttpd_total_accesses', 'lighttpd_total_kbytes', 'lighttpd_uptime',
      'lighttpd_busyservers', ]:
    ensure => 'lighttpd_';
  }
}
