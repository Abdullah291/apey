import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';
import 'package:apey/model/groupActivity_model.dart';

class GroupActivityScreen extends StatefulWidget {
  @override
  _GroupActivityScreenState createState() => _GroupActivityScreenState();
}
class _GroupActivityScreenState extends State<GroupActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/Bg2.png"),
                            fit: BoxFit.fill,
                          )
                      ),
                      child: ListTile(
                        leading: Image.asset("assets/screenback_iphone@3x.png",height: 25,),
                        title: Container(
                          margin: EdgeInsets.only(right: 55),
                          child: Text(
                            "Drink Activity",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),


                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(left: context.responsiveValue(mobile: 20,tablet: 50),right: context.responsiveValue(mobile: 20,tablet: 50),top: 100),
                        child: Column(
                          children: [
                            Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/Cider_iphone@3x.png",
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Drink Activity",
                                          style: TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/calender_iphone@3x.png",
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            "Dec.22,2020",
                                            style: textStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/clock_iphone@3x.png",
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            "20:30",
                                            style: textStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/HomeSpecial place_iphone@3x.png",
                                            height: 25,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                              width: Get.width * 0.6,
                                              child: Text(
                                                "8464 Cedarwood Ave, Lynchburg, VA 24502",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ), overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 35),
                                          width: 250,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(top: 7),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text("Activity Created by",
                                                      style: TextStyle(fontSize: 14,),overflow: TextOverflow.ellipsis,),
                                                    SizedBox(height: 2,),
                                                    SizedBox(
                                                        width: 200,
                                                        child: Container(
                                                            child: Text(
                                                              "Kristina Grebenshehikava",
                                                              style: TextStyle(fontSize: 14,
                                                                  fontWeight: FontWeight.bold),
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 2,)))
                                                  ],
                                                ),
                                              ),
                                              Image.asset("assets/cristinae_iphone@3x.png",height: 40,),
                                            ],
                                          ),

                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),


                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                              alignment: Alignment.centerLeft,
                                child: Text("Participants",style: TextStyle(fontWeight: FontWeight.bold),)),

                            Container(
                              padding: EdgeInsets.symmetric(vertical:10,),
                              child: GridView.builder
                                (
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:  context.responsiveValue(mobile: 3,tablet: 4),
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing:  2,
                                ),
                                itemCount: Getdrinkactivitylist.length,
                                itemBuilder: drnkactivityparticipants,

                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}



Widget drnkactivityparticipants(BuildContext context,index) {

  DrinkActivityParticipants DAP=drinkactivitylist[index];

  return Container(
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(DAP.image,width: context.responsiveValue(mobile: Get.width*0.15,tablet: Get.width*0.12),),
          Text(DAP.title.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
        ],

      ),
    ),
  );
}
