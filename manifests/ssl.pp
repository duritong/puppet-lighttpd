class lighttpd::ssl inherits lighttpd {
  lighttpd::config::file{ 'ssl': }
  if $use_shorewall {
    include shorewall::rules::https
  }
}
