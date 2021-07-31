

import 'package:get/state_manager.dart';

enum gender2{
  male,
  female,
}


enum eyecolor{
  brown,
  blue,
  coffee,
  Eggplant,
  grey,
}




enum haircolor{
  black,
  blue,
  brown,
  lightbrown,
  grey,
}


enum bodytype{
  fat,
  athlete,
  thin,
}




class CreateIPController  extends GetxController{



  var visible2=true;

  var selected2=null;

  Gender2(gender2 pick){
    if(pick==gender2.male)
    {
      selected2=0;
    }
    if(pick==gender2.female)
    {
      selected2=1;
    }
    update();
  }



//Eye Color

  var visible3=true;

  var selecteyecolor=null;

  EyeColor(var pick){
    if(pick==eyecolor.brown){
      selecteyecolor=eyecolor.brown;
    }
    else if(pick==eyecolor.blue){
      selecteyecolor=eyecolor.blue;
    }
    else if(pick==eyecolor.coffee){
      selecteyecolor=eyecolor.coffee;
    }
    else if(pick==eyecolor.grey){
      selecteyecolor=eyecolor.grey;
    }
    else{
      selecteyecolor=eyecolor.Eggplant;
    }
    update();
  }



//

//hair color

  var visiblehair=true;


  var selecthaircolor=null;

  Hair(var pick){
    if(pick==haircolor.black){
      selecthaircolor=haircolor.black;
    }
    else if(pick==haircolor.blue){
      selecthaircolor=haircolor.blue;
    }
    else if(pick==haircolor.brown){
      selecthaircolor=haircolor.brown;
    }
    else if(pick==haircolor.lightbrown){
      selecthaircolor=haircolor.lightbrown;
    }
    else{
      selecthaircolor=haircolor.grey;
    }
    update();
  }

//

//Body type

var visiblebodytype=true;


  var selectedbodytype=null;


  Bodytype(var pick){
    if(pick==bodytype.fat)
      {
        selectedbodytype=bodytype.fat;
      }
    else if(pick==bodytype.athlete){
      selectedbodytype=bodytype.athlete;
    }
    else{
      selectedbodytype=bodytype.thin;
    }
    update();
  }


//

  
  var selectedAge="18-24".obs;

  var Agelist=["25-30", "31-36","37-42","43-48","49-54","55-60"].obs;

  var selectedInterest="Select Interest".obs;

  var Intereslist=["Football","Basketball",'Horoscope','Party'];

  var selectedcity="Select City".obs;

  var citylist=["United Kingdom","France","Italy","Canada"].obs;
}