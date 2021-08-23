# one-time migration from ndnd to Hosted Chef

# validator pem for ndnd
cookbook_file '/etc/chef/matt-validator.pem' do
  sensitive true
  source 'matt-validator.pem'
  mode '0644'
end

# chef_server_url "https://ndnd.bottlebru.sh/organizations/chef_managed_org"
replace_or_add 'chef_server_url' do
  path '/etc/chef/client.rb'
  pattern 'chef_server_url*'
  line 'chef_server_url "https://api.chef.io/organizations/matt"'
  not_if { ::File.exist?('/etc/chef/client.pem.old') }
end

# validation_key "/etc/chef/chef_managed_org-validator.pem"
replace_or_add 'validation_key' do
  path '/etc/chef/client.rb'
  pattern 'validation_key*'
  line 'validation_key "/etc/chef/matt-validator.pem"'
  not_if { ::File.exist?('/etc/chef/client.pem.old') }
end

# delete validation_client_name "chef_managed_org"
replace_or_add 'validation_key_name' do
  path '/etc/chef/client.rb'
  pattern '#validation_client_name "matt-validator"'
  line 'validation_client_name "matt-validator"'
  not_if { ::File.exist?('/etc/chef/client.pem.old') }
end

# policy_group "ndnd-home"
replace_or_add 'policy_group' do
  path '/etc/chef/client.rb'
  pattern 'policy_group*'
  line 'policy_group "home"'
  not_if { ::File.exist?('/etc/chef/client.pem.old') }
end

# policy_name "raspbian"
replace_or_add 'policy_group' do
  path '/etc/chef/client.rb'
  pattern 'policy_name*'
  line 'policy_name "' + node['policy_name'] + '"'
  not_if { ::File.exist?('/etc/chef/client.pem.old') }
end

execute 'mv /etc/chef/client.pem /etc/chef/client.pem.old' do
  not_if { ::File.exist?('/etc/chef/client.pem.old') }
end
