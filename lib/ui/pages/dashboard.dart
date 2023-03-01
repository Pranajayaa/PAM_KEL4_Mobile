import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jastip/provider/auth/auth.dart';
import 'package:jastip/provider/auth/logout.dart';
import 'package:jastip/ui/pages/Categories/categories.dart';
import 'package:jastip/ui/pages/Customer/customer.dart';
import 'package:jastip/ui/pages/Dashboard/dashboardData.dart';
import 'package:jastip/ui/pages/Profile/profile.dart';
import 'package:jastip/ui/utils/constants.dart';
import 'package:jastip/ui/widgets/alert.dart';
import 'package:jastip/ui/widgets/latest_orders.dart';
import 'package:jastip/ui/widgets/location_slider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/User/ModelUserLogin.dart';
import '../../models/string_http_exception.dart';
import '../utils/helper.dart';
import 'Jastip/jastip.dart';

class Dashboard extends StatefulWidget {
  final int index;

  const Dashboard(this.index, {Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Track active index
  int activeIndex = 0;


  final List<Widget> _pages = <Widget>[
    const DashboardData(),
    const Jastip(),
    const Categories(),
    const Customer(),
    const Profile(),
  ];

  set(){
    setState(() {
      activeIndex = widget.index;
      print(widget.index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index != null){
      set();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(activeIndex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Constants.scaffoldBackgroundColor,
        buttonBackgroundColor: Constants.primaryColor,
        items: [
          Icon(
            Ionicons.home,
            size: 30.0,
            color: activeIndex == 0 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Ionicons.bag_add,
            size: 30.0,
            color: activeIndex == 1 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Ionicons.gift,
            size: 30.0,
            color: activeIndex == 2 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Ionicons.people,
            size: 30.0,
            color: activeIndex == 3 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Ionicons.person,
            size: 30.0,
            color: activeIndex == 4 ? Colors.white : Color(0xFFC8C9CB),
          ),
        ],
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
    );
  }
}
