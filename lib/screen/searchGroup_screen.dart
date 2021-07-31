import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/model/search_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';

import 'homeFeed_screen.dart';


String searchStrings = '';
class SearchGroup_screen extends StatefulWidget {
  @override
  _SearchGroup_screenState createState() => _SearchGroup_screenState();
}

class _SearchGroup_screenState extends State<SearchGroup_screen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: context.responsiveValue(mobile: 20,tablet: 50)),
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
                        searchStrings = value.replaceAll(" ", "").toLowerCase();
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
                margin: EdgeInsets.only(top: 25,bottom: 5,left: 5),
                child: Text("Popular Group",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              StreamBuilder(
                stream: Collection.groupRoom.snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.hasData? Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot docments=snapshot.data.docs[index];
                          return PopularGroup(context,docments);
                        },
                    ),
                  ):Container();
                }
              )

            ],
          ),
        ),
      ),
    );
  }
}


Widget PopularGroup(BuildContext context,DocumentSnapshot docments){


  String toName =  docments.data()["groupName"].toString().replaceAll(" ", "").toLowerCase() ?? ' ';

  if(toName.contains(searchStrings)) {
    return GestureDetector(
      onTap: (){
        Get.to(HomeFeedScreen(roomIds:docments["roomId"]));
      },
      child: Container(
        margin: EdgeInsets.only(top: 15),
        height: 80,
        child: Card(
          elevation: 2,
          child: ListTile(
            leading:  Column(
              children: [
                Container(
                    width: 55,
                    height: 55,

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(docments["groupImage"], fit: BoxFit.cover,

                      ),
                    )),
              ],
            ),
            title: Text(docments["groupName"], style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold),),
            subtitle:  Text(docments["members"].length.toString()+" Members",
              style: TextStyle(fontSize: 12, color: Colors.grey),),
            trailing:  Container(
              width: 100,
              child: Row(
                children: [
                  StreamBuilder(
                      stream: Collection.groupRoom.where("members",
                          arrayContains: UserSingleton.userData.userEmail)
                          .where("roomId",isEqualTo: docments["roomId"]).snapshots(),
                      builder: (context,AsyncSnapshot<QuerySnapshot> snap){
                        return  snap.hasData? Container(
                          child: snap.data.docs.length>0?Container():Container(
                            height: 35,
                            width: 100,

                            child: Card(
                                elevation: 3,
                                margin: EdgeInsets.all(0),
                                color: Colors.white,
                                child: FlatButton(
                                  onPressed: () {
                                    print(docments["roomId"]);
                                    Collection.groupRoom.doc(docments["roomId"].toString())
                                        .update({"members": FieldValue.arrayUnion([UserSingleton.userData.userEmail.toString()])}).whenComplete(() {
                                    });
                                  },
                                  child: FittedBox(child: Text(
                                    "Join Group".toUpperCase(), style: TextStyle(
                                      fontWeight: FontWeight.bold),)),
                                )
                            ),
                          ),
                        ):Container();
                      }


                  ),


                ],
              ),
            ),
          )
        ),
      ),
    );
  }
  else{
    Container();
  }

}



