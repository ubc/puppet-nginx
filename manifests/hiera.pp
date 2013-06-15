class nginx::hiera {
  $nginx_upstreams = hiera('nginx_upstreams', [])
  create_resources('nginx::resource::upstream', $nginx_upstreams)

  $nginx_vhosts = hiera('nginx_vhosts', [])
  create_resources('nginx::resource::vhost', $nginx_vhosts)
}
