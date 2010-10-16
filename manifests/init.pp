# manifests/init.pp - manage lighttpd stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class lighttpd {
  case $operatingsystem {
    debian,ubuntu: { include lighttpd::debian }
    centos,redhat,fedora: { include lighttpd::centos }
    default: { include lighttpd::base }
  }

  if $use_shorewall {
    include shorewall::rules::http
  }
  if $use_munin {
    include lighttpd::munin
  }
}

