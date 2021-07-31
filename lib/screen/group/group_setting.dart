
import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/screen/bottomNavBar_screen.dart';
import 'package:apey/screen/group/remove_members_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Group_Setting_Screen extends StatefulWidget {
  final groupId;
  Group_Setting_Screen({this.groupId});
  @override
  _Group_Setting_ScreenState createState() => _Group_Setting_ScreenState();
}

class _Group_Setting_ScreenState extends State<Group_Setting_Screen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          color: Kthirdcolor2,
                          image: DecorationImage(
                              image: AssetImage("assets/Bg2.png"),
                              fit: BoxFit.fill),
                        ),
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Container(
                                child: Image.asset(
                                  "assets/screenback_iphone@3x.png",
                                  height: 25,
                                )),
                          ),
                          title: Container(
                              margin: EdgeInsets.only(right: 60),
                              child: Text(
                                "Group Setting",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 115),
                        margin: EdgeInsets.symmetric(horizontal: context.responsiveValue(mobile: 20,tablet: 50)),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child: ListView(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      print("Done");
                                      Get.to(Remove_Member_from_Group(groupId:widget.groupId));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Card(
                                          margin: EdgeInsets.all(0),
                                          child: Container(
                                            height: 80,
                                            alignment: Alignment.center,
                                            child:ListTile(
                                              title: Text("Remove Group Members",style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                              trailing: Icon(Icons.arrow_forward_ios, size: 22,),
                                            ),

                                          )

                                      ),
                                    ),
                                  ),
                                  GroupSetting("Blocked Uers",),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 35,left:context.responsiveValue(mobile: 10,tablet: 20),right: context.responsiveValue(mobile: 10,tablet: 20),),
                              height: 45,
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                  onPressed: () {
                                    Collection.groupRoom.doc(widget.groupId.toString()).delete();
                                  },
                                  color: kprimarycolor2,
                                  child: Text("Delete Group", style: TextStyle(
                                      color: kforhtcolor2,
                                      fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 15,left:context.responsiveValue(mobile: 10,tablet: 20),right: context.responsiveValue(mobile: 10,tablet: 20),),
                              height: 45,
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                  onPressed: () {
                                    Get.offAll(BottomnavbarScreen());
                                  },
                                  color: kforhtcolor2,
                                  child: Text("Exit Group", style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),)),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget GroupSetting(String title) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Card(
          margin: EdgeInsets.all(0),
          child: Container(
            height: 80,
            alignment: Alignment.center,
            child:ListTile(
              title: Text(title,style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
              trailing: Icon(Icons.arrow_forward_ios, size: 22,),
            ),

          )

      ),
    );
  }
}
