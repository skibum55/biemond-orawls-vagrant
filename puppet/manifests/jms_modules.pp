# Class: tiaa-orawls::jms_modules
 # Parameters:
 # arguments
 #
 class tiaa-orawls::jms_modules {
  require tiaa-orawls::jms_saf_agents
  notify { 'class tiaa-orawls::jms_modules':} 
  tiaa-orawls::wlst_jms_yaml{'modules':} 
}
