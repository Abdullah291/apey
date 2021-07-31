// import 'package:apey/database/collection.dart';
// import 'package:apey/database/userSingleton.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class Group_Post extends StatefulWidget {
//   @override
//   _Group_PostState createState() => _Group_PostState();
// }
//
// class _Group_PostState extends State<Group_Post> {
//   bool like=false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 15, left: 20, right: 20),
//       child: SingleChildScrollView(
//         child: StreamBuilder(
//           stream: Collection.userPosts.snapshots(),
//           builder: (context, snapshot) {
//             return snapshot.hasData
//                 ? Column(
//               children: List.generate(snapshot.data.docs.length, (index) {
//                 DocumentSnapshot doc = snapshot.data.docs[index];
//                 return posts(index, doc);
//               }),
//              )
//                 : Container(
//               margin: EdgeInsets.only(top: Get.height * 0.4),
//               child: Center(
//                 child: CircularProgressIndicator(
//                   backgroundColor: Colors.blue,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget posts(int index, DocumentSnapshot doc) {
//
//
//     return FutureBuilder(
//         future: Collection.signUp.doc(doc.data()["userEmail"]).get(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasData) {
//             return Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   ListTile(
//                     contentPadding: EdgeInsets.symmetric(horizontal: 0),
//                     title: Text(
//                       snapshot.data["userName"].toString(),
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(snapshot.data["email"].toString(),
//                         style: TextStyle(
//                           fontSize: 14,
//                         )),
//                     leading: CircleAvatar(
//                       child: Image.network(snapshot.data["Image"].toString()),
//                     ),
//                   ),
//                   Container(
//                     height: 200,
//                     child: Image.network(
//                       doc.data()["Image"],
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
//                     child: Row(
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(
//                                 icon: StreamBuilder(
//                                     stream: Collection.userLikePost
//                                            .where("post_id",isEqualTo: doc.data()["key"]).
//                                          where("user_id",isEqualTo: UserSingleton.userData.userEmail).
//                                          where("isLike",isEqualTo: true).
//                                     snapshots(),
//                                     builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
//                                       return snapshot.hasData? Icon(
//                                         Icons.favorite,
//                                         color: snapshot.data.docs.length>0?Colors.red:Colors.grey,
//                                         size: 30,
//                                       ):Icon(
//                                         Icons.favorite,
//                                         color: Colors.grey,
//                                         size: 30,
//                                       );
//                                     }
//                                 ),
//                                 onPressed: () {
//
//                                   Collection.userLikePost.where("post_id",isEqualTo: doc.data()["key"]).
//                                   where("user_id",isEqualTo: UserSingleton.userData.userEmail).
//                                   get().then((value) {
//                                     var docs = value.docs;
//                                     print("cool");
//                                     print(docs);
//                                     if(docs.length>0){
//                                       setState(() {
//                                         like=false;
//                                       });
//                                       docs.forEach((element) {
//                                         if(element.data()["isLike"] == false){
//                                           Collection.userLikePost.doc(element.data()["key"]).
//                                           update({"isLike":true});
//                                         }
//                                         else{
//                                           Collection.userLikePost.
//                                           doc(element.data()["key"]).
//                                           update({"isLike":false});
//                                         }
//                                       });
//                                     }
//                                     else{
//                                       setState(() {
//                                         like=true;
//                                       });
//                                       var id = Timestamp.now()
//                                           .millisecondsSinceEpoch
//                                           .toString();
//                                       Collection.userLikePost.doc(id)
//                                           .set({
//                                         "created_at": Timestamp.now(),
//                                         "isLike": true,
//                                         "key": id,
//                                         "post_id": doc.data()["key"],
//                                         "status": 1,
//                                         "user_id": UserSingleton.userData.userEmail
//                                       });
//                                     }
//                                   });}),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             StreamBuilder(
//                               stream: Collection.userLikePost
//                                   .where("post_id",isEqualTo: doc.data()["key"]).
//                               where("isLike",isEqualTo: true).
//                               snapshots(),
//                               builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
//                                 return snapshot.hasData? Text(
//                                   snapshot.data.docs.length.toString(),
//                                   style: TextStyle(
//                                       fontSize: 18, fontWeight: FontWeight.w600),
//                                 ):Text("0");
//                               },
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             // Get.to(Comment(
//                             //   postID: doc.id,
//                             // ));
//                           },
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.comment,
//                                 color: Colors.grey,
//                                 size: 28,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               StreamBuilder(
//                                   stream: Collection.userCommentPost.
//                                       where("post_Id", isEqualTo: doc.id)
//                                       .snapshots(),
//                                   builder: (context, snapshots) {
//                                     return snapshots.hasData ? Text(
//                                       "${snapshots.data.docs.length}",
//                                       style: TextStyle(
//                                           fontSize: 18, fontWeight: FontWeight.w600),
//                                     ):Text(
//                                       "0",
//                                       style: TextStyle(
//                                           fontSize: 18, fontWeight: FontWeight.w600),
//                                     );
//                                   }
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.share,
//                               color: Colors.grey,
//                               size: 28,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               "0",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Container(
//               margin: EdgeInsets.only(top: Get.height * 0.4),
//               child: Center(
//                 child: CircularProgressIndicator(
//                   backgroundColor: Colors.blue,
//                 ),
//               ),
//             );
//           }
//         });
//   }
// }
