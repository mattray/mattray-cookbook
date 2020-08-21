cron "minecraft backups" do
  command "tar czf /home/minecraft/minecraft-backup-`date +\\%Y\\%m\\%d\\%H\\%M`.tgz /home/minecraft/minecraft"
  minute "30"
  hour "14"
end
