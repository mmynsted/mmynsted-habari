#mysql 

class habari::mysql (
   $root_password,
   $schema,
   $user,
   $password,
   $host,
   $prefix) {
      include mysql
      
      #mysql::server
      #Installs mysql-server packages, configures my.cnf and starts mysqld service:
      #Database login information stored in /root/.my.cnf.
      class { 'mysql::server':
        config_hash => { 'root_password' => $root_password }
      }
      
      #mysql::db
      #
      #Creates a database with a user and assign some privileges.
      mysql::db { "$schema":
        user     => $user,
        password => $password,
        host     => $host,
        grant    => ['all'],
      }
   
   #populate the db part of the config.php file by template
   $template_head = template("habari/mysql_head.php.erb")
}
