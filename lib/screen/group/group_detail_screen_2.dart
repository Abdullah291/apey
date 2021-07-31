

import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_group_Member2.dart';
import 'again_add_more_member.dart';

class Group_Detail_Screen_2 extends StatefulWidget {
  final roomIds;
  Group_Detail_Screen_2({this.roomIds});
  @override
  _Group_Detail_Screen_2State createState() => _Group_Detail_Screen_2State();
}

class _Group_Detail_Screen_2State extends State<Group_Detail_Screen_2> {
  var visible;
  bool visi = false;

  List<String> oldMember;

  void addNewMembers() {
    List<String> newMember = [];

    Collection.signUp
        .where("email", isNotEqualTo: UserSingleton.userData.userEmail)
        .get()
        .then((value) {
          print("sdsds");
      var dovs = value.docs;
      dovs.forEach((element) {
        newMember.add(element.data()["email"]);
      });
    }).then((value) {
      oldMember.forEach((element) {
        newMember.removeWhere((ele) => ele == element);
      });
    }).then((value) {
      newMember.forEach((element) {
        print(element);
      });
    }).whenComplete(() =>  Get.to(Again_Add_More_Members_2(
      roomIds: widget.roomIds.toString(),
      newMembers:newMember,
    ))

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Collection.groupRoom.where("roomId",isEqualTo: widget.roomIds).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData? GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 15,top: 20),
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder:(context,index)
                  {
                    DocumentSnapshot doc=snapshot.data.docs[index];
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                height: Get.height * 0.35,

                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        width: Get.width,
                                        child: Image.network(
                                          doc["groupImage"],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            doc["groupName"],
                                            style: TextStyle(
                                                color: KPrimaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 28),
                                          )),
                                    )
                                  ],
                                ),
                              ),


                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.012),
                                alignment: Alignment.centerLeft,
                                width: Get.width,
                                height: Get.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Created By:  ",
                                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                                    ),
                                    StreamBuilder(
                                        stream: Collection.signUp.where("email",isEqualTo: doc["createdBy"]).snapshots(),
                                        builder: (context, snapshot) {
                                          return snapshot.hasData? Column(
                                              children: List.generate(snapshot.data.docs.length, (index) {
                                                DocumentSnapshot detail=snapshot.data.docs[index];
                                                return Container(
                                                  margin: EdgeInsets.only(top: 9),
                                                  child: Text(
                                                    "${doc["createdBy"] ==
                                                        UserSingleton.userData.userEmail
                                                        ? 'You'
                                                        : detail["name"] +' '+ detail["surName"]}",
                                                    style: TextStyle(fontSize: 15,color: KBlueColor),
                                                  ),
                                                );
                                              },
                                              )
                                          ):Container();
                                        }
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15,right: 15),
                                width: Get.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${doc["members"].length.toString()} Members",
                                      style: TextStyle(color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    // ignore: deprecated_member_use
                                    UserSingleton.userData.userEmail ==
                                        doc["createdBy"]? FlatButton(
                                        color: KBlueColor,
                                        onPressed: (){
                                          oldMember = List.from(doc["members"]);
                                          addNewMembers();
                                        }, child: FittedBox(
                                        child: Text("Add Members",
                                          style: TextStyle(color: Colors.white,fontSize: 12),
                                        ))):Container(),
                                  ],
                                ),
                              ),
                              Column(
                                children:
                                List.generate(doc["members"].length, (index) {
                                  return StreamBuilder(
                                      stream: Collection.blockGroupUser
                                          .where("room_id",
                                          isEqualTo: widget.roomIds)
                                          .where("user",
                                          isEqualTo: doc["members"][index])
                                          .where("status", isEqualTo: false)
                                          .snapshots(),
                                      builder: (context,AsyncSnapshot<QuerySnapshot> blockSnapshot) {
                                        return blockSnapshot.hasData? Container(
                                          child: StreamBuilder(
                                              stream: Collection.signUp.where("email",isEqualTo: doc["members"][index]).snapshots(),
                                              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                                return snapshot.hasData? Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          visi=false;
                                                        });
                                                      },
                                                      child: Card(
                                                        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                                          margin:
                                                          EdgeInsets.symmetric(vertical: Get.height * 0.007),
                                                          width: Get.width,
                                                          height: 70,
                                                          decoration: BoxDecoration(
                                                            color:Colors.white,
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              StreamBuilder(
                                                                  stream: Collection.signUp.where("email",isEqualTo:doc["members"][index]).snapshots(),
                                                                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot4) {
                                                                    return snapshot4.hasData? Column(
                                                                        children: List.generate(snapshot4.data.docs.length, (index)
                                                                        {
                                                                          DocumentSnapshot doc4=snapshot4.data.docs[index];
                                                                          return Row(
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(left: 5,right: 15,top: 12),

                                                                                child: Stack(
                                                                                  overflow: Overflow.visible,
                                                                                  children: [
                                                                                    ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(100),
                                                                                      child: Container(
                                                                                          height: 45,
                                                                                          width: 45,
                                                                                          child: Image.network(doc4.data()["Image"],fit: BoxFit.cover,alignment: Alignment.topCenter,)),
                                                                                    ),
                                                                                    blockSnapshot.data.docs.length>0?   Positioned(top: -4,left: -4,child: Icon(Icons.block,color: Colors.red,size: 54,)):Container(),
                                                                                  ],
                                                                                ),
                                                                              ),

                                                                              Container(
                                                                                margin: EdgeInsets.only(top: 8),
                                                                                child: Text(doc4.data()["name"] + ' ' + doc4.data()["surName"]
                                                                                  ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                              ),



                                                                            ],
                                                                          );
                                                                        }
                                                                        )
                                                                    ):Container();
                                                                  }
                                                              ),

                                                              // Text(widget.groupChatModel.users[index]),

                                                              doc["members"][index] ==
                                                                  doc["createdBy"]
                                                                  ? Container(
                                                                margin: EdgeInsets.only(right: 15),
                                                                child: Text("Admin",
                                                                  style: TextStyle(color: KBlueColor,fontWeight: FontWeight.bold),
                                                                ),
                                                              )
                                                                  :  doc["createdBy"] ==
                                                                  UserSingleton.userData.userEmail
                                                                  ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    visible = index;
                                                                    visi = !visi;
                                                                  });
                                                                },
                                                                child: Container(
                                                                    color: Colors.transparent,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 5),
                                                                    child: Icon(Icons.more_vert_sharp)),
                                                              )
                                                                  : SizedBox()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    visible == index && visi
                                                        ? Positioned(
                                                      right: 28,
                                                      top: 20,
                                                      child: Container(
                                                        color: Colors.transparent,
                                                        child: Column(
                                                          children: [
                                                            StreamBuilder(stream:Collection.blockGroupUser.
                                                            where("room_id",
                                                                isEqualTo: widget.roomIds)
                                                                .where("user",
                                                                isEqualTo: doc["members"][index])
                                                                .where("status", isEqualTo: false)
                                                                .snapshots(),
                                                              builder: (context,AsyncSnapshot<QuerySnapshot> blockSnapshot2){
                                                                return blockSnapshot2.hasData? _info(0, blockSnapshot2.data.docs.length > 0
                                                                    ? "Unblock"
                                                                    : 'Block',
                                                                    doc["members"][index],  doc["members"]):Container();
                                                              },
                                                            ),

                                                            _info(1, 'Delete',
                                                                doc["members"][index],doc["members"]),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                        : SizedBox(),
                                                  ],
                                                ):Container();
                                              }
                                          ),
                                        ):Container();
                                      }
                                  );
                                }),
                              ),


                              // ignore: deprecated_member_use
                              // Container(
                              //   margin: EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
                              //   child: UserSingleton.userData.userEmail ==
                              //       widget.groupChatModel.createdBy?  FlatButton(
                              //     minWidth: Get.width,
                              //     color: KBlueColor,
                              //     onPressed: (){
                              //       setState(() {
                              //         Collection.groupChatRoom.doc(widget.groupChatModel.roomId).delete().whenComplete(() =>
                              //             Get.offAll(Group_Chat_Head()));
                              //       });
                              //     },
                              //     child: Text("Delete Group",
                              //       style: TextStyle(color: Colors.white),
                              //     ),): FlatButton(
                              //     minWidth: Get.width,
                              //     color: KBlueColor,
                              //     onPressed: (){
                              //       setState(() {
                              //         widget.groupChatModel.users.removeWhere((element) => element == UserSingleton.userData.userEmail);
                              //         Collection.groupChatRoom.doc(widget.groupChatModel.roomId)
                              //             .update({"members": widget.groupChatModel.users}).whenComplete(() =>
                              //             Get.offAll(Group_Chat_Head()));
                              //       });
                              //     },
                              //     child: Text("Leave Group",
                              //       style: TextStyle(color: Colors.white),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
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
                            title: Text(
                              doc["groupName"],
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                      ],
                    );
                  }

              ),
            ):Container();
          }
      ),
    );
  }
  Widget _info(int index, String title, String removeId, List members) {

    var checkMembers=List.from(members);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == 1) {
            print(removeId);
            checkMembers.removeWhere((element) => element == removeId);
            Collection.groupRoom.doc(widget.roomIds)
                .update({"members": checkMembers});
            visi=false;
          }
          if(title=="Unblock"){
            Collection.blockGroupUser
                .where("room_id", isEqualTo: widget.roomIds)
                .where("user", isEqualTo: removeId)
                .get()
                .then((value) {
              var docs = value.docs;
              if (docs.length > 0) {
                print("${docs[0].data()["id"]}");
                Collection.blockGroupUser
                    .doc(docs[0].data()["id"])
                    .update({"status": true});
              }

            }
            );
          }
          else {
            Collection.blockGroupUser
                .where("room_id", isEqualTo: widget.roomIds)
                .where("user", isEqualTo: removeId)
                .get()
                .then((value) {
              var docs = value.docs;
              if (docs.length > 0) {
                print("${docs[0].data()["id"]}");
                Collection.blockGroupUser
                    .doc(docs[0].data()["id"])
                    .update({"status": false});
              }
            });
          }
        });},
      child: Container(
        height: 35,
        margin: EdgeInsets.only(top: 0),
        width: 50,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: index == 0 ? KBlueColor : Colors.red,
            borderRadius: BorderRadius.circular(5)),
        child: FittedBox(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}










