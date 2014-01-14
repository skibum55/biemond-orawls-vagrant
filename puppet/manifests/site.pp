# test
#
# cluster setup with weblogic 10.36
# needs jdk7, orawls, orautils, fiddyspence-sysctl, erwbgy-limits puppet modules
#

node 'admin' {
  
  include os, ssh, java, wget, getfiles
  include orawls::weblogic, orautils
  include domains, nodemanager, startwls, userconfig
  include machines
  include managed_servers
  include clusters
  include jms_servers
  include jms_saf_agents
  include jms_modules
  include jms_module_subdeployments
  include jms_module_quotas
  include jms_module_cfs
  include jms_module_objects_errors
  include jms_module_queues_objects
  include jms_module_topics_objects
  include jms_module_foreign_server_objects,jms_module_foreign_server_entries_objects
  include pack_domain

  Class['os'] -> Class['getfiles'] -> Class['java'] -> Class['orawls::weblogic'] 
}

class getfiles {

  notify { 'getfiles from google': }
  
  file { ["/data","/data/install"]:
       ensure => "directory",
  }

  
  wget::fetch { "download jdk":
       source      => 'https://googledrive.com/host/0B8QvzyOq8dtQN2lWaXFTWGtKdkE',
       destination => '/vagrant/jdk-7u45-linux-x64.tar.gz',
       timeout     => 0,
       nocheckcertificate => true,
       verbose     => false,
    }
    
    wget::fetch { "download weblogic install":
       source      => 'https://googledrive.com/host/0B8QvzyOq8dtQMlBFU1ZiWXM3ejg',
       destination => '/vagrant/wls1036_generic.jar',
       timeout     => 0,
       nocheckcertificate => true,
       verbose     => false,
    }
}

# operating settings for Middleware
class os {

  notice "class os ${operatingsystem}"

  host{"node1":
    ip => "10.10.100.100",
    host_aliases => ['node1.example.com','node1'],
  }

  host{"node2":
    ip => "10.10.100.200",
    host_aliases => ['node2.example.com','node2'],
  }

  service { iptables:
        enable    => false,
        ensure    => false,
        hasstatus => true,
  }
# turn off firewall - UFW

#  exec { firewall_shutdown:
#        command => '/usr/sbin/ufw disable',
#        user => root,
#  }

  group { 'dba' :
    ensure => present,
  }

  # http://raftaman.net/?p=1311 for generating password
  # password = oracle
  user { 'ser_dvapp' :
    ensure     => present,
    groups     => 'dba',
    shell      => '/bin/bash',
    password   => '$1$DSJ51vh6$4XzzwyIOk6Bi/54kglGk3.',
    home       => "/home/ser_dvapp",
    comment    => 'ser_dvapp user created by Puppet',
    managehome => true,
    require    => Group['dba'],
  }

  $install = [ 'binutils','unzip']


  package { $install:
    ensure  => present,
  }

  class { 'limits':
    config => {
               '*'       => {  'nofile'  => { soft => '2048'   , hard => '8192',   },},
               'wls'     => {  'nofile'  => { soft => '65536'  , hard => '65536',  },
                               'nproc'   => { soft => '2048'   , hard => '16384',   },
                               'memlock' => { soft => '1048576', hard => '1048576',},
                               'stack'   => { soft => '10240'  ,},},
               },
    use_hiera => false,
  }

