# Class: tiaa-orawls::copydomain
 # Parameters:
 # arguments
 #
 class tiaa-orawls::copydomain {
  require orawls::weblogic

  notify { 'class tiaa-orawls::copydomain':} 
  $default_params = {}
  $copy_instances = hiera('copy_instances',{})
  create_resources('orawls::copydomain',$copy_instances, $default_params)
}
