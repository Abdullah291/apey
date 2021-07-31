import 'package:apey/database/userSingleton.dart';
import 'package:get/get.dart';

class InterestItem10{
  final id;
  var isSelected=false;
  final data; //Data of the user
  InterestItem10({this.id,this.isSelected,this.data});
}




// class GroupMembers2{
//   GroupMembers2({this.email1});
//   final email1;
// }

class CreateGroupChatController extends GetxController{



  var switch4=false.obs;
  List<InterestItem10> Interest10=[
    InterestItem10(id:1,isSelected:false,data:"Football"),
    InterestItem10(id:2,isSelected:false,data:"Basketball"),
    InterestItem10(id:3,isSelected:false,data:'Horoscope'),
    InterestItem10(id:4,isSelected:false,data:'Party'),
    InterestItem10(id:5,isSelected:false,data:'Franoe'),
    InterestItem10(id:6,isSelected:false,data:'Barrawer'),
    InterestItem10(id:7,isSelected:false,data:'Economics'),
    InterestItem10(id:8,isSelected:false,data:'Study'),
    InterestItem10(id:9,isSelected:false,data:'particular'),
  ].obs;


  List <InterestItem10> get  GetInterest3=>Interest10;

  List store10=[];

  void selectedInterest(int id,String data){
    var select=Interest10.firstWhere((element) => element.id==id);
    if(!store10.contains(data))
    {
      store10.add(data);
    }
    else{
      store10.remove(data);
    }
    select.isSelected=!select.isSelected;
    update();
  }





  List selectedID = [];

  // RxInt memberID=6.obs;
  List<String> addGroupMember=[];

  // List<GroupMembers2> get MembersGet2 => Members2;



  addMembers(String email){
    if (addGroupMember.contains(email)) {
      addGroupMember.removeWhere((element) =>
      element == email);
      update();
    } else {
      addGroupMember.add(email);
      update();
    }
  }




}