import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../models/Customer/modelCustomer.dart';
import '../../../models/string_http_exception.dart';
import '../../../provider/customer/customer.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../widgets/alert.dart';
import '../../widgets/app_button.dart';
import '../../widgets/input_widget.dart';


class InputCustomer extends StatefulWidget {
  const InputCustomer({Key? key}) : super(key: key);

  @override
  State<InputCustomer> createState() => _InputCustomerState();
}

class _InputCustomerState extends State<InputCustomer> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            nextScreen(context, "/home");
          },
        ),
        title: Text(
          "Add Customer",
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
            Container(
              padding: const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: InputWidget(
                      topLabel: "Nama",
                      prefixIcon: Icons.person,
                      obscureText: true,
                      controller: name,
                      hintText: "Enter your Name",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InputWidget(
                      topLabel: "Phone",
                      prefixIcon: Icons.phone,
                      obscureText: true,
                      controller: phone,
                      hintText: "Enter your Phone",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: InputWidget(
                      topLabel: "Email",
                      prefixIcon: Icons.email_outlined,
                      obscureText: true,
                      controller: name,
                      hintText: "Enter your Email",
                    ),
                  ),
                  isLoading
                  ? SpinKitThreeBounce(
                  color: Constants.primaryColor,
                  size: 30
              )
                  : AppButton(
                      type: ButtonType.PRIMARY,
                      text: "Submit",
                      onPressed: () {
                        if(name.text.isEmpty || email.text.isEmpty || phone.text.isEmpty){
                          sweetAlert("Complete Your Data !", context);
                        }else{
                          // postData();
                        }

                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
