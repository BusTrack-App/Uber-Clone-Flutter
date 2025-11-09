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
acabo de terminar el modulo 112