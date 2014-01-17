# Class: clusters
 # Parameters:
 # arguments
 #
class tiaa-orawls::clusters{
  require tiaa-orawls::managed_servers
  notify { 'class tiaa-orawls::clusters':} 
  tiaa-orawls::wlst_yaml{'clusters':} 
}