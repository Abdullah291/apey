import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';

import 'package:apey/screen/groupProfileDetail.dart';
import 'package:apey/screen/searchFirestore/userSearch.dart';
import 'package:apey/screen/searchGroup_screen.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'friendRequest.dart';



class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
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
                              "Friend",
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
                                    "Friend",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),

                                Tab(
                                  child: Text(
                                    "Request",
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
                      FriendList(),
                      FriendRequest(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}


String searchFriends = '';

class FriendList extends StatefulWidget {
  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchController = TextEditingController();




  List<DocumentSnapshot> list = [];

  Future<void> getData() {
    list.clear();
    Collection.signUp.where("email",isNotEqualTo: UserSingleton.userData.userEmail)
        .get().then((value) {
      var doc = value.docs;
      doc.forEach((element) {
        list.add(element);
      });
    });
  }



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
              GestureDetector(
                onTap: (){
                  Get.to(SearchFeed());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 5,),
                  height: 45,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    color: Kthirdcolor2,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchFriends = value.replaceAll(" ", "").toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search here....',
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, top: 5),
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
              ),

              Container(
                margin: EdgeInsets.only(top: 25, left: 5),
                child: Text(
                  "Friends",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                  stream: Collection.userFriends.where("by_and_to",
                      arrayContains: UserSingleton.userData.userEmail)
                      .where("isFriend", isEqualTo: true).snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot>  snapshot) {
                    return snapshot.hasData? ListView.builder(
                        padding: EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documnents = snapshot.data.docs[index];
                          return friends(context,documnents);
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

}



Widget friends(BuildContext context, DocumentSnapshot documnents){
  List friends=List();
  return StreamBuilder(
      stream:Collection.signUp.where("email", isEqualTo:
      documnents.data()["friend_by"]==UserSingleton.userData.userEmail?
      documnents.data()["by_and_to"][1]:documnents.data()["by_and_to"][0]).snapshots(),
      // updateUserData(documnents["friend_to"].toString()),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print("EMAIL");
        // print(snapshot.data.id);
        // print(snapshot.data["UserID"]);
        // print(snapshot.data["gender"]);
        // print(snapshot.data["dob"]);
        return snapshot.hasData? ListView.builder(
              padding: EdgeInsets.only(bottom: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.docs.length,
             itemBuilder: (context, index) {
              DocumentSnapshot doc = snapshot.data.docs[index];
              return Container(
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
                                doc.data()["Image"].toString(),
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
                              doc.data()["name"] +' '+ doc.data()["surName"],
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                        Text(
                          doc.data()["UserID"],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: Get.width * 0.25,
                                child: Card(
                                  margin: EdgeInsets.all(0),
                                  child: FlatButton(
                                    onPressed: () {
                                       Collection.userFriends.doc(documnents.data()["friend_to"]).update({
                                         "isFriend": false,
                                         "is_blocked": false,
                                       });
                                    },
                                    child: FittedBox(child: Text(
                                      "Unfriend".toUpperCase(),
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
                                  color: kprimarycolor2,
                                  child: FlatButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.06),
                                    onPressed: () {},
                                    color: kprimarycolor2,
                                    child: FittedBox(child: Text("Block".toUpperCase(),
                                      style: TextStyle(fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        ):Container();
      }
  );

}






