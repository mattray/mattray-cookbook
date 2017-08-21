#
# Cookbook Name:: MattRay
# Recipe:: default
#
# Copyright 2017 Matt Ray
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

user 'mattray' do
  comment 'Matt Ray'
  home '/home/mattray'
  shell '/bin/bash'
  password '$1$nzR3m/Xd$jJ3XxhiFZwuIxJXgqmUXF1'
end

directory '/home/mattray' do
  owner 'mattray'
  group 'mattray'
  mode '0700'
end

directory '/home/mattray/.ssh' do
  owner 'mattray'
  group 'mattray'
  mode '0700'
end

file '/home/mattray/.ssh/authorized_keys' do
  content 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwg/55j0pKI8FmzQ8g0hOQ+x5YXN8QPpDx7+Y7SZaZEvarC/ot5lBdPgypPd4ucGn/s+hpd8LfgyYNr10NGQhjis0Ll0XJMjQMqq9ucPSv1fVDVp3Kzc2e8Vjyych2Q25UMrDq4lkhFQREQX528Voj8W3PnRcsExZiXV8RQbyy3+VS1R3MUSO/fs7Kk2z1Xxnkyzy+3KEkpPVQWJdNVGcvpB7oSOchgYqPRBX5s93WMiG2ALQtji3W0MKGifOsp7c+Hxc1ZhZupyT2/uo5Ui3i0tYfnmewUwD1M6aOL5kQsFRvAYRV2jI6TOTL5eZQ/ntQOhD35bNvaKwfMWc2qTSkw== matthewhray@gmail.com'
  mode '0600'
  owner 'mattray'
  group 'mattray'
end

package 'emacs-nox'

apt_update 'update' do
  frequency 86400
  action :periodic
end
