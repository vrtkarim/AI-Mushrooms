import 'package:aimushrooms/applargetext.dart';
import 'package:aimushrooms/apptext.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class About extends StatefulWidget {
  About({required this.type, super.key});
  String type;

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  var data;
  
  void initState() {
     getdata(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    if (data != null)
      return Container(
        child: Stack(
          children: [
            Positioned(
                top: 330,
                child: Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: Row(children: [
                    Icon(Icons.error_outline),
                    Largetext(
                      text: 'About',
                      size: 15,
                    )
                  ]),
                )),
            Positioned(
                top: 360,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          width: double.maxFinite,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: data.data()['imgurl'] != null
                                ? Image.network(
                                    data.data()['imgurl'],
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: double.maxFinite,
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator()),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5, top: 15),
                          child: Apptext(
                            text: data.data()['article'] != null
                                ? data.data()['article']
                                : 'Loading',
                            size: 20,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      );
    else
    return Container(
        child: Stack(children: [
      Positioned(
          top: 330,
          child: Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Row(children: [
              Icon(Icons.error_outline),
              Largetext(
                text: 'About',
                size: 15,
              )
            ]),
          )),
      Positioned(
          top: 360,
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          ))
    ]));
  }

  getdata(type) async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('infos').doc(type).get();
    print(variable);
    data = variable;
  }
}
