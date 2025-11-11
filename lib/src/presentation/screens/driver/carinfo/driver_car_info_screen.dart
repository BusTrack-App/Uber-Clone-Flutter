import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_state.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/driver_car_info_content.dart';

class DriverCarInfoScreen extends StatefulWidget {
  const DriverCarInfoScreen({super.key});

  @override
  State<DriverCarInfoScreen> createState() => _DriverCarInfoScreenState();
}

class _DriverCarInfoScreenState extends State<DriverCarInfoScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverCarInfoBloc>().add(DriverCarInfoInitEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DriverCarInfoBloc, DriverCarInfoState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          else if (response is Success) {
            Fluttertoast.showToast(msg: 'Actualizacion exitosa', toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<DriverCarInfoBloc, DriverCarInfoState>(
          builder: (context, state) {
            final response = state.response;
            if (response is Loading) {
              return Stack(
                children: [
                  DriverCarInfoContent(state),
                  Center(child: CircularProgressIndicator())
                ],
              );
            }
            return DriverCarInfoContent(state);
          },
        ),
      ),
    );
  }
}
