name             'mattray'
maintainer       'Matt Ray'
maintainer_email 'matthewhray@gmail.com'
license          'Apache-2.0'
description      'Configures Matt Ray\' assorted machines'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.17'

chef_version '>= 15'

supports 'debian', '~> 9.0'
supports 'centos', '~> 7.0'

depends 'line', '~> 2.3'

issues_url 'https://github.com/mattray/mattray-cookbook/issues'
source_url 'https://github.com/mattray/mattray-cookbook'
