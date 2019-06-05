#
# Cookbook Name:: MattRay
# Recipe:: _rhel
#

package %w(
  alsa-firmware
  alsa-tools-firmware
  postfix
) do
  action :remove
end
