import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/screen/bottomNavBar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';
class DetailListDetailScreen extends StatefulWidget {
  
  final roomIds;
  DetailListDetailScreen({this.roomIds});

  @override
  _DetailListDetailScreenState createState() => _DetailListDetailScreenState();
}

class _DetailListDetailScreenState extends State<DetailListDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Kthirdcolor,
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: Collection.groupRoom.where("roomId",isEqualTo: widget.roomIds).snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.hasData? Column(
                children: List.generate(snapshot.data.docs.length, (index) {
                  DocumentSnapshot doc = snapshot.data.docs[index];
                  return Container(
                    color: Ksecoudrycolor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
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
                              margin: EdgeInsets.only(right: 60),
                              child: Text(
                                "Group Detail",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: context.responsiveValue(
                                  mobile: 20, tablet: 50)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                  height: 200,
                                  width: Get.width,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(doc["groupImage"],fit: BoxFit.cover,))
                              ),
                              SizedBox(height: 5,),
                              Text(doc["groupName"], style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,),
                                textAlign: TextAlign.center,),
                              SizedBox(height: 5,),
                              Text("Nice! love the material!!",
                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,),
                              StreamBuilder(
                                stream: Collection.signUp.where("email",isEqualTo: doc["createdBy"]).snapshots(),
                                builder: (context, ssnapshot) {
                                  return ssnapshot.hasData? Column(
                                    children: List.generate(ssnapshot.data.docs.length, (index2) {
                                      DocumentSnapshot doc2=ssnapshot.data.docs[index2];
                                      return Container(
                                        padding: EdgeInsets.only(left: 10,top: 2,bottom: 2,right: 10),
                                        margin: EdgeInsets.only(top: 15),
                                        width: Get.width*0.9,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              100),
                                          color: Colors.grey[100],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Image.network(
                                                  doc2["Image"],
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                  height: 30,),
                                              ),
                                            ),
                                              SizedBox(width: 15,),
                                            Flexible(
                                              child: Container(
                                                width: Get.width*0.6,
                                                child: Text("Created By: "+ doc2["name"] +' '+ doc2["surName"],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                  overflow: TextOverflow.ellipsis,),
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
                              SizedBox(height: 20,),
                              Container(
                                height: 90,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        height: 70,
                                        child: Card(
                                          elevation: 3,
                                          color: Colors.grey[200],
                                          margin: EdgeInsets.all(0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .end,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(doc["members"].length.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 16),),
                                                    SizedBox(height: 3,),
                                                    Text("Members",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 10),)
                                                  ],
                                                ),
                                              ),
                                              Container(child: Image.asset(
                                                'assets/followmember_iphone@3x.png',
                                                height: 45,)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/Bg2.png"),
                                  fit: BoxFit.fill
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 35, bottom: 3),
                                  child: Text("Main interest Runing",
                                    style: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,))
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: 35, right: 15, top: 5),
                            child: Wrap(
                              children: List.generate(doc["interest"].length, (index3){
                                  return Text(
                                  doc["interest"][index3]+", ",
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,);
                                  }
                              )         )
                        ),

                        StreamBuilder(
                            stream: Collection.groupRoom.where("roomId",isEqualTo:widget.roomIds).where("members",
                                arrayContains: UserSingleton.userData.userEmail).snapshots(),
                          builder: (context,AsyncSnapshot<QuerySnapshot> snaps) {
                            return snaps.hasData? ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Kthirdcolor, BlendMode.modulate),
                              child: Container(
                                height: context.responsiveValue(
                                    mobile: 100, tablet: 200),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/idealpersonbg_iphone@3x_2.png"),
                                      fit: BoxFit.fill
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: context.responsiveValue(
                                          mobile: 0, tablet: 30),
                                      left: context.responsiveValue(
                                          mobile: 25, tablet: 50),
                                      right: context.responsiveValue(
                                          mobile: 25, tablet: 50)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snaps.data.docs.length>0? Container(
                                        margin: EdgeInsets.only(top: 35),
                                        height: 45,
                                        child: FlatButton(
                                          onPressed: () {
                                            Collection.groupRoom.doc(widget.roomIds).update({
                                              "members":FieldValue.arrayRemove([UserSingleton.userData.userEmail])}).whenComplete(() => Get.offAll(BottomnavbarScreen()));

                                          },
                                          color: kprimarycolor,
                                          child: Text("Exit Group",
                                            style: TextStyle(color: kforhtcolor),),
                                        ),
                                      ): Container(
                                        margin: EdgeInsets.only(top: 35),
                                        height: 45,
                                        child: FlatButton(
                                          onPressed: () {
                                            print(widget.roomIds);
                                            Collection.groupRoom.doc(widget.roomIds.toString())
                                                .update({"members": FieldValue.arrayUnion([UserSingleton.userData.userEmail.toString()])});
                                                },
                                          color: kprimarycolor,
                                          child: Text("Join Group",
                                            style: TextStyle(color: kforhtcolor),),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                            ):Container();
                          }
                        )
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
    );
  }
}
