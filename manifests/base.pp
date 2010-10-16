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
        source => [ "puppet:///modules/site-lighttpd/${fqdn}/lighttpd.conf",
                    "puppet:///modules/site-lighttpd/lighttpd.conf",
                    "puppet:///modules/lighttpd/${operatingsystem}/lighttpd.conf" ],
                    "puppet:///modules/lighttpd/lighttpd.conf" ],
        require => Package['lighttpd'],
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }

    # ToDo: put that in a common module to share with apache
    file { 'default_lighttpd_index':
        path => '/var/www/lighttpd/index.html',
        ensure => file,
        content => template('lighttpd/default/default_index.erb'),
        owner => root, group => 0, mode => 0644;
    }
}
