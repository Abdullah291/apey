import 'package:apey/controller/group_bnb_controller.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/model/home_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:apey/constant.dart';
import 'homeFeed_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldkey13=GlobalKey<ScaffoldState>();

  bool like=false;

  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldkey13,
        backgroundColor: Kthirdcolor2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: Kthirdcolor2,
                      image: DecorationImage(
                          image: AssetImage("assets/Bg2.png"),fit: BoxFit.fill),
                    ),
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(right: 10,top: 5),
                          child: Text(
                            "Home",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,
                          )),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(left:  context.responsiveValue(mobile: 20,tablet: 50), right: context.responsiveValue(mobile: 20,tablet: 50),top: 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10,left: 5),
                            child: Text("Your group activity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                        StreamBuilder(
                          stream: Collection.groupRoom.snapshots(),
                          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                            return snapshot.hasData? ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder :(context,index){
                                  DocumentSnapshot documents=snapshot.data.docs[index];
                                   return groupactivity(index,documents,);
                                  },

                            ):Container();
                          }
                        ),

                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
  Widget groupactivity(int index,DocumentSnapshot documents){
    return GestureDetector(

      onTap: (){
        Get.to(HomeFeedScreen(roomIds:documents["roomId"]));
      },
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              margin: EdgeInsets.all(0),
              color:Ksecoudrycolor2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15,left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: context.responsiveValue(
                                    mobile: 50, tablet: 125),
                                height: context.responsiveValue(
                                    mobile: 50, tablet: 125),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(documents["groupImage"],
                                    fit: BoxFit.cover,
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(documents["groupName"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                    Text(documents["members"].length.toString() + " Memebers",style: TextStyle(fontSize: 10,color: Colors.grey),),
                                  ],
                                ),
                              ),
                            ],

                          ),
                        ),
                      //   Container(
                      //       margin: EdgeInsets.only(top: 15,right: 15),
                      //       child: Text("Cool",style: TextStyle(color: Color(0xfff2567f),fontWeight: FontWeight.bold),))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                      child:
                      documents["about"]!=null && documents["about"].toString().isNotEmpty?
                      Container(
                        child: ExpandableText(
                          documents["about"]+" ",
                          expandText: 'Seemore',
                          collapseText: 'Seeless',
                          maxLines: 3,
                          linkStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          linkColor: KBlueColor,
                          style: TextStyle(fontSize: 14),
                        ),
                      ):Container(),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 15,bottom: 10),
                          height: 45,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Kthirdcolor,
                          ),
                          child: Center(child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(icon:  StreamBuilder(
                                      stream: Collection.userLikeGroup
                                          .where("group_id",isEqualTo: documents["roomId"]).
                                      where("user_id",isEqualTo: UserSingleton.userData.userEmail).
                                      where("isLike", isEqualTo: true).
                                      snapshots(),
                                      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                        return snapshot.hasData?  Image.asset("assets/like_iphone@3x.png",width: 25,
                                          color:snapshot.data.docs.length>0?Colors.red:Colors.white,):Container();
                                      }
                                  ),
                                      onPressed: (){
                                        Collection.userLikeGroup
                                            .where("group_id",isEqualTo: documents["roomId"]).
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
                                                Collection.userLikeGroup.
                                                doc(element.data()["key"]).
                                                update({
                                                  "isLike":true,
                                                  "isDislike":false,
                                                });
                                              }
                                              else{
                                                Collection.userLikeGroup.
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
                                            var id = Timestamp.now().millisecondsSinceEpoch.toString();
                                            Collection.userLikeGroup.doc(id)
                                                .set({
                                              "created_at": Timestamp.now(),
                                              "isLike": true,
                                              "isDislike":false,
                                              "key": id,
                                              "group_id": documents["roomId"],
                                              "status": 1,
                                              "user_id": UserSingleton.userData.userEmail
                                            });
                                          }
                                        });

                                      }
                                  ),
                                  StreamBuilder(
                                    stream: Collection.userLikeGroup
                                        .where("group_id",isEqualTo: documents["roomId"]).
                                    where("isLike",isEqualTo: true).
                                    snapshots(),
                                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                      return snapshot.hasData? Text(
                                        snapshot.data.docs.length.toString(),
                                        style:TextStyle(fontSize: 12,color: Colors.black),
                                      ):Text("0",style: TextStyle(fontSize: 12,color: Colors.black),);
                                    },
                                  ),
                                  SizedBox(width: 12,),
                                  IconButton(icon:  StreamBuilder(
                                      stream: Collection.userLikeGroup
                                          .where("group_id",isEqualTo: documents["roomId"]).
                                      where("user_id",isEqualTo: UserSingleton.userData.userEmail).
                                      where("isDislike", isEqualTo: true).
                                      snapshots(),
                                      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                        return snapshot.hasData?  FaIcon(FontAwesomeIcons.heartBroken,size: 23,
                                          color:snapshot.data.docs.length>0?Colors.red:Colors.white,):Container();
                                      }
                                  ),
                                      onPressed: (){
                                        Collection.userLikeGroup
                                            .where("group_id",isEqualTo: documents["roomId"]).
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
                                                Collection.userLikeGroup.
                                                doc(element.data()["key"]).
                                                update({
                                                  "isLike":false,
                                                  "isDislike":true,
                                                });
                                              }
                                              else{
                                                Collection.userLikeGroup.
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
                                            Collection.userLikeGroup.doc(id)
                                                .set({
                                              "created_at": Timestamp.now(),
                                              "isLike": false,
                                              "isDislike":true,
                                              "key": id,
                                              "group_id": documents["roomId"],
                                              "status": 1,
                                              "user_id": UserSingleton.userData.userEmail
                                            });
                                          }
                                        });


                                      }),

                                  StreamBuilder(
                                    stream: Collection.userLikeGroup
                                        .where("group_id",isEqualTo: documents["roomId"]).
                                    where("isDislike",isEqualTo: true).
                                    snapshots(),
                                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                      return snapshot.hasData? Text(
                                        snapshot.data.docs.length.toString(),
                                        style:TextStyle(fontSize: 12,color: Colors.black),
                                      ):Text("0",style: TextStyle(fontSize: 12,color: Colors.black),);
                                    },
                                  ),

                                ],
                              ),
                            ],
                          ),




                          ),
                        ),

                       
                       StreamBuilder(
                         stream: Collection.groupRoom.where("members",arrayContains: UserSingleton.userData.userEmail).where("roomId",isEqualTo: documents["roomId"]).snapshots(),
                         builder: (context,AsyncSnapshot<QuerySnapshot> snap){
                           return  snap.hasData? Container(
                             child: snap.data.docs.length>0?Container(): Container(
                             height: 40,
                             decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             border: Border.all(color:kforhtcolor2)
                             ),
                             margin: EdgeInsets.only(top: 15,right: 15),
                             child: FlatButton(
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14),),
                             onPressed: (){
                             print(documents["roomId"]);
                             Collection.groupRoom.doc(documents["roomId"].toString())
                                 .update({"members": FieldValue.arrayUnion([UserSingleton.userData.userEmail.toString()])}).whenComplete(() {
                             });
                             },
                             height: 40,
                             minWidth: 100,
                             child: Center(child: FittedBox(child: Text("Join",style: TextStyle(color: kforhtcolor2,fontWeight: FontWeight.bold,fontSize: 12),))),
                       ),
                       ),
                           ):Container();
                         }
                         

                       )
                      ],
                    ),





                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}





class TopGroup extends StatefulWidget {
  TopGroup({this.imgpt,this.txtpt,this.txtlast});
  final imgpt;
  final txtpt;
  final txtlast;
  @override
  _TopGroupState createState() => _TopGroupState();
}

class _TopGroupState extends State<TopGroup> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        height: 125 ,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(10),
          color:Ksecoudrycolor2,
        ),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5,),
              Image.asset(widget.imgpt,height: 50,),
              Flexible(child: Text(widget.txtpt,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
              Flexible(child: Text(widget.txtlast,style: TextStyle(color: Colors.grey,fontSize: 12),overflow: TextOverflow.ellipsis,)),
              SizedBox(height: 5,),
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    color: Colors.black,
                    width: 0,height: 0,),
                    Positioned(
                      bottom: -20,
                      right: -13,
                      child: Container(
                        margin: EdgeInsets.only(left:0),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kprimarycolor2,
                          border: Border.all(color: Colors.grey[200],width: 2),
                        ),
                        child: Icon(Icons.arrow_forward_ios,size: 12,),
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