#
# Cookbook Name:: MattRay
# Recipe:: macbookpro
#

# Enable better power management
package %w( macfanctld thermald tlp )

%w{ macfanctld thermald tlp }.each do |srvc|
  service srvc do
    action [:enable, :start]
  end
end

template '/etc/macfanctl.conf' do
  source 'macfanctl.conf.erb'
  notifies :restart, 'service[macfanctld]'
end

# set CPU usage to powersave mode
file '/etc/default/cpufrequtils' do
  content 'GOVERNOR="powersave"'
  mode '0644'
  owner 'root'
  group 'root'
end

# put in battery mode always
execute 'tlp bat'

# This machine has a busted USB interface, we'll remove the tools and modules and other unused packages bluetooth bluez
package %w(
  modemmanager
  wpasupplicant
) do
  action :remove
end

reboot 'blacklist' do
  action :nothing
end

# disable loading kernel modules
modules = %w{
  bnep
  btusb
  btrtl
  btintel
  bnep
  btbcm
  bcm5974
  usbhid
  uas
  bluetooth
  ehci_hcd
  uhci_hcd
  ehci_pci
  usb_storage
  usbcore
  usbcommon
  firewire_ohci
  firewire_core
  brcmsmac
  b43
  mac80211
  joydev
  snd_hda_intel
  snd_hda_codec_cirrus
  snd_hda_codec_generic
  snd_hda_codec_hdmi
  snd_hda_codec
  snd_hwdep
  snd_hda_core
  snd_pcm
  snd_timer
  snd
  soundcore
}

modules.each do |mod|
  file "/etc/modprobe.d/blacklist_#{mod}.conf" do
    content "blacklist #{mod}"
    mode '0644'
    notifies :request_reboot, 'reboot[blacklist]'
  end
end

# disable unused kernel modules
modules.each do |dsbl|
  execute "rmmod #{dsbl}" do
    ignore_failure true
    only_if "lsmod | grep #{dsbl}"
  end
end

# enable wakeonlan
# systemctl suspend
# call it with wakeonlan ma:cd:ad:re:ss
cookbook_file '/etc/network/interfaces.d/enp2s0' do
  source 'enp2s0'
  mode '0644'
  owner 'root'
  group 'root'
end
