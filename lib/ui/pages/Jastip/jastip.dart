import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jastip/models/Jastip/ModelJastip.dart';
import 'package:jastip/provider/jastip/jastip.dart';
import 'package:provider/provider.dart';

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
                    padding: EdgeInsets.only(top: 30),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: jast.isEmpty ?0 :jast.length,
                    itemBuilder: ((BuildContext ctx, int index){
                      return Container(
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name : ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(
                                      "${jast[index].name}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                PopupMenuButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  onSelected: (value){

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
                            SizedBox(height: 20),
                          ],
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
