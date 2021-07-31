import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/model/homeFeed_model.dart';
import 'package:apey/screen/group/comment.dart';
import 'file:///D:/Projects/apey/lib/screen/group/detaiListdetail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apey/constant.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'group/timeshow_and_day.dart';
import 'group/upload_Post.dart';




class HomeFeedScreen extends StatefulWidget {
  final roomIds;
  HomeFeedScreen({this.roomIds});
  @override
  _HomeFeedScreenState createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print("Cool Ids");
    print(widget.roomIds);
    super.initState();
  }

  bool like=false;

  bool show=false;

  final GlobalKey<ScaffoldState> _scaffoldkey2=GlobalKey<ScaffoldState>();


  bool enable=false;

  int _value=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey2,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: StreamBuilder(
             stream: Collection.groupRoom.where("roomId",isEqualTo: widget.roomIds).snapshots(),
              builder: (context, snapshot) {
               return snapshot.hasData? Column(
             children: List.generate(snapshot.data.docs.length, (index) {
                 DocumentSnapshot ds=snapshot.data.docs[index];
                return Container(
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
                            onTap: () {
                              Get.back();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Transform.rotate(
                                      angle: 3.1,
                                      child: Image.asset(
                                        "assets/arrow_iphone@3x.png",
                                        width: 25,
                                        height: 24,
                                        color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          title: GestureDetector(
                            onTap: (){
                              Get.to(DetailListDetailScreen(roomIds:widget.roomIds));
                            },
                            child: Container(
                                        margin:
                                        EdgeInsets.only(
                                            right: Get.width * 0.2, top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Image.network(ds["groupImage"],fit: BoxFit.cover,),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Text(
                                              ds["groupName"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ))
                            ),
                          ),

                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: context.responsiveValue(mobile: 20, tablet: 50),
                            right: context.responsiveValue(mobile: 20, tablet: 50),
                            top: 110),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                child: Text(
                              "Your Groups Activity",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                            StreamBuilder(
                                stream: Collection.userPosts
                                    .where("group_id", isEqualTo: widget.roomIds).orderBy("created_at",descending: true)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  return snapshot.hasData
                                      ? Container(
                                          child: ListView.builder(
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              DocumentSnapshot doc =
                                                  snapshot.data.docs[index];
                                              return feedback(index, doc, ds);
                                            },
                                          ),
                                        )
                                      : Container();
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ):Container();
            }
          ),
        ),
        ),
        bottomNavigationBar: StreamBuilder(
          stream: Collection.blockGroupUser.where("room_id", isEqualTo: widget.roomIds)
            .where("user",
            isEqualTo: UserSingleton.userData.userEmail)
            .where("status", isEqualTo: false).snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snaping) {
            return snaping.hasData? Container(
              child: snaping.data.docs.length>0?
              Container(
                color: KPrimaryColor,
                height: 60,
                child: Center(child: Text("The admin of the group blocked you",
                  style: TextStyle(color: KBlueColor),
                  overflow: TextOverflow.ellipsis,)),
              ):
              StreamBuilder(
                stream: Collection.groupRoom.where("roomId",isEqualTo:widget.roomIds).where("members",
                arrayContains: UserSingleton.userData.userEmail).snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snap) {
                  return snap.hasData? Container(
                    child: BottomAppBar(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: Get.width*0.1,vertical: 5),
                        child:snap.data.docs.length>0? FlatButton(
                          color: KClipperColor,
                          child: Text("Create Post",style: TextStyle(
                            fontSize: 14,color: KPrimaryColor
                          ),),
                          onPressed: (){
                            Get.to(Group_Upload_Post(roomIds:widget.roomIds));
                          },
                        ):FlatButton(
                          color: KClipperColor,
                          child: Text("Join Group",style: TextStyle(
                            fontSize: 14,color: KPrimaryColor
                          ),),
                          onPressed: (){
                            print(widget.roomIds);
                            Collection.groupRoom.doc(widget.roomIds.toString())
                                .update({"members": FieldValue.arrayUnion([UserSingleton.userData.userEmail.toString()])});
                          },
                        ),
                      ),
                    ),
                  ):Container();
                }
              ),
            ):Container();
          }
        ),
      ),
    );
  }

  Widget feedback(int index, DocumentSnapshot doc,DocumentSnapshot ds) {
    return StreamBuilder(
        stream: Collection.signUp
            .where("email", isEqualTo: doc["user_email"])
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? Column(
                  children: List.generate(snapshot.data.docs.length, (index2) {
                    DocumentSnapshot doc2 = snapshot.data.docs[index2];
                    return Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Ksecoudrycolor),
                            padding:
                                EdgeInsets.only(top: 10,bottom: 70, left: 10,right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         width: context.responsiveValue(
                                             mobile: 50, tablet: 60),
                                         height: context.responsiveValue(
                                             mobile: 50, tablet: 60),
                                         child: ClipRRect(
                                           borderRadius: BorderRadius.circular(100),
                                           child: Image.network(
                                             doc2["Image"],fit: BoxFit.cover,
                                           ),
                                         ),
                                       ),
                                       Container(
                                         margin: EdgeInsets.only(top: 10, left: 5),
                                         width: Get.width * 0.25,
                                         child: Column(
                                           crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                           children: [
                                             Text(
                                               doc2["name"] + ' ' + doc2["surName"],
                                               style: TextStyle(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.bold),
                                               overflow: TextOverflow.ellipsis,
                                               maxLines: 2,
                                             ),
                                             FittedBox(
                                               child: Text(
                                                 getTimeDifferenceFromNow(doc["created_at"].toDate()),
                                                 style: TextStyle(fontSize: 10),
                                                 overflow: TextOverflow.ellipsis,
                                               ),
                                             )
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),

                               doc["user_email"]==UserSingleton.userData.userEmail ||
                               ds["createdBy"] == UserSingleton.userData.userEmail ?

                               PopupMenuButton(
                                 offset: Offset(-50,-30),
                                   itemBuilder: (context) => [
                                     PopupMenuItem(
                                       child: Text("Delete",style: TextStyle(fontWeight: FontWeight.bold,color: KBlueColor),),
                                       value: 1,
                                     ),

                                   ],
                                 onSelected: (value){
                                   if(value==1) {
                                     print("coolssss");
                                     setState(() {
                                       Collection.userPosts.doc(doc["post_id"])
                                           .delete();
                                       // ignore: deprecated_member_use
                                       _scaffoldkey2.currentState.showSnackBar(
                                           SnackBar(
                                             backgroundColor: KClipperColor,
                                             content: Text(
                                               "Post Successfully Delete",
                                               style: TextStyle(
                                                   color: KSecondaryColor),),
                                             duration: Duration(seconds: 3),
                                           ));
                                     });
                                   }
                               },
                               ):Container(),



                                  ],
                                ),
                              doc["images"].length==0 ?Container():Container(
                                  width: Get.width,
                                  height: Get.height*0.6,
                                    margin: EdgeInsets.only(
                                      top: 15,
                                    ),
                                    child: doc["images"].length==1?
                                    Container(child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network( doc["images"][0],fit: BoxFit.fill,))):
                                    Swiper(
                                      containerHeight: 200,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (BuildContext context,int index){
                                        return Container(child: ClipRRect(
                                             borderRadius: BorderRadius.circular(10),
                                            child: Image.network( doc["images"][index],fit: BoxFit.fill,)));
                                      },
                                      itemCount: doc["images"].length,

                                      pagination: SwiperPagination(),
                                    ),
                                     ),


                                doc['text']!=null && doc['text'].toString().isNotEmpty?
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: ExpandableText(
                                    doc['text']+" ",
                                    expandText: 'Seemore',
                                    collapseText: 'Seeless',
                                    maxLines: 4,
                                    linkStyle: TextStyle(color: KBlueColor,fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    ),
                                    linkColor: KBlueColor,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ):Container(),



                              ],
                            )),
                        Positioned(
                          left: -15,
                          bottom: 15,
                          child: Container(
                            margin: EdgeInsets.only(top: 25),
                            height: 45,
                            width: 230,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(25),
                              color: Colors.grey[100],
                            ),
                            child:Row(
                              children: [
                                IconButton(icon:  StreamBuilder(
                                    stream: Collection.userLikePost.
                                    where("group_id", isEqualTo: widget.roomIds)
                                        .where("post_id",isEqualTo: doc["post_id"]).
                                    where("user_id",isEqualTo: UserSingleton.userData.userEmail).
                                    where("isLike", isEqualTo: true).
                                    snapshots(),
                                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                      return snapshot.hasData?  Image.asset("assets/like_iphone@3x.png",width: 25,
                                        color:snapshot.data.docs.length>0?Colors.red:Colors.white,):Container();
                                    }
                                ),
                                    onPressed: (){
                                      Collection.userLikePost.
                                      where("group_id", isEqualTo: widget.roomIds)
                                          .where("post_id",isEqualTo: doc["post_id"]).
                                      where("user_id",isEqualTo: UserSingleton.userData.userEmail).
                                      get().then((value) {
                                        var docs = value.docs;
                                        print("cool");
                                        print(docs);
                                        if(docs.length>0){
                                          setState(() {
                                            like=false;
                                          });
                                          docs.forEach((element) {
                                            if(element.data()["isLike"] == false){
                                              Collection.userLikePost.
                                              doc(element.data()["key"]).
                                              update({
                                                "isLike":true,
                                                "isDislike":false,
                                              });
                                            }
                                            else{
                                              Collection.userLikePost.
                                              doc(element.data()["key"]).
                                              update({
                                                "isLike":false,
                                              });
                                            }
                                          });
                                        }
                                        else{
                                          setState(() {
                                            like=true;
                                          });
                                          print("Enter cool");
                                          var id = Timestamp.now().millisecondsSinceEpoch.toString();
                                          Collection.userLikePost.doc(id)
                                              .set({
                                            "created_at": Timestamp.now(),
                                            "isLike": true,
                                            "isDislike":false,
                                            "key": id,
                                            "group_id": widget.roomIds,
                                            'post_id': doc["post_id"],
                                            "status": 1,
                                            "user_id": UserSingleton.userData.userEmail
                                          });
                                          print("Enter cool 1");
                                        }
                                      });

                                    }
                                ),
                                StreamBuilder(
                                  stream: Collection.userLikePost.
                                  where("group_id", isEqualTo: widget.roomIds)
                                      .where("post_id",isEqualTo: doc["post_id"]).
                                  where("isLike", isEqualTo: true).
                                  snapshots(),
                                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                    return snapshot.hasData? Text(
                                      snapshot.data.docs.length.toString(),
                                      style:textStyle,
                                    ):Text("0",style: TextStyle(fontSize: 12,color: Colors.black),);
                                  },
                                ),
                                SizedBox(width: 12,),
                                IconButton(icon:  StreamBuilder(
                                    stream: Collection.userLikePost.
                                    where("group_id", isEqualTo:widget.roomIds)
                                        .where("post_id",isEqualTo: doc["post_id"]).
                                    where("user_id",isEqualTo: UserSingleton.userData.userEmail).
                                    where("isDislike", isEqualTo: true).
                                    snapshots(),
                                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                      return snapshot.hasData?  FaIcon(FontAwesomeIcons.heartBroken,size: 23,
                                        color:snapshot.data.docs.length>0?Colors.red:Colors.white,):Container();
                                    }
                                ),
                                    onPressed: (){
                                      Collection.userLikePost.
                                      where("group_id", isEqualTo: widget.roomIds)
                                          .where("post_id",isEqualTo: doc["post_id"]).
                                      where("user_id",isEqualTo: UserSingleton.userData.userEmail).
                                      get().then((value) {
                                        var docs = value.docs;
                                        print("cool");
                                        print(docs);
                                        if(docs.length>0){
                                          setState(() {
                                            like=false;
                                          });
                                          docs.forEach((element) {
                                            if(element.data()["isDislike"] == false){
                                              Collection.userLikePost.
                                              doc(element.data()["key"]).
                                              update({
                                                "isLike":false,
                                                "isDislike":true,
                                              });
                                            }
                                            else{
                                              Collection.userLikePost.
                                              doc(element.data()["key"]).
                                              update({
                                                "isDislike":false,
                                              });
                                            }
                                          });
                                        }
                                        else{
                                          setState(() {
                                            like=true;
                                          });
                                          var id = Timestamp.now().millisecondsSinceEpoch.toString();
                                          Collection.userLikePost.doc(id).set({
                                            "created_at": Timestamp.now(),
                                            "isLike": false,
                                            "isDislike":true,
                                            "key": id,
                                            "group_id": widget.roomIds,
                                            'post_id': doc["post_id"],
                                            "status": 1,
                                            "user_id": UserSingleton.userData.userEmail
                                          });
                                        }
                                      });


                                    }),

                                StreamBuilder(
                                  stream: Collection.userLikePost.
                                  where("group_id", isEqualTo:doc["group_id"])
                                      .where("post_id",isEqualTo: doc["post_id"]).
                                  where("isDislike",isEqualTo: true).
                                  snapshots(),
                                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                    return snapshot.hasData? Text(
                                      snapshot.data.docs.length.toString(),
                                      style:textStyle,
                                    ):Text("0",style: textStyle);
                                  },
                                ),
                                // Text("5.2K",style: TextStyle(fontSize: 12,color: Colors.black),),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(
                                      Comment(
                                          groupId: widget.roomIds,
                                          postId:  doc["post_id"],
                                      )
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 25),
                                        child: Image.asset(
                                          "assets/comments_iphone@3x.png",  width: 19,),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      StreamBuilder(
                                          stream: Collection.userCommentPost
                                              .where("post_Id", isEqualTo: doc.id)
                                              .snapshots(),
                                          builder: (context, snapshots) {
                                            return snapshots.hasData ? Text(
                                              "${snapshots.data.docs.length}",
                                                style: textStyle,
                                            ):Text(
                                              "0",
                                                style: textStyle
                                            );
                                          }
                                      ),

                                    ],
                                  )
                                ),


                              ],
                            ),



                          ),
                        )
                      ],
                    );
                  }),
                )
              : Container();
        });
  }
}

