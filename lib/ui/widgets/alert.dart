import 'package:flutter/cupertino.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

void sweetAlert(String message, BuildContext context){
  SweetAlertV2.show(
    context,
    subtitle: message,
    subtitleTextAlign: TextAlign.center,
    style: SweetAlertV2Style.confirm,
  );
}