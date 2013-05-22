# init.pp

#Habari can be found here https://github.com/habari/habari
#The system submodule here https://github.com/habari/system
#The system submodule is tagged for various deployments
#Example: v0.9
#
#The habari install zip matches the habari/system tag
#Example http://habariproject.org/dist/habari-0.9.zip
#would be a habari install for system tag v0.9

#archive
#https://github.com/smarchive/puppet-archive

#get archive habari-0.9 from http://habariproject.org/dist/habari-0.9.zip
# and expand to /var/www/html

class habari (
      $db_template_head = '',
      $version = '0.9', 
      $admin_username, 
      $admin_pass, 
      $install_path = '/var/www/html', 
      $admin_email = 'myemail@changeme.com', 
      $blog_title = 'My Habari', 
      $option_theme_name = 'wazi', 
      $option_theme_dir = 'wazi') {

   $habari_root = "${install_path}/habari-${version}"
   
   #ensure required packages are installed

   package { ['php-common', 'php-mbstring', 'php-mysql', 'php-pdo', 'php-gd']:
    ensure => installed,
    }

   #unzip is needed by archive to extract the habari install
   #It is not currently provided in the archive package
   package { 'unzip':
       ensure => installed,
   }
   
   archive { "habari-${version}":
     ensure => present,
     url    => "http://habariproject.org/dist/habari-${version}.zip",
     extension => 'zip',
     digest_url => "http://habariproject.org/dist/habari-${version}.md5",
     src_target => '/tmp',
     target => $install_path,
   }
   
   #Create directory to store user files, like silo images.
   #and is readable for testing.
   file {"${habari_root}/user/files":
         ensure => directory,
         mode   => 0755,
   }
   
   #Ensure the cache folder is correct to match production
   #and is readable for testing
   file {"${habari_root}/user/cache":
         ensure => directory,
         mode   => 0755,
   }
   
   file {"${habari_root}/config.php":
         ensure => file,
         content => join([$db_template_head, template('habari/config.php.erb')], ''),
   }

   #Make sure that puppet installs habari in order
   Package['unzip'] -> Archive["habari-${version}"] -> File["${habari_root}/user/files"] -> File["${habari_root}/user/cache"] -> File["${habari_root}/config.php"]
   #Package['unzip'] -> Archive["habari-${version}"] -> File["${habari_root}/user/files"] -> File["${habari_root}/user/cache"]
}
