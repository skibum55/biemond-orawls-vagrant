# Class: tiaa-orawls::managed_servers
 # Parameters:
 # arguments
 #
 class tiaa-orawls::managed_servers {
  require tiaa-orawls::machines
  notify { 'class tiaa-orawls::managed_servers':} 
  tiaa-orawls::wlst_yaml{'servers':} 
}