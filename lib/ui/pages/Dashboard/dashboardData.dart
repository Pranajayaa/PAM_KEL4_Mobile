import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/User/ModelUserLogin.dart';
import '../../../models/string_http_exception.dart';
import '../../../provider/auth/auth.dart';
import '../../utils/constants.dart';
import '../../widgets/alert.dart';
import '../../widgets/latest_orders.dart';
import '../../widgets/location_slider.dart';


class DashboardData extends StatefulWidget {
  const DashboardData({Key? key}) : super(key: key);

  @override
  State<DashboardData> createState() => _DashboardDataState();
}

class _DashboardDataState extends State<DashboardData> {
  UserLogin? user;
  bool isLoading = false;
  int userId = 0;


  getPref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      int id = preferences.getInt('id')!;
      getData(id.toString());
    });
  }

  getData(String id)async{
    setState((){
      isLoading = true;
    });
    try {
      user = await Provider.of<Auth>(context, listen: false).users(id);
    }on StringHttpException catch(error){
      var errorMessage = error.toString();
      sweetAlert(errorMessage, context);
    }catch(e){
      sweetAlert("Error \n $e !!", context);
    }
    setState(() {
      isLoading = false;
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
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Stack(
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
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isLoading
                                ? SpinKitThreeBounce(
                                color: Colors.white,
                                size: 30
                            )
                                : RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Welcome Back,\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: user == null || user!.data == null
                                        ? ""
                                        : "${user!.data!.name} !",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )

                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){

                              },
                              child: Image.asset(
                                "assets/images/dp.png",
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 200.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Constants.scaffoldBackgroundColor,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "New Locations",
                            style: TextStyle(
                              color: Color.fromRGBO(19, 22, 33, 1),
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 7.0),
                        Container(
                          height: ScreenUtil().setHeight(100.0),
                          child: Center(
                            // lets make a widget for the cards
                            child: LocationSlider(),
                          ),
                        ),
                        LatestOrders(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
