# Class: tiaa-orawls::jms_module_foreign_server_objects
 # Parameters:
 # arguments
 #
class tiaa-orawls::jms_module_foreign_server_objects{
  require tiaa-orawls::jms_module_topics_objects
  notify { 'class tiaa-orawls::jms_module_foreign_server_objects':} 
  tiaa-orawls::wlst_jms_yaml{'foreign_servers':} 
}