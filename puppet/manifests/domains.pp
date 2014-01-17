# Define: tiaa-orawls::domains
 # Parameters:
 # arguments
 #
 define tiaa-orawls::domains(){
  require orawls::weblogic

  notice 'class tiaa-orawls::domains'
  $default_params = {}
  $domain_instances = hiera('domain_instances', {})
  create_resources('orawls::domain',$domain_instances, $default_params)
}