# ssl enabled lighttpd
class lighttpd::ssl(
  $cluster_node     = $cluster_node,
  $manage_shorewall = false,
  $manage_munin     = false,
) {
  class{'lighttpd':
    cluster_node     => $cluster_node,
    manage_shorewall => $manage_shorewall,
    manage_munin     => $manage_munin,
  }
  lighttpd::config::file{ 'ssl': }
  if $manage_shorewall {
    include shorewall::rules::https
  }
}
