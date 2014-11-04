# fleet-cluster-cookbook

A working example on how to setup a two machine Vagrant box cluster using fleet version 0.5.0.

## Supported Platforms

This is currently based on CentOS7. 
TODO: List your supported platforms.

## Setup

This will start two boxes with etcd, fleet and Docker next to an example service.

```
$ kitchen converge
```

```
$ kitchen login default
$ systemctl --failed
```

You should see no failed services here. Now for the cluster:

```
$ fleetctl list-machines -l
MACHINE					IP		METADATA
2993aec374654ef39d8b408f74716c0e	192.168.33.10	az=eu-central-1b,region=eu-central-1
37568b8d74794355b936643f790b070a	192.168.33.9	az=eu-central-1a,region=eu-central-1
```

We see two machines working as a fleet cluster. Lets have a look at etcd:

```
$ etcdctl member list
53d215869e907e0c: name=infra1 peerURLs=http://192.168.33.10:2380 clientURLs=http://192.168.33.10:2380,http://192.168.33.10:7001
a7e311a6b89e188f: name=infra0 peerURLs=http://192.168.33.9:2380 clientURLs=http://192.168.33.9:2380,http://192.168.33.9:7001
```

Some more details:

```
$ curl http://192.168.33.9:2379/v2/stats/leader
{
    "leader": "a7e311a6b89e188f",
    "followers": {
        "53d215869e907e0c": {
            "latency": {
                "current": 0.441689,
                "average": 84.62743093358489,
                "standardDeviation": 1296.8138483894625,
                "minimum": 0.197766,
                "maximum": 29738.208068
            },
            "counts": {
                "fail": 216,
                "success": 6068
            }
        }
    }
}
```

Now lets start the test service.

```
$ sudo su core
$ exec /usr/bin/ssh-agent $SHELL
$ ssh-add
Identity added: /home/core/.ssh/id_rsa (/home/core/.ssh/id_rsa)
$ /usr/local/bin/fleetctl start /root/test.service
Unit test.service launched on 2993aec3.../192.168.33.10
```

It's deployed on the other box. Checking the status of the container.

```
$ /usr/local/bin/fleetctl status test.service
The authenticity of host '192.168.33.10' can't be established.
ECDSA key fingerprint is 14:1a:d6:19:4f:ad:89:fd:99:37:0c:f7:60:1e:ec:de.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.33.10' (ECDSA) to the list of known hosts.
test.service - MyTestApp
   Loaded: loaded (/run/fleet/units/test.service; linked-runtime)
   Active: active (running) since Tue 2014-11-04 11:40:22 EST; 1min 25s ago
  Process: 4485 ExecStartPre=/usr/bin/docker pull busybox (code=exited, status=0/SUCCESS)
  Process: 4478 ExecStartPre=/usr/bin/docker rm busybox1 (code=exited, status=1/FAILURE)
  Process: 4468 ExecStartPre=/usr/bin/docker kill busybox1 (code=exited, status=1/FAILURE)
 Main PID: 4639 (docker)
   CGroup: /system.slice/test.service
           └─4639 /usr/bin/docker run --name busybox1 busybox /bin/sh -c while true; do echo Hello World; sleep 1; done

Nov 04 11:41:37 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:38 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:39 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:40 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:41 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:42 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:43 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:44 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:45 peer-centos7.vagrantup.com docker[4639]: Hello World
Nov 04 11:41:46 peer-centos7.vagrantup.com docker[4639]: Hello World
```
## Recipes

## Recipes
| Name | Description |
|:-----|:------------|
| `default` | Install and setup the service

## Attributes

| attribute | default setting | description |
|:---------------------------------|:---------------|:-----------------------------------------|

## Usage

### fleet-cluster::default

Include `fleet-cluster` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[fleet-cluster::default]"
  ]
}
```

## License and Authors

Author:: Jan Nabbefeld (jan.nabbefeld@kreuzwerker.de)
