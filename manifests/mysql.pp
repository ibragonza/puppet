define mysqldb_db( $db_name ) {
    exec { "create-${name}-db":
      command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${db_name};\"",
      require => Service["mysql"],
    }
}

define mysqldb_user( $user, $password ) {
    exec { "create-$user":
      unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
      command => "/usr/bin/mysql -uroot -p$mysql_password -e \"grant all on ${name}.* to ${user}@localhost identified by '${password}';\"",
      require => Service["mysql"],
    }
}

class twspeeds::db {
    mysqldb_db { "twspeeds" : 
      db_name => "Test DB",
    }
    mysqldb_user { "twspeeds":
      user => "twspeeds_admin",
      password => "testing_only",
    }


}


class xxx {
    package { "mysql-server": ensure => installed }
    package { "mysql": ensure => installed }
    service { "mysql":
      enable => true,
      ensure => running,
      require => Package["mysql-server"]

    }

    include twspeeds::db

}
 
class { 'xxx':}
