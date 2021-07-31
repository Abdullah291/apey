import 'package:apey/constant.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        backgroundColor: Kthirdcolor2,
        elevation: 1,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(angle: 3.1,child: Image.asset("assets/arrow_iphone@3x.png",width: 25,height: 24,color: Colors.black,)),
            ],
          ),
        ),
        title: Text(UserSingleton.userData.firstName +" " + UserSingleton.userData.lastName
        ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
        actions: [

        ],
      ),
      body: Center(
        child: Hero(
          tag: "profile_photo",
          child: Container(
              child: Container(
                height: 400,
                width: Get.width,
                child: Image.network(UserSingleton.userData.imageUrl,fit: BoxFit.cover,alignment: Alignment.topCenter,),
              )),
        ),
      ),
    );
  }
}
