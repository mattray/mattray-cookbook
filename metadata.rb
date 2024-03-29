name             'mattray'
maintainer       'Matt Ray'
maintainer_email 'chef@mattray.dev'
license          'Apache-2.0'
description      'Configures Matt Ray\'s assorted machines'
version          '0.33.0'

chef_version '>= 17'

supports 'debian', '~> 10.0'
supports 'centos', '~> 7.0'
supports 'mac_os_x', '~> 10.14'

# depends 'chef_client_updater', '~> 3.1'
depends 'line', '~> 4.0'

issues_url 'https://github.com/mattray/mattray-cookbook/issues'
source_url 'https://github.com/mattray/mattray-cookbook'
