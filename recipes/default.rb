#
# Cookbook Name:: chef-init-ezvm
# Recipe:: default
#
# Copyright 2014, Vubeology LLC
#

bash "prepare ezvm parent dir" do
  user "root"
  code <<-EOH
    parent=`dirname "#{node['ezvm']['install_dir']}"`
    ezvm=`basename "#{node['ezvm']['install_dir']}"`
    [ -d "$parent" ] || mkdir -p -m 0775 "$parent"
    chown vagrant "$parent"
    chgrp vagrant "$parent"
    chmod 775 "$parent"
  EOH
end

bash "clone ezvm" do
  user "vagrant"
  code <<-EOH
    cd /tmp
    ezvm=`basename "#{node['ezvm']['install_dir']}"`
    git clone "#{node['ezvm']['scm_url']}" "$ezvm"
    mv "$ezvm" "#{node['ezvm']['install_dir']}"
  EOH
  not_if { ::File.directory?(node['ezvm']['install_dir']) }
end
