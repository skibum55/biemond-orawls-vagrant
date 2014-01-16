# Define: tiaa-orawls::wlst_jms_yaml
 # Parameters:
 # arguments
 #
 define tiaa-orawls::wlst_jms_yaml()
{
  $type            = $title
  $apps            = hiera('weblogic_apps')
  $apps_config_dir = hiera('apps_config_dir')

  $apps.each |$app| { 
    $allHieraEntriesYaml = loadyaml("puppet://modules/tiaa-orawls/${apps_config_dir}/${app}/jms/${type}/${app}_${type}.yaml")
    if $allHieraEntriesYaml != undef {
      if $allHieraEntriesYaml["${type}_instances"] != undef {
        orawls::utils::wlstbulk{ "jms_${type}_instances_${app}":
          entries_array => $allHieraEntriesYaml["${type}_instances"],
        }
      }  
    }
  }  
}

