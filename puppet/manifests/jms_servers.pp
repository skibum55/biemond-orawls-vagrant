# Class: tiaa-orawls::jms_servers
 # Parameters:
 # arguments
 #
 class tiaa-orawls::jms_servers {
  require tiaa-orawls::clusters
  notify { 'class tiaa-orawls::jms_servers':} 
  tiaa-orawls::wlst_jms_yaml{'servers':} 
}