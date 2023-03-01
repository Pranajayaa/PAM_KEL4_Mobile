import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jastip/ui/utils/constants.dart';

class InputWidget extends StatelessWidget {
  final String? hintText;
  final IconData prefixIcon;
  final double height;
  final String topLabel;
  final bool obscureText;
  final controller;
  final number;
  final length;

  InputWidget({
    this.hintText,
    this.prefixIcon = Icons.add,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    this.controller,
    this.number,
    this.length
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.topLabel),
        SizedBox(height: 5.0),
        length == 0 || length == null
        ? Container(
            height: ScreenUtil().setHeight(height),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            keyboardType: number,
            decoration: InputDecoration(
              prefixIcon: Icon(
                this.prefixIcon,
                color: Color.fromRGBO(105, 108, 121, 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.primaryColor,
                ),
              ),
              hintText: this.hintText,
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          )
          )
        : Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child:  TextFormField(
            obscureText: obscureText,
            controller: controller,
            keyboardType: number,
            maxLines: length,
            decoration: InputDecoration(
              prefixIcon: Icon(
                this.prefixIcon,
                color: Color.fromRGBO(105, 108, 121, 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.primaryColor,
                ),
              ),
              hintText: this.hintText,
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          ),
        )

      ],
    );
  }
}
