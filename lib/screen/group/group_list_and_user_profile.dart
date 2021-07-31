import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/model/groupDetail_model.dart';
import 'package:apey/screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:apey/constant.dart';
import 'package:apey/screen/hero_animation/profile_photo.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../friend/friends.dart';
import '../chat/chat_head.dart';
import 'editProfile_screen.dart';
import 'group_detail_screen_2.dart';
import 'package:apey/screen/idealPerson/idealperson_screen.dart';

class Group_List_And_User_Profile_Screen extends StatefulWidget {
  @override
  _Group_List_And_User_Profile_ScreenState createState() => _Group_List_And_User_Profile_ScreenState();
}

class _Group_List_And_User_Profile_ScreenState extends State<Group_List_And_User_Profile_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Kthirdcolor2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Ksecoudrycolor2,
                padding: EdgeInsets.symmetric(horizontal: context.responsiveValue(mobile:20,tablet: 50)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: context.responsiveValue(mobile: 10,tablet: 20),bottom:  context.responsiveValue(mobile: 0,tablet: 20),),
                      height:100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width:context.responsiveValue(mobile: 90,tablet: 125),
                            child: UserSingleton.userData.imageUrl!=null? GestureDetector(
                              onTap: (){
                                Get.to(ProfileImage(),transition: Transition.fadeIn,);
                              },
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: "profile_photo",
                                child: Container(
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(UserSingleton.userData.imageUrl,fit: BoxFit.cover,alignment: Alignment.topCenter,),
                                      ),
                                    )),
                              ),
                            ) : Container(
                              child: Image(
                                  image: AssetImage('assets/profile_Image.png'),
                                  height: 100
                              ),
                            ),


                            // Image.network('assets/haeppy_iphone@3x.png'),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(child: Text(UserSingleton.userData.firstName + ' ' + UserSingleton.userData.lastName,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
                                  SizedBox(height: 5,),
                                  Text(UserSingleton.userData.userId,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12),)
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut()
                                      .then((value) => Get.offAll(LoginScreen()));
                                },
                                child: Container(
                                    width:  context.responsiveValue(mobile: 25,tablet: 35),
                                    child:  Image.asset("assets/singout_iphone@3x.png")
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(EditProfileScreen());
                                },
                                child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: context.responsiveValue(mobile: 25,tablet: 35),
                                    child: Image.asset("assets/edit_iphone@3x.png")

                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex:5,
                            child: Container(
                              height: 70,
                              child: Card(
                                elevation: 3,
                                color: Colors.grey[200],
                                margin: EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    StreamBuilder(
                                      stream: Collection.groupRoom.where("createdBy",isEqualTo: UserSingleton.userData.userEmail).snapshots(),
                                      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                        return snapshot.hasData? Container(
                                          margin:EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(snapshot.data.docs.length.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                              SizedBox(height: 3,),
                                              Text("Groups",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),)
                                            ],
                                          ),
                                        ):Container();
                                      }
                                    ),
                                    Container(child: Image.asset('assets/followmember_iphone@3x.png',height: 45,)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 70,
                              child: Card(
                                margin: EdgeInsets.all(0),
                                elevation: 3,
                                color: Colors.grey[200],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    StreamBuilder(
                                      stream: Collection.userFriends.where("by_and_to",
                                          arrayContains: UserSingleton.userData.userEmail)
                                          .where("isFriend",isEqualTo: true).snapshots(),
                                      builder: (context,AsyncSnapshot<QuerySnapshot> snaps) {
                                        return snaps.hasData? Container(
                                          margin:EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                               Text(snaps.data.docs.length.toString(),
                                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                                              ),
                                              SizedBox(height: 3,),
                                              Text("Friends",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),)
                                            ],
                                          ),
                                        ):Container();
                                      }
                                    ),
                                    Container(alignment: Alignment.bottomRight,child: Image.asset('assets/member_iphone@3x.png',height: 45,)),
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
                height: 130,
                padding: EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: Kthirdcolor2,
                  image: DecorationImage(
                      image: AssetImage("assets/Bg2.png"),
                      fit: BoxFit.fill
                  ),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(Friends());
                      },
                      child: Image.asset('assets/addgroup_iphone@3x.png',width: Get.width*0.15,),
                    ),
                    SizedBox(width: 15,),
                    GestureDetector(
                        onTap: (){
                          Get.to(Ideal_person_screen());
                        },
                        child: Image.asset('assets/addedgroup_iphone@3x.png',width: Get.width*0.15,)
                    ),
                    SizedBox(width: 15,),
                    GestureDetector(
                        onTap: (){
                          Get.to(ChatHead());
                        },
                        child: Image.asset('assets/Message_iphone@3x.png',width: Get.width*0.15,)),
                    SizedBox(width: 15,),
                    GestureDetector(
                      onTap: () async{
                        await FirebaseAuth.instance.signOut()
                            .then((value) => Get.offAll(LoginScreen()));
                      },
                        child: Image.asset('assets/Logout_iphone@3x.png',width: Get.width*0.14,)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: context.responsiveValue(mobile:25,tablet: 50)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        Text("Gourp List",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                      ],
                    ),

                    StreamBuilder(
                        stream: Collection.groupRoom.where("createdBy",isEqualTo: UserSingleton.userData.userEmail).snapshots(),
                        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                          return snapshot.hasData? ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context,index){
                                DocumentSnapshot doc= snapshot.data.docs[index];
                                return GestureDetector(
                                  onTap: (){
                                    Get.to(Group_Detail_Screen_2(
                                      roomIds: doc.id,
                                    ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Card(
                                        margin: EdgeInsets.all(0),
                                        child: Container(
                                          height: 80,
                                          alignment: Alignment.center,
                                          child:ListTile(
                                            leading: doc["groupImage"]==null || doc["groupImage"].toString().isEmpty ?

                                            Image.asset("assets/groupchatIcon.png"):Container(
                                                width: 60,
                                                height: 60,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: Image.network(doc["groupImage"],fit: BoxFit.cover,))),

                                            title: Text(doc["groupName"],style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                            subtitle: Text(doc["location"],style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,),
                                            trailing: Image.asset("assets/nextscreendetail_iphone@3x.png",height: 30,),
                                          ),

                                        )

                                    ),
                                  ),
                                );
                              }
                          ):Container();
                        }
                    ),

                    SizedBox(height: 15,),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
