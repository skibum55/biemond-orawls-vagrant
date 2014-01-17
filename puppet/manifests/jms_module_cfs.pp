
# Class: tiaa-orawls::jms_module_cfs
 # Parameters:
 # arguments
 #
 # Define: name
 # Parameters:
 # arguments
 #
 class  tiaa-orawls::jms_module_cfs {
  require tiaa-orawls::jms_module_quotas
  notify { 'class tiaa-orawls::jms_module_cfs':} 
  tiaa-orawls::wlst_jms_yaml{'cf':} 
}

