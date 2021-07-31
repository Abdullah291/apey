import 'dart:convert';
import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_screen.dart';
import 'package:intl/intl.dart';



class ChatHead extends StatefulWidget {
  @override
  _ChatHeadState createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHead> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Stack(
                children: [
                  Container(
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/b.png"),fit: BoxFit.fill),
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
                      margin: EdgeInsets.only(right: Get.width*0.18),
                      child: Text(
                        "Chat",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                  Container(
                    margin: EdgeInsets.only(top: 105),
                    child: StreamBuilder(
                        stream: Collection.chatRoom.where("users", arrayContains: UserSingleton.userData.userEmail)
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return snapshot.hasData? Column(
                            children: List.generate(snapshot.data.docs.length, (index) {
                              DocumentSnapshot doc = snapshot.data.docs[index];

                              return snapshot.hasData? StreamBuilder(
                                  stream: Collection.signUp
                                  .where("email",isEqualTo:
                                  doc.data()["createdBy"] == UserSingleton.userData.userEmail?
                                  doc.data()["users"][1]:doc.data()["users"][0])
                                  .snapshots(),
                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                                    return snapshot.hasData? ListView.builder(
                                        itemCount: snapshot.data.docs.length,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot data = snapshot.data.docs[index];
                                          return Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(ChatScreen(
                                                  roomID: doc.id,
                                                  userEmail: doc.data()["peerId"],
                                                  userName: data.data()["name"]+data.data()["surName"],
                                                  userImage: data.data()["Image"],
                                                ));
                                              },
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    contentPadding: EdgeInsets.only(bottom: 0),
                                                    leading: Stack(
                                                      overflow: Overflow.visible,
                                                      children: [
                                                        CircularProfileAvatar(
                                                          "",
                                                          radius: 24,
                                                          child: Image.network(
                                                            "${data.data()["Image"]}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Positioned(
                                                            bottom: -5,
                                                            right: 0,
                                                            child: Container(
                                                              width: 15,
                                                              height: 15,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(100),
                                                                color: data.data()["presence"]==false?Colors.transparent:Colors.green,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                    title: Text( "${data.data()["name"]}" + " "+ "${data.data()["surName"]}" , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                                    subtitle: Text("${data.data()["UserID"]}",style: TextStyle(color: KGreyColor),),
                                                    trailing: data.data()["presence"]==false? Text(getTimeDifferenceFromNow(data.data()["last_seen"].toDate())) : Text("online",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                    ),),
                                                  ),
                                                  Divider(
                                                    color: KGreyColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    ):Container();
                                  }):Container();
                            }),
                          ):Container();
                        }),
                  ),],
              )
            ],
          )),
    );
  }

  String getTimeDifferenceFromNow(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);

    DateFormat dateFormat = DateFormat("dd/MM/yyyy");

    var newtime=dateFormat.format(dateTime);

    if (difference.inSeconds < 5) {
      return "Just now";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds}s ago";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "$newtime";
    }
  }
}
