#
# Cookbook Name:: docker-host
# Recipe:: etcd
#
# Copyright (C) 2014 Jan Nabbefeld
#
# All rights reserved - Do Not Redistribute
#

execute 'systemctl-daemon-reload' do
  command '/bin/systemctl --system daemon-reload'
  action :nothing
end

service "etcd" do
  action :nothing
  provider Chef::Provider::Service::Systemd
  supports :status => true, :restart => true, :reload => true
  action :nothing
  #action [:start, :enable]
end

ark 'etcd' do
  url node[:etcd][:download_url]
  has_binaries ['etcd', 'etcdctl']
end

template "/etc/systemd/system/etcd.service" do
  source "etcd.service.erb"
  variables({
    :environment => node[:etcd][:config][:environment],
  })
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :enable, 'service[etcd]', :immediately
  notifies :restart, 'service[etcd]', :immediately
end

