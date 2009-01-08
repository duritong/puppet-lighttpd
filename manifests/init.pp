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
        hasstatus => true, 
        require => Package[lighttpd],
    }

    file{'/etc/lighttpd/lighttpd.conf':
        source => [ "puppet://$server/files/lighttpd/${fqdn}/lighttpd.conf",
                    "puppet://$server/files/lighttpd/lighttpd.conf",
                    "puppet://$server/lighttpd/lighttpd.conf" ],
        require => Package['lighttpd'],
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }
}
