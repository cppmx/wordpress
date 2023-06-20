# @summary Configuración de la tabla de hosts
# @author Carlos Colón
#
# Esta clase configura la tabla de hosts de las VMs.
#
# @example
#   include hosts
class hosts {
  # Definimos las IPs que usa localhost
  $localhosts_ips = ['127.0.0.1', '::1']

  # Creamos las entradas que tendrá el archivo hosts
  $entries = {
    'localhost.localdomain' => '127.0.0.1',
    'centos8.localdomain' => '127.0.0.1',
    'db.unir.actividad1.mx' => '192.168.56.10',
    'site.unir.actividad1.mx' => '192.168.56.20',
    'proxy.unir.actividad1.mx' => '192.168.56.30',
  }

  # El contenido del archivo de hosts será definido en la plantilla hosts.erb
  file { '/etc/hosts':
    ensure  => present,
    content => template('hosts/hosts.erb'),
  }
}
