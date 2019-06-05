#
# Cookbook Name:: MattRay
# Recipe:: default
#

if platform_family?('debian')
  include_recipe('mattray::_debian')
elsif platform_family?('rhel')
  include_recipe('mattray::_rhel')
end

# must have sudo
package %w( emacs-nox sudo )

# directory for kitchen/solo
directory '/etc/chef/trusted_certs/' do
  recursive true
  mode '0755'
end

# self-signed cert for internal A2 testing
cookbook_file '/etc/chef/trusted_certs/ndnd.crt' do
  sensitive true
  source 'ndnd.crt'
  mode '0644'
end

append_if_no_line 'add ndnd to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.2        ndnd'
end

user 'mattray' do
  comment 'Matt Ray'
  manage_home true
  shell '/bin/bash'
  password '$1$nzR3m/Xd$jJ3XxhiFZwuIxJXgqmUXF1'
end

directory '/home/mattray/.ssh' do
  owner 'mattray'
  group 'mattray'
  mode '0700'
end

cookbook_file '/home/mattray/.ssh/authorized_keys' do
  sensitive true
  source 'authorized_keys'
  mode '0600'
  owner 'mattray'
  group 'mattray'
end

sudo 'mattray' do
  user 'mattray'
  nopasswd true
end
