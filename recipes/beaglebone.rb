#
# Cookbook:: MattRay
# Recipe:: beaglebone
#

# deb [arch=armhf] http://repos.rcn-ee.com/debian/ bullseye main
apt_repository 'repos.rcn-ee.com' do
  uri          'http://repos.rcn-ee.com/debian'
  distribution 'bullseye'
  components   ['main']
  arch         'armhf'
  deb_src      false
end

# mount the eMMC as an extra filesystem
directory '/emmc'

mount '/emmc' do
  device '/dev/mmcblk1'
  fstype 'ext4'
  options 'rw'
  action [:mount, :enable]
end

package %w(
  bone101
  crda
  dmidecode
  iw
  nginx
  nginx-common
  nginx-core
  nodejs-doc
  wireless-regdb
  wpasupplicant
) do
  action :remove
end

# dphys-swapfile turning it back on because builds starve out for memory
package %w( dphys-swapfile )

# low swap
sysctl 'vm.swappiness' do
  value 1
end
