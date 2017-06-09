define mysqldb_db( $user, $password ) {
    exec { "create-${name}-db":
      command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${name};\"",
      require => Service["mysql"],
    }
}

define mysqldb_user( $user, $password ) {
    exec { "create-$user":
      unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
      command => "/usr/bin/mysql -uroot -p$mysql_password -e \"grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
      require => Service["mysql"],
    }
}

class twspeeds::db {
    mysqldb_db { "twspeeds":
      user => "twspeeds_admin",
      password => "testing_only",
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
