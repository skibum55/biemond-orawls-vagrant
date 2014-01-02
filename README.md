skibum55-orawls-vagrant
=======================

The reference implementation of https://github.com/biemond/biemond-orawls  
optimized for linux and the use of Hiera  

Uses CentOS 6.4 box with puppet 3.4.0 Future Parser

Creates 12.1.2 WebLogic cluster ( admin, node1, node2 )


site.pp is located here:  
https://github.com/biemond/skibum55-orawls-vagrant/blob/master/puppet/manifests/site.pp  

The used hiera files https://github.com/skibum55/biemond-orawls-vagrant/tree/master/puppet/hieradata

used the following software
- jdk-7u45-linux-x64.tar.gz

weblogic 12.1.2
- wls121200_.jar
- p16175470_121200_Generic.zip

Using the following facts

- environment => "development"
- vm_type     => "vagrant"
- env_app1    => "application_One"
- env_app2    => "application_Two"

also need to set "--parser future" (Puppet >= 3.40) to the puppet configuration, cause it uses lambda expressions for collection of yaml entries from application_One and application_Two

# admin server  
vagrant up admin

# node1  
vagrant up node1

# node2  
vagrant up node2


Detailed vagrant steps (setup) can be found here:

http://vbatik.wordpress.com/2013/10/11/weblogic-12-1-2-00-with-vagrant/

For Mac Users.  The procedure has been and run tested on Mavericks.
