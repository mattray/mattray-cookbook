#
# Cookbook:: MattRay
# Recipe:: macbookpro
# DMI: Apple Inc. MacBookPro6,2/Mac-F22586C8, BIOS    MBP61.88Z.0057.B17.1702241225 02/24/17
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
#/sys/class/backlight/gmux_backlight/brightness
execute 'echo 0 > /sys/class/backlight/gmux_backlight/brightness' do
  not_if 'grep ^0 /sys/class/backlight/gmux_backlight/brightness'
  ignore_failure true
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
  bluetooth
  bluez
  task-laptop
  wireless-regdb
  wireless-tools
  wpasupplicant
) do
  action :remove
end

# disable loading kernel modules
modules = %w(
  ehci_pci
  usbhid
  bcm5974
  apple_mfi_fastcharge
  uas
  usb_storage
  ehci_hcd
  btusb
  uhci_hcd
  usbcore
  firewire_core
  firewire_ohci
  firewire_sbp2
  b43
  brcmsmac
  mac80211
  ssb
  pcmcia
  pcmcia_core
  nouveau
)

modules.each do |mod|
  kernel_module mod do
    action :uninstall
    ignore_failure true
  end
end
