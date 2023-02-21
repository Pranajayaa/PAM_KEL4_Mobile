import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../utils/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key,
  required this.fotoProfile,
    required this.namaUser,
    required this.noTelpon,
    required this.email,

  }) : super(key: key);

  final fotoProfile;
  final namaUser;
  final noTelpon;
  final email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 60,
              spreadRadius: 4,
              color: Color(0x1A000000),
            ),
          ],
          image: const DecorationImage(
              alignment: Alignment.centerRight,
              image: AssetImage('assets/images/illustration.png'),
              opacity: 0.03,
              fit: BoxFit.contain)),
      child: Row(
        children: [
          CircleAvatar(
              radius: 36,
              backgroundColor: Colors.grey[200],
              child: Image.asset(
                  "assets/images/dp.png",
                fit: BoxFit.cover,
              ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Wrap(
              runSpacing: 8,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        namaUser,
                        style: const TextStyle(
                            fontSize: 15, fontFamily: 'Bold', color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Ionicons.call, size: 11, color: Colors.white,),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: Text(
                        noTelpon,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Medium', color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Ionicons.mail, size: 13, color: Colors.white,),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: Text(
                        email,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Medium', color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
