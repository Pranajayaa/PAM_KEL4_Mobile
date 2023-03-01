import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jastip/models/Jastip/ModelJastip.dart';
import 'package:jastip/provider/jastip/jastip.dart';
import 'package:jastip/ui/pages/Jastip/detailJastip.dart';
import 'package:jastip/ui/pages/Jastip/input_jastip.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../models/string_http_exception.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../widgets/alert.dart';

class Jastip extends StatefulWidget {
  const Jastip({Key? key}) : super(key: key);

  @override
  State<Jastip> createState() => _JastipState();
}

class _JastipState extends State<Jastip> {
  bool isLoading = false;
  List<ModelJastip> jast = [];

  getData()async{
    setState(() {
      isLoading = true;
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
      isLoading = false;
    });
  }

  Future dialogDelete(String name, id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Delete $name ?',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                )
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(
                    'Ok',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),
                    )
                ),
                onPressed:(){
                  deleteData(id.toString());
                },
              ),
            ],
          );
        });
  }

  deleteData(String id)async{
    ToastContext().init(context);
    setState((){
      isLoading = true;
    });
    try {
      await Provider.of<JastipData>(context, listen: false).deleteJastip(id);
    }on StringHttpException catch(error){
      var errorMessage = error.toString();
      sweetAlert(errorMessage, context);
    }catch(e, s){
      sweetAlert("Error \n $e!!", context);
      print(s.toString());
    }
    setState(() {
      bool? status = Provider.of<JastipData>(context, listen: false).statDelete;
      if(status!){
        Navigator.pop(context);
        Toast.show("Data Berhasil di Hapus !", duration: Toast.lengthLong, gravity:  Toast.bottom);
        getData();
      }
      isLoading = false;
    });
  }

  choiceAction(String value, name, id)async{
    if(value == "edit"){
      setState(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (context) {
                  return InputJastip(id.toString());
                }));
      });
    }else if(value == "delete"){
      setState(() {
        dialogDelete(name, id);
      });
    }
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getData();
  }

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
        actions: [
          GestureDetector(
              onTap: (){
                nextScreen(context, "/input-jastip");
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child:  Icon(Icons.add),
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoading
                ? Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: SpinKitThreeBounce(
                          color: Constants.primaryColor,
                          size: 30
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 30,bottom: 20),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: jast.isEmpty ?0 :jast.length,
                    itemBuilder: ((BuildContext ctx, int index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return DetailJastip(jast[index].id.toString());
                                  }));
                        },
                        child: Container(
                          margin:  EdgeInsets.only(right: 20, left: 20, top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Constants.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7,
                                  spreadRadius: 5,
                                  offset: Offset(0, 3),
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${jast[index].name}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  PopupMenuButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    onSelected: (value){
                                      choiceAction(value, jast[index].name, jast[index].id);
                                    },
                                    offset: Offset(0, 30),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("Edit"),
                                          value: 'edit',
                                        ),
                                        PopupMenuItem(
                                          child: Text("Delete"),
                                          value: 'delete',
                                        ),
                                      ];
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                jast[index].description!.length > 100
                                    ? jast[index].description!.substring(0, 100)+'...'
                                    : "${jast[index].description}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    }),
                  )
          ],
        ),
      ),
    );;
  }
}
