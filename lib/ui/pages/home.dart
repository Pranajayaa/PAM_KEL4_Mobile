import 'package:flutter/material.dart';
import 'package:jastip/ui/pages/dashboard.dart';
import 'package:jastip/ui/utils/constants.dart';
import 'package:jastip/ui/utils/helper.dart';
import 'package:jastip/ui/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum LoginStatus{notSignIn, signIn}

class _HomeState extends State<Home> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  getPref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      String status = preferences.getString('loginStatus')!;
      _loginStatus = status == 'success'
          ? LoginStatus.signIn
          : LoginStatus.notSignIn;
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
        return Scaffold(
          backgroundColor: Constants.primaryColor,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        top: 100.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 150.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/cloth_faded.png"),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/illustration.png",
                            scale: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 24.0,
                      ),
                      decoration: BoxDecoration(
                        color: Constants.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text(
                              "Welcome to Laundree!",
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(19, 22, 33, 1),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "This is the first version of our laundry app. Please sign in or create an account below.",
                              style: TextStyle(
                                color: Color.fromRGBO(74, 77, 84, 1),
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            // Let's create a generic button widget
                            AppButton(
                              text: "Log In",
                              type: ButtonType.PLAIN,
                              onPressed: () {
                                nextScreen(context, "/login");
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            AppButton(
                              text: "Create an Account",
                              type: ButtonType.PRIMARY,
                              onPressed: (){
                                nextScreen(context, "/register");
                              },
                            )
                          ],
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        );
        break ;
      case LoginStatus.signIn :
        return Dashboard();
        break ;
    }
  }
}
