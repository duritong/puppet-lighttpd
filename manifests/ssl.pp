class lighttpd::ssl(
  $manage_shorewall = false
) {
  class{'lighttpd':
    manage_shorewall => $manage_shorewall
  }
  lighttpd::config::file{ 'ssl': }
  if $manage_shorewall {
    include shorewall::rules::https
  }
}
