import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jastip/models/Customer/ModelCustomerDetail.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';
import 'package:toast/toast.dart';

import '../../../models/Customer/modelCustomer.dart';
import '../../../models/Jastip/ModelJastip.dart';
import '../../../models/string_http_exception.dart';
import '../../../provider/customer/customer.dart';
import '../../../provider/jastip/jastip.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../widgets/alert.dart';
import '../../widgets/app_button.dart';
import '../../widgets/input_widget.dart';
import '../dashboard.dart';


class InputCustomer extends StatefulWidget {
  final String id;
  const InputCustomer(this.id, {Key? key}) : super(key: key);

  @override
  State<InputCustomer> createState() => _InputCustomerState();
}

class _InputCustomerState extends State<InputCustomer> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  ModelCustomerDetail? customerDetail;
  bool isLoading = false;
  bool isLoading2 = false;
  String? jastipId;
  String? jastip;
  List<ModelJastip> jast = [];

  postCostumer()async{
    ToastContext().init(context);
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Customers>(context, listen: false).postCustomer(jastipId!, name.text, phone.text, email.text, widget.id);
    }on StringHttpException catch (error) {
      var errorMessage = error.toString();
      sweetAlert(errorMessage, context);
    }catch (e, l) {
      print("$l");
      sweetAlert("Terjadi Kesalahan $l" + e.toString(), context);
    }
    setState(() {
      bool? success = Provider.of<Customers>(context, listen: false).statPost;
      if(success!){
        if(widget.id == "0"){
          Toast.show("Data Berhasil di Tambahkan !", duration: Toast.lengthShort, gravity:  Toast.bottom);
        }else{
          Toast.show("Data Berhasil di Edit !", duration: Toast.lengthShort, gravity:  Toast.bottom);
        }
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(
                  builder: (context) {
                    return Dashboard(3);
                  }));
        });

      }
      isLoading = false;
    });
  }

  getData()async{
    setState(() {
      isLoading2 = true;
    });
    try{
      await Provider.of<JastipData>(context,listen: false).getJastip();
    }on StringHttpException catch(e){
      var errorMessage = e.toString();
      sweetAlert(errorMessage, context);
    }catch(error){
      sweetAlert("Something went wrong !! \n $error", context);
    }
    setState(() {
      jast = Provider.of<JastipData>(context,listen: false).listJastip;
      isLoading2 = false;
    });
  }

  getDataById()async{
    setState(() {
      isLoading = true;
    });
    try{
      customerDetail = await Provider.of<Customers>(context,listen: false).getCustomerDetail(widget.id);
    }on StringHttpException catch(e){
      var errorMessage = e.toString();
      sweetAlert(errorMessage, context);
    }catch(error){
      sweetAlert("Something went wrong !! \n $error", context);
    }
    setState(() {
      name.text = customerDetail!.results![0].name!;
      phone.text = customerDetail!.results![0].phone!;
      email.text = customerDetail!.results![0].email!;
      jastipId = customerDetail!.results![0].personalShopperId!.toString();


      isLoading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    if(widget.id != "0"){
      getDataById();
    }
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(
                    builder: (context) {
                      return Dashboard(3);
                    }));
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
            isLoading2
            ? SpinKitThreeBounce(
                color: Constants.primaryColor,
                size: 30
            )
            : Container(
              padding: EdgeInsets.only(top: 40, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Jastip"),
                  Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      child: SearchChoices.single(
                        readOnly: false,
                        isCaseSensitiveSearch: false,
                        clearIcon: Icon(Icons.clear_all),
                        hint: Text(
                            jastip == null || jastip!.isEmpty
                                ? "Jastip"
                                : jastip!
                        ),
                        value: jastip,
                        items: jast.map((item){
                          String name = item.name!;
                          String id = item.id.toString();
                          String all = "$id[]$name";
                          return DropdownMenuItem(
                            child: Text(
                                name == null
                                    ? ""
                                    : name,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.grey[600]
                                  ),
                                )
                            ),
                            value: all,
                          );
                        }).toList(),
                        onChanged: (value){
                          List a = value.split("[]");
                          setState(() {
                            jastipId = a[0];
                            jastip = a[1];
                          });
                        },
                        dialogBox: false,
                        isExpanded: true,
                        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
                      )
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: InputWidget(
                      topLabel: "Nama",
                      prefixIcon: Icons.person,
                      obscureText: false,
                      controller: name,
                      hintText: "Enter your Name",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InputWidget(
                      topLabel: "Phone",
                      prefixIcon: Icons.phone,
                      obscureText: false,
                      controller: phone,
                      number: TextInputType.number,
                      hintText: "Enter your Phone",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: InputWidget(
                      topLabel: "Email",
                      prefixIcon: Icons.email_outlined,
                      obscureText: false,
                      controller: email,
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
                         postCostumer();
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
