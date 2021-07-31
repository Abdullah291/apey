import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InterestItem{
  final id;
  var isSelected=false;
  final data; //Data of the user
  InterestItem({this.id,this.isSelected,this.data});
}
enum gender{
  male,
  female,
}

class SignUpController extends GetxController{

  var visible=true;

  var selected=null;

  Gender(gender pick){
    if(pick==gender.male)
      {
        selected="male";
      }
    if(pick==gender.female)
      {
        selected="female";
      }
    update();
  }

  List<InterestItem> Interest=[
    InterestItem(id:1,isSelected:false,data:"Football"),
    InterestItem(id:2,isSelected:false,data:"Basketball"),
    InterestItem(id:3,isSelected:false,data:'Horoscope'),
    InterestItem(id:4,isSelected:false,data:'Party'),
    InterestItem(id:5,isSelected:false,data:'Franoe'),
    InterestItem(id:6,isSelected:false,data:'Barrawer'),
    InterestItem(id:7,isSelected:false,data:'Economics'),
    InterestItem(id:8,isSelected:false,data:'Study'),
    InterestItem(id:9,isSelected:false,data:'particular'),
  ].obs;


  List <InterestItem> get  GetInterest=>Interest;

  List store=[];

  void selectedInterest(int id,String data){
    var select=Interest.firstWhere((element) => element.id==id);
    if(!store.contains(data))
      {
        store.add(data);

      }
    else{
      store.remove(data);
     }
    select.isSelected=!select.isSelected;
      update();
  }

}