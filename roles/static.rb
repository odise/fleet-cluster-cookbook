name "static"
description "Using statisc etcd configuration."

default_attributes 'etcd' => {
  'config' => {
    'environment' => {
      'ETCD_INITIAL_CLUSTER' => 'infra0=http://192.168.33.9:2380,infra1=http://192.168.33.10:2380',
      'ETCD_INITIAL_CLUSTER_TOKEN' => 'etcd-cluster-1',
      'ETCD_INITIAL_CLUSTER_STATE' => 'new'
    }
  }
}
