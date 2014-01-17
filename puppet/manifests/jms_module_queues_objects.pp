# Class: tiaa-orawls::jms_module_queues_objects
 # Parameters:
 # arguments
 #
 class tiaa-orawls::jms_module_queues_objects {
  require tiaa-orawls::jms_module_objects_errors
  notify { 'class tiaa-orawls::jms_module_queues_objects':} 
  tiaa-orawls::wlst_jms_yaml{'queues':} 
}