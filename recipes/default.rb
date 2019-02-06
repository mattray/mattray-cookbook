#
# Cookbook Name:: MattRay
# Recipe:: default
#
# Copyright 2017-2018 Matt Ray
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

apt_update

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

user 'debian' do
  manage_home true
  action :remove
end

package %w( binutils-doc bluetooth bluez doc-debian exim4-base libssl-doc libx11-doc nfs-common samba-common ) do
  action :remove
end
