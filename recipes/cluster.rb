#
# Cookbook:: MattRay
# Recipe:: cluster
#

# this is for members of the K8s Arm cluster

# remove unnecessary packages
package %w(
  iw
  wireless-regdb
  wpasupplicant
) do
  action :remove
end
