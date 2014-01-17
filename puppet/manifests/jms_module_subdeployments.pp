# Class: tiaa-orawls::jms_module_subdeployments
 # Parameters:
 # arguments
 #
 class  tiaa-orawls::jms_module_subdeployments {
  require tiaa-orawls::jms_modules
  notify { 'class tiaa-orawls::jms_module_subdeployments':} 
  tiaa-orawls::wlst_jms_yaml{'subdeployments':} 
}