//
// import 'package:apey/constant.dart';
// import 'package:apey/screen/group/group_setting.dart';
// import 'package:flutter/material.dart';
// import 'package:apey/database/collection.dart';
// import 'package:apey/database/userSingleton.dart';
// import 'package:apey/screen/group/add_group_Member2.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';
//
//
//
//
// class Group_Detail_Screen extends StatefulWidget {
//   @override
//   _Group_Detail_ScreenState createState() => _Group_Detail_ScreenState();
// }
//
// class _Group_Detail_ScreenState extends State<Group_Detail_Screen> {
//   // List<String> oldMember;
//   // void addNewMembers(String roomId) {
//   //   List<String> newMember = [];
//   //
//   //   Collection.signUp
//   //       .where("email", isNotEqualTo: UserSingleton.userData.userEmail)
//   //       .get()
//   //       .then((value) {
//   //     var dovs = value.docs;
//   //     dovs.forEach((element) {
//   //       newMember.add(element.data()["email"]);
//   //     });
//   //   }).then((value) {
//   //     oldMember.forEach((element) {
//   //       newMember.removeWhere((ele) => ele == element);
//   //     });
//   //   }).then((value) {
//   //     newMember.forEach((element) {
//   //       print(element);
//   //     });
//   //   }).whenComplete(() =>  Get.to(Add_Group_Memeber_2(
//   //       roomids: roomId.toString(),
//   //       newMembers:newMember,
//   //       already: true))
//   //       .whenComplete(() => print("done by id"+ roomId.toString(),))
//   //   );
//   // }
//
//   TextEditingController sendInformation=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: StreamBuilder(
//                 stream: Collection.groupRoom.where("createdBy",isEqualTo: UserSingleton.userData.userEmail).snapshots(),
//                 builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
//                   return snapshot.hasData ? SingleChildScrollView(
//                     child: snapshot.data.docs.length>0 ? Column(
//                         children: List.generate(snapshot.data.docs.length, (index) {
//                           DocumentSnapshot doc= snapshot.data.docs[index];
//                           return GestureDetector(
//                             onTap: () {
//                               FocusScope.of(context).unfocus();
//                             },
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     child: Container(
//                                       height: context.responsiveValue(
//                                           mobile: 200, tablet: 230),
//                                       child: Container(
//                                         color: Colors.white,
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: context.responsiveValue(
//                                                 mobile: 25, tablet: 50)),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Container(
//                                               margin: EdgeInsets.only(bottom: 5,),
//                                               height: 100,
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Container(
//                                                     width: context.responsiveValue(
//                                                         mobile: 85, tablet: 125),
//                                                     child: doc["createdBy"]==UserSingleton.userData.userEmail?
//                                                     ClipRRect(
//                                                         borderRadius: BorderRadius.circular(100),
//                                                         child: Image.network(doc["groupImage"])):
//                                                     Image.asset(
//                                                       'assets/Game boy_iphone@3x.png',),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 5,
//                                                     child: Container(
//                                                       margin: EdgeInsets.only(left: 8),
//                                                       child: Column(
//                                                         mainAxisAlignment: MainAxisAlignment
//                                                             .center,
//                                                         crossAxisAlignment: CrossAxisAlignment
//                                                             .start,
//                                                         children: [
//                                                           FittedBox(child: Text(
//                                                             doc["createdBy"]==UserSingleton.userData.userEmail? doc["groupName"] :"Happy Tri Milliarta",
//                                                             style: TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16,
//                                                                 fontWeight: FontWeight
//                                                                     .bold),
//                                                             overflow: TextOverflow
//                                                                 .ellipsis,)),
//                                                           SizedBox(height: 5,),
//                                                           doc["createdBy"]==UserSingleton.userData.userEmail?
//                                                           Wrap(
//                                                             children: List.generate(doc.data()["interest"].length, (index)=>Text(doc.data()["interest"][index] +', ',style: TextStyle(
//                                                                 color: Colors.grey,
//                                                                 fontWeight: FontWeight
//                                                                     .bold,
//                                                                 fontSize: 12),)),
//                                                           ): FittedBox(child: Text(
//                                                             "Happy Tri 2212 😍",
//                                                             style: TextStyle(
//                                                                 color: Colors.grey,
//                                                                 fontWeight: FontWeight
//                                                                     .bold,
//                                                                 fontSize: 12),),),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Spacer(flex: 1,),
//                                                   GestureDetector(
//                                                     onTap: (){
//                                                       Get.to(Group_Setting_Screen(groupId:doc["roomId"]));
//                                                     },
//                                                     child: Container(
//                                                       width: context.responsiveValue(
//                                                           mobile: 35, tablet: 50),
//                                                       child: Image.asset(
//                                                           "assets/groupsetting_iphone@3x.png"),
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             Container(
//                                               margin: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: Container(
//                                                       height: 70,
//                                                       decoration: BoxDecoration(
//                                                           borderRadius: BorderRadius
//                                                               .circular(10)
//                                                       ),
//                                                       child: Card(
//                                                         elevation: 3,
//                                                         color: Colors.grey[200],
//                                                         margin: EdgeInsets.all(0),
//                                                         shape: RoundedRectangleBorder(
//                                                           borderRadius: BorderRadius
//                                                               .circular(10),
//                                                         ),
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment
//                                                               .spaceBetween,
//                                                           crossAxisAlignment: CrossAxisAlignment
//                                                               .end,
//                                                           children: [
//                                                             Container(
//                                                               margin: EdgeInsets.only(
//                                                                   left: 15),
//                                                               child: Column(
//                                                                 crossAxisAlignment: CrossAxisAlignment
//                                                                     .start,
//                                                                 mainAxisAlignment: MainAxisAlignment
//                                                                     .center,
//                                                                 children: [
//                                                                   Text(doc.data()["members"].length.toString(),
//                                                                     style: TextStyle(
//                                                                         fontWeight: FontWeight
//                                                                             .bold,
//                                                                         fontSize: 16),),
//                                                                   SizedBox(height: 3,),
//                                                                   Text("Member",
//                                                                     style: TextStyle(
//                                                                         fontWeight: FontWeight
//                                                                             .bold,
//                                                                         fontSize: 10),)
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Container(child: Image
//                                                                 .asset(
//                                                               'assets/followmember_iphone@3x.png',
//                                                               height: 45,)),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 15,),
//                                                   Expanded(
//                                                     child: Container(
//                                                       height: 70,
//                                                       child: Card(
//                                                         margin: EdgeInsets.all(0),
//                                                         color: Colors.grey[200],
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment
//                                                               .spaceBetween,
//                                                           crossAxisAlignment: CrossAxisAlignment
//                                                               .end,
//                                                           children: [
//                                                             Container(
//                                                               margin: EdgeInsets.only(
//                                                                   left: 15),
//                                                               child: Column(
//                                                                 crossAxisAlignment: CrossAxisAlignment
//                                                                     .start,
//                                                                 mainAxisAlignment: MainAxisAlignment
//                                                                     .center,
//                                                                 children: [
//                                                                   Text("102k",
//                                                                     style: TextStyle(
//                                                                         fontWeight: FontWeight
//                                                                             .bold,
//                                                                         fontSize: 16),),
//                                                                   SizedBox(height: 3,),
//                                                                   Text("Followers",
//                                                                     style: TextStyle(
//                                                                         fontWeight: FontWeight
//                                                                             .bold,
//                                                                         fontSize: 10),)
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Container(child: Image
//                                                                 .asset(
//                                                               'assets/member_iphone@3x.png',
//                                                               height: 45,))
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 25),
//                                     height: 130,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           image: AssetImage("assets/Bg2.png"),
//                                           fit: BoxFit.fill
//                                       ),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         GestureDetector(
//                                           onTap:(){
//                                             // oldMember = List.from(doc.data()["members"]);
//                                             // addNewMembers(doc.id);
//                                           },
//                                           child: Image.asset('assets/addgroup_iphone@3x.png',
//                                             width: Get.width * 0.2,),
//                                         ),
//                                         SizedBox(width: 15,),
//
//                                         SizedBox(width: 15,),
//                                         GestureDetector(
//                                             onTap: () {
//                                               // Get.to(Create_Group_Screen());
//                                             },
//                                             child:
//                                             Image.asset(
//                                               'assets/personalnotification_iphone@3x3.png',
//                                               width: Get.width * 0.2,)
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                                       children: [
//                                         Container(
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: context.responsiveValue(
//                                                   mobile: 25, tablet: 50)),
//
//                                           child: Card(
//                                             color: Color(0xffffffff),
//                                             margin: EdgeInsets.all(0),
//                                             elevation: 0,
//                                             child: Row(
//                                               crossAxisAlignment: CrossAxisAlignment.end,
//                                               children: [
//                                                 Expanded(
//                                                   flex: 8,
//                                                   child: TextFormField(
//                                                     minLines: 1,
//                                                     maxLines: 8,
//                                                     controller: sendInformation,
//                                                     decoration: InputDecoration(
//                                                       hintText: "Write something on your feed...",
//                                                       hintStyle: TextStyle(
//                                                           color: Colors.grey,
//                                                           fontSize: 14),
//                                                       border: InputBorder.none,
//                                                       contentPadding: EdgeInsets.only(
//                                                           left: 15,bottom: 10),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: (){
//                                                     Collection.groupRoom.doc(doc.id).update({
//                                                       "feedback_group":sendInformation,
//                                                     });
//                                                   },
//                                                   child: Container(
//                                                     alignment: Alignment.bottomRight,
//                                                     margin: EdgeInsets.only(
//                                                         left: 10, right: 6,bottom: 5,top: 5),
//                                                     height: 46,
//                                                     width: 60,
//                                                     child: Image.asset(
//                                                         "assets/sendfeed_iphone@3x.png"),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//
//                                         SizedBox(height: 30,),
//                                         Container(
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: context.responsiveValue(
//                                                   mobile: 25, tablet: 50)),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment
//                                                 .spaceBetween,
//                                             children: [
//                                               Text("Members", style: TextStyle(
//                                                   fontWeight: FontWeight.bold),),
//                                               Text(doc.data()["members"].length.toString(), style: TextStyle(
//                                                   fontWeight: FontWeight.bold),),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: 10,),
//                                         doc["createdBy"]==UserSingleton.userData.userEmail?
//
//
//                                         Container(
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: context.responsiveValue(
//                                                   mobile: 20, tablet: 50)),
//                                           child: GridView.builder(
//                                             itemCount: doc.data()["members"].length,
//                                             scrollDirection: Axis.vertical,
//                                             physics: ClampingScrollPhysics(),
//                                             shrinkWrap: true,
//                                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                               crossAxisCount: context.responsiveValue(
//                                                   mobile: 3, tablet: 4),
//                                               crossAxisSpacing: 2,
//                                               mainAxisSpacing: 2,
//                                             ),
//                                             itemBuilder: (context, index) {
//
//                                               return StreamBuilder(
//                                                   stream: Collection.signUp.where("email",isEqualTo: doc.data()["members"][index]).snapshots(),
//                                                   builder: (context, ssnapshot) {
//                                                     return ssnapshot.hasData? Column(
//                                                         children: List.generate(ssnapshot.data.docs.length, (index2) {
//                                                           DocumentSnapshot doc2= ssnapshot.data.docs[index2];
//                                                           return Container(
//                                                             width: Get.width,
//                                                             height: 120,
//                                                             child: Card(
//                                                               child: Column(
//                                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                 children: [
//                                                                   ClipRRect(
//                                                                     borderRadius: BorderRadius.circular(100),
//                                                                     child: Image.network(doc2["Image"],
//                                                                       width: 60,
//                                                                       height: 60,
//                                                                     ),
//                                                                   ),
//                                                                   Text(doc2["name"] + ' ' + doc2["surName"],
//                                                                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
//                                                                 ],
//
//                                                               ),
//                                                             ),
//                                                           );
//                                                         }
//                                                         )
//                                                     ):Container();
//                                                   }
//                                               );
//                                             },
//
//                                           ),
//                                         ):Container(),
//                                         SizedBox(height: 10,),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                         )
//                     ): Container(
//                       height: Get.height*0.9,
//                       child: Center(
//                         child: FlatButton(
//                           color: KBlueColor,
//                           child: Text("Create Group",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
//                           onPressed: (){
//                             // Get.to(Create_Group_Screen());
//                           },
//                         ),
//                       ),
//                     ),
//                   ) : Container();
//                 }
//             )
//         )
//     );
//   }
// }
