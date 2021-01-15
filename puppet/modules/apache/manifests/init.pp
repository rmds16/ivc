class apache {
  package { "apache2":
    ensure => present
  }

  service { "apache2":
    ensure => running,
    enable => true,
    require => Package["apache2"]
  }

  file { "/etc/apache2/sites-enabled/000-default.conf":
    notify => Service['apache2'],
    ensure => present,
    source => "/vagrant/puppet/files/vhost",
    require => Package['apache2'],
    force => true
  }
}