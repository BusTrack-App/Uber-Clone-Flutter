# uber_clone

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



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



Hasta aqui todo bien
acabo de terminar el modulo 113 TODO NICE



Hay un error en la pantalla de cliente, al querer seleccionar una ubicacion mientras se mueve el mapa
I/flutter (26550): Error: PlatformException(IO_ERROR, gcaa: UNAVAILABLE, null, null)
I/flutter (26550): OnCameraIdle Error: type 'Null' is not a subtype of type 'PlacemarkData'





ERROR:

La conexion al socket IO es correcta segun el servidor ya que llega el mensaje de conexion exitosa
Pero al tratar de enviar un mensaje desde ClientMapBookingBloc no llega el mensaje al servidor
Tampoco se puede usar el listener en el Driver_client_request_bloc