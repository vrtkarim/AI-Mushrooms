import 'package:aimushrooms/applargetext.dart';
import 'package:aimushrooms/apptext.dart';
import 'package:aimushrooms/reading.dart';
import 'package:aimushrooms/scanning.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:aimushrooms/adinit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference datac =
      FirebaseFirestore.instance.collection('blogs');
  void initState() {
    super.initState();
    Adinit.banner.dispose();
    Adinit.banner.load();
  }

  final AdWidget adWidget = AdWidget(ad: Adinit.banner);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(height: 50, child: adWidget),
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Scanning()));
              },
              icon: Icon(Icons.camera_alt),
              label: Largetext(
                text: 'Identify',
                color: Colors.white,
                size: 18,
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 50),
                backgroundColor: Color.fromARGB(255, 254, 82, 122),
                onPrimary: Colors.white,
                //elevation: 10,
                side: BorderSide(
                    color: const Color.fromARGB(255, 251, 251, 251), width: 1),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Icon(Icons.chrome_reader_mode),
                SizedBox(
                  width: 3,
                ),
                Largetext(
                  text: 'Articles',
                  size: 15,
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('blogs')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                    if (streamsnapshot.hasData) {
                      return Container(
                        child: GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: (1 / 0.3)),
                          children: streamsnapshot.data!.docs
                              .map((note) => Listv(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Reading(doc: note)));
                                  }, note))
                              .toList(),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          )
        ]),
      ),
    );
  }
}

Widget Listv(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      //margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(right: 10, left: 10),
      height: 160,
      width: 300,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: Image.network(
              doc['imgurl'],
              fit: BoxFit.cover,
              width: BouncingScrollSimulation.maxSpringTransferVelocity,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Color.fromARGB(115, 43, 41, 41).withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            margin: EdgeInsets.only(right: 5, left: 5),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Largetext(
                  text: doc['title'],
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
