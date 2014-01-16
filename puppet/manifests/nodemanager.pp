# Class: tiaa-orawls::nodemanager
 # Parameters:
 # arguments
 #
 class  tiaa-orawls::nodemanager {
  require tiaa-orawls::domains,orawls::weblogic 

  notify { 'class tiaa-orawls::nodemanager':} 
  $default_params = {}
  $nodemanager_instances = hiera('nodemanager_instances', {})
  create_resources('orawls::nodemanager',$nodemanager_instances, $default_params)
}