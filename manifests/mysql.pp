exec { 'apt-update':
	command => '/usr/bin/apt-get update'
}

package { 'mysql-server':
	require => Exec['apt-update'],
	ensure => installed,
}



class { '::mysql::server':
    root_password    => 'testing_pass',
    override_options => {
        'mysqld' => {
            'max_connections'   => '1024',
            'key_buffer_size'   => '512M'       
        }       
    }   
}
 
