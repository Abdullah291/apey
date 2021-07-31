import 'package:apey/constant.dart';
import 'package:apey/model/groupActivityDetail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupActivityDetailScreen extends StatefulWidget {
  @override
  _GroupActivityDetailScreenState createState() => _GroupActivityDetailScreenState();
}

class _GroupActivityDetailScreenState extends State<GroupActivityDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:Column(
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
                      leading: Container(
                          child: Image.asset(
                            "assets/screenback_iphone@3x.png",
                            height: 25,
                          )),
                      title: Container(
                          margin: EdgeInsets.only(right: 60),
                          child: Text(
                            "Group Activity Detail",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:100,left:context.responsiveValue(mobile: 20,tablet: 50),right:context.responsiveValue(mobile: 20,tablet: 50),),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10,left: 5),
                            child: Text("This Week",style: TextStyle(fontWeight: FontWeight.bold),)),
                        ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount:  Getgadlist.length,
                          shrinkWrap: true,
                          itemBuilder: activityweek,
                        ),
                        SizedBox(height: 15,),
                      ],
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


Widget activityweek(BuildContext context,index) {

  GroupActivityDetail GAD=gadlist[index];

  return Container(
    margin: EdgeInsets.only(top: 15),
    child: Card(
        margin: EdgeInsets.all(0),
        child: Container(
          height: 80,
          alignment: Alignment.center,
          child:ListTile(
              leading: Image.asset(GAD.image,  width:60),
              title: Text(GAD.title,style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
              subtitle: Text(GAD.subtitle,style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,),
            trailing: Image.asset("assets/nextscreendetail_iphone@3x.png",height: 30,),

              ),

        )

    ),
  );
}

