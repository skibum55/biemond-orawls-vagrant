# Class: tiaa-orawls::userconfig
 # Parameters:
 # arguments
 #
 class tiaa-orawls::userconfig {
  require orawls::weblogic, tiaa-orawls::domains, tiaa-orawls::nodemanager, tiaa-orawls::startwls 

  notify { 'class tiaa-orawls::userconfig':} 
  $default_params = {}
  $userconfig_instances = hiera('userconfig_instances', {})
  create_resources('orawls::storeuserconfig',$userconfig_instances, $default_params)
} 