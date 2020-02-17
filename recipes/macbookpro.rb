#
# Cookbook:: MattRay
# Recipe:: macbookpro
#

# Fans https://github.com/dgraziotin/mbpfan
# CPU thermald? https://github.com/intel/thermal_daemon
# Power TLP? disabled for now

package %w( mbpfan )

%w( mbpfan ).each do |srvc|
  service srvc do
    action [:enable, :start]
  end
end

# turn off the screen
execute 'echo 0 > /sys/class/backlight/apple_backlight/brightness' do
  not_if 'grep 0 /sys/class/backlight/apple_backlight/brightness'
end

replace_or_add 'disable lid closing suspend' do
  path '/etc/systemd/logind.conf'
  pattern '#HandleLidSwitch=suspend'
  line 'HandleLidSwitch=ignore'
end

service 'systemd-logind' do
  subscribes :restart, 'service[systemd-logind]', :immediately
  action :nothing
end

# This machine has a busted USB interface, we'll remove the tools and modules and other unused packages bluetooth bluez
package %w(
  modemmanager
  wireless-regdb
  wireless-tools
  wpasupplicant
) do
  action :remove
end

# disable loading kernel modules
modules = %w(
  b43
  bcm5974
  bluetooth
  bnep
  brcmsmac
  btbcm
  btintel
  btrfs
  btrtl
  btusb
  drm
  drm_kms_helper
  ehci_hcd
  ehci_hcd
  ehci_pci
  firewire_core
  firewire_ohci
  firewire_sbp2
  jfs
  joydev
  mac80211
  msdos
  nouveau
  pcmcia
  pcmcia_core
  qnx4
  raid6_pq
  snd
  snd_hda_codec
  snd_hda_codec_cirrus
  snd_hda_codec_generic
  snd_hda_codec_hdmi
  snd_hda_core
  snd_hda_intel
  snd_hwdep
  snd_pcm
  snd_timer
  soundcore
  ssb
  uas
  ufs
  uhci_hcd
  usb_common
  usb_storage
  usbcommon
  usbcore
  usbhid
  vfat
  video
  xfs
)

modules.each do |mod|
  kernel_module mod do
    action :uninstall
    ignore_failure true
  end
end
