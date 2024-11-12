#!/bin/bash

# Definir colores
GREEN='\033[32m'
RESET='\033[0m'

# Función para mostrar el banner usando figlet
banner() {
    # Verificar si 'figlet' está instalado, si no, instalarlo
    if ! command -v figlet &> /dev/null
    then
        echo -e "${GREEN}Instalando figlet...\033[0m"
        pkg install figlet -y
    fi

    # Mostrar banner con figlet
    figlet -c "The Termux Syndicate"
    echo -e "${GREEN}by red365${RESET}"
    echo ""
}

# Función para verificar si un puerto está en uso
verificar_puerto() {
    puerto=$1
    if lsof -i :$puerto > /dev/null; then
        return 1  # El puerto está en uso
    else
        return 0  # El puerto está libre
    fi
}

# Función para encontrar un puerto libre
encontrar_puerto_libre() {
    puerto=$1
    while ! verificar_puerto $puerto; do
        puerto=$((puerto + 1))
    done
    echo $puerto
}

# Función para iniciar el servidor web
iniciar_servidor() {
    # Verificar si Python está instalado
    if ! command -v python3 &> /dev/null
    then
        echo -e "${GREEN}Python no está instalado. Instalando Python...\033[0m"
        pkg update && pkg upgrade -y
        pkg install python -y
    fi

    # Crear un directorio para el servidor web dentro de LocalhHostSyndicate (si no existe)
    mkdir -p ~/LocalhHostSyndicate/web

    # Verificar si el archivo index.html existe en la nueva ruta
    if [ ! -f ~/LocalhHostSyndicate/web/index.html ]; then
        echo -e "${GREEN}index.html no encontrado. Creando un archivo básico...\033[0m"
        echo "<!DOCTYPE html><html><head><title>Mi Página Local</title></head><body><h1>Bienvenido a mi servidor local</h1></body></html>" > ~/LocalhHostSyndicate/web/index.html
    fi

    # Selección de plantilla
    echo -e "${GREEN}Selecciona una plantilla de las siguientes:\033[0m"
    select plantilla in $(ls ~/LocalhHostSyndicate/web); do
        if [[ -n "$plantilla" ]]; then
            cp ~/LocalhHostSyndicate/web/$plantilla ~/LocalhHostSyndicate/web/index.html
            echo -e "${GREEN}Plantilla seleccionada: $plantilla\033[0m"
            break
        else
            echo -e "${GREEN}Opción inválida. Intenta nuevamente.\033[0m"
        fi
    done

    # Solicitar el puerto
    read -p "Introduce el puerto para el servidor (default 8080): " puerto
    puerto=${puerto:-8080}

    # Encontrar un puerto libre
    puerto_libre=$(encontrar_puerto_libre $puerto)
    echo -e "${GREEN}Iniciando el servidor web en http://localhost:$puerto_libre\033[0m"
    
    # Iniciar el servidor web y guardar el PID del proceso
    python3 -m http.server $puerto_libre --directory ~/LocalhHostSyndicate/web &
    echo $! > ~/servidor_pid.txt  # Guardamos el PID del servidor en un archivo
}

# Función para ver el contenido del directorio
ver_contenido() {
    echo -e "${GREEN}Contenido del directorio ~/LocalhHostSyndicate/web:\033[0m"
    ls -l ~/LocalhHostSyndicate/web
}

# Función para ver puertos en uso sin necesidad de ser root
ver_puertos_en_uso() {
    echo -e "${GREEN}Puertos actualmente en uso:\033[0m"
    ss -tuln
}

# Función para liberar puertos
liberar_puertos() {
    echo -e "${GREEN}Introduce el puerto que deseas liberar:\033[0m"
    read puerto
    # Verificar si el puerto está en uso
    if lsof -i :$puerto > /dev/null; then
        echo -e "${GREEN}Liberando el puerto $puerto...\033[0m"
        # Matar el proceso que está usando el puerto
        sudo fuser -k $puerto/tcp
        echo -e "${GREEN}Puerto $puerto liberado.\033[0m"
    else
        echo -e "${GREEN}El puerto $puerto no está en uso.\033[0m"
    fi
}

# Función para mostrar instrucciones
instrucciones() {
    echo -e "${GREEN}Instrucciones de uso:\033[0m"
    echo "1. Iniciar servidor web: Selecciona esta opción para iniciar el servidor HTTP en el puerto deseado."
    echo "2. Ver contenido del directorio ~/LocalhHostSyndicate/web: Muestra los archivos disponibles en la carpeta del servidor."
    echo "3. Ver puertos en uso: Muestra una lista de los puertos que están siendo utilizados en el sistema."
    echo "4. Liberar puertos: Permite liberar puertos ocupados por otros procesos."
    echo "5. Salir: Cierra el script."
    echo ""
}

# Función para mostrar el menú
mostrar_menu() {
    clear
    banner
    echo -e "${GREEN}==================== MENU ===================="
    echo "1. Iniciar servidor web"
    echo "2. Ver contenido del directorio ~/LocalhHostSyndicate/web"
    echo "3. Ver puertos en uso"
    echo "4. Liberar puerto"
    echo "5. Instrucciones"
    echo "6. Salir"
    echo "==============================================="
    echo -e "${RESET}"  # Resetear color
}

# Bucle principal del menú
while true; do
    mostrar_menu
    read -p "Elige una opción (1-6): " opcion

    case $opcion in
        1)
            iniciar_servidor
            break
            ;;
        2)
            ver_contenido
            read -p "Presiona Enter para continuar..."
            ;;
        3)
            ver_puertos_en_uso
            read -p "Presiona Enter para continuar..."
            ;;
        4)
            liberar_puertos
            read -p "Presiona Enter para continuar..."
            ;;
        5)
            instrucciones
            read -p "Presiona Enter para continuar..."
            ;;
        6)
            echo -e "${GREEN}Saliendo...\033[0m"
            break
            ;;
        *)
            echo -e "${GREEN}Opción inválida. Por favor, elige una opción entre 1 y 6.\033[0m"
            ;;
    esac
done
