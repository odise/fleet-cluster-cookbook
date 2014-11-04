#
# Cookbook Name:: docker-host
# Recipe:: test_service
#
# Copyright (C) 2014 Jan Nabbefeld
#
# All rights reserved - Do Not Redistribute
#

template "/root/test.service" do
  source "test.service.erb"
end

