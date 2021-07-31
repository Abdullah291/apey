import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../groupProfileDetail.dart';
import 'ideal_person_seraching.dart';

class Ideal_person_screen extends StatefulWidget {

  @override
  _Ideal_person_screenState createState() => _Ideal_person_screenState();
}

class _Ideal_person_screenState extends State<Ideal_person_screen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Kthirdcolor,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                          color: Kthirdcolor2,
                          image: DecorationImage(
                            image: AssetImage("assets/Bg.png",),
                            fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            leading: GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Container(
                                  child: Image.asset("assets/screenback_iphone@3x.png",width: 25,)),
                            ),
                            title: Container(
                              margin: EdgeInsets.only(right: 60),
                                child: Center(
                                  child: Text(
                                    "Your ideal person",
                                    style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "❤ ADD A IDEAL PERSON",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(Ideal_Person_Search_list());
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        color: kforhtcolor2,
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:  context.responsiveValue(mobile: 25,tablet: 50), right: context.responsiveValue(mobile: 25,tablet: 50),top: 170),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "Ideal person List:",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),

                        StreamBuilder(
                          stream:Collection.ideaPerson
                                .where("add_by",
                                isEqualTo: UserSingleton.userData.userEmail)
                                .where("ideal", isEqualTo: true)
                                .snapshots(),
                          builder: (context,AsyncSnapshot<QuerySnapshot> snaps) {
                            return snaps.hasData? ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snaps.data.docs.length,
                              itemBuilder: (context , index)
                              {
                                DocumentSnapshot ds= snaps.data.docs[index];
                                return StreamBuilder(
                                  stream: Collection.signUp.where("email",isEqualTo: ds.data()["add_to"]).snapshots(),
                                  builder: (context,AsyncSnapshot<QuerySnapshot> snaps2) {
                                    return snaps2.hasData? Column(
                                      children: List.generate(snaps2.data.docs.length, (index2) {
                                        DocumentSnapshot ds2= snaps2.data.docs[index2];
                                        return GestureDetector(
                                          onTap: (){
                                            Get.to(GroupProfileDetailScreen(
                                              image: ds2.data()["Image"],
                                              email: ds2.data()["email"],
                                              userid: ds2.data()["UserID"],
                                              name: ds2.data()["name"],
                                              surName: ds2.data()["surName"],
                                              interest: ds2.data()["interest"],
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 15),
                                            child: Card(
                                                margin: EdgeInsets.all(0),
                                                child: Container(
                                                  height: 80,
                                                  alignment: Alignment.center,
                                                  child: ListTile(
                                                    leading:Container(
                                                   width:60,
                                                   height:60,
                                                   child:ClipRRect(
                                                      borderRadius: BorderRadius.circular(100),
                                                      child: Image.network(ds2.data()["Image"],
                                                        fit: BoxFit.cover,),
                                                    ),
                                                    ),
                                                    title: Text(ds2.data()["name"] +' '+ ds2.data()["surName"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .bold),
                                                      maxLines: 2,
                                                      overflow: TextOverflow
                                                          .ellipsis,),
                                                    trailing: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 22,
                                                    ),
                                                  ),

                                                )

                                            ),
                                          ),
                                        );
                                      }

                                    )
                                    ):Container();
                                  }
                                );
                              },
                            ):Container();
                          }
                        ),

                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}



