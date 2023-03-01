import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jastip/ui/pages/dashboard.dart';
import 'package:jastip/ui/utils/constants.dart';
import 'package:jastip/ui/utils/helper.dart';
import 'package:jastip/ui/widgets/alert.dart';
import 'package:jastip/ui/widgets/app_button.dart';
import 'package:jastip/ui/widgets/input_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/string_http_exception.dart';
import '../../provider/auth/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

enum LoginStatus{notSignIn, signIn}

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  getPref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      String status = preferences.getString('loginStatus')!;
      _loginStatus = status == 'success'
          ? LoginStatus.signIn
          : LoginStatus.notSignIn;
    });
  }

  postLogin()async{
    setState(() {
      loading = true;
    });
    try{
      await Provider.of<Auth>(context,listen: false).authenticate(username.text, password.text);
    }on StringHttpException catch(e){
      var errorMessage = e.toString();
      sweetAlert(errorMessage, context);
    }catch(s){
      sweetAlert("Login Failed !! \n $s", context);
    }
    setState(() {
      loading = false;
      bool login = Provider.of<Auth>(context,listen: false).loginUser;
      if(login == true){
        nextScreen(context, "/dashboard");
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch(_loginStatus){
      case LoginStatus.notSignIn :
        return WillPopScope(
            child: Scaffold(
              backgroundColor: Constants.primaryColor,
              body: Container(
                child: Stack(
                  children: [
                    Positioned(
                      top: 80,
                      left: 20,
                      child: Text(
                        "Log in to your account",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                        !.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          color: Colors.white,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 40),
                          child: SingleChildScrollView(
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputWidget(
                                  topLabel: "Username",
                                  prefixIcon: Icons.email_outlined,
                                  hintText: "Enter your Username",
                                  controller: username,
                                  length: 0,
                                ),
                                SizedBox(
                                  height: 25.0,
                                ),
                                InputWidget(
                                  topLabel: "Password",
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: true,
                                  controller: password,
                                  hintText: "Enter your password",
                                  length: 0,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Constants.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
                                  text: "Log In",
                                  onPressed: () {
                                    if(username.text.isEmpty || password.text.isEmpty){
                                      sweetAlert("Complete Your Username & Password !", context);
                                    }else{
                                      postLogin();
                                    }

                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
            onWillPop: ()async{
              nextScreen(context, "/home");
              return true;
            }
        );
        break;
      case LoginStatus.signIn:
        return Dashboard(1);
      break;
    }
  }
}

