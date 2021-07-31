import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/screen/groupProfileDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class FriendRequest extends StatefulWidget {
  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
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
                margin: EdgeInsets.only(top: 25, left: 5),
                child: Text(
                  "Friends Request",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              StreamBuilder(
                  stream: Collection.userFriends.where("friend_to",isEqualTo: UserSingleton.userData.userEmail).
                  where("request",isEqualTo: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData? Column(
                        children:
                        List.generate(snapshot.data.docs.length, (index) {
                          DocumentSnapshot documnents = snapshot.data.docs[index];
                          return friendsRequest(index, documnents);
                        })):Container();
                  }
              ),


            ],
          ),
        ),
      ),
    );
  }
}


Widget friendsRequest(int index,DocumentSnapshot documnents) {

  return StreamBuilder(
     stream:Collection.signUp.where("email",isEqualTo: documnents.data()["friend_by"]).snapshots(),
     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
       return snapshot.hasData ? ListView.builder(
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
                               doc.data()["Image"]..toString() ,
                               fit: BoxFit.cover,
                               width: context.responsiveValue(mobile: Get.width*0.15,tablet: Get.width*0.12),
                             ),
                           ),
                         )),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                             child: Text(
                               doc.data()["name"].toString() +' '+  doc.data()["surName"].toString(),
                               style: TextStyle(
                                   fontSize: 14, fontWeight: FontWeight.bold),
                             )),
                         //     Text(
                         //       snapshot.data["UserID"] as String,
                         //       style: TextStyle(fontSize: 12, color: Colors.grey),
                         //     ),
                         Container(
                           margin: EdgeInsets.only(top: 15),
                           child: Row(
                             children: [
                               Container(
                                 height: 35,
                                 width: Get.width * 0.25,
                                 child: Card(
                                   margin: EdgeInsets.all(0),
                                   // ignore: deprecated_member_use
                                   child: FlatButton(
                                     onPressed: () {
                                       print("Check");
                                       print(doc.id);
                                       Collection.userFriends.doc(documnents.id).update({
                                         'isFriend': true,
                                          'request': false,
                                       });
                                     },
                                     child: FittedBox(child: Text(
                                       "Accept".toUpperCase(), style: TextStyle(
                                         fontWeight: FontWeight.bold),)),
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
                                   // ignore: deprecated_member_use
                                   child: FlatButton(
                                     onPressed: () {
                                       Collection.userFriends.doc(documnents.id).update({
                                         'isFriend': false,
                                         "request": false,
                                       });
                                     },
                                     color: kprimarycolor2,
                                     child: FittedBox(child: Text(
                                       "Delete".toUpperCase(), style: TextStyle(
                                         fontWeight: FontWeight.bold),)),
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




//
// StreamBuilder(
// stream: Collection.userFriends.where("friend_to",isEqualTo: UserSingleton.userData.userEmail).
// where("request",isEqualTo: true).snapshots(),
// builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// return snapshot.hasData? Column(
// children:
// List.generate(snapshot.data.docs.length, (index) {
// DocumentSnapshot doc = snapshot.data.docs[index];
// return StreamBuilder (
// stream: Collection.signUp.where("email", isEqualTo :doc.data()["friend_by"]).snapshots(),
// builder: (BuildContext context, snapshot) {
// if( snapshot.connectionState == ConnectionState.waiting){
// return  Center(child: Text('Please wait its loading...'));
// }
// else{
// if (snapshot.hasError)
// return Center(child: Text('Error: ${snapshot.error}'));
// else
// return Column(
// children: List.generate(snapshot.data.docs.length, (index) {
// DocumentSnapshot doc2 = snapshot.data.docs[index]; // snapshot.data  :- get your object which is pass from your downloadData() function
// return Center(child: new Text('${doc2.data()['name']}'));
// }
// ));
// }
// },

