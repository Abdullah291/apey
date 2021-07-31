import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/screen/groupProfileDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ideal_Person_Search_list extends StatefulWidget {
  @override
  _Ideal_Person_Search_listState createState() =>
      _Ideal_Person_Search_listState();
}

class _Ideal_Person_Search_listState extends State<Ideal_Person_Search_list> {
  String searchIdeal = '';

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [

              Container(
                margin: EdgeInsets.only(top: 150),
                child: StreamBuilder(
                    stream: Collection.signUp
                        .where("email",
                            isNotEqualTo: UserSingleton.userData.userEmail)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              padding: EdgeInsets.only(bottom: 20),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot documnents =
                                    snapshot.data.docs[index];
                                return idealPersons(context, documnents);
                              })
                          : Container();
                    }),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Bg.png"), fit: BoxFit.fill)),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                    context.responsiveValue(mobile: 10, tablet: 25)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Ideal Person",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                          left: 10,
                          right: 10,
                        ),
                        height: 45,
                        child: Card(
                          margin: EdgeInsets.all(0),
                          color: Kthirdcolor2,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchIdeal = value.replaceAll(" ", "").toLowerCase();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search here....',
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 15, top: 10),
                              suffixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                    ]
                ),
              )),
        ],
      ),
    );
  }

  Widget idealPersons(BuildContext context, DocumentSnapshot documnents) {
    String toName = documnents
            .data()["UserID"]
            .toString()
            .replaceAll(" ", "")
            .toLowerCase() ??
        ' ';
    if (toName.contains(searchIdeal)) {
      return GestureDetector(
        onTap: () {
          Get.to(GroupProfileDetailScreen(
            image: documnents.data()["Image"],
            email: documnents.data()["email"],
            userid: documnents.data()["UserID"],
            name: documnents.data()["name"],
            surName: documnents.data()["surName"],
            interest: documnents.data()["interest"],
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
                child: Image.network(
                  documnents["Image"].toString() ?? "",
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            )),
            title: Text(
              documnents["name"].toString() +
                  ' ' +
                  documnents["surName"].toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              documnents["UserID"].toString() ?? '',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            trailing: Container(
              width: 90,
              child: StreamBuilder(
                  stream: Collection.ideaPerson
                      .where("add_by",
                          isEqualTo: UserSingleton.userData.userEmail)
                      .where("add_to", isEqualTo: documnents["email"])
                      .where("ideal", isEqualTo: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData
                        ? Container(
                            margin: EdgeInsets.only(top: 15),
                            child: snapshot.data.docs.length > 0
                                ? Container(
                                    height: 35,
                                    width: 80,
                                    child: Card(
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        // ignore: deprecated_member_use
                                        child: Container(
                                            child: FlatButton(
                                          color: KClipperColor,
                                          onPressed: () {
                                            print("checking");
                                            Collection.ideaPerson.doc(snapshot.data.docs.single.id).update({
                                              'ideal':false,
                                            });
                                          },
                                          child: FittedBox(
                                              child: Text(
                                            "Ideal Person".toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                          // ignore: deprecated_member_use
                                        ))))
                                : Container(
                                    height: 35,
                                    width: 80,
                                    child: Card(
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        // ignore: deprecated_member_use
                                        child: Container(
                                            child: FlatButton(
                                          color: KSecondaryColor,
                                          onPressed: () {
                                            print("checking 2");
                                            Collection.ideaPerson
                                                .where("add_by",
                                                    isEqualTo: UserSingleton
                                                        .userData.userEmail)
                                                .where("add_to",
                                                    isEqualTo:
                                                        documnents["email"])
                                                .where("ideal",
                                                    isEqualTo: false)
                                                .get()
                                                .then((value) {
                                              var documents = value.docs;
                                              if (documents.length > 0) {
                                                Collection.ideaPerson
                                                    .doc(documents.single.id)
                                                    .update({
                                                  "ideal": true,
                                                });
                                              } else {
                                                String id = DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString();
                                                Collection.ideaPerson
                                                    .doc(id)
                                                    .set({
                                                  "Created_at": DateTime.now(),
                                                  "id": id,
                                                  "add_by": UserSingleton
                                                      .userData.userEmail,
                                                  "add_to": documnents["email"],
                                                  "ideal": true,
                                                });
                                              }
                                            });
                                          },
                                          child: FittedBox(
                                              child: Text(
                                            "Add Person".toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                          // ignore: deprecated_member_use
                                        )))))
                        : Container();
                  }),
            ),
          ),
        ),
      );
    } else {
      Container();
    }
  }
}
