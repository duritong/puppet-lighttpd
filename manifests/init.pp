# manifests/init.pp - manage lighttpd stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class lighttpd(
  $cluster_node     = '',
  $manage_munin     = false,
  $manage_shorewall = false
) {

  $conf_dir_name =  $::operatingsystem ? {
    debian  => 'conf-available',
    ubuntu  => 'conf-available',
    default => 'conf.d'
  }

  $conf_dir = "/etc/lighttpd/${conf_dir_name}"

  case $::operatingsystem {
    debian,ubuntu: { include lighttpd::debian }
    centos,redhat,fedora: { include lighttpd::centos }
    default: { include lighttpd::base }
  }

  if $manage_shorewall {
    include shorewall::rules::http
  }
  if $manage_munin {
    include lighttpd::munin
  }
}

