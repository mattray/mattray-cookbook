name             'mattray'
maintainer       'Matt Ray'
maintainer_email 'matthewhray@gmail.com'
license          'Apache-2.0'
description      'Configures Matt Ray\' assorted machines'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.15.0'

chef_version '>= 14'
supports 'debian', '>= 9.0'

depends 'line', '~> 2.1.1'
