import 'dart:io';
import 'package:aimushrooms/about.dart';
import 'package:aimushrooms/applargetext.dart';
import 'package:aimushrooms/apptext.dart';
import 'package:aimushrooms/database.dart';
import 'package:aimushrooms/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:aimushrooms/adinit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var x;

class Scanning extends StatefulWidget {
  const Scanning({super.key});

  @override
  State<Scanning> createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  final String InterstitialAdUnitId = 'ca-app-pub-1082671244415442/4200809049';
  var image;
  String result = '';
  String name = '';
  void initState() {
    Adinit.banner.dispose();
    Adinit.banner.load();
    super.initState();
    loadmodel();

    //x.dispose();
  }

  final AdWidget adWidget = AdWidget(ad: Adinit.banner);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(height: 50, child: adWidget),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Row(
                    children: [
                      //Align(alignment: Alignment.centerLeft,),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        icon: Icon(
                          Icons.keyboard_return_rounded,
                          size: 35,
                        ),
                        color: const Color.fromARGB(255, 0, 0, 0),
                      )
                    ],
                  )),
              Positioned(
                  top: 15,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  getImage(source: ImageSource.camera);
                                },
                                icon: Icon(Icons.camera_alt),
                                label: Largetext(
                                  text: 'Camera',
                                  size: 18,
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(150, 50),
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  onPrimary: Colors.black,
                                  //elevation: 10,
                                  side:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    getImage(source: ImageSource.gallery);
                                    //classify(image);
                                  },
                                  icon: Icon(Icons.image_search),
                                  label: Largetext(
                                    text: 'Gallery',
                                    size: 18,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(150, 50),
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    onPrimary: Colors.black,
                                    //elevation: 10,
                                    side: BorderSide(
                                        color: Colors.black, width: 1),
                                  ))
                            ]),
                        if (image!=null)
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 200,
                                child: ClipRRect(
                                  child: Image(image: FileImage(image)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_florist_outlined,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  Largetext(
                                    text: 'Species:  ',
                                    size: 20,
                                    color: Color.fromARGB(255, 165, 161, 171),
                                  ),
                                  Largetext(
                                    text: result.toString(),
                                    size: 20,
                                    color: Color.fromARGB(255, 0, 242, 24),
                                  )
                                ],
                              )
                            ],
                          )
                      ],
                    ),
                  )),
              if (result != '')
                About(
                  type: result,
                )
            ],
          ),
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        image = File(file!.path);
        classify(image);
      });
    }
  }

  loadmodel() async {
    await Tflite.loadModel(model: 'tf/model.tflite', labels: 'tf/labels.txt');
  }

  classify(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      if (output != null) {
        result = output[0]['label'];
      }
    });
  }
}
