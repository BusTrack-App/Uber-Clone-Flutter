import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_field.dart';

class DriverCarInfoContent extends StatelessWidget {

  DriverCarInfoState state;

  DriverCarInfoContent(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Column(
            children: [
              _headerProfile(context),
              Spacer(),
              _actionProfile(context, 'ACTUALIZAR DATOS', Icons.check),
              SizedBox(height: 35,)
            ],
          ),
          _cardUserInfo(context),
          // DefaultIconBack(
          //   margin: EdgeInsets.only(top: 20, left: 30),
          // )
        ],
      ),
    );
  }
 
  Widget _cardUserInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, right: 35, top: 100),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 40),
            CustomTextField(
              text: 'Marca del vehiculo', 
              icon: Icons.drive_eta, 
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              backgroundColor: Colors.grey[200]!,
              initialValue: state.brand.value,
              onChanged: (text) {
                context.read<DriverCarInfoBloc>().add(BrandChanged(brand: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.brand.error;
              },
            ),
            CustomTextField(
              text: 'Placa del vehiculo', 
              icon: Icons.car_rental, 
              backgroundColor: Colors.grey[200]!,
              initialValue: state.plate.value,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              keyboardType: TextInputType.phone,
              onChanged: (text) {
                context.read<DriverCarInfoBloc>().add(PlateChanged(plate: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.plate.error;
              },
            ),
            CustomTextField(
              text: 'Color', 
              icon: Icons.color_lens,
              initialValue: state.color.value,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              backgroundColor: Colors.grey[200]!, 
              onChanged: (text) {
                context.read<DriverCarInfoBloc>().add(ColorChanged(color: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.color.error;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionProfile(BuildContext context, String option, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (state.formKey!.currentState != null) {
          if (state.formKey!.currentState!.validate()) {
            context.read<DriverCarInfoBloc>().add(FormSubmit());
          }
        }
        else {
          context.read<DriverCarInfoBloc>().add(FormSubmit());
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: ListTile(
          title: Text(
            option,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 19, 58, 213),
                  Color.fromARGB(255, 65, 173, 255),
                ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerProfile(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 19, 58, 213),
                Color.fromARGB(255, 65, 173, 255),
          ]
        ),
      ),
      child: Text(
        'DATOS DEL VEHICULO',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 19
        ),
      ),
    );
  }
}