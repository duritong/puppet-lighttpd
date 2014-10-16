# ssl enabled lighttpd
class lighttpd::ssl(
  $cluster_node     = $cluster_node,
  $manage_shorewall = false,
  $manage_munin     = false,
  $ssl_pemfile      = '/etc/ssl/private/lighttpd.pem',
  $ssl_cipher       = 'HIGH:MEDIUM:!aNULL:!SSLv2:@STRENGTH'
) {
  class{'lighttpd':
    cluster_node     => $cluster_node,
    manage_shorewall => $manage_shorewall,
    manage_munin     => $manage_munin,
  }
  lighttpd::config::file{ 'ssl':
    template => true
  }
  if $manage_shorewall {
    include shorewall::rules::https
  }
}
