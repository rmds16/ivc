class apt {
  stage { "apt-setup":  before => Stage["apt-update"] }
  stage { "apt-update": before => Stage["main"] }

  class {
    "apt::setup":   stage => "apt-setup";
    "apt::update":  stage => "apt-update";
  }
}
