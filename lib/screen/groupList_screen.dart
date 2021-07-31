import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';
import 'package:apey/model/groupList_model.dart';



class GroupListScreen extends StatefulWidget {
  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: ()
          {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: Ksecoudrycolor,
                            child: ListTile(
                              leading: Image.asset("assets/screenback_iphone@3x.png",height: 25,),
                              title: Container(
                                margin: EdgeInsets.only(right: 55),
                                child: Text(
                                  "Group List",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Bg2.png"),
                                fit:BoxFit.fill,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color:Kthirdcolor2,

                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 15,top: 15),
                                        border: InputBorder.none,
                                        hintText: "Search here.....",hintStyle: TextStyle(fontSize: 12,color: KGreyColor,),
                                        suffixIcon: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/search_iphone@3x.png",height: 25,),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 180),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: context.responsiveValue(mobile: 22,tablet: 50)),
                                      child: Text("Group List",style: textStyle,)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              margin: EdgeInsets.symmetric(horizontal: context.responsiveValue(mobile: 20,tablet: 50),),
                              child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  itemCount: Getgrouplist.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    var gl=grouplist[index];
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Card(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Image.asset(gl.image,width: context.responsiveValue(mobile: Get.width*0.15,tablet: Get.width*0.1),),
                                                      Container(
                                                          margin: EdgeInsets.only(left: 7,top: 15),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(width: Get.width*0.45,child: Text(gl.title.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                              SizedBox(width:  Get.width*0.45,child: Text(gl.subtitle.toString(),style: TextStyle(color: KTertiatColor,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,))
                                                            ],
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    width: 30,
                                                    child: Image.asset("assets/nextscreendetail_iphone@3x.png")),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text("Members: "+gl.members.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                                    Text("Followers: "+gl.followers.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ),
                                    );
                                  },
                              ),
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                      )

                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

