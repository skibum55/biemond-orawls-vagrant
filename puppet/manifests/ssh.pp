# Class: tiaa-orawls::ssh
 # Parameters:
 # arguments
 #
 class tiaa-orawls::ssh {
  require tiaa-orawls::os

  notice 'class tiaa-orawls::ssh'

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
    source  => "ssh/id_rsa.pub",
    require => File["ser_dvapp-ssh-dir"],
  }
  
  file { "/home/ser_dvapp/.ssh/id_rsa":
    ensure  => present,
    owner   => "ser_dvapp",
    group   => "dba",
    mode    => "600",
    source  => "ssh/id_rsa",
    require => File["ser_dvapp-ssh-dir"],
  }
  
  file { "/home/ser_dvapp/.ssh/authorized_keys":
    ensure  => present,
    owner   => "ser_dvapp",
    group   => "dba",
    mode    => "644",
    source  => "ssh/id_rsa.pub",
    require => File["ser_dvapp-ssh-dir"],
  }        
}