  sysctl { 'kernel.msgmnb':                 ensure => 'present', permanent => 'yes', value => '65536',}
  sysctl { 'kernel.msgmax':                 ensure => 'present', permanent => 'yes', value => '65536',}
  sysctl { 'kernel.shmmax':                 ensure => 'present', permanent => 'yes', value => '2588483584',}
  sysctl { 'kernel.shmall':                 ensure => 'present', permanent => 'yes', value => '2097152',}
  sysctl { 'fs.file-max':                   ensure => 'present', permanent => 'yes', value => '6815744',}
  sysctl { 'net.ipv4.tcp_keepalive_time':   ensure => 'present', permanent => 'yes', value => '1800',}
  sysctl { 'net.ipv4.tcp_keepalive_intvl':  ensure => 'present', permanent => 'yes', value => '30',}
  sysctl { 'net.ipv4.tcp_keepalive_probes': ensure => 'present', permanent => 'yes', value => '5',}
  sysctl { 'net.ipv4.tcp_fin_timeout':      ensure => 'present', permanent => 'yes', value => '30',}
  sysctl { 'kernel.shmmni':                 ensure => 'present', permanent => 'yes', value => '4096', }
  sysctl { 'fs.aio-max-nr':                 ensure => 'present', permanent => 'yes', value => '1048576',}
  sysctl { 'kernel.sem':                    ensure => 'present', permanent => 'yes', value => '250 32000 100 128',}
  sysctl { 'net.ipv4.ip_local_port_range':  ensure => 'present', permanent => 'yes', value => '9000 65500',}
  sysctl { 'net.core.rmem_default':         ensure => 'present', permanent => 'yes', value => '262144',}
  sysctl { 'net.core.rmem_max':             ensure => 'present', permanent => 'yes', value => '4194304', }
  sysctl { 'net.core.wmem_default':         ensure => 'present', permanent => 'yes', value => '262144',}
  sysctl { 'net.core.wmem_max':             ensure => 'present', permanent => 'yes', value => '1048576',}

}

class ssh {
  require os

  notice 'class ssh'

  file { "/home/ser_dvapp/.ssh/":
    owner  => "ser_dvapp",
    group  => "dba",
    mode   => "700",
    ensure => "directory",
    alias  => "ser_dvapp-ssh-dir",
  }
  
  file { "/home/ser_dvapp/.ssh/id_rsa.pub":
    ensure  => present,
    owner   => "ser_dvapp",
    group   => "dba",
    mode    => "644",
    source  => "/vagrant/ssh/id_rsa.pub",
    require => File["ser_dvapp-ssh-dir"],
  }
  
  file { "/home/ser_dvapp/.ssh/id_rsa":
    ensure  => present,
    owner   => "ser_dvapp",
    group   => "dba",
    mode    => "600",
    source  => "/vagrant/ssh/id_rsa",
    require => File["ser_dvapp-ssh-dir"],
  }
  
  file { "/home/ser_dvapp/.ssh/authorized_keys":
    ensure  => present,
    owner   => "ser_dvapp",
    group   => "dba",
    mode    => "644",
    source  => "/vagrant/ssh/id_rsa.pub",
    require => File["ser_dvapp-ssh-dir"],
  }        
}

class java {
  require os

  notice 'class java'

  $remove = [ "java-1.7.0-openjdk.x86_64", "java-1.6.0-openjdk.x86_64" ]

  package { $remove:
    ensure  => absent,
  }

  include jdk7

  jdk7::install7{ 'jdk1.7.0_45':
      version              => "7u45" , 
      fullVersion          => "jdk1.7.0_45",
      alternativesPriority => 18000, 
      x64                  => true,
      downloadDir          => "/data/install",
      urandomJavaFix       => true,
      sourcePath           => "/vagrant",
  }

}

class bsu{
  require orawls::weblogic

  notice 'class bsu'
  $default_params = {}
  $bsu_instances = hiera('bsu_instances', {})
  create_resources('orawls::bsu',$bsu_instances, $default_params)
}

class domains{
  require orawls::weblogic

  notice 'class domains'
  $default_params = {}
  $domain_instances = hiera('domain_instances', {})
  create_resources('orawls::domain',$domain_instances, $default_params)
}

class nodemanager {
  require orawls::weblogic, domains

  notify { 'class nodemanager':} 
  $default_params = {}
  $nodemanager_instances = hiera('nodemanager_instances', {})
  create_resources('orawls::nodemanager',$nodemanager_instances, $default_params)
}

class startwls {
  require orawls::weblogic, domains,nodemanager


  notify { 'class startwls':} 
  $default_params = {}
  $control_instances = hiera('control_instances', {})
  create_resources('orawls::control',$control_instances, $default_params)
}

class userconfig{
  require orawls::weblogic, domains, nodemanager, startwls 

