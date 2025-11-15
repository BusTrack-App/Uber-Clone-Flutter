import 'package:flutter/material.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';

class CustomButton extends StatelessWidget {

  Function() onPressed;
  String text;
  Color textColor;
  EdgeInsetsGeometry margin;
  double? width;
  double height;
  IconData? iconData;
  Color iconColor;

  CustomButton({super.key, 
    required this.text,
    required this.onPressed,
    this.textColor = AppColors.backgroundDark,
    this.margin = const EdgeInsets.only(bottom: 20, left: 40, right: 40),
    this.height = 60,
    this.width,
    this.iconData,
    this.iconColor = AppColors.backgroundDark
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      // alignment: Alignment.center,
      margin: margin,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null 
            ? Icon(
              iconData, 
              color: iconColor,
              size: 30,
            ) 
            : Container(),
            SizedBox(width: iconData != null ? 7 : 0),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        )
      ),
    );
  }
}