import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_event.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_state.dart';

class ClientDriverOffersScreen extends StatefulWidget {
  const ClientDriverOffersScreen({super.key});

  @override
  State<ClientDriverOffersScreen> createState() =>
      _ClientDriverOffersScreenState();
}

class _ClientDriverOffersScreenState extends State<ClientDriverOffersScreen> {
  int? idClientRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (idClientRequest != null) {
        context.read<ClientDriverOffersBloc>().add(ListenNewDriverOfferSocketIO(idClientRequest: idClientRequest!));
      }  
    });
  }

  @override
  Widget build(BuildContext context) {
    idClientRequest = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: BlocListener<ClientDriverOffersBloc, ClientDriverOffersState>(
        listener: (context, state) {
          final response = state.responseDriverOffers;
          if (response is ErrorData) {
            Fluttertoast.showToast(
              msg: response.message,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: BlocBuilder<ClientDriverOffersBloc, ClientDriverOffersState>(
          builder: (context, state) {
            final response = state.responseDriverOffers;
            if (response is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (response is Success) {
              List<DriverTripRequest> driverTripRequest =
                  response.data as List<DriverTripRequest>;
              return ListView.builder(
                itemCount: driverTripRequest.length,
                itemBuilder: (context, index) {
                  return Text(driverTripRequest[index].id.toString());
                },
              );
            } else {
              return Center(child: Text('Error'));
            }
          },
        ),
      ),
    );
  }
}
