
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

abstract class DriverCarInfoEvent {}

class DriverCarInfoInitEvent extends DriverCarInfoEvent {}

class BrandChanged extends DriverCarInfoEvent {
  final BlocFormItem brand;
  BrandChanged({ required this.brand });
}

class PlateChanged extends DriverCarInfoEvent {
  final BlocFormItem plate;
  PlateChanged({ required this.plate });
}

class ColorChanged extends DriverCarInfoEvent {
  final BlocFormItem color;
  ColorChanged({ required this.color });
}

class FormSubmit extends DriverCarInfoEvent {}