import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jastip/provider/category/category.dart';
import 'package:jastip/provider/customer/customer.dart';
import 'package:jastip/provider/jastip/jastip.dart';
import 'package:jastip/ui/pages/Customer/input_customer.dart';
import 'package:jastip/ui/pages/Jastip/input_jastip.dart';
import 'package:jastip/ui/pages/dashboard.dart';
import 'package:jastip/ui/pages/home.dart';
import 'package:jastip/ui/pages/login.dart';
import 'package:jastip/ui/pages/single_order.dart';
import 'package:jastip/ui/register.dart';
import 'package:jastip/ui/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:jastip/provider/auth/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Customers(),
        ),
        ChangeNotifierProvider.value(
          value: CategoryData(),
        ),
        ChangeNotifierProvider.value(
          value: JastipData(),
        )
      ],
      child: Consumer(
        builder: (BuildContext context, value, child){
          return ScreenUtilInit(
              designSize: Size(375, 812),
              builder: (context, child){
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Flutter Laundry UI",
                  theme: ThemeData(
                    primaryColor: Constants.primaryColor,
                    scaffoldBackgroundColor: Constants.scaffoldBackgroundColor,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: GoogleFonts.poppinsTextTheme(),
                  ),
                  initialRoute: "/",
                  onGenerateRoute: _onGenerateRoute,
                );
              }
          );
        },
      ),
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      });
    case "/login":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
    case "/register":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Register();
      });
    case "/dashboard":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Dashboard(1);
      });
    case "/single-order":
      return MaterialPageRoute(builder: (BuildContext context) {
        return SingleOrder();
      });
    case "/input-customer":
      return MaterialPageRoute(builder: (BuildContext context) {
        return InputCustomer("0");
      });
    case "/input-jastip":
      return MaterialPageRoute(builder: (BuildContext context) {
        return InputJastip("0");
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      });
  }
}
