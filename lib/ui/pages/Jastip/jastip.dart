import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Jastip extends StatefulWidget {
  const Jastip({Key? key}) : super(key: key);

  @override
  State<Jastip> createState() => _JastipState();
}

class _JastipState extends State<Jastip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Jastip",
          style: TextStyle(
            color: Constants.scaffoldBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          ],
        ),
      ),
    );;
  }
}
