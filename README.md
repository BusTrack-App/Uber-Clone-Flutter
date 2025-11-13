

Clean Architecture usado en este proyecto src/presentation, src/domain, src/data

en el api_config.dart debe ponerse la url a del servidor a donde se hacen las peticiones



// Configurar la api key de Google Maps en el android manifest y en el AppDelegate.swift del ios



Para simular datos de un conductor desde postman hay que ejecutar una conexion a
192.168.1.55:9092/

y en message poner 'change_driver_position' y enviar un json asi
{
    "id": 5,         <- Id del conducor
    "lat": 4.698628,
    "lng": -74.103646
}




// NOTA DE USO
Al solicitar un viaje, en el cliente no se mostrara la ruta al inicio, se mostrara una ves la informacion de la ubicacion de conductor se actualice
Entonces se debe modificar la ubicacion del dispositivo del conductor para ver la ruta y el tiempo