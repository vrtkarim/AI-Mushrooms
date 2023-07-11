
import 'package:aimushrooms/applargetext.dart';
import 'package:aimushrooms/apptext.dart';
import 'package:aimushrooms/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aimushrooms/adinit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class Reading extends StatefulWidget {
  
  Reading(
      {required this.doc,
      super.key});
  QueryDocumentSnapshot doc;

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  @override
  void initState() {
    Adinit.banner.dispose();
    Adinit.banner.load();
    super.initState();
  }

  final AdWidget adWidget = AdWidget(ad: Adinit.banner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: adWidget,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                    width: double.maxFinite,
                    height: 250,
                    child: widget.doc['imgurl'] != null
                        ? Image.network(
                            widget.doc['imgurl'],
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.maxFinite,
                            height: 250,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator()),
                  ),
            Container(
                    width: double.maxFinite,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(115, 27, 7, 29).withOpacity(0.3),),),
            Container(
              margin: EdgeInsets.only(left: 20,),
              child: Largetext(
                  text: widget.doc['title'] != null ? widget.doc['title'] : 'loading',
                  size: 20,
                  color: Colors.white,),
            ),
          ])),
            Positioned(
                top: 30,
                left: 15,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      icon: Icon(Icons.menu,size: 35,),
                      color: Color.fromARGB(255, 255, 255, 255),
                      
                    )
                  ],
                )),
            Positioned(
                top: 220,
                bottom: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 900,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )),
                    child: SingleChildScrollView(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15)),
                          Apptext(
                            text: widget.doc['article'] != null ? widget.doc['article'] : 'loading',
                            size: 20,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
