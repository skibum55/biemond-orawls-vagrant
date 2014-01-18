# Class: tiaa-orawls::java
 # Parameters:
 # arguments
 #
 class tiaa-orawls::java {
  require tiaa-orawls::os

  notice 'class tiaa-orawls::java'

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
      sourcePath           => "puppet://modules/tiaa-orawls",
  }

 }
