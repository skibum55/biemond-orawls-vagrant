# Class: tiaa-orawls::jms_module_foreign_server_entries_objects
 # Parameters:
 # arguments
 #
 class tiaa-orawls::jms_module_foreign_server_entries_objects {
  require tiaa-orawls::jms_module_foreign_server_objects
  notify { 'class tiaa-orawls::jms_module_foreign_server_entries_objects':} 
  tiaa-orawls::wlst_jms_yaml{'foreign_servers_objects':} 
}