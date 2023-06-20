# @summary Configuración de la tabla de hosts
# @author Carlos Colón
#
# Esta clase configura la tabla de hosts de las VMs.
#
# @example
#   include hosts
class hosts {
  # Creamos las entradas que tendrá el archivo hosts
  $entries = {
    'db.unir.actividad1.mx' => '192.168.56.10',
    'site.unir.actividad1.mx' => '192.168.56.20',
    'proxy.unir.actividad1.mx' => '192.168.56.30',
  }

  # El contenido del archivo de hosts será definido en la plantilla hosts.erb
  file { '/etc/hosts':
    ensure  => present,
    content => template('hosts/hosts.erb'),
    replace => true,
  }
}
