import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jastip/models/category/ModelCategory.dart';
import 'package:jastip/provider/category/category.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../models/string_http_exception.dart';
import '../../utils/constants.dart';
import '../../widgets/alert.dart';


class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isLoading = false;
  TextEditingController cate = TextEditingController();
  List<ModelCategory> category = [];

  getData()async{
    setState(() {
      isLoading = true;
    });
    try{
      await Provider.of<CategoryData>(context,listen: false).getCategory();
    }on StringHttpException catch(e){
      var errorMessage = e.toString();
      sweetAlert(errorMessage, context);
    }catch(error){
      sweetAlert("Something went wrong !! \n $error", context);
    }
    setState(() {
      category = Provider.of<CategoryData>(context,listen: false).listCategory;
      isLoading = false;
    });
  }

  choiceAction(String value, name, id)async{
    if(value == "edit"){
      setState(() {
        dialog(id);
        cate.text = name;
      });
    }else if(value == "delete"){
      setState(() {
        dialogDelete(name, id);
      });
    }
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
      await Provider.of<CategoryData>(context, listen: false).deleteCategory(id);
    }on StringHttpException catch(error){
      var errorMessage = error.toString();
      sweetAlert(errorMessage, context);
    }catch(e, s){
      sweetAlert("Error \n $e!!", context);
      print(s.toString());
    }
    setState(() {
      bool? status = Provider.of<CategoryData>(context, listen: false).statDelete;
      if(status!){
        Navigator.pop(context);
        Toast.show("Data Berhasil di Hapus !", duration: Toast.lengthLong, gravity:  Toast.bottom);
        getData();
      }
      isLoading = false;
    });
  }

  dialog(String id){
    return showDialog<void>(
        context: context,
        builder: (BuildContext context){
          bool isLoading = false;

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState){

                  postData()async{
                    ToastContext().init(context);
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await Provider.of<CategoryData>(context, listen: false).postCategory(cate.text.toString(), id);
                    }on StringHttpException catch (error) {
                      var errorMessage = error.toString();
                      sweetAlert(errorMessage, context);
                    }catch (e, l) {
                      print("$l");
                      sweetAlert("Terjadi Kesalahan $l" + e.toString(), context);
                    }
                    setState(() {
                      bool? success = Provider.of<CategoryData>(context, listen: false).statPost;
                      if(success!){
                        if(id == "0"){
                          Toast.show("Data Berhasil di Tambahkan !", duration: Toast.lengthShort, gravity:  Toast.bottom);
                        }else{
                          Toast.show("Data Berhasil di Edit !", duration: Toast.lengthShort, gravity:  Toast.bottom);
                        }
                        Navigator.pop(context);
                        cate.clear();
                        getData();
                      }
                      isLoading = false;
                    });
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            width: 400,
                            child: Column(
                              children: [
                                Text(
                                  id == "0"
                                    ? "Add Categories"
                                    : "Edit Catagories",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      textStyle:  TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10, top: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          "Categories",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          )
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 60.0,
                                        child: TextField(
                                          textCapitalization: TextCapitalization.sentences,
                                          keyboardType: TextInputType.text,
                                          controller: cate,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            contentPadding: EdgeInsets.only(left: 10.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        isLoading
                                            ? const SpinKitThreeBounce(
                                                color: Colors.blueAccent,
                                                size: 20.0,
                                              )
                                            : Container(
                                          child:  TextButton(
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(
                                                  Constants.primaryColor,
                                                ),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                )
                                            ),
                                            onPressed: () {
                                              if(cate.value.text.isEmpty){
                                               sweetAlert("Lengkapi Data !", context);
                                              }else{
                                                postData();
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                  "Submit",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          child:  TextButton(
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(
                                                    Colors.grey
                                                ),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                )
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                "Cancel",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(fontSize: 14.0, color: Colors.white)
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  );
                }
            ),
          );
        }
    );
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
          "Categories",
          style: TextStyle(
            color: Constants.scaffoldBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              dialog("0");
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
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: category.isEmpty ?0 :category.length,
                    itemBuilder: ((BuildContext ctx, int index){
                      return Container(
                        margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
                        padding: const EdgeInsets.all(10),
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
                                Text(
                                  "${category[index].name}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                                PopupMenuButton(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  onSelected: (value){
                                    choiceAction(value, category[index].name, category[index].id.toString());
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      const PopupMenuItem(
                                        child: Text("Edit"),
                                        value: 'edit',
                                      ),
                                      const PopupMenuItem(
                                        child: Text("Delete"),
                                        value: 'delete',
                                      ),
                                    ];
                                  },
                                )
                              ],
                            ),

                          ],
                        ),
                      );
                    }),
                  )
          ],
        ),
      ),
    );
  }
}
