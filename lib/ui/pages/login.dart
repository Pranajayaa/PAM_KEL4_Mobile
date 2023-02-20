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
                                      "Log in to your account",
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
                                        height: 25.0,
                                      ),
                                      InputWidget(
                                        topLabel: "Password",
                                        prefixIcon: Icons.lock_outline,
                                        obscureText: true,
                                        controller: password,
                                        hintText: "Enter your password",
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onWillPop: ()async{
              nextScreen(context, "/home");
              return true;
            }
        );
        break;
      case LoginStatus.signIn:
        return Dashboard();
      break;
    }
  }
}

