#
# Cookbook:: MattRay
# Recipe:: _rhel
#

package %w( emacs-nox sudo)

package %w(
  alsa-firmware
  alsa-tools-firmware
  chrony
  postfix
) do
  action :remove
end
