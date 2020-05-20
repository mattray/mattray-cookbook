#
# Cookbook:: MattRay
# Recipe:: _rhel
#

package %w( emacs-nox sudo)

package %w(
  alsa-firmware
  alsa-tools-firmware
  postfix
) do
  action :remove
end
