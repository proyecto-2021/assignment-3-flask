# Descripción de la tarea

Desarrollar un servidor en Python y Flask que implemente la siguiente especificación de API Rest:

https://documenter.getpostman.com/view/7711154/U16jP6kH

El proyecto deberá realizarse de manera individual. Fecha límite de entrega: 20/9

# Convenciones que su app debe cumplir para pasar los tests:

## Dependencias 

Debe tener instalados todos los paquetes listados en el archivo requirements.txt.

## Ejecución de la aplicación

El arnés de test levanta automáticamente su aplicación antes de ejecutar los tests. Para permitir esto, la aplicación principal deberá estar contenida en un archivo llamado `app.py` en el directorio raíz, y debe poder ejecutarse con el comando `./run.sh` (ver el script provisto). La aplicación debe correr en la URL `http://127.0.0.1:4000`.

## Finalización de la aplicación

Para que el arnés de test pueda terminar la aplicación luego de ejecutarse, debe incluir el siguiente código en `app.py` para exponer la URL `/shutdown` que permita bajar el servidor.

```
def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()


@app.route('/shutdown', methods=['POST'])
def shutdown():
    shutdown_server()
    return 'Server shutting down...'
```

El arnés de test hará un post en `/shutdown` al finalizar la ejecución de los mismos.

## Ejecución del arnés de test

*Importante*: ¡Cargar el ambiente virtual donde se hayan instalado todos los paquetes antes de ejecutar los tests!

Ejecute el comando `./run-tests.sh`. Obtendrá un reporte similar al siguiente:

```
==============================================================================
Test Assignment 3                                                             
==============================================================================
Scenario: Create a new assignment                                     | PASS |
------------------------------------------------------------------------------
Scenario: Try to create an existing assignment                        | PASS |
------------------------------------------------------------------------------
Scenario: Delete an existing assignment                               | PASS |
------------------------------------------------------------------------------
Scenario: Try to delete a non existing assignment                     | PASS |
------------------------------------------------------------------------------
Scenario: Update an existing assignment                               | PASS |
------------------------------------------------------------------------------
Scenario: Try to update a non existing assignment                     | PASS |
------------------------------------------------------------------------------
Test Assignment 3                                                     | PASS |
6 tests, 6 passed, 0 failed
==============================================================================
```

El reporte indica la cantidad de tests ejecutados y que pasaron exitosamente. Para aprobar el trabajo todos los tests deben ser exitosos.
