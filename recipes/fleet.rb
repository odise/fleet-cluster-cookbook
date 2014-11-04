#
# Cookbook Name:: docker-host
# Recipe:: fleet
#
# Copyright (C) 2014 Jan Nabbefeld
#
# All rights reserved - Do Not Redistribute
#

execute 'systemctl-daemon-reload' do
  command '/bin/systemctl --system daemon-reload'
  action :nothing
end

service "fleet" do
  action :nothing
  provider Chef::Provider::Service::Systemd
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

ark 'fleet' do
  url node[:fleet][:download_url]
  has_binaries ['fleetd', 'fleetctl']
end

template "/etc/systemd/system/fleet.service" do
  source "fleet.service.erb"
  variables({
    :config => node[:fleet][:config],
  })
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :enable, 'service[fleet]', :immediately
  notifies :restart, 'service[fleet]', :immediately
end

