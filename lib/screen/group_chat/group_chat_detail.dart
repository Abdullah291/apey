import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'group_chat _head.dart';
import 'group_chat_model.dart';
import 'add_new_more_member.dart';

// ignore: must_be_immutable
class GroupChatDetail extends StatefulWidget {
  GroupChatModel groupChatModel;
  GroupChatDetail({this.groupChatModel});
  @override
  _GroupChatDetailState createState() => _GroupChatDetailState();
}

class _GroupChatDetailState extends State<GroupChatDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void addNewMembers() {
    List<String> newMember = [];
    List<String> oldMember = List.from(widget.groupChatModel.users);
    Collection.signUp
        .where("email", isNotEqualTo: UserSingleton.userData.userEmail)
        .get()
        .then((value) {
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
    }).whenComplete(() =>  Get.to(AddNewMoreGroupMember(
        roomids: widget.groupChatModel.roomId.toString(),
        newMembers:newMember,
        jsondata:widget.groupChatModel.toJson(),
    ))
    .whenComplete(() => print("done by id"+ widget.groupChatModel.roomId.toString(),))
    );
  }

  var visible;
  bool visi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Stack(
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
                                  widget.groupChatModel.groupImg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    widget.groupChatModel.groupName,
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
                                "Created By: ",
                          style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                            ),
                            StreamBuilder(
                              stream: Collection.signUp.where("email",isEqualTo: widget.groupChatModel.createdBy).snapshots(),
                              builder: (context, snapshot) {
                                return snapshot.hasData? Column(
                                  children: List.generate(snapshot.data.docs.length, (index) {
                                    DocumentSnapshot detail=snapshot.data.docs[index];
                                    return Container(
                                      margin: EdgeInsets.only(top: 9),
                                      child: Text(
                                        "${widget.groupChatModel.createdBy ==
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
                              "${widget.groupChatModel.users.length} Members",
                              style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            // ignore: deprecated_member_use
                           UserSingleton.userData.userEmail ==
                                widget.groupChatModel.createdBy? FlatButton(
                                color: KBlueColor,
                                onPressed: (){
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
                        List.generate(widget.groupChatModel.users.length, (index) {
                          return StreamBuilder(
                            stream: Collection.blockGroupChatUser
                                .where("room_id",
                                isEqualTo: widget.groupChatModel.roomId)
                                .where("user",
                                isEqualTo: widget.groupChatModel.users[index])
                                .where("status", isEqualTo: false)
                                .snapshots(),
                            builder: (context,AsyncSnapshot<QuerySnapshot> blockSnapshot) {
                              return blockSnapshot.hasData? Container(
                                child: StreamBuilder(
                                  stream: Collection.signUp.where("email",isEqualTo: widget.groupChatModel.users[index]).snapshots(),
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
                                                    stream: Collection.signUp.where("email",isEqualTo:widget.groupChatModel.users[index]).snapshots(),
                                                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                                      return snapshot.hasData? Column(
                                                        children: List.generate(snapshot.data.docs.length, (index)
                                                      {
                                                        DocumentSnapshot doc=snapshot.data.docs[index];
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
                                                                       child: Image.network(doc.data()["Image"],fit: BoxFit.cover,alignment: Alignment.topCenter,)),
                                                                 ),
                                                              blockSnapshot.data.docs.length>0?   Positioned(top: -4,left: -4,child: Icon(Icons.block,color: Colors.red,size: 54,)):Container(),
                                                               ],
                                                             ),
                                                           ),

                                                           Container(
                                                             margin: EdgeInsets.only(top: 8),
                                                             child: Text(doc.data()["name"] + ' ' + doc.data()["surName"]
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

                                                  widget.groupChatModel.users[index] ==
                                                      widget.groupChatModel.createdBy
                                                      ? Container(
                                                        margin: EdgeInsets.only(right: 15),
                                                        child: Text("Admin",
                                                    style: TextStyle(color: KBlueColor,fontWeight: FontWeight.bold),
                                                  ),
                                                      )
                                                      : widget.groupChatModel.createdBy ==
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
                                             StreamBuilder(stream:Collection.blockGroupChatUser.
                                                where("room_id",
                                                isEqualTo: widget
                                                    .groupChatModel.roomId)
                                                .where("user",
                                                isEqualTo: widget.groupChatModel
                                                    .users[index])
                                                .where("status", isEqualTo: false)
                                                .snapshots(),
                                               builder: (context,AsyncSnapshot<QuerySnapshot> blockSnapshot2){
                                                   return blockSnapshot2.hasData? _info(0, blockSnapshot2.data.docs.length > 0
                                                       ? "Unblock"
                                                       : 'Block',
                                                       widget.groupChatModel.users[index]):Container();
                                               },
                                             ),

                                                _info(1, 'Delete',
                                                    widget.groupChatModel.users[index]),
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
                      Container(
                        margin: EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
                        child: UserSingleton.userData.userEmail ==
                            widget.groupChatModel.createdBy?  FlatButton(
                          minWidth: Get.width,
                          color: KBlueColor,
                          onPressed: (){
                            setState(() {
                              Collection.groupChatRoom.doc(widget.groupChatModel.roomId).delete().whenComplete(() =>
                                  Get.offAll(Group_Chat_Head()));
                            });
                          },
                          child: Text("Delete Group",
                            style: TextStyle(color: Colors.white),
                          ),): FlatButton(
                           minWidth: Get.width,
                            color: KBlueColor,
                            onPressed: (){
                               setState(() {
                                 widget.groupChatModel.users.removeWhere((element) => element == UserSingleton.userData.userEmail);
                                 Collection.groupChatRoom.doc(widget.groupChatModel.roomId)
                                     .update({"members": widget.groupChatModel.users}).whenComplete(() =>
                                  Get.offAll(Group_Chat_Head()));
                               });
                            },
                            child: Text("Leave Group",
                            style: TextStyle(color: Colors.white),
                            ),
                        ),
                      ),
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
              widget.groupChatModel.groupName,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              overflow: TextOverflow.ellipsis,
                ),
               ),
              ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  // for showing edit project delete project etc
  Widget _info(int index, String title, String removeId,) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == 1) {
            print(removeId);
            widget.groupChatModel.users.removeWhere((element) => element == removeId);
           Collection.groupChatRoom.doc(widget.groupChatModel.roomId)
                .update({"members": widget.groupChatModel.users});
           visi=false;
          }
          if(title=="Unblock"){
            Collection.blockGroupChatUser
                .where("room_id", isEqualTo: widget.groupChatModel.roomId)
                .where("user", isEqualTo: removeId)
                .get()
                .then((value) {
              var docs = value.docs;
              if (docs.length > 0) {
                print("${docs[0].data()["id"]}");
                Collection.blockGroupChatUser
                    .doc(docs[0].data()["id"])
                    .update({"status": true});
              }

        }
        );
      }
          else {
           Collection.blockGroupChatUser
                .where("room_id", isEqualTo: widget.groupChatModel.roomId)
                .where("user", isEqualTo: removeId)
                .get()
                .then((value) {
              var docs = value.docs;
              if (docs.length > 0) {
                print("${docs[0].data()["id"]}");
                Collection.blockGroupChatUser
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
