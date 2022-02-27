#
# Cookbook:: MattRay
# Recipe:: cluster
#

# this is for members of the K8s Arm cluster

# remove unnecessary packages
package %w(
  iw
  wireless-regdb
  wpasupplicant
) do
  action :remove
end

append_if_no_line 'add ndnd to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.2        ndnd ndnd.bottlebru.sh'
end

append_if_no_line 'add mom to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.100        mom mom.bottlebru.sh'
end

append_if_no_line 'add igner to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.101        igner igner.bottlebru.sh'
end

append_if_no_line 'add walt to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.102        walt walt.bottlebru.sh'
end

append_if_no_line 'add larry to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.103        larry larry.bottlebru.sh'
end

append_if_no_line 'add nixon to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.104        nixon nixon.bottlebru.sh'
end

append_if_no_line 'add yancy to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.105        yancy yancy.bottlebru.sh'
end

# this doesn't work
# chef_client_updater 'cinc' do
#   product_name 'cinc'
#   rubygems_url 'https://packagecloud.io/cinc-project/stable'
# end

arch = node['hostnamectl']['architecture']
if arch.eql?('x86-64')
  arch = 'amd64'
end

cinc_version = node['mattray']['cinc']['version']
cinc_deb = "/root/cinc-#{cinc_version}_#{arch}.deb"

remote_file cinc_deb do
  source "http://downloads.cinc.sh/files/stable/cinc/#{cinc_version}/debian/11/cinc_#{cinc_version}-1_#{arch}.deb"
end

dpkg_package 'cinc_deb' do
  source cinc_deb
  version cinc_version
  action :nothing
  subscribes :install, "remote_file[#{cinc_deb}]", :delayed
end
