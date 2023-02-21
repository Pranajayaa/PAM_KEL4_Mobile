import 'package:flutter/material.dart';

import '../../utils/constants.dart';


class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Categories",
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
    );
  }
}
