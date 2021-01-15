# Set up GPG keys and sources for Debian repos

class apt::setup {

  package {[
      "debian-archive-keyring",
      "apt-transport-https",
      "ca-certificates"
    ]:
    ensure => latest,
    #before => File["/etc/apt/sources.list"],
    require => Exec["apt-get pre sources update"]
  }

  exec { "apt-get pre sources update":
    command => "/usr/bin/apt-get update"
  }

  #file { "/etc/apt/sources.list":
  #  ensure => file,
  #  owner => root,
  #  group => root,
  #  source => "/vagrant/puppet/files/sources.list",
  #}

  #file { "/etc/apt/debian-ai-key.asc":
  #  owner  => root,
  #  group  => root,
  #  mode   => 0600,
  #  source => "/vagrant/puppet/files/debian-ai-key.asc",
  #  ensure => present,
  #  require => File["/etc/apt/sources.list"]
  #}

  #exec { "import-debian-ai-key":
  #  command => "/usr/bin/apt-key add /etc/apt/debian-ai-key.asc",
  #  subscribe => File["/etc/apt/debian-ai-key.asc"],
  #  refreshonly => true
  #}

  #exec { "import-phusion-passenger-key":
  #  command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7",
  #  subscribe => File["/etc/apt/sources.list"],
  #  refreshonly => true
  #}
}
