import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jastip/provider/url_api.dart';
import 'package:provider/provider.dart';

import '../../../models/Jastip/ModelJastip.dart';
import '../../../models/string_http_exception.dart';
import '../../../provider/jastip/jastip.dart';
import '../../utils/constants.dart';
import '../../widgets/alert.dart';
import '../dashboard.dart';


class DetailJastip extends StatefulWidget {
  final String id;
  const DetailJastip(this.id, {Key? key}) : super(key: key);

  @override
  State<DetailJastip> createState() => _DetailJastipState();
}

class _DetailJastipState extends State<DetailJastip> {
  bool isLoading = false;
  List<ModelJastip> jast = [];
  List<String> img = [];

  getData()async{
    setState(() {
      isLoading = true;
    });
    try{
      await Provider.of<JastipData>(context,listen: false).getJastipById(widget.id);
    }on StringHttpException catch(e){
      var errorMessage = e.toString();
      sweetAlert(errorMessage, context);
    }catch(error){
      sweetAlert("Something went wrong !! \n $error", context);
    }
    setState(() {
      jast = Provider.of<JastipData>(context,listen: false).listJastip;
      for(int a=0; a < jast[0].personalShopperImages!.length; a++){
        img.add(jast[0].personalShopperImages![a].name!);
      }

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
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: Container(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [

                        isLoading
                            ? Container()
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                                items: img.map((fileImage) {
                                  print(fileImage);
                                  return Container(
                                    margin: const EdgeInsets.all(0),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          "http://www.pam-kel4.my.id/$fileImage" ,
                                          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null ?
                                                loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  height: 200,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                )),
                            Container(
                              padding: EdgeInsets.only(right: 20, left: 20, top: 50, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${jast[0].name}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold
                                    )
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${jast[0].description}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 13.0,
                                    )
                                  ),
                                  SizedBox(height: 40),
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                            "Provider Name",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                            ": ${jast[0].providerName}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                            "Stock",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                            ": ${jast[0].stock}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                            "Temporary Stock",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                            ": ${jast[0].temporaryStock}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                            "WA Admin",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                            ": ${jast[0].waAdmin}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                            "Category",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                            ": ${jast[0].category!.name}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            )
                                        ),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, left: 20),
                          child: GestureDetector(
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Constants.primaryColor,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Constants.scaffoldBackgroundColor,
                                ),
                              ),
                              onTap: (){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return Dashboard(1);
                                        }));
                              }
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: ()async{
          Navigator.pushReplacement(context,
              MaterialPageRoute(
                  builder: (context) {
                    return Dashboard(1);
                  }));
          return true;
        }
    );
  }
}
