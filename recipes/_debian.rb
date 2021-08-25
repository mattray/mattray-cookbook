#
# Cookbook:: MattRay
# Recipe:: _debian
#

# for apt-cacher-ng
append_if_no_line 'add cubert to /etc/hosts' do
  path '/etc/hosts'
  line '10.0.0.4        cubert cubert.bottlebru.sh'
end

apt_repository 'deb.debian.org' do
  uri          'http://deb.debian.org/debian'
  distribution 'bullseye'
  components   %w(main contrib non-free)
  deb_src      false
end

apt_repository 'deb.debian.org-updates' do
  uri          'http://deb.debian.org/debian'
  distribution 'bullseye-updates'
  components   %w(main contrib non-free)
  deb_src      false
end

apt_repository 'security.debian.org' do
  uri          'http://security.debian.org/debian-security'
  distribution 'bullseye-security'
  components   %w(main contrib non-free)
  deb_src      false
end

file '/etc/apt/sources.list' do
  action :delete
end

apt_update

# preferred extra packages
package %w(
  curl
  emacs-nox
  htop
  rsync
  sudo
  zsh
)

# Debian 11 is really minimal!
package %w(
  exim4-base
  exim4-config
  exim4-daemon-light
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
  btsdio
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
