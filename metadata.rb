name             'docker-compose'
maintainer       'MATSUI Shinsuke'
maintainer_email 'poppen.jp@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures docker-compose'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports         'ubuntu', '>= 12.04'

depends          'docker'
