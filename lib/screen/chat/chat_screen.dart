import 'dart:async';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';



import '../../constant.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  String roomID;
  String userEmail;
  String userName;
  String userImage;

  ChatScreen({this.roomID, this.userEmail,this.userName,this.userImage});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String selectedRoomId;
  var listMessage;
  ScrollController _scrollController = ScrollController();

  bool isSendIcon = false;
  TextEditingController textcontroller;
  String textsaver = "";

  @override
  void initState() {
    print("in room id  ${widget.roomID}");
    print("in room id  ${widget.userEmail}");
    super.initState();
    textcontroller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textcontroller.dispose();
  }

  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // Timer(
    //   Duration(seconds: 1),
    //       () => _controller.jumpTo(_controller.position.maxScrollExtent),
    // );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Kthirdcolor,
        body: SafeArea(
          child: Column(
            children: [
               Expanded(
                 child: Stack(
                   children: [
                     SingleChildScrollView(child: conversation()),
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
                                margin: EdgeInsets.only(right: 10,top: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20,right: 10),
                                  height: 45,
                                  width: 45,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(widget.userImage,fit: BoxFit.cover,alignment: Alignment.topCenter,),
                                  ),
                                  ),
                                    Flexible(
                                      child: Text(
                                        widget.userName,
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                     ),
                   ],
                 ),
               ),
              // SizedBox(
              //   height: Get.height * .01,
              // ),

              Expanded(flex: null,child: bottomtextnavigation()),
            ],
          ),
        ),

      ),
    );
  }

  Widget bottomtextnavigation() {
    return Container(
      padding: EdgeInsets.only(
          left: Get.width * .01,
          right: Get.width * .03,
          top: Get.height * .01,
         bottom: Get.height * .01,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: Get.width * .02,
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.only(
                    left: Get.width * .03,
                  ),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextField(
                    cursorColor: kprimarycolor,
                    textAlign: TextAlign.start,
                    controller: textcontroller,
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
                    onChanged: (value) {
                      setState(() {
                        if (textcontroller.text.isNotEmpty) {
                          isSendIcon = true;
                        } else {
                          isSendIcon = false;
                        }
                      });
                      textsaver = value;
                      print("text saver   " + textsaver);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * .02,
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        // textcontroller.clear();
                        // if (isSendIcon && textsaver.isNotEmpty) {
                        //   chatList.add(sendchat(5, textsaver));
                        //   textsaver = "";
                        // } else {
                        //   Fluttertoast.showToast(msg: "Please type something");
                        // }

                        onSendMessage(textcontroller.text);
                      });
                    },
                    child: Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                       child: Image.asset("assets/sendfeed_iphone@3x.png"),
                        
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onSendMessage(String content,) {
// type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textcontroller.clear();
      var documentReference = Collection.chat
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'message': content,
            'receiver_id': widget.userEmail,
            'sender_id': UserSingleton.userData.userEmail,
            'room_id': widget.roomID,
            'created_at': Timestamp.now(),
            'seen': false,
            'type': 1,
          },
        );
      });
      _controller.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Widget conversation() {
    return Container(
      margin: EdgeInsets.only(top: 70),
      child: StreamBuilder(
        stream: Collection.chat
            .where("room_id", isEqualTo: widget.roomID)
        // .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(margin: EdgeInsets.only(top: 200),child: Container(
              width: Get.width,
              child: Column(

                children: [
                  CircularProgressIndicator(backgroundColor: KBlueColor,),
                ],
              ),
            ));
          } else if (snapshot.data.docs.isEmpty) {
            return Container(height: Get.height*0.7,child: Center(child: Text("No conversation history")));
          } else {
            listMessage = snapshot.data.docs;
            print(listMessage.length);
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  buildItem(index, snapshot.data.docs[index]),
              itemCount: snapshot.data.docs.length,
              reverse: false,
              controller: _scrollController,
            );
          }
        },
      ),
    );
  }

  Widget buildItem(
      int index,
      DocumentSnapshot document,
      ) {
    if (document.data()['sender_id'] == UserSingleton.userData.userEmail) {
// Right (my message)
      return Column(
          children: [
        sendChat(
          index,
          document.data()['message'],
          document.data()['type'],
          document.data()['post_id'],
          document.data()['created_at'].toDate(),
        ),
      ]);
    } else {
// Left (peer message)
      return Container(
        child: Column(
          children: [
            receivedChat(
              document.data()['message'],
              index,
              document.data()["sender_id"],
              document.data()['type'],
              document.data()['post_id'],
              document.data()['shared_id'],
              document.data()['created_at'].toDate(),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  Widget sendChat(int index, String text, int type, String postId,var time) {
    // var result = TimeAgo.getTimeAgo(DateTime.parse(time));
    // DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("HH:mm:a");
    String newtime = dateFormat.format(time);

    return Container(
        margin: EdgeInsets.only(
          right: 5,
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Card(
                    margin: EdgeInsets.only(left: 10, bottom: 16),
                    color: kforhtcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            topLeft: Radius.circular(100),
                            bottomRight: Radius.circular(0),
                            topRight: Radius.circular(100))),
                    child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 3),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .7,
                            minWidth: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                text,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text('$newtime',
                              style: TextStyle(color: Colors.white,fontSize: 10),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              SizedBox(
                width: 5,
              ),
              CircularProfileAvatar(
                "",
                radius: 18,
                child: Image.network(
                  "${UserSingleton.userData.imageUrl}",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ));
  }

  Widget receivedChat(String text, int index, String sender, int type,
      String postId, String shareID,var time) {

    DateFormat dateFormat = DateFormat("HH:mm:a");
    String newtime = dateFormat.format(time);

    return Container(
        margin: EdgeInsets.only(
          right: 5,
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("SignUp")
                      .doc(sender)
                      .get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return CircularProfileAvatar(
                        "",
                        radius: 18,
                        child: Image.network(
                          widget.userImage,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  }),
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 16),
                child: Card(

                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            topLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                            topRight: Radius.circular(100))),
                    child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 3),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .7,
                            minWidth: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                text,
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            Text('$newtime',
                              style: TextStyle(color: KBlueColor,fontSize: 10),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
