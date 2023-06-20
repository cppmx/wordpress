# @summary Instalación y configuración de MySQL
# @author Carlos Colón
#
# Esta clase instala y configura la base de datos MySQL
#
# @example
#   include database
class database {
  # Instalar el servidor MySQL
  package { 'mysql-server':
    ensure => installed,
  }

  # Verificar que el servicio de MySQL esté en ejecución
  service { 'mysqld':
    ensure => running,
    enable => true,
  }

  # Agregamos el usuario wordpress
  mysql_user { 'wordpress@192.168.56.20':
    ensure        => 'present',
    password_hash => mysql::password('testP@55word'),
  }

  # Agregamos una base de datos para wordpress
  mysql_database { 'wordpress':
    ensure => 'present',
  }

  # Asignamos privilegios al usuario en la base de datos
  mysql_grant { 'wordpress@192.168.56.20/wordpress.*':
    ensure     => 'present',
    user       => 'wordpress@192.168.56.20',
    table      => 'wordpress.*',
    privileges => ['ALL'],
    require    => Mysql_database['wordpress'],
  }

  # Abrir el puerto 3306 en la zona pública
  firewalld_port { 'Open port 3306 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 3306,
    protocol => 'tcp',
    notify   => Service['firewalld'],
  }

  # Verificar que el firewall esté en ejecución
  service { 'firewalld':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}

node default {
  include hosts
  include database
}
