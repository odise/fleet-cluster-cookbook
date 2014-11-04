#
# Cookbook Name:: docker-host
# Recipe:: ssh
#
# Copyright (C) 2014 Jan Nabbefeld
#
# All rights reserved - Do Not Redistribute
#

# we need to add a user core here due to the fact, that fleetctl 
# is always connecting ssh with core@<cluster ip>. Have a look at this 
# https://github.com/coreos/fleet/blob/a7a4845662d76a8ca31d58dcc7fb68554055405a/fleetctl/ssh.go#L107

user node["fleet"]["user"] do
  supports :manage_home => true
  comment "Core User"
  gid node["fleet"]["group"]
  home node["fleet"]["/home"]
  shell "/bin/bash"
end

directory "/#{node["fleet"]["home"]}/.ssh" do
  owner node["fleet"]["user"]
  group node["fleet"]["group"]
  mode '0700'
  action :create
end

private_key = data_bag_item("fleet_data_bag", "fleet_ssh_keys")["private_key"]
public_key = data_bag_item("fleet_data_bag", "fleet_ssh_keys")["public_key"] 
authorized_keys = data_bag_item("fleet_data_bag", "fleet_ssh_keys")["public_key"]

file "/#{node["fleet"]["home"]}/.ssh/id_rsa" do
  content private_key
  owner node["fleet"]["user"]
  group node["fleet"]["group"]
  mode '600'
end

file "/#{node["fleet"]["home"]}/.ssh/id_rsa.pub" do
  content public_key
  owner node["fleet"]["user"]
  group node["fleet"]["group"]
  mode '600'
end

file "/#{node["fleet"]["home"]}/.ssh/authorized_keys" do
  content authorized_keys
  owner node["fleet"]["user"]
  group node["fleet"]["group"]
  mode '600'
end
