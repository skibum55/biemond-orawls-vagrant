# Class: tiaa-orawls::machines
 # Parameters:
 # arguments
 #
 class tiaa-orawls::machine
  require tiaa-orawls::userconfig

  notify { 'class tiaa-orawls::machines':} 
  $default_params = {}
  $machines_instances = hiera('machines_instances', {})
  create_resources('orawls::wlstexec',$machines_instances, $default_params)
}
