# Class: tiaa-orawls::jms_saf_agents
 # Parameters:
 # arguments
 #
 class tiaa-orawls::jms_saf_agents{
  require tiaa-orawls::jms_servers
  notify { 'class tiaa-orawls::jms_saf_agents':} 
  tiaa-orawls::wlst_jms_yaml{'saf_agents':} 
}