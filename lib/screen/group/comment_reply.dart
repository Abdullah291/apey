import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';




class CommentReply extends StatefulWidget {
  final groupId;
  final postId;
  final commentId;

  CommentReply({this.groupId,this.postId,this.commentId});

  @override
  _CommentReplyState createState() => _CommentReplyState();
}

class _CommentReplyState extends State<CommentReply> {
  @override
  void initState() {
    print(widget.groupId);
    print(widget.postId);
    print(widget.commentId);
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
                      .where("comment_Id", isEqualTo: widget.commentId).
                  snapshots(),
                  builder: (context,snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data=snapshot.data.docs[index];
                            return StreamBuilder(
                                stream: Collection.signUp.where("email",isEqualTo:data["user_id"]).snapshots(),
                                builder: (context,AsyncSnapshot<QuerySnapshot> futureSnapshot) {
                                  return futureSnapshot.hasData? Column(
                                    children: List.generate(futureSnapshot.data.docs.length, (index2) {

                                      DocumentSnapshot data2=futureSnapshot.data.docs[index2];
                                      return Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 25),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      100),
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Image.network(
                                                      data2["Image"],
                                                      fit: BoxFit.fill,),
                                                  )
                                              ),
                                            ),

                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  decoration: BoxDecoration(
                                                    color: KGreyColor
                                                        .withOpacity(0.2),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                      topLeft: Radius.circular(
                                                          20),
                                                      topRight: Radius.circular(
                                                          20),
                                                      bottomLeft: Radius
                                                          .circular(20),
                                                      bottomRight: Radius
                                                          .circular(0),
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
                                                            Text(data2["name"] + ' '+ data2["surName"],
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .black),),
                                                            // SizedBox(width: Get.width*0.4,),
                                                            Icon(Icons
                                                                .favorite_border_outlined,
                                                              color: KGreyColor,
                                                              size: 25,),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 2,),
                                                      Container(
                                                        width: Get.width * 0.7,
                                                        child: Text(
                                                          data["comment"],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight
                                                                .w300,
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

                                                          Text("Reply",
                                                            style: TextStyle(
                                                                color: KGreyColor,
                                                                fontWeight: FontWeight
                                                                    .w700,
                                                                fontFamily: ""),)
                                                        ],
                                                      ),
                                                      Text(
                                                        getTimeDifferenceFromNow(
                                                            data["created_at"]
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
                                      );
                                    }
                                    ),
                                  ):
                                  Container();
                                }
                            );
                          }
                      );
                    }
                  }
              ),
                  ),
          StreamBuilder(
          stream: Collection.blockGroupUser.where("room_id", isEqualTo: widget.groupId)
              .where("user",
          isEqualTo: UserSingleton.userData.userEmail)
              .where("status", isEqualTo: false).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snaping) {
            return snaping.hasData ? Container(
              child: snaping.data.docs.length > 0 ? Container(
          color: KPrimaryColor,
          height: 60,
          child: Center(child: Text("The admin of the group blocked you",
            style: TextStyle(color: KBlueColor),
            overflow: TextOverflow.ellipsis,)),
        ) : Align(
          alignment: Alignment.bottomCenter,
          child: Card(
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
                  onTap: () {
                    if (sendController.text.isNotEmpty) {
                      var key = Timestamp
                          .now()
                          .millisecondsSinceEpoch
                          .toString();
                      Collection.userCommentPost.doc(key).set({
                        "comment": sendController.text,
                        "created_at": DateTime.now(),
                        "key": key.toString(),
                        "comment_Id": widget.commentId,
                        "reply_comment_Id": widget.commentId,
                        "group_Id": widget.groupId,
                        "post_Id": widget.postId,
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
                    child: Center(
                        child: Image.asset("assets/sendfeed_iphone@3x.png")),
                  ),
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
                            margin: EdgeInsets.only(top: 25,),
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
