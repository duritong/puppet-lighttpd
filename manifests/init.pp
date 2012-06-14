# manifests/init.pp - manage lighttpd stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class lighttpd(
  $cluster_node,
  $manage_munin     = false,
  $manage_shorewall = false
) {
  case $::operatingsystem {
    debian,ubuntu: { include lighttpd::debian }
    centos,redhat,fedora: { include lighttpd::centos }
    default: { include lighttpd::base }
  }

  if $lighthttpd::manage_shorewall {
    include shorewall::rules::http
  }
  if $lighthttpd::manage_munin {
    include lighttpd::munin
  }
}

