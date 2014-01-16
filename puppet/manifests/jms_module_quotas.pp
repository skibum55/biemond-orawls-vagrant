# Class: tiaa-orawls::jms_module_quotas
 # Parameters:
 # arguments
 #
 class  tiaa-orawls::jms_module_quotas {
  require tiaa-orawls::jms_module_subdeployments
  notify { 'class tiaa-orawls::jms_module_quotas':} 
  tiaa-orawls::wlst_jms_yaml{'quotas':} 
}
