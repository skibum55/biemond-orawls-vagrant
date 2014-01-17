# Class: tiaa-orawls::startwls
 # Parameters:
 # arguments
 #
 class tiaa-orawls::startwls {
  require orawls::weblogic, tiaa-orawls::domains,tiaa-orawls::nodemanager


  notify { 'class tiaa-orawls::startwls':} 
  $default_params = {}
  $control_instances = hiera('control_instances', {})
  create_resources('orawls::control',$control_instances, $default_params)
}