# manage a simple vhost file
define lighttpd::vhost::file(
  $ensure       = present,
  $vhost_source = 'absent',
  $content      = 'absent'
){
  include ::lighttpd::vhosts
  file{"/etc/lighttpd/vhosts.d/${name}.conf":
    ensure => $ensure,
    notify => Service['lighttpd'],
    owner  => root,
    group  => 0,
    mode   => '0644';
  }

  if $ensure != 'absent' {
    case $content {
      'absent': {
        File["/etc/lighttpd/vhosts.d/${name}.conf"]{
          source => $vhost_source ? {
            'absent'  => [
              "puppet:///modules/site_lighttpd/vhosts.d/${facts['fqdn']}/${name}.conf",
              "puppet:///modules/site_lighttpd/vhosts.d/${lighttpd::cluster_node}/${name}.conf",
              "puppet:///modules/site_lighttpd/vhosts.d/${facts['os']['name']}.${facts['os']['release']['major']}/${name}.conf",
              "puppet:///modules/site_lighttpd/vhosts.d/${facts['os']['name']}/${name}.conf",
              "puppet:///modules/site_lighttpd/vhosts.d/${name}.conf"
            ],
            default => "puppet:///${vhost_source}",
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
}
