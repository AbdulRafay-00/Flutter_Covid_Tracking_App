import 'dart:async';

import 'package:covid_19_app/Covid_World_Status.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..forward();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OverAll_Status()));

    });


  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              AnimatedBuilder(animation:_controller
                  ,

                  builder: (context, child){
                    return Transform.rotate(angle:_controller.value *2 * 3.14,
                      child:Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset("AssetsImages/virus.png"),
                      ) ,);
                  }),
              SizedBox(height: 20,),
              Text("Covid-19"),
              Text("Tracking App"),

            ],
          ),
        ),
      ),
    );
  }
}
