# Default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

class development {

  # Make puppet and vagrant shut up about the puppet group
  #group { "puppet":
  #  ensure => "present",
  #}

  # Set FQDN for virtualbox
  if $virtual == "virtualbox" and $fqdn == '' {
    $fqdn = "localhost"
  }

  # Add SSH keys
  #file { "/home/vagrant/.ssh":
  #  ensure => directory,
  #  recurse => true,
  #  owner => vagrant,
  #  group => vagrant,
  #  source => '/vagrant/puppet/files/ssh_keys',
  #  mode => 600
  #}

  # Add bash profile with some useful defaults
  #file { "/home/vagrant":
  #  ensure => directory,
  #  recurse => true,
  #  owner => ubuntu,
  #  group => ubuntu,
  #  source => '/vagrant/puppet/files/bash_profiles',
  #}

  # Install useful default packages
  $packages = ["dnsutils", "curl", "libcurl4-openssl-dev", "git", "vim", "postfix", "libxml2", "libxml2-dev", "libxslt1-dev", "ruby-dev", "g++", "libsasl2-dev", "build-essential", "uuid-dev", "whois", "libfontconfig1", "libgmp-dev", "libpcre3-dev", "telnet", "ruby-railties", "bundler", "libapache2-mod-passenger", "libssl-dev", "libxrender1", "mailutils", "qtchooser", "qt5-default", "libqt5webkit5-dev"]

  package { $packages:
    ensure  => present,
    require => Exec["apt-get update"]
  }
}

include apt
include development
include mysql

include apache
include memcached
