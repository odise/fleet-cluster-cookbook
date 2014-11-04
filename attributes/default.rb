default['etcd']['download_url'] = "https://github.com/coreos/etcd/releases/download/v0.5.0-alpha.1/etcd-v0.5.0-alpha.1-linux-amd64.tar.gz"
default['etcd']['config']['ipaddress'] = node['ipaddress']
default['etcd']['config']['name'] = "infra"
default['etcd']['config']['cluster_token'] = "etcd-cluster-1"
default['etcd']['config']['data_dir'] = "/var/lib/etcd/"

default['etcd']['config']['environment']['ETCD_DATA_DIR'] = node['etcd']['config']['data_dir']
default['etcd']['config']['environment']['ETCD_NAME'] = node['etcd']['config']['name']
default['etcd']['config']['environment']['ETCD_INITIAL_CLUSTER'] = 'infra0=http://192.168.33.9:2380,infra1=http://192.168.33.10:2380'
default['etcd']['config']['environment']['ETCD_INITIAL_CLUSTER_TOKEN'] = node['etcd']['config']['cluster_token']
default['etcd']['config']['environment']['ETCD_INITIAL_CLUSTER_STATE'] = 'new'
default['etcd']['config']['environment']['ETCD_INITIAL_ADVERTISE_PEER_URLS'] = "http://#{node['etcd']['config']['ipaddress']}:2380"
default['etcd']['config']['environment']['ETCD_LISTEN_CLIENT_URLS'] = "http://#{node['etcd']['config']['ipaddress']}:2379,http://#{node['etcd']['config']['ipaddress']}:4001,http://127.0.0.1:4001"
default['etcd']['config']['environment']['ETCD_LISTEN_PEER_URLS'] = "http://#{node['etcd']['config']['ipaddress']}:2380,http://#{node['etcd']['config']['ipaddress']}:7001"
default['etcd']['config']['environment']['ETCD_ADVERTISE_CLIENT_URLS'] = "http://#{node['etcd']['config']['ipaddress']}:2380,http://#{node['etcd']['config']['ipaddress']}:7001"


default['fleet']['download_url'] = "https://github.com/coreos/fleet/releases/download/v0.8.3/fleet-v0.8.3-linux-amd64.tar.gz"
default['fleet']['user'] = 'core'
default['fleet']['group'] = 'root'
default['fleet']['home'] = '/home/core'
default['fleet']['config']['net_interface'] = node[:ipaddress]
default['fleet']['config']['metadata'] = "region=eu-central-1,az=eu-central-1a"

#default['docker']['install_type'] = "binary"
#default['docker']['binary']['version'] = "latest"
default['docker']['graph'] = "/data/docker"
#default['docker']['iptables'] = false
default['docker']['package']['name'] = "docker"
default['docker']['version'] = "0.11.1-22.el7.centos"
#default['docker']['version'] = "1.1.2-13.el7"
default['docker']['init_type'] = 'systemd'

default['axelspringer-base']['proxy']['enabled'] = true
default['axelspringer-base']['dmz'] = true

