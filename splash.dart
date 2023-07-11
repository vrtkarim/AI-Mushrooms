import 'package:aimushrooms/applargetext.dart';
import 'package:aimushrooms/apptext.dart';
import 'package:aimushrooms/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                width: 300,
                alignment: Alignment.center,
                child: Image.asset('img/icon.jpg',))),
            Positioned(
              top: 460,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: Apptext(text: 'Identify, Discover Mushrooms',color: Color.fromRGBO(203, 15, 104, 1),size: 25,)))
          ],
        ),
      ),
    );
  }
}
