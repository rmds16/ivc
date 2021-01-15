class mysql {
  package {[
      "libmysqlclient-dev",
      "mysql-client",
      "mysql-common",
      "mysql-server"
    ]:
    ensure  => installed,
  }

  service { "mysql":
    enable  => true,
    ensure  => running,
    require => Package["mysql-server"]
  }
}
