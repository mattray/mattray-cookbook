#
# Cookbook Name:: MattRay
# Recipe:: raspberrypi
#

user 'pi' do
  manage_home true
  action :remove
  ignore_failure true
end

# https://www.raspberrypi.org/documentation/configuration/config-txt/

# We're not using bluetooth and other unused packages
package %w(
  dphys-swapfile
  libraspberrypi-doc
  pi-bluetooth
) do
  action :remove
end

# disable loading kernel modules
# no sound or video on these devices
modules = %w{
  bcm2835_v4l2
  vc4
  snd
  snd_bcm2835
  snd_pcm_dmaengine
  snd_soc_core
  snd_pcm
  snd_timer
  v4l2_common
  videobuf2_vmalloc
  bcm2835_codec
  v4l2_mem2mem
  bcm2835_mmal_vchiq
  videobuf2_dma_contig
  videobuf2_memops
  videobuf2_v4l2
  videobuf2_common
  videodev
  media
  vc_sm_cma
}

modules.each do |mod|
  kernel_module mod do
    action :uninstall
    ignore_failure true
  end
end

reboot 'reboot' do
  action :nothing
end

append_if_no_line 'reduce gpu memory' do
  path '/boot/config.txt'
  line 'gpu_mem=16'
  notifies :request_reboot, 'reboot[reboot]'
end

# no swap
sysctl_param 'vm.swappiness' do
  value 0
end
