# Install the redis database server

class memcached {
  package { "memcached": ensure => "installed" }

  file { "/etc/memcached.conf":
    ensure => file,
    owner => root,
    group => root,
    source => '/vagrant/puppet/files/memcached.conf',
    mode => 755,
    subscribe => Package['memcached'],
    require => Package['memcached']
  }

  service { "memcached":
    enable => true,
    ensure => running,
    require => Package["memcached"]
  }
}
