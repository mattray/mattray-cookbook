#
# Cookbook Name:: MattRay
# Recipe:: beaglebone
#

execute 'turn off the blinking network light' do
  command 'echo none > /sys/class/leds/beaglebone\:green\:usr0/trigger'
  not_if { ::File.exist?('/tmp/beaglebone-leds') }
  ignore_failure true
end

file '/tmp/beaglebone-leds'

package %w(
  bone101
  doc-beaglebone-getting-started
  mesa-common-dev
  modemmanager
  wpasupplicant
  xorg-sgml-doctools
) do
  action :remove
end