  notify { 'class userconfig':} 
  $default_params = {}
  $userconfig_instances = hiera('userconfig_instances', {})
  create_resources('orawls::storeuserconfig',$userconfig_instances, $default_params)
} 

class machines{
  require userconfig

  notify { 'class machines':} 
  $default_params = {}
  $machines_instances = hiera('machines_instances', {})
  create_resources('orawls::wlstexec',$machines_instances, $default_params)
}


define wlst_yaml()
{
  $type            = $title
  $apps            = hiera('weblogic_apps')
  $apps_config_dir = hiera('apps_config_dir')

  $apps.each |$app| { 
    $allHieraEntriesYaml = loadyaml("/vagrant/${apps_config_dir}/${app}/${type}/${app}_${type}.yaml")
    if $allHieraEntriesYaml != undef {
      if $allHieraEntriesYaml["${type}_instances"] != undef {
        orawls::utils::wlstbulk{ "${type}_instances_${app}":
          entries_array => $allHieraEntriesYaml["${type}_instances"],
        }
      }  
    }
  }  
}

class managed_servers{
  require machines
  notify { 'class managed_servers':} 
  wlst_yaml{'servers':} 
}

class clusters{
  require managed_servers
  notify { 'class clusters':} 
  wlst_yaml{'clusters':} 
}

define wlst_jms_yaml()
{
  $type            = $title
  $apps            = hiera('weblogic_apps')
  $apps_config_dir = hiera('apps_config_dir')

  $apps.each |$app| { 
    $allHieraEntriesYaml = loadyaml("/vagrant/${apps_config_dir}/${app}/jms/${type}/${app}_${type}.yaml")
    if $allHieraEntriesYaml != undef {
      if $allHieraEntriesYaml["${type}_instances"] != undef {
        orawls::utils::wlstbulk{ "jms_${type}_instances_${app}":
          entries_array => $allHieraEntriesYaml["${type}_instances"],
        }
      }  
    }
  }  
}

class jms_servers{
  require clusters
  notify { 'class jms_servers':} 
  wlst_jms_yaml{'servers':} 
}

class jms_saf_agents{
  require jms_servers
  notify { 'class jms_saf_agents':} 
  wlst_jms_yaml{'saf_agents':} 
}

class jms_modules{
  require jms_saf_agents
  notify { 'class jms_modules':} 
  wlst_jms_yaml{'modules':} 
}

class jms_module_subdeployments{
  require jms_modules
  notify { 'class jms_module_subdeployments':} 
  wlst_jms_yaml{'subdeployments':} 
}

class jms_module_quotas{
  require jms_module_subdeployments
  notify { 'class jms_module_quotas':} 
  wlst_jms_yaml{'quotas':} 
}

class jms_module_cfs{
  require jms_module_quotas
  notify { 'class jms_module_cfs':} 
  wlst_jms_yaml{'cf':} 
}

class jms_module_objects_errors{
  require jms_module_cfs
  notify { 'class jms_module_objects_errors':} 
  wlst_jms_yaml{'error_queues':} 
}

class jms_module_queues_objects{
  require jms_module_objects_errors
  notify { 'class jms_module_queues_objects':} 
  wlst_jms_yaml{'queues':} 
}

class jms_module_topics_objects{
  require jms_module_queues_objects
  notify { 'class jms_module_topics_objects':} 
  wlst_jms_yaml{'topics':} 
}


class jms_module_foreign_server_objects{
  require jms_module_topics_objects
  notify { 'class jms_module_foreign_server_objects':} 
  wlst_jms_yaml{'foreign_servers':} 
}

class jms_module_foreign_server_entries_objects{
  require jms_module_foreign_server_objects
  notify { 'class jms_module_foreign_server_entries_objects':} 
  wlst_jms_yaml{'foreign_servers_objects':} 
}

class pack_domain{
  require jms_module_foreign_server_entries_objects

  notify { 'class pack_domain':} 
  $default_params = {}
  $pack_domain_instances = hiera('pack_domain_instances', $default_params)
  create_resources('orawls::packdomain',$pack_domain_instances, $default_params)
}

