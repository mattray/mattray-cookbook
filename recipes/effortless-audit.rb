hab_sup 'default' do
  license 'accept'
  auto_update true
  event_stream_application 'effortless-home'
  event_stream_environment 'effortless'
  event_stream_site 'home'
  event_stream_url 'roberto.bottlebru.sh:4222'
  event_stream_token 'mZ7HwczDoFkIljIQvhFiE22YRO4='
  event_stream_cert '/etc/chef/trusted_certs/roberto_bottlebru_sh.crt'
end

hab_service 'mattray/effortless-ndnd-home' do
  update_condition 'track-channel'
  topology 'standalone'
  channel 'unstable'
end

hab_config 'effortless-ndnd-home.default' do
  config({
          chef_license: {
                         acceptance: 'accept',
                        },
          automate: {
                     enable: true,
                     server_url: 'https://roberto.bottlebru.sh',
                     token: 'mZ7HwczDoFkIljIQvhFiE22YRO4=',
                     environment: 'effortless',
                     node_uuid: node['chef_guid'],
                    },
         })
end
