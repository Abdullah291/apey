
import 'package:get/get.dart';


class IdealPerson{
  final image;
  final title;
  IdealPerson({this.image,this.title});
}



  List<IdealPerson>  Idealpersonlist=[
    IdealPerson(image:"assets/cristinaa_iphone@3x.png", title: "My Princes",),
    IdealPerson(image:"assets/cristina_iphone@3x.png", title:"My Mom",),
    IdealPerson(image:"assets/Roxana Carabas_iphone@3x.png", title: "My Princes",),
    IdealPerson(image:"assets/cristinai_iphone@3x.png", title:"My Mom",),
    IdealPerson(image:"assets/krstina_iphone@3x.png", title:"My Princes",),
    IdealPerson(image:"assets/cristinai_iphone@3x.png", title:"My Mom",),
  ];

  List get GetIdealperson=>Idealpersonlist;

