# Make sure the packages are up to date before beginning

class apt::update {

  exec { "apt-get update":
    command => "/usr/bin/apt-get update"
  }
}
