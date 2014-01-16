# Class: tiaa-orawls::admin
#
# cluster setup with weblogic 10.36
# needs jdk7, orawls, orautils, fiddyspence-sysctl, erwbgy-limits puppet modules
#

class tiaa-orawls::admin {
  
  include tiaa-orawls::os, tiaa-orawls::ssh, tiaa-orawls::java, wget, tiaa-orawls::getfiles
  include orawls::weblogic, orautils
  include tiaa-orawls::domains, tiaa-orawls::nodemanager, tiaa-orawls::startwls, tiaa-orawls::userconfig
  include tiaa-orawls::machines
  include tiaa-orawls::managed_servers
  include tiaa-orawls::clusters
  include tiaa-orawls::jms_servers
  include tiaa-orawls::jms_saf_agents
  include tiaa-orawls::jms_modules
  include tiaa-orawls::jms_module_subdeployments
  include tiaa-orawls::jms_module_quotas
  include tiaa-orawls::jms_module_cfs
  include tiaa-orawls::jms_module_objects_errors
  include tiaa-orawls::jms_module_queues_objects
  include tiaa-orawls::jms_module_topics_objects
  include tiaa-orawls::jms_module_foreign_server_objects,tiaa-orawls::jms_module_foreign_server_entries_objects
  include tiaa-orawls::pack_domain

  Class['tiaa-orawls::os'] -> Class['tiaa-orawls::getfiles'] -> Class['tiaa-orawls::java'] -> Class['orawls::weblogic'] 

  File {
    sourcePath =>  "puppet://modules/tiaa-orawls/"
  }
}
