import 'package:apey/constant.dart';
import 'package:apey/controller/bottomNavbar_controller.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomnavbarScreen extends StatefulWidget {
  @override
  _BottomnavbarScreenState createState() => _BottomnavbarScreenState();
}

class _BottomnavbarScreenState extends State<BottomnavbarScreen> {

  BottomNavBarController  BNcontroller=Get.put(BottomNavBarController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<BottomNavBarController>(
            init: BottomNavBarController(),
          builder:(controller){
              return controller.li[controller.currentIndex];
          }
        ),
        bottomNavigationBar: GetBuilder<BottomNavBarController>(
          init: BottomNavBarController(),
          builder: (controller) {
            return CurvedNavigationBar(
              backgroundColor: Kthirdcolor2.withOpacity(0.9),
              buttonBackgroundColor: kforhtcolor2,
              height: 70,
              color:Colors.white,
              items: <Widget>[
                Image.asset(BNcontroller.currentIndex==0?"assets/Home_iphone@3x.png":"assets/homegroup_iphone@3x.png",width: 38,),

                Image.asset(BNcontroller.currentIndex==1?"assets/homeselet_iphone@3x.png":"assets/search_iphone@3x.png",width: 38,),

                Image.asset(BNcontroller.currentIndex==2?"assets/homeadd_iphone@3x.png":"assets/add_iphone@3x_2.png",width: 38,),

                Image.asset(BNcontroller.currentIndex==3?"assets/Grouphome_iphone@3x.png":"assets/group_iphone@3x.png",width: 38,),

                Image.asset(BNcontroller.currentIndex==4?"assets/profilehome_iphone@3x.png":"assets/profile_iphone@3x.png",width: 38,),
              ],
              onTap:(index) {
                    BNcontroller.onSelected(index);
              },
            );
          }
        ),

      ),
    );

  }
}
