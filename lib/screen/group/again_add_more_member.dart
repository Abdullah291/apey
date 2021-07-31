

import 'package:apey/controller/createGroup_controller.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';



String searchString7 = '';

class Again_Add_More_Members_2 extends StatefulWidget {

  String roomIds;
  List<String> newMembers;

  Again_Add_More_Members_2({this.roomIds,this.newMembers});

  @override
  _Again_Add_More_Members_2State createState() => _Again_Add_More_Members_2State();
}

class _Again_Add_More_Members_2State extends State<Again_Add_More_Members_2> {

  CreateGroupController  controller=Get.put(CreateGroupController());


  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/b.png"),
                            fit: BoxFit.fill)),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                          context.responsiveValue(mobile: 10, tablet: 25)),
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.rotate(angle: 3.1,child: Image.asset("assets/arrow_iphone@3x.png",width: 25,height: 24,color: Colors.black,)),
                            ],
                          ),
                        ),
                        title: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Add Members",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // ignore: deprecated_member_use
                        trailing:  Container(
                          width: 80,
                          child: FlatButton(
                              color: KBlueColor,
                              onPressed: (){

                                 Collection.groupRoom.doc(widget.roomIds.toString())
                                 .update({"members": FieldValue.arrayUnion(controller.Members2)}).whenComplete(() {

                                 }).whenComplete(() {
                                 controller.Members2.forEach((element) async {
                                 var key = DateTime.now().millisecondsSinceEpoch.toString();
                                 await Collection.blockGroupUser
                                     .doc(key)
                                     .set({
                                      "room_id": widget.roomIds,
                                      "id": key,
                                      "user": element,
                                     "status": true,
                                 }).whenComplete(() => controller.Members2.clear());
                                 });
                                 } ).whenComplete(() => Get.back());
                              }, child: FittedBox(
                              child: Text("Done",style: TextStyle(color: Colors.white),))),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    child:  Container(
                      margin: EdgeInsets.only(top: 80),
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
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
                                        searchString7 = value.replaceAll(" ", "").toLowerCase();
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
                                  stream: Collection.signUp.where("email",isNotEqualTo: UserSingleton.userData.userEmail).
                                  where("email",whereIn: widget.newMembers).snapshots(),
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
                    ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget makeFriend(BuildContext context, DocumentSnapshot documnents) {

    String toName =  documnents.data()["UserID"].toString().replaceAll(" ", "").toLowerCase() ?? ' ';
    if (toName.contains(searchString7)) {
      return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: GetBuilder<CreateGroupController>(
            init: CreateGroupController(),
            builder: (controller) {
              return GestureDetector(
                onTap: (){
                  controller.AddMember(documnents.data()["email"]);
                  print("This is list");
                  print(controller.Members2);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 80,
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 60,
                          width: 60,
                          child: Image.network(
                            documnents.data()["Image"],
                            fit: BoxFit.cover,
                            width: context.responsiveValue(
                                mobile: Get.width * 0.15, tablet: Get.width * 0.12),
                          ),
                        ),
                      ),
                      title: Text(
                        documnents.data()["name"] + ' ' + documnents.data()["surName"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        documnents.data()["UserID"],
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      trailing: controller.Members2.contains(documnents.data()["email"])?Container(
                          width: 50,
                          margin: EdgeInsets.only(right: 8,top: 5),
                          child: Image.asset("assets/select_iphone@3x.png",height: 26,)):Container(width: 1,),
                    ),

                  ),
                ),
              );
            }
        ),
      );
    }
    else{
      Container();
    }
  }

}



















