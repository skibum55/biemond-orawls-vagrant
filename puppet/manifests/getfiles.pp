# Define: tiaa-orawls::getfiles 
 # Parameters:
 # arguments
 #
 define tiaa-orawls::getfiles (){

  notify { 'getfiles from google': }
  
  file { ["/data","/data/install"]:
       ensure => "directory",
  }

  
  wget::fetch { "download jdk":
       source      => 'https://googledrive.com/host/0B8QvzyOq8dtQN2lWaXFTWGtKdkE',
       destination => '/etc/puppetlabs/puppet/modules/tiaa-orawls/files/jdk-7u45-linux-x64.tar.gz',
       timeout     => 0,
       nocheckcertificate => true,
       verbose     => false,
    }
    
    wget::fetch { "download weblogic install":
       source      => 'https://googledrive.com/host/0B8QvzyOq8dtQMlBFU1ZiWXM3ejg',
       destination => '/etc/puppetlabs/puppet/modules/tiaa-orawls/files/wls1036_generic.jar',
       timeout     => 0,
       nocheckcertificate => true,
       verbose     => false,
    }
}