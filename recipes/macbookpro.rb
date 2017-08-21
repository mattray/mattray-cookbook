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

# This machine has a busted USB interface, we'll remove the tools and modules

packages = %w{ bluetooth bluez libusb-0.1 libusb-1.0 usbutils }

packages.each do |pkg|
  package pkg do
    action :remove
  end
end

reboot 'blacklist' do
  action :nothing
end

modules = %w{ bnep btusb btrtl btintel bnep btbcm bcm5974 usbhid uas bluetooth ehci_hcd uhci_hcd ehci_pci usb_storage usbcore usbcommon firewire_ohci firewire_core }

modules.each do |mod|
  file "/etc/modprobe.d/blacklist_#{mod}.conf" do
    content "blacklist #{mod}"
    mode '0644'
    notifies :request_reboot, 'reboot[blacklist]'
  end
end

disable = %w{ ehci_hcd uhci_hcd ehci_pci usbcore usb_common }

disable.each do |dsbl|
  execute "rmmod #{dsbl}" do
    ignore_failure true
    only_if "lsmod | grep #{dsbl}"
  end
end
