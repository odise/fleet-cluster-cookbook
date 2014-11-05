name "discovery"
description "Using etcd discovery service."

default_attributes 'etcd' => {
  'config' => {
    'environment' => {
      # important note: use the size flag to generate the discovery.etcd.io entry - server 
      # will disconnect with 504 otherwise:
      # curl https://discovery.etcd.io/new?size=2
      # look at: https://github.com/coreos/etcd/issues/1292
      'ETCD_DISCOVERY' => "https://discovery.etcd.io/ad716088a794a4f6a904e7c4eb1786b0"
    }
  }
}
