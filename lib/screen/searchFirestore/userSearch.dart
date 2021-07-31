import 'package:apey/constant.dart';
import 'package:apey/controller/createGroup_controller.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/screen/groupProfileDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firestoreSearchPackage.dart';
//

class SearchFeed extends StatefulWidget {
  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {

  CreateGroupController  controller=Get.put(CreateGroupController());



  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      scaffoldBackgroundColor: Kthirdcolor2,
      appBarBackgroundColor: Kthirdcolor2,
      searchBackgroundColor: Kthirdcolor2,
      searchBodyBackgroundColor: Kthirdcolor2,
      backButtonColor: Colors.amber,
      firestoreCollectionName: 'SignUp',
      searchBy: "name",
      dataListFromSnapshot: DataModel().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DataModel> dataList = snapshot.data;

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataList?.length ?? 0,
              itemBuilder: (context, index) {
                final DataModel data = dataList[index];

                return Container(
                  height: 80,
                  child: ListTile(
                    leading: Container(
                        child: Container(
                          height: 55,
                          width: 55,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(data?.image.toString() ?? '',fit: BoxFit.cover,alignment: Alignment.topCenter,),
                          ),
                        )),
                       title:  Text(data?.name.toString() + ' ' + data?.surName.toString() ,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                       subtitle:  Text(data?.UserID.toString() ?? '',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12),),
                       trailing:  Container(
                         margin: EdgeInsets.only(top: 15),
                         child: Container(
                               height: 35,
                               width: 100,
                               child: Card(
                                 elevation: 5,
                                 margin: EdgeInsets.all(0),
                                 child: FlatButton(
                                   onPressed: () {},
                                   child: FittedBox(child: Text("Add Member".toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),)),
                                 ),
                               ),
                             ),


                       ),
                  ),
                );


              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      scaffoldBody: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            child: StreamBuilder(
              stream: Collection.signUp.where("email",isNotEqualTo: UserSingleton.userData.userEmail).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data.docs[index];
                              print(doc.data()["interest"]);
                            return GestureDetector(
                              onTap: (){
                                Get.to(GroupProfileDetailScreen(
                                  image: doc.data()["Image"],
                                  email: doc.data()["email"],
                                  userid: doc.data()["UserID"],
                                  name: doc.data()["name"],
                                  surName: doc.data()["surName"],
                                  interest : doc.data()["interest"],
                                ));
                              },
                              child: Container(
                                height: 80,
                                child: ListTile(
                                  leading: Container(
                                      child: Container(
                                        height: 55,
                                        width: 55,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.network(doc["Image"].toString() ?? "",fit: BoxFit.cover,alignment: Alignment.topCenter,),
                                        ),
                                      )),
                                  title:  Text(doc["name"].toString()+ ' ' + doc["surName"].toString() ,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                  subtitle:  Text(doc["UserID"].toString() ?? '',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12),),
                                  trailing:  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Card(
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        // ignore: deprecated_member_use
                                        child:  StreamBuilder(
                                          stream: Collection.groupRoom.where("createdBy",isEqualTo: UserSingleton.userData.userEmail).
                                            where("members", arrayContains: "coolboy123@gmail.com").snapshots(),
                                          builder: (context, AsyncSnapshot<QuerySnapshot> Fsnapshot) {
                                            return Fsnapshot.hasData?Container(
                                                child:Fsnapshot.data.docs.length>0?
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                    color: Kthirdcolor2,
                                                    onPressed: () {
                                                      // Collection.groupMember.doc(doc["new_id"]).delete();
                                                    },
                                                    child: FittedBox(child: Text("Already Member".toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),)),
                                                  // ignore: deprecated_member_use
                                                  ) :FlatButton(
                                              color: controller.selectedID.contains(doc.id)?Colors.yellow:Colors.white,
                                              onPressed: () {
                                                  controller.AddMember(doc.data()["email"]);
                                              },
                                              child: FittedBox(child: Text("Add Member".toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),)),
                                              // ignore: deprecated_member_use
                                            )
                                            ) :Container();

                                          },
                                        )
                                        )

                                        ),
                                      ),
                                    ),




                              ),
                            );
                          }
                        );



                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          // Text("See More Members",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          // Container(
          //   child:  StreamBuilder(
          //     stream: Collection.signUp.snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //             return ListView.builder(
          //                 physics: ClampingScrollPhysics(),
          //                 shrinkWrap: true,
          //                 itemCount: snapshot.data.docs.length,
          //                 itemBuilder: (context, index) {
          //                   DocumentSnapshot doc = snapshot.data.docs[index];
          //
          //                   return StreamBuilder(
          //                     stream: Collection.groupMember.where("Admin",isEqualTo:UserSingleton.userData.userEmail).
          //                       where("Member",isEqualTo: doc["email"]).snapshots(),
          //                     builder: (context, Secondsnapshot) {
          //
          //                       return Secondsnapshot.hasData?Container():Container(
          //                         height: 80,
          //                         child: ListTile(
          //                           leading: Container(
          //                               child: Container(
          //                                 height: 55,
          //                                 width: 55,
          //                                 child: ClipRRect(
          //                                   borderRadius: BorderRadius.circular(100),
          //                                   child: Image.network(doc["Image"].toString() ?? "",fit: BoxFit.cover,alignment: Alignment.topCenter,),
          //                                 ),
          //                               )),
          //                           title:  Text(doc["name"].toString()+ ' ' + doc["surName"].toString() ,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
          //                           subtitle:  Text(doc["UserID"].toString() ?? '',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12),),
          //                           trailing:  Container(
          //                             margin: EdgeInsets.only(top: 15),
          //                             child: Container(
          //                               height: 35,
          //                               width: 100,
          //                               child: Card(
          //                                   elevation: 5,
          //                                   margin: EdgeInsets.all(0),
          //                                   // ignore: deprecated_member_use
          //                                   child:  FlatButton(
          //                                     color: controller.selectedID.contains(doc.id)?Colors.yellow:Colors.white,
          //                                     onPressed: () {
          //                                       setState(() {
          //                                         if (!controller.selectedID.contains(doc.id)) {
          //                                           controller.selectedID.add(doc.id);
          //                                           print("selected ID");
          //                                           print(controller.selectedID.length);
          //                                           print(doc.id);
          //                                         } else {
          //                                           controller.selectedID.remove(doc.id);
          //                                           print("Remove Id");
          //                                           print(controller.selectedID.length);
          //                                           print(doc.id);
          //                                         }
          //                                       });
          //                                     },
          //                                     child: FittedBox(child: Text("Already Member".toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),)),
          //                                     // ignore: deprecated_member_use
          //                                   )
          //
          //                               ),
          //
          //
          //
          //
          //
          //                             ),
          //                           ),
          //
          //
          //                         ),
          //
          //                       );
          //                     }
          //                   );
          //
          //
          //                 });
          //
          //
          //       }
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class DataModel {
  final String image;
  final String name;
  final String surName;
  final String email;
  final String UserID;

  DataModel({this.image,this.name,this.surName,this.email,this.UserID});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map dataMap = snapshot.data();

      return DataModel(
          image: dataMap['Image'],
          name: dataMap['name'],
          surName: dataMap['surName'],
          email: dataMap['email'],
          UserID: dataMap['UserID']
      );
    }).toList();
  }
}