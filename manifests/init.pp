# manifests/init.pp - manage lighttpd stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class lighttpd(
  $cluster_node = hiera('lighttpd_cluster_node','some_cluster_node')
) {
  case $::operatingsystem {
    debian,ubuntu: { include lighttpd::debian }
    centos,redhat,fedora: { include lighttpd::centos }
    default: { include lighttpd::base }
  }

  if hiera('use_shorewall',false) {
    include shorewall::rules::http
  }
  if hiera('use_munin',false) {
    include lighttpd::munin
  }
}

