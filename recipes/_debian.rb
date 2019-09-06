#
# Cookbook Name:: MattRay
# Recipe:: _debian
#

apt_update

user 'debian' do
  manage_home true
  action :remove
  ignore_failure true
end

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
  exim4-base
  javascript-common
  libssl-doc
  libx11-doc
  mysql-common
  v4l-utils
) do
  action :remove
end
