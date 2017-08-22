#
# Cookbook Name:: MattRay
# Recipe:: macbookpro
#
# Copyright 2017 Matt Ray
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Enable better power management
%w{ macfanctld thermald tlp }.each do |pkg|
  package pkg
end

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

# put the second hard drive to sleep, currently unused
execute 'hdparm -Y /dev/sdb'

# This machine has a busted USB interface, we'll remove the tools and modules
packages = %w{ bluetooth bluez }

packages.each do |pkg|
  package pkg do
    action :remove
  end
end

reboot 'blacklist' do
  action :nothing
end

# disable loading kernel modules
modules = %w{ bnep btusb btrtl btintel bnep btbcm bcm5974 usbhid uas bluetooth ehci_hcd uhci_hcd ehci_pci usb_storage usbcore usbcommon firewire_ohci firewire_core brcmsmac b43 mac80211 }

modules.each do |mod|
  file "/etc/modprobe.d/blacklist_#{mod}.conf" do
    content "blacklist #{mod}"
    mode '0644'
    notifies :request_reboot, 'reboot[blacklist]'
  end
end

# disable unused kernel modules
disable = %w{ bnep btusb btrtl btintel bnep btbcm bcm5974 usbhid uas bluetooth ehci_hcd uhci_hcd ehci_pci usb_storage usbcore usbcommon firewire_ohci firewire_core brcmsmac b43 mac80211 }

disable.each do |dsbl|
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
