# @summary Configuración del sitio apache
# @author Carlos Colón
#
# Esta clase instala apache y los módulos de php necesarios
# para ejecutar wordpress.
#
# @example
#   include httpd
class apache {
  # Instalar los paquetes de apache y php necesarios
  package { ['httpd', 'php', 'php-mysqlnd', 'php-json', 'unzip']:
    ensure => installed,
  }

  # Verificar que el directorio raíz de apache esté presente
  file { '/var/www/html':
    ensure => 'directory',
  }

  # Verificar que el directorio de configuración de sitios de apache esté presente
  file { '/etc/httpd/conf.d':
    ensure => 'directory',
  }

  file { '/etc/httpd/conf/httpd.conf':
    ensure => present,
  }

  # Verificar que el servicio httpd este en ejecución
  service { 'httpd':
    ensure => running,
    enable => true,
  }

  # Abrir el puerto 80 en la zona pública
  firewalld_port { 'Open port 80 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 80,
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

  # Agregar configuración permanente de SELinux
  class { 'selinux':
    mode => 'enforcing',
  }

  # Habilitar httpd_can_network_connect en SELinux
  selboolean { 'httpd_can_network_connect':
    value      => 'on',
    persistent => true,
  }

  include wordpress
}
