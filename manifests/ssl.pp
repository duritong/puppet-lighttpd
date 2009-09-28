class lighttpd::ssl inherits lighttpd {
  if $use_shorewall {
    include shorewall::rules::https
  }
}
