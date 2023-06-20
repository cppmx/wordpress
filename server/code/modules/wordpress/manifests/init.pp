# @summary Configuración de Wordpress
# @author Carlos Colón
#
# Esta clase configura Wordpress
#
# @example
#   include proxy
class wordpress {
  # Descargar el archivo zip de Wordpress
  exec { 'download_wordpress':
    command => '/usr/bin/curl -o /tmp/wordpress.zip https://wordpress.org/latest.zip',
    creates => '/tmp/wordpress.zip',
    require => File['/var/www/html'],
  }

  # Extraer el archivo zip de Wordpress
  archive { 'extract_wordpress':
    path         => '/tmp/wordpress.zip',
    extract      => true,
    extract_path => '/var/www/html',
    require      => Exec['download_wordpress'],
    creates      => '/var/www/html/wordpress',
  }

  # Configurar los permisos para el directorio de Wordpress
  file { '/var/www/html/wordpress':
    ensure => 'directory',
    mode   => '0755',
  }

  # Crear el archivo de configuración de Wordpress usando la plantilla wp-config.php.erb
  file { '/var/www/html/wordpress/wp-config.php':
    ensure  => present,
    content => template('wordpress/wp-config.php.erb'),
    require => Archive['extract_wordpress'],
  }

  exec { 'change_html_path':
    command => "/usr/bin/sed -i 's|/var/www/html|/var/www/html/wordpress|g' /etc/httpd/conf/httpd.conf",
    creates => '/etc/httpd/conf/httpd.conf.modified',
    require => File['/etc/httpd/conf/httpd.conf'],
    notify  => Service['httpd'],
  }
}
