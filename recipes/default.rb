#
# Cookbook Name:: chef-init-ezvm
# Recipe:: default
#
# Copyright 2014, Vubeology LLC
#

include_recipe "apt"

# ezvm depends on the realpath package
package "realpath"

# Clone the ezvm Git repo and move its contents into /usr/local/ezvm
# Here we cannot just mv the directory since /usr/local may not be
# writeable by vagrant.  So we find all files/folders and move them.
#
# Here we must use find so list all the dotfiles/dotdirs like .git
# and .gitmodules or what-have-you.  Globs don't work well in these
# cases.

bash "clone ezvm into #{node['ezvm']['install_dir']}" do
  user "vagrant"
  group "vagrant"
  code <<-EOH
    cd /tmp || exit 1
    if [ -d ezvm ]; then
       rm -rf ezvm || exit 2
    fi
    git clone "#{node['ezvm']['scm_url']}" ezvm || exit 3
    sudo mv ezvm "#{node['ezvm']['install_dir']}" || exit 4
    sudo ln -sf "#{node['ezvm']['install_dir']}/bin/ezvm" /usr/local/bin/ezvm || exit 5
  EOH

  # Not if the install_dir is a Git repository; that means we already
  # checked it out there
  not_if { ::File.directory?(node['ezvm']['install_dir']) }
end
