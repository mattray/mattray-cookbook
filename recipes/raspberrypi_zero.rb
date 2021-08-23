#
# Cookbook:: MattRay
# Recipe:: raspberrypi
#

# this is for Rasberry Pi Zero running Debian 11

# dphys-swapfile turning it back on because builds starve out for memory
package %w( dphys-swapfile )

sysctl 'vm.swappiness' do
  value 1
end

# https://raspi.debian.net/defaults-and-settings/
# https://www.raspberrypi.org/documentation/computers/config_txt.html#gpu_mem
txt_if_no_line 'reduce gpu memory' do
  path '/etc/default/raspi-firmware-custom'
  line 'gpu_mem=16'
  notifies :request_reboot, 'reboot[reboot]'
end
