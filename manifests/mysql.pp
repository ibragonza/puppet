define mysqldb( $user, $password ) {
    exec { "create-${name}-db":
      unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
      command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
      require => Service["mysql"],
    }
}


class twspeeds::db {
    mysqldb { "twspeeds":
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
