#
# Cookbook:: MattRay
# Recipe:: _debian
#

# for apt-cacher-ng
append_if_no_line 'add cubert to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.4        cubert cubert.bottlebru.sh'
end

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
  chrony
  exim4-base
  exim4-config
  exim4-daemon-light
  mysql-common
  ntp
  ntpdate
  nano
) do
  action :remove
end
