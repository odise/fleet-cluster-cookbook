name "proxy"
description "Chef environment for Docker host deployments with proxy settings."

http_proxy = "proxy.example.com"
http_proxy_port = "8080"

default_attributes 'docker' => {
  'http_proxy' => "#{http_proxy}:#{http_proxy_port}"
 },
 'etcd' => {
  'config' => {
    'environment' => {
      'ETCD_DISCOVERY_PROXY' => "#{http_proxy}:#{http_proxy_port}"
     }
   }
 }

Chef::Log.info "Read 'production' environment with default_attributes: #{default_attributes}."

