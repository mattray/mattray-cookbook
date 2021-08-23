#
# Cookbook:: MattRay
# Recipe:: default
#

if debian_platform?
  include_recipe 'mattray::_debian'
elsif raspbian_platform?
  include_recipe 'mattray::_raspbian'
elsif arch_platform?
  include_recipe 'mattray::_arch'
elsif redhat_based?('rhel')
  include_recipe 'mattray::_rhel'
elsif macos_platform?
  include_recipe 'mattray::macos'
end

unless platform_family?('windows')
  unless macos_platform?

    append_if_no_line 'set the PAGER for remote TRAMP sessions' do
      path '/etc/bash.bashrc'
      line 'export PAGER=cat'
    end

    user 'mattray' do
      comment 'Matt Ray'
      manage_home true
      shell '/usr/bin/zsh'
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
    chef_client_systemd_timer 'Run Cinc Client as a systemd timer' do
      environment ({'HOME' => '/etc/cinc'})
    end
  end

end

timezone 'Australia/Sydney'
