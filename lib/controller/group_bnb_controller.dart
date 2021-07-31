import 'package:apey/constant.dart';
import 'package:apey/screen/group/upload_Post.dart';
import 'package:apey/screen/homeFeed_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class GroupBottomnavbarScreen extends StatefulWidget {
  final roomId;
  GroupBottomnavbarScreen({this.roomId});
  @override
  _GroupBottomnavbarScreenState createState() => _GroupBottomnavbarScreenState();
}

class _GroupBottomnavbarScreenState extends State<GroupBottomnavbarScreen> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    List li=[HomeFeedScreen(roomIds: widget.roomId,),Group_Upload_Post(roomIds:widget.roomId)];
    return SafeArea(
      child: Scaffold(
        body: li[currentIndex],
        bottomNavigationBar:  CurvedNavigationBar(
                backgroundColor: Kthirdcolor2.withOpacity(0.9),
                buttonBackgroundColor: kforhtcolor2,
                height: 70,
                color:Colors.white,
                items: <Widget>[
                  Image.asset(currentIndex==0?"assets/Home_iphone@3x.png":"assets/homegroup_iphone@3x.png",width: 38,),

                  Image.asset(currentIndex==1?"assets/homeadd_iphone@3x.png":"assets/add_iphone@3x_2.png",width: 38,),
                ],
                onTap:(index) {
                  setState(() {
                    currentIndex =index;
                  });
                },

        ),

      ),
    );

  }
}
