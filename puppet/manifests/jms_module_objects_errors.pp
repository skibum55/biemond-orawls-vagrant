# Class: tiaa-orawls::jms_module_objects_errors
 # Parameters:
 # arguments
 #
 class  tiaa-orawls::jms_module_objects_errors{
  require tiaa-orawls::jms_module_cfs
  notify { 'class tiaa-orawls::jms_module_objects_errors':} 
  tiaa-orawls::wlst_jms_yaml{'error_queues':} 
}
