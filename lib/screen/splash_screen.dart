import 'dart:async';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/screen/bottomNavBar_screen.dart';
import 'package:apey/screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


getCurrentUsers() {

  User user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    print(user.email);
    Collection.signUp.doc(user.email).get().then((d) {
      if (d.data != null){
        UserSingleton.userData.firstName = d.data()["name"];
        UserSingleton.userData.lastName = d.data()["surName"];
        UserSingleton.userData.userEmail = d.data()["email"];
        UserSingleton.userData.userId = d.data()["UserID"];
        UserSingleton.userData.dob = d.data()["dob"];
        UserSingleton.userData.imageUrl = d.data()["Image"];
        UserSingleton.userData.interest = d.data()["interest"];
      } else {
        print("Nope");
        // setState(() {
        //   // AppRoutes.makeFirst(context, SignUp());
        // });
      }
    }).then((e) {
      print("user data get");
      print(UserSingleton.userData.interest);
      Get.offAll(BottomnavbarScreen(), transition: Transition.leftToRightWithFade);
    });
  } else {
    print("user not exist");
    Get.offAll(LoginScreen(), transition: Transition.leftToRightWithFade);
  }
}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 3), getCurrentUsers);
  }

  @override
  void initState() {
    loadData();
   super.initState();
 }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset("assets/Splash.png",fit: BoxFit.fill,),
        ),
      ),
    );
  }
}
