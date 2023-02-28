import 'dart:io';

import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jastip/models/category/ModelCategory.dart';
import 'package:jastip/provider/category/category.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';

import '../../../models/string_http_exception.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../widgets/alert.dart';
import '../../widgets/app_button.dart';
import '../../widgets/input_widget.dart';


class InputJastip extends StatefulWidget {
  const InputJastip({Key? key}) : super(key: key);

  @override
  State<InputJastip> createState() => _InputJastipState();
}

class _InputJastipState extends State<InputJastip> {
  TextEditingController providerName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController temporaryStock = TextEditingController();
  TextEditingController wa = TextEditingController();
  bool isLoading = false;
  List<ModelCategory> cate = [];
  List<XFile> imageFileList = [];
  String? categoryId;
  String? category;
  final ImagePicker imagePicker = ImagePicker();

  void selectImages() async {
    final List<XFile> selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList.length.toString());
    setState((){});
  }

  getData()async{
    setState(() {
      isLoading = true;
    });
    try{
      await Provider.of<Category>(context,listen: false).getCategory();
    }on StringHttpException catch(e){
      var errorMessage = e.toString();
      sweetAlert(errorMessage, context);
    }catch(error){
      sweetAlert("Something went wrong !! \n $error", context);
    }
    setState(() {
      cate = Provider.of<Category>(context,listen: false).listCategory;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
          "Add Jastip",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select Category"),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            child: SearchChoices.single(
                              readOnly: false,
                              isCaseSensitiveSearch: false,
                              clearIcon: Icon(Icons.clear_all),
                              hint: Text(
                                  category == null || category!.isEmpty
                                      ? "Category"
                                      : category!
                              ),
                              value: category,
                              items: cate.map((item){
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
                                  categoryId = a[0];
                                  category = a[1];
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InputWidget(
                      topLabel: "Provider Name",
                      prefixIcon: Icons.person,
                      obscureText: true,
                      controller: providerName,
                      hintText: "Enter your Provider Name",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InputWidget(
                      topLabel: "Name Item",
                      prefixIcon: Icons.card_travel,
                      obscureText: true,
                      controller: name,
                      hintText: "Enter your Name Item",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InputWidget(
                      topLabel: "Description",
                      prefixIcon: Icons.format_align_center,
                      obscureText: true,
                      controller: desc,
                      hintText: "Enter Description",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( bottom: 10),
                    child: InputWidget(
                      topLabel: "Stock",
                      prefixIcon: Icons.shopping_bag,
                      obscureText: true,
                      controller: stock,
                      hintText: "Enter Stock",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InputWidget(
                      topLabel: "Temporary Stock",
                      prefixIcon: Icons.shopping_bag,
                      obscureText: true,
                      controller: temporaryStock,
                      hintText: "Enter Temporary Stock",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InputWidget(
                      topLabel: "Wa Admin",
                      prefixIcon: Icons.phone,
                      obscureText: true,
                      controller: wa,
                      hintText: "Enter Wa Admin",
                      number: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Add Image"),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: DottedBorder(
                                color: const Color(0xFFAFAFAF),
                                strokeWidth: 1,
                                dashPattern: const [8, 4],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(12),
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(15)),
                                  child: Stack(children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(top: 0),
                                        child: IconButton(
                                            iconSize: 30,
                                            icon: const Icon(
                                              Icons.add,
                                              color: Color(0xFFAFAFAF),
                                            ),
                                            onPressed: () => selectImages()),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 90,
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 10),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: imageFileList.length,
                                itemBuilder: (BuildContext ctx, int index){
                                  return Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Stack(children: [
                                      Badge(
                                        showBadge: true,
                                        badgeStyle: BadgeStyle(
                                          padding: const EdgeInsets.all(6),
                                          badgeColor: Colors.red,
                                          elevation: 0,
                                        ),
                                        badgeContent: GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              imageFileList.removeAt(index);
                                            });
                                          },
                                          child: const Icon(
                                              Icons.delete,
                                              size: 14,
                                              color: Colors.black),
                                        ),
                                        child: SizedBox(
                                          width: 75,
                                          height: 75,
                                          child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              child: Image.file(File(imageFileList[index].path),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      )
                                    ]),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ],
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
                      if(name.text.isEmpty || providerName.text.isEmpty || desc.text.isEmpty
                      || stock.text.isEmpty || temporaryStock.text.isEmpty || wa.text.isEmpty  ){
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
