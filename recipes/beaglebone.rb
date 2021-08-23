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
  alsa-topology-conf
  alsa-ucm-conf
  alsa-utils
  ardupilot-copter-3.6-bbbmini
  ardupilot-copter-3.6-blue
  ardupilot-copter-3.6-pocket
  ardupilot-rover-3.4-bbbmini
  ardupilot-rover-3.4-blue
  ardupilot-rover-3.4-pocket
  bb-beaglebone-io-installer
  bb-johnny-five-installer
  bb-node-red-installer
  bb-usb-gadgets
  bone101
  bonescript
  c9-core-installer
  dmidecode
  doc-beaglebone-getting-started
  firmware-atheros
  firmware-brcm80211
  firmware-iwlwifi
  firmware-libertas
  firmware-misc-nonfree
  firmware-realtek
  firmware-ti-connectivity
  firmware-zd1211
  mesa-common-dev
  mjpg-streamer
  modemmanager
  nginx
  nginx-full
  rfkill
  vpdma-dra7xx-installer
  wireguard-tools
  wireless-regdb
  wireless-tools
  wpasupplicant
  xorg-sgml-doctools
) do
  action :remove
end

# dphys-swapfile turning it back on because builds starve out for memory
package %w( dphys-swapfile )

# low swap
sysctl 'vm.swappiness' do
  value 1
end
