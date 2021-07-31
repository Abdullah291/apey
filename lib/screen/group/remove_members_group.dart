import 'package:apey/constant.dart';
import 'package:apey/controller/createGroup_controller.dart';
import 'package:apey/database/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class Remove_Member_from_Group extends StatefulWidget {

  final groupId;
  Remove_Member_from_Group({this.groupId});
  @override
  _Remove_Member_from_GroupState createState() => _Remove_Member_from_GroupState();
}

class _Remove_Member_from_GroupState extends State<Remove_Member_from_Group> {


  String searchString6 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "Remove Members",
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
                                      searchString6 = value.replaceAll(" ", "").toLowerCase();
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
                              stream: Collection.groupRoom.where("roomId",isEqualTo: widget.groupId).snapshots(),
                              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                return snapshot.hasData? Column(
                                  children: List.generate(snapshot.data.docs.length, (index){
                                     DocumentSnapshot doc1=snapshot.data.docs[index];
                                     return Column(
                                       children: List.generate(doc1["members"].length, (index2)
                                     {
                                       print("coolung");
                                       return StreamBuilder(
                                           stream: Collection.signUp.where("email", isEqualTo: doc1["members"][index2])
                                               .snapshots(),
                                           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                                             return snapshot2.hasData ? ListView.builder(padding: EdgeInsets.only(bottom: 20),
                                                 shrinkWrap: true,
                                                 physics: ClampingScrollPhysics(),
                                                 itemCount: snapshot2.data.docs.length,
                                                 itemBuilder: (context, index3) {
                                                   DocumentSnapshot documnents = snapshot2.data.docs[index3];
                                                   return makeFriend(context, documnents,doc1,index2);
                                                 }) : Container();
                                           }
                                       );
                                     }
                                       )
                                     );
                                  }
                                ),
                              ):Container();
                                }
                            )
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
    );
  }
  Widget makeFriend(BuildContext context,documnents,doc1,index2) {

    List<String> members=List.from(doc1["members"]);

    String toName =  documnents.data()["UserID"].toString().replaceAll(" ", "").toLowerCase() ?? ' ';
    if (toName.contains(searchString6)) {
      return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: GestureDetector(
                onTap: (){

                  print("This is list");

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
                            documnents["Image"],
                            fit: BoxFit.cover,
                            width: context.responsiveValue(
                                mobile: Get.width * 0.15, tablet: Get.width * 0.12),
                          ),
                        ),
                      ),
                      title: Text(
                        documnents["name"] + ' ' + documnents["surName"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        documnents["UserID"],
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      trailing: GestureDetector(
                        onTap: (){
                          members.removeWhere((element) => element == doc1["members"][index2]);
                          Collection.groupRoom.doc(widget.groupId).update({"members": members});
                        },
                        child: Container(
                            width: 50,
                            margin: EdgeInsets.only(right: 8,top: 5),
                            child: Image.asset("assets/delete_iphone@3x.png",height: 26,color:KBlueColor,)),
                      ),
                    ),

                  ),
                ),
              )
      );
    }
    else{
      Container();
    }
  }
}
