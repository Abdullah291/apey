import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'comment_reply.dart';



class Comment extends StatefulWidget {
  final groupId;
  final postId;

  Comment({this.groupId,this.postId});

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  void initState() {
    print(widget.groupId);
    print(widget.postId);
    // TODO: implement initState
    super.initState();
  }


  TextEditingController sendController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kthirdcolor,

        body:  Stack(
          children: [

            Container(
              margin: EdgeInsets.only(top: 70,bottom: 60),
              child: StreamBuilder(
                  stream: Collection.userCommentPost
                      .where("group_Id",isEqualTo: widget.groupId)
                      .where("post_Id", isEqualTo: widget.postId).
                      where("reply_comment_Id", isEqualTo: "").
                    snapshots(),
                  builder: (context,snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    } else {
                      if (snapshot.data.docs.length>0) {
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data=snapshot.data.docs[index];
                            return StreamBuilder(
                                stream: Collection.signUp.where("email",isEqualTo: data["user_id"]).snapshots(),
                                builder: (context,AsyncSnapshot<QuerySnapshot> singleSnapshot) {
                                  return singleSnapshot.hasData? Column(
                                    children: List.generate(singleSnapshot.data.docs.length, (index2) {
                                      DocumentSnapshot doc2=singleSnapshot.data.docs[index2];
                                     return Column(
                                       children: [
                                         Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 25),
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(
                                                          100),
                                                      child: Container(
                                                        height: 50,
                                                        width: 50,
                                                        child: Image.network(
                                                          doc2.data()["Image"], fit: BoxFit.fill,),
                                                      )
                                                  ),
                                                ),

                                                Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 15, vertical: 15),
                                                      decoration: BoxDecoration(
                                                        color: KGreyColor.withOpacity(0.3),
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(20),
                                                          topRight: Radius.circular(20),
                                                          bottomLeft: Radius.circular(20),
                                                          bottomRight: Radius.circular(0),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Container(
                                                            width: Get.width * 0.7,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(doc2.data()["name"] +' '+ doc2.data()["surName"], style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    color: Colors.black),),
                                                                // SizedBox(width: Get.width*0.4,),
                                                                Icon(Icons.favorite_border_outlined,
                                                                  color: KGreyColor,
                                                                  size: 25,),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height:2,),
                                                          Container(
                                                            width: Get.width * 0.7,
                                                            child: Text(
                                                              data["comment"],
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w300,
                                                                fontFamily: "",
                                                                color: Colors.black,
                                                              ),
                                                              // softWrap: false,
                                                              // maxLines: 4,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Container(
                                                      width: Get.width * 0.7,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [

                                                              GestureDetector(
                                                                onTap: (){
                                                                  Get.to(
                                                                    CommentReply(
                                                                      groupId:widget.groupId,
                                                                      postId:widget.postId,
                                                                      commentId: data["key"],
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text("Reply", style: TextStyle(
                                                                    color: KGreyColor,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontFamily: ""),),
                                                              )
                                                            ],
                                                          ),
                                                          Text(getTimeDifferenceFromNow(data["created_at"].toDate()), style: TextStyle(
                                                              color: KGreyColor,
                                                              fontWeight: FontWeight.w700,
                                                              fontFamily: ""),),

                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ],
                                            ),
                                         ),
                                        GestureDetector(
                                        onTap:(){
                                          Get.to(
                                            CommentReply(
                                          groupId:widget.groupId,
                                           postId:widget.postId,
                                            commentId: data["key"],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: StreamBuilder(
                                              stream: Collection.userCommentPost
                                                  .where("reply_comment_Id", isEqualTo: data["comment_Id"])
                                                  .snapshots(),
                                              builder: (context,nestedSnapshot) {
                                                if (!nestedSnapshot.hasData) {
                                                  return SizedBox();
                                                } else {
                                                  return Column(
                                                    children: [
                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: ClampingScrollPhysics(),
                                                          itemCount: nestedSnapshot.data.docs.length>0?1:0,
                                                          itemBuilder: (context, index4) {
                                                            int length=nestedSnapshot.data.docs.length-1;
                                                            DocumentSnapshot data4=nestedSnapshot.data.docs[index4];
                                                            return Column(
                                                              children: [
                                                                StreamBuilder(
                                                                    stream: Collection.signUp.where("email",isEqualTo:data4["user_id"]).snapshots(),
                                                                    builder: (context,AsyncSnapshot<QuerySnapshot> nestedFutureSnapshot) {
                                                                      return nestedFutureSnapshot.hasData?
                                                                      Column(
                                                                      children: List.generate(nestedFutureSnapshot.data.docs.length, (index6) {
                                                                        DocumentSnapshot doc8 = nestedFutureSnapshot
                                                                            .data
                                                                            .docs[index6];
                                                                        return Column(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets
                                                                                  .only(
                                                                                  top: 20,
                                                                                  right: 20),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment
                                                                                    .end,
                                                                                children: [
                                                                                  Container(
                                                                                    margin: EdgeInsets
                                                                                        .only(
                                                                                        bottom: 25),
                                                                                    child: ClipRRect(
                                                                                        borderRadius: BorderRadius
                                                                                            .circular(
                                                                                            100),
                                                                                        child: Container(
                                                                                          height: 30,
                                                                                          width: 30,
                                                                                          child: Image
                                                                                              .network(
                                                                                            doc8["Image"],
                                                                                            fit: BoxFit
                                                                                                .fill,),
                                                                                        )
                                                                                    ),
                                                                                  ),

                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment
                                                                                        .end,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: Get
                                                                                            .width *
                                                                                            0.6,
                                                                                        margin: EdgeInsets
                                                                                            .only(
                                                                                            left: 10),
                                                                                        padding: EdgeInsets
                                                                                            .symmetric(
                                                                                            horizontal: 15,
                                                                                            vertical: 15),
                                                                                        decoration: BoxDecoration(
                                                                                          color: KGreyColor
                                                                                              .withOpacity(
                                                                                              0.2),
                                                                                          borderRadius: BorderRadius
                                                                                              .only(
                                                                                            topLeft: Radius
                                                                                                .circular(
                                                                                                20),
                                                                                            topRight: Radius
                                                                                                .circular(
                                                                                                20),
                                                                                            bottomLeft: Radius
                                                                                                .circular(
                                                                                                20),
                                                                                            bottomRight: Radius
                                                                                                .circular(
                                                                                                0),
                                                                                          ),
                                                                                        ),
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                                              .end,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: Get
                                                                                                  .width *
                                                                                                  0.6,
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment
                                                                                                    .spaceBetween,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    doc8["name"] +
                                                                                                        ' ' +
                                                                                                        doc8["surName"],
                                                                                                    style: TextStyle(
                                                                                                        fontWeight: FontWeight
                                                                                                            .bold,
                                                                                                        color: Colors
                                                                                                            .black),),
// SizedBox(width: Get.width*0.4,),
                                                                                                  Icon(
                                                                                                    Icons
                                                                                                        .favorite_border_outlined,
                                                                                                    color: KGreyColor,
                                                                                                    size: 25,),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 2,),
                                                                                            Container(
                                                                                              width: Get
                                                                                                  .width *
                                                                                                  0.6,
                                                                                              child: Text(
                                                                                                data4["comment"],
                                                                                                style: TextStyle(
                                                                                                  fontSize: 15,
                                                                                                  fontWeight: FontWeight
                                                                                                      .w300,
                                                                                                  fontFamily: "",
                                                                                                  color: Colors
                                                                                                      .black,
                                                                                                ),
                                                                                                softWrap: false,
                                                                                                maxLines: 4,


                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 5,),
                                                                                      Container(
                                                                                        width: Get
                                                                                            .width *
                                                                                            0.6,
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment
                                                                                              .spaceBetween,
                                                                                          children: [
                                                                                            Row(
                                                                                              children: [
                                                                                                Text(
                                                                                                  "1 Like",
                                                                                                  style: TextStyle(
                                                                                                      color: KGreyColor,
                                                                                                      fontWeight: FontWeight
                                                                                                          .w400,
                                                                                                      fontFamily: ""),),
                                                                                                SizedBox(
                                                                                                  width: 20,),
                                                                                                Text(
                                                                                                  "Reply",
                                                                                                  style: TextStyle(
                                                                                                      color: KGreyColor,
                                                                                                      fontWeight: FontWeight
                                                                                                          .w700,
                                                                                                      fontFamily: ""),)
                                                                                              ],
                                                                                            ),
                                                                                            Text(
                                                                                              getTimeDifferenceFromNow(
                                                                                                  data4["created_at"]
                                                                                                      .toDate()),
                                                                                              style: TextStyle(
                                                                                                  color: KGreyColor,
                                                                                                  fontWeight: FontWeight
                                                                                                      .w700,
                                                                                                  fontFamily: ""),),

                                                                                          ],
                                                                                        ),
                                                                                      ),

                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],

                                                                        );
                                                                      }
                                                                              )


                                                                      ): Container();
                                                                    }
                                                                ),
                                                                length==0?Container():  Container(
                                                                    alignment: Alignment.centerRight,
                                                                    margin: EdgeInsets.only(right: 20,top: 20),
                                                                    child: length==1?
                                                                    Text("view 1 more comment...",
                                                                      style: TextStyle(fontWeight: FontWeight.bold),
//
                                                                    ):Text("view "+ length.toString() + " more comments...",
                                                                      style: TextStyle(fontWeight: FontWeight.bold),

                                                                    )),
                                                              ],
                                                            );
                                                          }
                                                      ),
                                                    ],
                                                  );
                                                }
                                              }
                                          ),
                                        ),
                                      ),

                                       ],

                                      );
                                     }
                                          )
                                  ):
                                  Container();
                                }
                            );
                          }
                      );
                      } else {
                        return Center(child: Image.asset("assets/comment_pic.png",height: 150,));
                      }
                    }
                  }
              ),
            ),
            StreamBuilder(
              stream: Collection.blockGroupUser.where("room_id",isEqualTo:widget.groupId).
        where("user",
       isEqualTo: UserSingleton.userData.userEmail)
        .where("status", isEqualTo: false).snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snaps) {

                return snaps.hasData? Align(
                  alignment: Alignment.bottomCenter,
                  child: snaps.data.docs.length>0?
                  Container(
                    color: KPrimaryColor,
                    height: 60,
                    child: Center(child: Text("The admin of the group blocked you",
                      style: TextStyle(color: KBlueColor),
                      overflow: TextOverflow.ellipsis,)),)
                      :Card(
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      height: 56,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Container(
                          child: TextField(
                            cursorColor: kprimarycolor,
                            textAlign: TextAlign.start,
                            controller: sendController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            minLines: 1,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * .03,
                                    vertical: Get.height * .02),
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                hintText: "Type your message...",
                                hintStyle: TextStyle(
                                    fontSize: 14
                                )
                            ),
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: (){
                           if(sendController.text.isNotEmpty) {
                             var key = Timestamp
                                 .now()
                                 .millisecondsSinceEpoch
                                 .toString();
                             Collection.userCommentPost.doc(key).set({
                               "comment": sendController.text,
                               "key": key,
                               "created_at": DateTime.now(),
                               "comment_Id": key,
                               "reply_comment_Id": "",
                               "post_Id": widget.postId,
                               "group_Id": widget.groupId,
                               "status": 1,
                               "user_id": UserSingleton.userData.userEmail,
                             }).then((value) {
                               print("comment sent successfully");
                               sendController.clear();
                             });
                           }
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.only(left: 5),
                            margin: EdgeInsets.only(right: 10),

                            child: Center(child: Image.asset("assets/sendfeed_iphone@3x.png")),
                          ),
                        ),
                      ),
                    ),
                  )
                ):Container();
              }
            ),
            Container(
              height: 165,
              width: Get.width,
              decoration: BoxDecoration(
                // color: Colors.,
                image: DecorationImage(
                    image: AssetImage("assets/b.png"),
                    fit: BoxFit.fill),
              ),
              child: Stack(
                children: [

                  ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Transform.rotate(
                              angle: 3.1,
                              child: Image.asset(
                                "assets/arrow_iphone@3x.png",
                                width: 50,
                                height: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Container(
                        margin: EdgeInsets.only(top: 25,right: 50),
                        child: Text("Replies",style: textStyle,textAlign: TextAlign.center,)),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }


  String getTimeDifferenceFromNow(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inSeconds < 5) {
      return "Just now";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds}s ago";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }
}


