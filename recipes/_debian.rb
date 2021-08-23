#
# Cookbook:: MattRay
# Recipe:: _debian
#

# for apt-cacher-ng
append_if_no_line 'add cubert to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.4        cubert cubert.bottlebru.sh'
end

apt_update

# preferred extra packages
package %w( curl emacs-nox htop rsync sudo zsh )

# Debian 11 is really minimal!
package %w(
  nano
) do
  action :remove
end

# disable loading kernel modules
# no bluetooth on these devices
modules = %w(
  hci_uart
  btrtl
  btintel
  btqca
  btbcm
  bluetooth
  joydev
)

modules.each do |mod|
  kernel_module mod do
    action :uninstall
    ignore_failure true
  end
end

reboot 'reboot' do
  action :nothing
end
