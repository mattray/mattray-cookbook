name 'mattray'

run_list 'mattray::default'
named_run_list 'beaglebone', 'mattray::default', 'mattray::beaglebone'
named_run_list 'macbookpro', 'mattray::default', 'mattray::macbookpro'

default_source :supermarket

cookbook 'mattray', path: '..'
