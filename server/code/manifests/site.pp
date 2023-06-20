# @summary Script inicial para la actividad
# @author Carlos Colón
#
# Aquí se decidirá qué se debe isntalar y configurar en cada una de la VMs.
#
# @example
#   include nginx_proxy
class unir {
  include hosts

  # Para distinguir cada VM voy a usar la variable fqdn (Fully Qualified Domain Name).
  case $trusted['certname'] {
    'proxy.unir.actividad1.mx': {
      include nginx_proxy
    }
    'site.unir.actividad1.mx': {
      include apache
    }
    'db.unir.actividad1.mx': {
      include database
    }
    default: {
      fail("Error: El dominio ${facts['hostname']} no se reconoce como un dominio válido para esta configuración.")
    }
  }
}

node default {
  include unir
}
