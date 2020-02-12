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

package 'htop'

# from Debian?
package %w(
  doc-debian
  nfs-common
  samba-common
  telnet
) do
  action :remove
end

# from Raspbian?
package %w(
  alsa-utils
  binutils-doc
  bluetooth
  bluez
  chrony
  exim4-base
  exim4-config
  javascript-common
  libssl-doc
  libx11-doc
  mysql-common
  ntp
  sntp
  v4l-utils
) do
  action :remove
end
