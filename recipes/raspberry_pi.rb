#
# Cookbook:: MattRay
# Recipe:: raspberry_pi
#

# this is for all Rasberry Pi devices running Debian 11.
# Tag them with 'rpi'
# knife tag create walt rpi

# dphys-swapfile turning it back on because builds starve out for memory
package %w( dphys-swapfile )

sysctl 'vm.swappiness' do
  value 1
end

# https://raspi.debian.net/defaults-and-settings/
# https://www.raspberrypi.org/documentation/computers/config_txt.html#gpu_mem
append_if_no_line 'reduce gpu memory' do
  path '/etc/default/raspi-firmware-custom'
  line 'gpu_mem=16'
end

# deleted on reboot
file '/tmp/raspi-firmware' do
  content 'gpu_mem=16'
end

# rerun after reboot
execute 'dpkg-reconfigure raspi-firmware' do
  action :nothing
  subscribes :run, 'file[/tmp/raspi-firmware]'
end
