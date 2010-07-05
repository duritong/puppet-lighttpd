class lighttpd::ssl inherits lighttpd {
  lighttpd::config::file{ 'ssl.conf': }
  if $use_shorewall {
    include shorewall::rules::https
  }
}
