#exec { 'apt-update':
#	command => '/usr/bin/apt-get update'
#}

#package { 'mysql-server':
#	require => Exec['apt-update'],
#	ensure => installed,
#}


class twspeeds::db {
    mysqldb { "twspeeds":
        user => "twspeeds_admin",
        password => "testing_only",
    }
}


define mysqldb( $user, $password ) {
    exec { "create-${name}-db":
      unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
      command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
      require => Service["mysqld"],
    }
}



class mysql::server {
	package { "mysql-server": ensure => installed }
  	package { "mysql": ensure => installed }
	root_password => 'testing',
	include twspeeds::db

  	service { "mysqld":
    		enable => true,
    		ensure => running,
    		require => Package["mysql-server"]
  	}
}
 
