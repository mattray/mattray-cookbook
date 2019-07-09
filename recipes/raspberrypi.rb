#
# Cookbook Name:: MattRay
# Recipe:: raspberrypi
#

user 'pi' do
  manage_home true
  action :remove
end

# We're not using bluetooth and other unused packages
package %w(
  libraspberrypi-doc
  pi-bluetooth
) do
  action :remove
end

reboot 'blacklist' do
  action :nothing
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
  file "/etc/modprobe.d/blacklist_#{mod}.conf" do
    content "blacklist #{mod}"
    mode '0644'
    notifies :request_reboot, 'reboot[blacklist]'
  end
end

# disable unused kernel modules
modules.each do |dsbl|
  execute "rmmod #{dsbl}" do
    ignore_failure true
    only_if "lsmod | grep #{dsbl}"
  end
end
