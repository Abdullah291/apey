import 'package:get/get.dart';

class InterestItem3{
  final id;
  var isSelected=false;
  final data; //Data of the user
  InterestItem3({this.id,this.isSelected,this.data});
}




// class GroupMembers2{
//   GroupMembers2({this.email1});
//   final email1;
// }

class CreateGroupController extends GetxController{

  var switch3=false.obs;
  List<InterestItem3> Interest3=[
    InterestItem3(id:1,isSelected:false,data:"Football"),
    InterestItem3(id:2,isSelected:false,data:"Basketball"),
    InterestItem3(id:3,isSelected:false,data:'Horoscope'),
    InterestItem3(id:4,isSelected:false,data:'Party'),
    InterestItem3(id:5,isSelected:false,data:'Franoe'),
    InterestItem3(id:6,isSelected:false,data:'Barrawer'),
    InterestItem3(id:7,isSelected:false,data:'Economics'),
    InterestItem3(id:8,isSelected:false,data:'Study'),
    InterestItem3(id:9,isSelected:false,data:'particular'),
  ].obs;


  List <InterestItem3> get  GetInterest3=>Interest3;

  List store3=[].obs;

  void selectedInterest(int id,String data){
    var select=Interest3.firstWhere((element) => element.id==id);
    if(!store3.contains(data))
    {
      store3.add(data);
    }
    else{
      store3.remove(data);
    }
    select.isSelected=!select.isSelected;
    update();
  }



  List selectedID = [];

  // RxInt memberID=6.obs;
  List Members2=[];

  // List<GroupMembers2> get MembersGet2 => Members2;



  AddMember(String email){
    if (Members2.contains(email)) {
      Members2.removeWhere((element) =>
      element == email);
      update();
    } else {
      Members2.add(email);
      update();
    }
  }







}