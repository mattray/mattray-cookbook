#
# Cookbook:: MattRay
# Recipe:: _debian
#

apt_update

user 'debian' do
  manage_home true
  action :remove
  ignore_failure true
end

package %w( emacs-nox htop rsync sudo )

# from Debian?
package %w(
  bluetooth
  bluez
  exim4-base
  exim4-config
  exim4-daemon-light
  mysql-common
  nano
) do
  action :remove
end
