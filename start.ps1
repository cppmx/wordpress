while ($true) {
    Clear-Host
    Write-Host "Iniciar Wordpress"
    Write-Host
    Write-Host "1. Lanzar Wordpress usando un servidor Puppet"
    Write-Host "2. Lanzar Wordpress usando sin un servidor Puppet"
    Write-Host "3. Salir"
    Write-Host
    $option = Read-Host "Selecciona una opción: "
    Write-Host

    switch ($option) {
        "1" {
            Set-Location -Path "server"
            vagrant up
            break
        }
        "2" {
            Set-Location -Path "standalone"
            vagrant up
            break
        }
        "3" {
            exit 0
        }
        default {
            Write-Host "Opción inválida. Por favor, selecciona una opción válida."
            Read-Host -Prompt "Presiona Enter para continuar..."
        }
    }
}
