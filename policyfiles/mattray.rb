name 'mattray'

run_list 'mattray::default'
named_run_list 'beaglebone', 'mattray::default', 'mattray::beaglebone'
named_run_list 'macbookair', 'mattray::default', 'mattray::macbookair'
named_run_list 'macbookpro', 'mattray::default', 'mattray::macbookpro'
named_run_list 'raspberrypi', 'mattray::default', 'mattray::raspberrypi'

default_source :supermarket

cookbook 'mattray', path: '..'
