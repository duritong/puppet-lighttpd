define lighttpd::vhost::file(
    $ensure = present,
    $vhost_source = 'absent',
    $content = 'absent'
){
    include ::lighttpd::vhosts
    file{"/etc/lighttpd/vhosts.d/${name}.conf":
        ensure => $ensure,
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }

    case $content {
        'absent': {
            File["/etc/lighttpd/vhosts.d/${name}.conf"]{
                source => $vhost_source ? {
                  'absent'  => [
                    "puppet:///modules/site-lighttpd/vhosts.d/$fqdn/$name.conf",
                    "puppet:///modules/site-lighttpd/vhosts.d/$lighttpd_cluster_node/$name.conf",
                    "puppet:///modules/site-lighttpd/vhosts.d/$operatingsystem.$lsbdistcodename/$name.conf",
                    "puppet:///modules/site-lighttpd/vhosts.d/$operatingsystem/$name.conf",
                    "puppet:///modules/site-lighttpd/vhosts.d/$name.conf",
                    "puppet:///modules/lighttpd/vhosts.d/$operatingsystem.$lsbdistcodename/$name.conf",
                    "puppet:///modules/lighttpd/vhosts.d/$operatingsystem/$name.conf",
                    "puppet:///modules/lighttpd/vhosts.d/$name.conf"
                  ],
                  default => "puppet:///$vhost_source",
              }
            }
        }
        default: {
            File["/etc/lighttpd/vhosts.d/${name}.conf"]{
                content => $content,
            }
        }
    }
}
