class lighttpd::ssl inherits lighttpd {
  lighttpd::config::file{ 'ssl': }
  if hiera('use_shorewall',false) {
    include shorewall::rules::https
  }
}
