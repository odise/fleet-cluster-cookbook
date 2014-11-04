package "net-tools"

if (node["current_user"].to_s.include? "vagrant")
  execute "machine-id" do
    command "rm /etc/machine-id && systemd-machine-id-setup"
  end
end

include_recipe "fleet-cluster::ssh"
include_recipe "docker"
include_recipe "fleet-cluster::etcd5"
include_recipe "fleet-cluster::fleet"

include_recipe "fleet-cluster::test_service"

service "firewalld" do
  provider Chef::Provider::Service::Systemd
  action :stop
end

