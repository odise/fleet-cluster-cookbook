package "net-tools"

# regenerate the machine-id file once as we use an VB image here
if (node["current_user"].to_s.include? "vagrant")
  execute "machine-id" do
    command "mv /etc/machine-id /etc/machine-id.old && systemd-machine-id-setup"
    not_if { ::File.exists?("/etc/machine-id.old")}
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

