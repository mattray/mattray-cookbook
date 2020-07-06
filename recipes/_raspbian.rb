#
# Cookbook:: MattRay
# Recipe:: _raspbian
#

# for apt-cacher-ng
append_if_no_line 'add cubert to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.4        cubert cubert.bottlebru.sh'
end

apt_update

user 'pi' do
  manage_home true
  action :remove
  ignore_failure true
end

package %w( emacs-nox sudo htop)

# We're not using bluetooth and other unused packages
package %w(
  alsa-utils
  binutils-doc
  bluetooth
  bluez
  chrony
  doc-debian
  exim4-base
  exim4-config
  javascript-common
  libraspberrypi-doc
  libssl-doc
  libx11-doc
  mysql-common
  nfs-common
  ntp
  pi-bluetooth
  samba-common
  telnet
  v4l-utils
) do
  action :remove
end
