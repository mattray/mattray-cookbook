#
# Cookbook:: MattRay
# Recipe:: macbookair 7,2
#

# mount the SD Card as an extra filesystem
# directory '/storage'

# mount '/storage' do
#   device '/dev/sda'
#   fstype 'ext4'
#   options 'rw'
#   action [:mount, :enable]
# end

# Fans https://github.com/dgraziotin/mbpfan

package %w( mbpfan )

%w( mbpfan ).each do |srvc|
  service srvc do
    action [:enable, :start]
  end
end

# turn off the screen
# off
# root@inez:# echo 4 > /sys/class/backlight/intel_backlight/bl_power
# on
# root@inez:# echo 0 > /sys/class/backlight/intel_backlight/bl_power
execute 'echo 4 > /sys/class/backlight/intel_backlight/bl_power' do
  not_if 'grep 4 /sys/class/backlight/intel_backlight/bl_power'
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
  btrtl
  btintel
  btbcm
  btusb
  bluetooth
  joydev
  thunderbolt
)

modules.each do |mod|
  kernel_module mod do
    action :uninstall
    ignore_failure true
  end
end
