define lighttpd::config::file(
    $ensure = present,
    $conf_source = 'absent',
    $content = 'absent'
){
    file{"/etc/lighttpd/conf.d/${name}.conf":
        ensure => $ensure,
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }

    case $content {
        'absent': {
            File["/etc/lighttpd/conf.d/${name}.conf"]{
                source => $conf_source ? {
                  'absent'  => [
                    "puppet:///modules/site-lighttpd/conf.d/$fqdn/$name.conf",
                    "puppet:///modules/site-lighttpd/conf.d/$lighttpd_cluster_node/$name.conf",
                    "puppet:///modules/site-lighttpd/conf.d/$operatingsystem.$lsbdistcodename/$name.conf",
                    "puppet:///modules/site-lighttpd/conf.d/$operatingsystem/$name.conf",
                    "puppet:///modules/site-lighttpd/conf.d/$name.conf",
                    "puppet:///modules/lighttpd/conf.d/$name.conf",
                    "puppet:///modules/lighttpd/conf.d/$operatingsystem.$lsbdistcodename/$name.conf",
                    "puppet:///modules/lighttpd/conf.d/$operatingsystem/$name.conf",
                    "puppet:///modules/lighttpd/conf.d/$name.conf"
                  ],
                  default => "puppet:///$conf_source",
              }
            }
        }
        default: {
            File["/etc/lighttpd/conf.d/${name}.conf"]{
                content => $content,
            }
        }
    }
}
