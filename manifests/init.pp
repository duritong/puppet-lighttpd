# manifests/init.pp - manage lighttpd stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3


class lighttpd {
    case $operatingsystem {
        default: { include lighttpd::base }
    }
}

class lighttpd::base {
    package{'lighttpd':
        ensure => installed,
    }

    service{lighttpd:
        ensure => running,
        enable => true,
        #hasstatus => true, #fixme!
        require => Package[lighttpd],
    }

}
