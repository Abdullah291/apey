import "package:apey/database/collection.dart";
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';
import 'chat/chat_screen.dart';
import 'chat/initiat_chat.dart';

class GroupProfileDetailScreen extends StatelessWidget {

  final image;
  final email;
  final userid;
  final name;
  final surName;
  List interest;


  GroupProfileDetailScreen({
    this.image,
    this.email,
    this.userid,
    this.name,
    this.surName,
    this.interest,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Kthirdcolor,
        body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Container(
                  color: Ksecoudrycolor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                              child: Image.asset(
                                "assets/screenback_iphone@3x.png",
                                height: 20,
                              )),
                        ),
                        title: Container(
                            margin: EdgeInsets.only(right: 60),
                            child: Text(
                              "Profile Detail",
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,
                            )),
                      ),
                        Column(
                          children: [
                            Container(
                               child: Container(
                               height: 100,
                               width: 100,
                               child: ClipRRect(
                               borderRadius: BorderRadius.circular(100),
                               child: Image.network(image,fit: BoxFit.cover,alignment: Alignment.topCenter,),
                              ),
                     )),
                          ],
                        ),
                      Column(
                        children: [
                          SizedBox(height: 15,),
                          Text(name +' '+ surName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                          SizedBox(height: 7,),
                          Text(userid,style: TextStyle(fontSize: 12,color: Colors.grey),textAlign: TextAlign.center,),
                        ],
                      ),
                      Stack(
                        overflow: Overflow.visible,
                        children: [
                          Container(
                            height: 130,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/Bg2.png"),fit: BoxFit.fill,
                                )
                            ),
                          ),
                          Positioned(
                            top: 95,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 35,bottom: 3),
                                    child: Text("Interest", style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,),
                                      ),
                                Container(
                                    margin: EdgeInsets.only(left: 35,right: 15,top: 5),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Get.width*0.8,
                                          child: Wrap(
                                              children: List.generate(interest.length,(index){
                                                return Text(interest[index].toString()+", ",style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,maxLines: 3,);
                                              }
                                              )
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                     SizedBox(height: 40,),
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(Kthirdcolor, BlendMode.modulate),
                        child: Container(
                          decoration: BoxDecoration(
                            image:DecorationImage(
                                image: AssetImage("assets/idealpersonbg_iphone@3x_2.png"),fit: BoxFit.fill
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top:context.responsiveValue(mobile:  80,tablet: 150),left: context.responsiveValue(mobile: 20,tablet: 50),right: context.responsiveValue(mobile: 20,tablet: 50)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex:5,
                                        child: Container(
                                          height: 70,
                                          child: Card(
                                            elevation: 3,
                                            color: Colors.grey[200],
                                            margin: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin:EdgeInsets.only(left: 15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("27k",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                                      SizedBox(height: 3,),
                                                      Text("Member",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),)
                                                    ],
                                                  ),
                                                ),
                                                Container(child: Image.asset('assets/followmember_iphone@3x.png',height: 45,)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          height: 70,
                                          child: Card(
                                            margin: EdgeInsets.all(0),
                                            elevation: 3,
                                            color: Colors.grey[200],
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin:EdgeInsets.only(left: 15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("102k",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                                      SizedBox(height: 3,),
                                                      Text("Followers",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),)
                                                    ],
                                                  ),
                                                ),
                                                Container(alignment: Alignment.bottomRight,child: Image.asset('assets/member_iphone@3x.png',height: 45,)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40,),
                                Container(

                                  margin: EdgeInsets.symmetric(horizontal: context.responsiveValue(mobile: 10,tablet: 20)),
                                  height: 45,
                                  child: FlatButton(
                                    onPressed: () {



                                      InitiateChat(
                                         to: email,
                                         by: UserSingleton.userData.userEmail,
                                         name: "user",
                                         peerId: email,
                                      ).now().then((value) async {
                                          Get.to(
                                              ChatScreen(
                                                roomID: value.roomId,
                                                userEmail: email,
                                                userImage: image,
                                                userName: name+' '+surName,
                                              ),
                                              transition: Transition
                                                  .leftToRightWithFade);
                                        });
                                    },
                                    color: kforhtcolor,
                                    child: FittedBox(
                                      child: Text("Send Message",
                                        style: TextStyle(fontSize: 14, color: Ksecoudrycolor),),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          ],
        )
      ),
    );
  }
}
