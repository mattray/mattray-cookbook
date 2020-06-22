#
# Cookbook:: MattRay
# Recipe:: default
#

if debian_platform?
  include_recipe('mattray::_debian')
elsif raspbian_platform?
  include_recipe('mattray::_raspbian')
elsif redhat_based?('rhel')
  include_recipe('mattray::_rhel')
end

unless platform_family?('windows')

  # directory for kitchen/solo
  directory '/etc/chef/trusted_certs/' do
    recursive true
    mode '0755'
  end

  # self-signed cert for internal A2 testing
  cookbook_file '/etc/chef/trusted_certs/roberto_bottlebru_sh.crt' do
    sensitive true
    source 'roberto_bottlebru_sh.crt'
    mode '0644'
  end

  # self-signed cert for internal Chef Infra Server
  cookbook_file '/etc/chef/trusted_certs/ndnd_bottlebru_sh.crt' do
    sensitive true
    source 'ndnd_bottlebru_sh.crt'
    mode '0644'
  end

  append_if_no_line 'add ndnd to /etc/hosts' do
    path '/etc/hosts'
    line '10.0.0.2        ndnd ndnd.bottlebru.sh'
  end

  append_if_no_line 'add cubert to /etc/hosts' do
    path '/etc/hosts'
    line '10.0.0.4        cubert cubert.bottlebru.sh'
  end

  delete_lines 'add inze /etc/hosts' do
    path '/etc/hosts'
    pattern /inez/
  end

  append_if_no_line 'add cubert to /etc/hosts' do
    path '/etc/hosts'
    line '10.0.0.10        roberto roberto.bottlebru.sh'
  end

  append_if_no_line 'set the PAGER for remote TRAMP sessions' do
    path '/etc/bash.bashrc'
    line 'export PAGER=cat'
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

  # this works for Chef and Cinc
  chef_client_systemd_timer 'Run Chef Infra Client as a systemd timer' do
    chef_binary_path '/usr/bin/chef-client'
  end

end

timezone 'Australia/Sydney'
