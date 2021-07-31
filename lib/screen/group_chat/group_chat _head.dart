// import 'dart:convert';
import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'group_chat_screen.dart';
import 'group_room_create.dart';






class Group_Chat_Head extends StatefulWidget {
  @override
  _Group_Chat_HeadState createState() => _Group_Chat_HeadState();
}

class _Group_Chat_HeadState extends State<Group_Chat_Head> {

  final GlobalKey<ScaffoldState> _scaffoldkey12=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey12,
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
                      title: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          "Group Chat",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,
                        ),
                      ),

                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 80,left: 15,right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 15),
                          width: 100,
                          child: FlatButton(
                              color: KClipperColor,
                              onPressed: (){
                                Get.to(CreateGroupRoomScreen());
                              }, child: FittedBox(
                              child: Text("Create Group",style: TextStyle(color: Colors.white),))),
                        ),
                        StreamBuilder(
                            stream: Collection.groupChatRoom.where("members", arrayContains: UserSingleton.userData.userEmail)
                                .snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              return snapshot.hasData? Column(
                                children: List.generate(snapshot.data.docs.length, (index) {
                                  DocumentSnapshot doc = snapshot.data.docs[index];

                                  return snapshot.hasData?  Container(
                                                margin: EdgeInsets.only(top: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                        Get.to(GroupChatScreen(roomID: doc.id));

                                                  },
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        contentPadding: EdgeInsets.only(bottom: 0),
                                                        leading: CircularProfileAvatar(
                                                          "",
                                                          radius: 24,
                                                          child: Image.network(
                                                            "${doc.data()["groupImage"]}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        title: Text( "${doc.data()["groupName"]}" , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                                       subtitle: Text("${doc.data()["members"].length}  members"),
                                                      ),
                                                      Divider(
                                                        color: KGreyColor,
                                                      ),
                                                    ],
                                                  ),
                                                )):Container();
                                }),
                              ):Container();
                            }),
                      ],
                    ),
                  ),],
              )
            ],
          )),
    );
  }
}














//
// class Group_Chat_Head extends StatefulWidget {
//   @override
//   _Group_Chat_HeadState createState() => _Group_Chat_HeadState();
// }
//
// class _Group_Chat_HeadState extends State<Group_Chat_Head> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Groups"),
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(
//             horizontal: Get.width * 0.03, vertical: Get.height * 0.02),
//         child: Column(
//           children: [
//             Container(
//               width: Get.width,
//               height: Get.height * 0.06,
//               child: ElevatedButton(
//                 child: Text("new Group"),
//                 onPressed: () {
//                   Get.to(CreateGroupRoomScreen());
//                 },
//               ),
//             ),
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             StreamBuilder(
//                 stream: Collection.groupChatRoom
//                     .where("isGroup", isEqualTo: true)
//                     .where("members",
//                     arrayContains: UserSingleton.userData.userEmail)
//                     .snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) {
//                     return Container();
//                   } else {
//                     return Column(
//                       children:
//                       List.generate(snapshot.data.docs.length, (index) {
//                         DocumentSnapshot doc = snapshot.data.docs[index];
//                         return GestureDetector(
//                           onTap: () {
//                             // Get.to(() => GroupChatScreen(roomID: doc.id));
//                           },
//                           child: Container(
//                             margin: EdgeInsets.symmetric(vertical: 5),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: Get.width * 0.03,
//                             ),
//                             width: Get.width,
//                             height: Get.height * 0.063,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.amber,
//                                       spreadRadius: 1,
//                                       blurRadius: 3)
//                                 ]),
//                             child: Row(
//                               children: [
//                                 GestureDetector(
//                                     onTap: () {
//                                       // Get.to(() => DetailGroup(
//                                       //   groupChatModel:
//                                       //   GroupChatModel.fromJson(
//                                       //       doc.data()),
//                                       // ));
//                                     },
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         child: Icon(Icons.info))),
//                                 SizedBox(
//                                   width: Get.width * 0.02,
//                                 ),
//                                 Container(
//                                   child: CircularProfileAvatar(
//                                     "",
//                                     radius: 18,
//                                     child: Image.network(
//                                       "${doc.data()["groupImage"]}",
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: Get.width * 0.02,
//                                 ),
//                                 Text(doc.data()["groupName"]),
//                                 Spacer(),
//                                 Container(
//                                     decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.grey),
//                                     padding: EdgeInsets.all(10),
//                                     child: Text(
//                                       "${doc.data()["members"].length}",
//                                       style: TextStyle(color: Colors.white),
//                                     ))
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                     );
//                   }
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
