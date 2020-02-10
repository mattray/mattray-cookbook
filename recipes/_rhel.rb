#
# Cookbook:: MattRay
# Recipe:: _rhel
#

package %w(
  alsa-firmware
  alsa-tools-firmware
  ntp
  ntpdate
  postfix
) do
  action :remove
end
