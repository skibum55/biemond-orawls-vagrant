#Class: tiaa-orawls::bsu
 # Parameters:
 # arguments
 #
 class tiaa-orawls::bsu {
  require orawls::weblogic

  notice 'class tiaa-orawls::bsu'
  $default_params = {}
  $bsu_instances = hiera('bsu_instances', {})
  create_resources('orawls::bsu',$bsu_instances, $default_params)
}