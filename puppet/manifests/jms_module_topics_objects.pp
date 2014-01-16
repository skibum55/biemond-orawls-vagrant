# Class: jms_module_topics_objects
# Parameters:
# arguments
#
class tiaa-orawls::jms_module_topics_objects {
  require tiaa-orawls::jms_module_queues_objects
  notify { 'class tiaa-orawls::jms_module_topics_objects':} 
  tiaa-orawls::wlst_jms_yaml{'topics':} 
}
