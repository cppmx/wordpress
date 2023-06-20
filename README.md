# Wordpress (Vagrant + Puppet)

Este proyecto es para una tarea de la Maestría en Desarrollo y Operaciones de UNIR.

El Objetivo es desplegar Wondpress usando Vagrant y Puppet.

En este proyecto estoy usando dos formas de despliegue; usando un servidor Puppet y usando el agente de puppet en modo standalone.

Para ambios modos, estoy usando tres VMs:
    1. Una VM con MySQL
    2. Una VM con Apache y Wordpress
    3. Una VM con Nginx

En al versión del servidor Puppet, se agrega una VM más que tendrá el puppet-server, y las otras tres máquinas virtuales se conectan a ella para descargar sus configuraciones.

## Supuestos

- Se espera que la red de las VMs sea 192.168.56.0/256. Si VirtualBox tiene otro rango de red entonces hay que ajustar los archivos Vagrantfile para ajustar las Ips de las VMs.
- La Box que yo estoy usando es `generic/centos8`, si requieres alguna otra Box que no esté basada en Red Hat entonces hay que hacer algunos ajustes en los módulos.
  Por ejemplo, para CentOS yo considero que SELinux está activado y que el firewall se controla con `Firewalld`. Algunas otras distribuciones como Ubuntu no usan SELinux, y en lugar de `Firewalld` usan `iptables`. Toma esto en consideración si decides usar otra Box que no esté basada en Red Hat.

## Pre-requisitos

- Necesitas tener instalado Git
- Necesitas tener instalado Vagrant
- Necesitas tener instalado VirtualBox

## Uso

1. Colna este repositorio

```bash
git clone git@github.com:cppmx/wordpress.git
```

2. Lanza el modo que deseas probar

2.1 Si quieres usar el modo con el servidor Puppet

```bash
cd server
Vagrant up
```

2.2 Si quieres usar el modo sin el servidor Puppet

```bash
cd standalone
Vagrant up
```

3. Alternativamente puedes usar el script start que se adecue a tu sistema:

3.1 Si estás en Linux o Mac usa:

```bash
./start
```

3.2 Si estás en Windows, abre una ventana PowerShell en modo administardor y ejecuta:

```PowerShell
start.ps1
```

## Wordpress

Una vez que se hayan levantado todas las VMs podrás acceder a Wordpress en la página: http://localhos:1800/
