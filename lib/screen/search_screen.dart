import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/screen/searchGroup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:apey/constant.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:get/get.dart';
import 'chat/chat_screen.dart';
import 'chat/initiat_chat.dart';
import 'groupProfileDetail.dart';



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Bg.png"),
                          fit: BoxFit.fill)),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal:
                        context.responsiveValue(mobile: 10, tablet: 25)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Search",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Card(
                            margin: EdgeInsets.all(0),
                            color: Kthirdcolor2,
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BubbleTabIndicator(
                                  indicatorHeight: 45,
                                  indicatorRadius: 10,
                                  indicatorColor: Colors.orange),
                              tabs: [
                                Tab(
                                  child: Text(
                                    "User",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Group",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 150),
                  child: TabBarView(
                    children: [
                      User(),

                      SearchGroup_screen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
String searchString = '';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {

  @override
  void initState() {
    // getData();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchController = TextEditingController();




  // List<DocumentSnapshot> list = [];
  //
  // Future<void> getData() {
  //   list.clear();
  //   Collection.signUp.where("email",isNotEqualTo: UserSingleton.userData.userEmail)
  //       .get().then((value) {
  //     var doc = value.docs;
  //     doc.forEach((element) {
  //       list.add(element);
  //     });
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: context.responsiveValue(mobile: 20, tablet: 50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 5,),
                height: 50,
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: Kthirdcolor2,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.replaceAll(" ", "").toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search here....',
                      hintStyle: TextStyle(
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.only(left: 15, top: 15),
                      suffixIcon: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/search_iphone@3x.png",
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 25, left: 5),
                child: Text(
                  "Search new people",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                  stream: Collection.signUp.where("email",isNotEqualTo: UserSingleton.userData.userEmail,).snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot>  snapshot) {
                    return snapshot.hasData? ListView.builder(
                        padding: EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documnents = snapshot.data.docs[index];
                          return makeFriend(context, documnents);
                        }
                    ):Container();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget makeFriend(BuildContext context, DocumentSnapshot documnents) {



    String toName =  documnents.data()["UserID"].toString().replaceAll(" ", "").toLowerCase() ?? ' ';
    if (toName.contains(searchString)) {
      return GestureDetector(
        onTap: (){
          Get.to(GroupProfileDetailScreen(
            image: documnents.data()["Image"],
            email: documnents.data()["email"],
            userid: documnents.data()["UserID"],
            name: documnents.data()["name"],
            surName: documnents.data()["surName"],
            interest : documnents.data()["interest"],
          ));
        },
        child: Container(
          margin: EdgeInsets.only(top: 15),
          height: 120,
          child: Card(
            elevation: 2,
            margin: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 15, bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 70,
                        width: 70,
                        child: Image.network(
                          documnents.data()["Image"],
                          fit: BoxFit.cover,
                          width: context.responsiveValue(
                              mobile: Get.width * 0.15, tablet: Get.width * 0.12),
                        ),
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                          documnents.data()["name"] + ' ' + documnents.data()["surName"],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                    Text(
                      documnents.data()["UserID"],
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    StreamBuilder(
                        stream: Collection.userFriends.
                        where("by_and_to", arrayContains: documnents.data()["email"],)
                            .where("friend_to", isEqualTo: UserSingleton.userData.userEmail,)
                            .where("isFriend", isEqualTo: true).snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return snapshot.hasData?Container(
                            margin: EdgeInsets.only(top: 15),
                            child: snapshot.data.docs.length>0?Container(
                              width: Get.width*0.5,
                              child: Row(
                                children: [
                                  Text("Friend",style: TextStyle(color: KBlueColor),),
                                  SizedBox(width: 8,),
                                  Image.asset("assets/select_iphone@3x.png",height: 18,),
                                ],
                              ),)
                                :StreamBuilder(
                                stream: Collection.userFriends
                                    .where("friend_by", isEqualTo: UserSingleton.userData.userEmail,)
                                    .where("friend_to", isEqualTo: documnents.data()["email"],)
                                    .where("request", isEqualTo: true).
                                where("isFriend", isEqualTo: false).
                                snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshotTwo) {
                                  return snapshotTwo.hasData? Row(
                                    children: [
                                      snapshotTwo.data.docs.length>0 ?Card(
                                        margin: EdgeInsets.all(0),
                                        child: Container(
                                          height: 35,
                                          width: Get.width * 0.25,
                                          // ignore: deprecated_member_use
                                          child:  FlatButton(
                                            onPressed: () {
                                              Collection.userFriends.doc(snapshotTwo.data.docs.single.id).update({
                                                "isFriend": false,
                                                "request": false,
                                              });
                                            },
                                            child: FittedBox(child: Text(
                                              "Requested".toUpperCase(),
                                              style: TextStyle(fontWeight: FontWeight.bold),)),
                                          ),
                                        ),
                                      ) :Card(
                                        margin: EdgeInsets.all(0),
                                        child: Container(
                                          height: 35,
                                          width: Get.width * 0.25,
                                          // ignore: deprecated_member_use
                                          child:  FlatButton(

                                            onPressed: () {
                                              
                                              Collection.userFriends.
                                                  where("friend_by",isEqualTo: UserSingleton.userData.userEmail,).
                                                  where("friend_to",isEqualTo: documnents.data()["email"],).
                                                  where("isFriend",isEqualTo: false).where("request",isEqualTo: false).
                                                  get().then((value) {
                                                    if(value.docs.length>0)
                                                      {
                                                        print("level");
                                                        Collection.userFriends.doc(value.docs.single.id).update({
                                                          "request":true,
                                                        });
                                                      }else{
                                                      String id = DateTime
                                                          .now()
                                                          .millisecondsSinceEpoch
                                                          .toString();
                                                      Collection.userFriends.doc(id).set({
                                                        "created_at": DateTime.now(),
                                                        "friend_by": UserSingleton.userData.userEmail,
                                                        "friend_to": documnents.data()["email"],
                                                        "friend_id": id,
                                                        "isFriend": false,
                                                        "request": true,
                                                        "is_blocked": false,
                                                        "status": true,
                                                        "by_and_to":[UserSingleton.userData.userEmail,
                                                          documnents.data()["email"],],
                                                      });
                                                    }
                                              });


                                            },
                                            child: FittedBox(child: Text(
                                              "Add Friend".toUpperCase(),
                                              style: TextStyle(fontWeight: FontWeight.bold),)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        height: 35,
                                        width: Get.width * 0.25,
                                        child: Card(
                                          margin: EdgeInsets.all(0),
                                          color: KBlueColor,
                                          child: FlatButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.06),
                                            onPressed: () {
                                              InitiateChat(
                                                to:  documnents.data()["email"],
                                                by: UserSingleton.userData.userEmail,
                                                name: "user",
                                                peerId: documnents.data()["email"],
                                              ).now().then((value) async {
                                                Get.to(
                                                    ChatScreen(
                                                      roomID: value.roomId,
                                                      userEmail: documnents.data()["email"],
                                                      userImage:  documnents.data()["Image"],
                                                      userName:  documnents.data()["name"]+' '+documnents.data()["surName"],
                                                    ),
                                                    transition: Transition
                                                        .leftToRightWithFade);
                                              });
                                            },
                                            color: KBlueColor,
                                            child: FittedBox(child: Image.asset("assets/messenger.png",height: 25,width: 28,color: KPrimaryColor,)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ):Container();
                                }
                            ),
                          ):Container();
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    else{
      Container();
    }
  }
}















class DiscoverUser extends StatefulWidget {
  DiscoverUser({this.imgpt, this.txtpt, this.txtlast});
  final imgpt;
  final txtpt;
  final txtlast;
  @override
  _DiscoverUserState createState() => _DiscoverUserState();
}

class _DiscoverUserState extends State<DiscoverUser> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(GroupProfileDetailScreen());
      },
      child: Container(
        width: Get.width*0.28,
        height: 130,
        child: Card(
          margin: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Image.asset(
                widget.imgpt,
                height: 50,
              ),
              Flexible(
                  child: Text(
                    widget.txtpt,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  )),
              Flexible(
                  child: Text(
                    widget.txtlast,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  )),
              SizedBox(
                height: 5,
              ),
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    color: Colors.black,
                    width: 0,
                    height: 0,
                  ),
                  Positioned(
                    bottom: -20,
                    right: -13,
                    child: Container(
                      margin: EdgeInsets.only(left: 0),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kprimarycolor2,
                        border: Border.all(color: Colors.grey[200], width: 2),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
