#
# Cookbook:: MattRay
# Recipe:: beaglebone
#

# mount the eMMC as an extra filesystem
directory '/emmc'

mount '/emmc' do
  device '/dev/mmcblk1'
  fstype 'ext4'
  options 'rw'
  action [:mount, :enable]
end

package %w(
  ardupilot-copter-3.6-bbbmini
  ardupilot-copter-3.6-blue
  ardupilot-copter-3.6-pocket
  ardupilot-rover-3.4-bbbmini
  ardupilot-rover-3.4-blue
  ardupilot-rover-3.4-pocket
  bb-beaglebone-io-installer
  bb-johnny-five-installer
  bb-node-red-installer
  dmidecode
  doc-beaglebone-getting-started
  mesa-common-dev
  mjpg-streamer
  modemmanager
  rfkill
  vpdma-dra7xx-installer
  wireguard-tools
  wireless-tools
  wpasupplicant
  xorg-sgml-doctools
) do
  action :remove
end

# no swap
sysctl 'vm.swappiness' do
  value 0
end
