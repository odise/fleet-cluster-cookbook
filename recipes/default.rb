package "net-tools"

if (node["current_user"].to_s.include? "vagrant")
  execute "machine-id" do
    command "rm /etc/machine-id && systemd-machine-id-setup"
  end
end

include_recipe "docker-host::ssh"
include_recipe "docker"
include_recipe "docker-host::etcd5"
include_recipe "docker-host::fleet"

include_recipe "docker-host::test_service"

service "firewalld" do
  provider Chef::Provider::Service::Systemd
  action :stop
end

