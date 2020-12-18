cron 'minecraft backups 1' do
  command 'tar czf /home/minecraft/minecraft-backup-`date +\\%Y\\%m\\%d\\%H\\%M`.tgz /home/minecraft/minecraft'
  hour '11'
end

cron 'minecraft backups 2' do
  command 'tar czf /home/minecraft/minecraft-backup-`date +\\%Y\\%m\\%d\\%H\\%M`.tgz /home/minecraft/minecraft'
  minute '30'
  hour '16'
end
