import 'package:flutter/material.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/driver_client_request_item.dart';

class CustomTextFielOutlined extends StatelessWidget {

  String text;
  Function(String text) onChanged;
  IconData icon;
  EdgeInsetsGeometry margin;
  String? Function(String?)? validator;

  CustomTextFielOutlined({super.key, 
    required this.text,
    required this.icon,
    required this.onChanged,
    this.margin = const EdgeInsets.only(top: 25, left: 20, right: 20),
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: margin,
      decoration: BoxDecoration(
        // color: Color.fromRGBO(255, 255, 255, 0.2),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(15),
        //   bottomRight: Radius.circular(15),
        // )
      ),
      child: TextFormField(
        onChanged: (text) {
          onChanged(text);
        },
        validator: validator,
        decoration: InputDecoration(
          label: Text(
            text,
            style: TextStyle(
              color: AppColors.backgroundDark
            ),
          ),
          
          // border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.yellow,
              width: 2
            )
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.backgroundDark,
              width: 2
            )
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(top: 10),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.black,
                )
              ],
            ),
          )
        ),
        
      ),
    );
  }
}