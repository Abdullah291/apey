import 'package:get/get.dart';


class InterestItem3{
  final id;
  var isSelected=false;
  final data; //Data of the user
  InterestItem3({this.id,this.isSelected,this.data});
}

class EditProfileController extends GetxController{


  var selected=null;


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

  List store2=[];

  void selectedInterest(int id,String data){
    var select=Interest3.firstWhere((element) => element.id==id);
    if(!store2.contains(data))
    {
      store2.add(data);

    }
    else{
      store2.remove(data);
    }
    select.isSelected=!select.isSelected;
    update();
  }

  var selectedlanguage="English".obs;

  var languagelist=["English", "Urdu","French","Chinese","Spanish","Russian"].obs;


}