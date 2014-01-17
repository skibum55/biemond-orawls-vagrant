# class: tiaa-orawls::pack_domain
 # Parameters:
 # arguments
 #
 class tiaa-orawls::pack_domain {
  require tiaa-orawls::jms_module_foreign_server_entries_objects

  notify { 'class tiaa-orawls::pack_domain':} 
  $default_params = {}
  $pack_domain_instances = hiera('pack_domain_instances', $default_params)
  create_resources('orawls::packdomain',$pack_domain_instances, $default_params)
}