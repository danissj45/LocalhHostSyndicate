## **LocalhHostSyndicate**
**Repositorio para montar una página web en el localhost**

Aquí tienes las instrucciones de uso para el archivo **servidor.sh** que se encuentra en tu repositorio de GitHub:

### **Instrucciones de Uso: servidor.sh**

1. **Clonar el Repositorio desde GitHub**
   Para comenzar, primero debes clonar el repositorio que contiene el script `servidor.sh` y la carpeta `web`:

   ```bash
   git clone https://github.com/danissj45/LocalhHostSyndicate.git
   ```

   Esto descargará el repositorio en tu directorio actual. Dentro de la carpeta del repositorio, encontrarás el archivo `servidor.sh` y la carpeta `web`.

2. **Acceder al Directorio del Repositorio**
   Una vez clonado el repositorio, navega hasta el directorio donde se encuentra el script:

   ```bash
   cd LocalhHostSyndicate
   ```

3. **Dar Permisos de Ejecución al Script**
   Antes de poder ejecutar el script, necesitas otorgarle permisos de ejecución:

   ```bash
   chmod +x servidor.sh
   ```

4. **Instalar Paquetes Necesarios**
   El script requiere algunos paquetes para poder mostrar puertos en uso y liberar puertos. Instálalos ejecutando los siguientes comandos:

   ```bash
   pkg install net-tools      # Para netstat
   pkg install iproute2        # Para ss
   pkg install lsof            # Para lsof
   ```

   Esto instalará las herramientas necesarias para que el script funcione correctamente.

5. **Ejecutar el Script**
   Para iniciar el script, usa el siguiente comando:

   ```bash
   ./servidor.sh
   ```

   Esto ejecutará el menú interactivo del servidor web en tu terminal.

6. **Menú Interactivo**
   El script presenta un menú interactivo con las siguientes opciones:

   1. **Iniciar servidor web**: Esta opción inicia un servidor HTTP local utilizando Python. Puedes seleccionar el puerto en el que quieres que el servidor se ejecute (por defecto, usa el puerto 8080).
   2. **Ver contenido del directorio ~/LocalhHostSyndicate/web**: Muestra todos los archivos que se encuentran dentro de la carpeta `web`.
   3. **Ver puertos en uso**: Muestra los puertos TCP y UDP que están en uso en tu sistema.
   4. **Liberar puerto**: Permite liberar un puerto en uso, eliminando el proceso que lo está ocupando.
   5. **Detener servicio**: Detiene el servidor web que se está ejecutando.
   6. **Instrucciones**: Muestra este documento de instrucciones.
   7. **Salir**: Cierra el script.

7. **Seleccionar Plantilla Web**
   El script busca un archivo `index.html` dentro de la carpeta `web`. Si no lo encuentra, crea uno básico. Durante la ejecución del script, se te pedirá que selecciones una plantilla de las disponibles en la carpeta `web` para utilizarla como la página principal de tu servidor web local.

8. **Requisitos del Sistema**
   - **Termux**: El script está diseñado para ser ejecutado en Termux, una terminal para Android.
   - **Python**: Se necesita tener Python 3 instalado en tu dispositivo. Si no lo tienes, el script te pedirá que lo instales automáticamente.
   - **figlet**: Para mostrar el banner en el inicio, se usa el comando `figlet`. Si no tienes `figlet` instalado, el script también se encargará de instalarlo automáticamente.

9. **Liberar Puertos**
   En el caso de que un puerto esté ocupado y necesites liberarlo para tu servidor, puedes usar la opción de **"Liberar puerto"** del menú. Se te pedirá que ingreses el número del puerto y el script eliminará el proceso que lo esté usando.

10. **Acceder a la Página Web**
   Una vez que el servidor esté en marcha, puedes acceder a la página web desde un navegador utilizando la dirección `http://localhost:PUERTO`, donde `PUERTO` es el número del puerto que seleccionaste o el que se asignó automáticamente.

   **Ejemplo**: Si el servidor está corriendo en el puerto 8080, puedes acceder a la página con:

   ```bash
   http://localhost:8080
   ```

11. **Salir del Script**
   Para salir del script, simplemente selecciona la opción **7** "Salir" del menú.

### **Nota Adicional:**
Si deseas cambiar la plantilla web, solo debes agregar más archivos `.html` dentro de la carpeta `web`. El script te permitirá elegir una nueva plantilla al iniciar el servidor.

---

Estas son las instrucciones completas para usar el script `servidor.sh`. ¡Espero que te sea útil para montar tu servidor web local de manera sencilla!

--- 

Estas instrucciones ahora incluyen los paquetes necesarios para la correcta ejecución del script.
