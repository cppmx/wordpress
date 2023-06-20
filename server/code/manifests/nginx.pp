# @summary Configuración del proxy usnado Nginx
# @author Carlos Colón
#
# Esta clase configura el proxy del proyecto
#
# @example
#   include nginx_proxy
class nginx_proxy {
  # Abrir el puerto 8080 en la zona pública
  firewalld_port { 'Open port 8080 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 8080,
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

  include proxy
}
