name             'mattray'
maintainer       'Matt Ray'
maintainer_email 'chef@mattray.dev'
license          'Apache-2.0'
description      'Configures Matt Ray\'s assorted machines'
version          '0.23.0'

chef_version '>= 16'

supports 'debian', '~> 10.0'
supports 'centos', '~> 7.0'

depends 'line', '~> 2.9'
depends 'habitat', '~> 2.2'

issues_url 'https://github.com/mattray/mattray-cookbook/issues'
source_url 'https://github.com/mattray/mattray-cookbook'
