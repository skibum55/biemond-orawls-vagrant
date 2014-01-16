# test
#
# one machine setup with weblogic 12.1.2
# creates an WLS Domain with JAX-WS (advanced, soap over jms)
# needs jdk7, orawls, orautils, fiddyspence-sysctl, erwbgy-limits puppet modules
#

class tiaa-orawls::node {
  
  include tiaa-orawls::os, tiaa-orawls::ssh, tiaa-orawls::java, orawls::weblogic
  include tiaa-orawls::orautils, tiaa-orawls::copydomain, tiaa-orawls::nodemanager, wget, tiaa-orawls::getfiles

  Class['tiaa-orawls::java'] -> Class['orawls::weblogic'] 
}



