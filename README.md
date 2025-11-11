

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




Hay un error en la pantalla de cliente, al querer seleccionar una ubicacion mientras se mueve el mapa
I/flutter (26550): Error: PlatformException(IO_ERROR, gcaa: UNAVAILABLE, null, null)
I/flutter (26550): OnCameraIdle Error: type 'Null' is not a subtype of type 'PlacemarkData'

