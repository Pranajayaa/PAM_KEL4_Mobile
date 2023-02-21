import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jastip/ui/widgets/profileCard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/User/ModelUserLogin.dart';
import '../../../models/string_http_exception.dart';
import '../../../provider/auth/auth.dart';
import '../../../provider/auth/logout.dart';
import '../../utils/constants.dart';
import '../../widgets/alert.dart';
import '../../widgets/selectionProfile.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        builder: (builder){
          return Wrap(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)
                      )
                  ),
                  child:  Container(
                    padding:const EdgeInsets.only(bottom: 40, right: 10, left: 10, top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Logout ?",
                            style: TextStyle(
                                fontFamily: 'PoppinsMedium',
                                fontSize: 16,
                                color: Color(0xFF424242))
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: const Size(120, 25),
                                backgroundColor: Constants.primaryColor,
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 14, left: 40, right: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: ()async{
                                Logout();
                              },
                              child: const Text(
                                "Oke!",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemibold',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size(120, 25),
                                backgroundColor: Colors.grey,
                                padding: const EdgeInsets.only(
                                    top: 14, bottom: 14, left: 40, right: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemibold',
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              )
            ],
          );
        }
    );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50, bottom: 20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
           Padding(
             padding: EdgeInsets.only(right: 10, left: 10),
             child:  Column(
               children: [
                 isLoading
                     ? const ProfileCard(
                     fotoProfile: "",
                     namaUser: " ",
                     noTelpon: " ",
                     email: " "
                 )
                     : ProfileCard(
                   fotoProfile: "",
                   namaUser: user  == null
                       ? ""
                       : user!.data!.name,
                   noTelpon: user  == null || user!.data!.phone == null
                       ? ""
                       : user!.data!.phone,
                   email: user  == null
                       ? ""
                       : user!.data!.email,
                 ),
               ],
             )
           ),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20, top: 30),
              child: Column(
                children: [
                  SelectionProfile(
                      icon: const Icon(
                        Ionicons.person,
                        size: 18,
                        color: Colors.grey,
                      ),
                      text: 'Edit Profile',
                      logic: (){}
                  ),
                  SizedBox(height: 10),
                  SelectionProfile(
                      icon: const Icon(
                        Ionicons.lock_closed,
                        size: 18,
                        color: Colors.grey,
                      ),
                      text: 'Change Password',
                      logic: (){}
                  ),
                  SizedBox(height: 55),
                  Container(
                    height: 65,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.red[100]
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )
                              )
                          ),
                          onPressed: () {
                            _modalBottomSheetMenu();
                          },
                          child: Text(
                            "Logout",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                                textStyle: TextStyle(fontSize: 14.0, color: Colors.red)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
