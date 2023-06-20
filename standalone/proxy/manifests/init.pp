# @summary Configuración de Nginx
# @author Carlos Colón
#
# Esta clase configura Nginx
#
# @example
#   include proxy
class proxy {
  # Verificar que el paquete Nginx esté instalado
  package { 'nginx':
    ensure => installed,
  }

  # Configuramos wordpress usando la plantilla wordpress.conf.erb
  file { '/etc/nginx/conf.d/wordpress.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('proxy/wordpress.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  # Verificar que el servicio de Nginx esté en ejecución
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/nginx/conf.d/wordpress.conf'],
  }

  # Agregar configuración permanente de SELinux
  class { 'selinux':
    mode => 'enforcing',  # Opcional: establece el modo SELinux si es necesario
  }

  # Habilitar httpd_can_network_connect en SELinux
  selboolean { 'httpd_can_network_connect':
    value      => 'on',
    persistent => true,
  }
}
