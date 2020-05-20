#
# Cookbook:: MattRay
# Recipe:: _debian
#

apt_update

user 'debian' do
  manage_home true
  action :remove
  ignore_failure true
end

package %w( emacs-nox sudo htop)

# from Debian?
package %w(
  doc-debian
  nfs-common
  samba-common
  telnet
) do
  action :remove
end
