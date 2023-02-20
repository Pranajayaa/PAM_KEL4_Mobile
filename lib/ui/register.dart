import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jastip/ui/pages/login.dart';
import 'package:jastip/ui/utils/constants.dart';
import 'package:jastip/ui/utils/helper.dart';
import 'package:jastip/ui/widgets/alert.dart';
import 'package:jastip/ui/widgets/app_button.dart';
import 'package:jastip/ui/widgets/input_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

import '../models/string_http_exception.dart';
import '../provider/auth/auth.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool loading = false;


  postData()async{
    setState(() {
      loading = true;
    });
    try{
      await Provider.of<Auth>(context,listen: false).register(username.text, password.text, name.text, email.text, phone.text);
    }on StringHttpException catch(e){
      var errorMessage = e.toString();
      sweetAlert(errorMessage, context);
    }catch(s){
      sweetAlert("Login Failed !! \n $s", context);
    }
    setState(() {
      loading = false;
      bool register = Provider.of<Auth>(context,listen: false).registerSucces;
      String msg = Provider.of<Auth>(context,listen: false).messageRegist;
      if(register == true){
        SweetAlertV2.show(
          context,
          subtitle: msg,
          style: SweetAlertV2Style.success,
            onPress: (bool on){
              if(on){
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: Login()
                    )
                );
              }
              return false;
            }
        );

      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0.0,
                top: -20.0,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "assets/images/washing_machine_illustration.png",
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Register",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                              !.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80.0,
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                            MediaQuery.of(context).size.height - 180.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Lets make a generic input widget
                              InputWidget(
                                topLabel: "Username",
                                prefixIcon: Icons.email_outlined,
                                hintText: "Enter your Username",
                                controller: username,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InputWidget(
                                topLabel: "Password",
                                prefixIcon: Icons.lock_outline,
                                obscureText: true,
                                controller: password,
                                hintText: "Enter your password",
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InputWidget(
                                topLabel: "Name",
                                prefixIcon: Icons.person_outlined,
                                controller: name,
                                hintText: "Enter your Name",
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InputWidget(
                                topLabel: "Email",
                                prefixIcon: Icons.alternate_email,
                                controller: email,
                                hintText: "Enter your Email",
                                number: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InputWidget(
                                topLabel: "Phone Number",
                                prefixIcon: Icons.phone_outlined,
                                controller: phone,
                                hintText: "Enter your Phonenumber",
                                number: TextInputType.phone,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              loading
                                  ? SpinKitThreeBounce(
                                  color: Constants.primaryColor,
                                  size: 30
                              )
                                  : AppButton(
                                type: ButtonType.PRIMARY,
                                text: "Register",
                                onPressed: () {
                                  if(username.text.isEmpty || password.text.isEmpty || name.text.isEmpty
                                      || email.text.isEmpty || phone.text.isEmpty){
                                    sweetAlert("Complete Your Data !", context);
                                  }else{
                                    postData();
                                  }

                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
