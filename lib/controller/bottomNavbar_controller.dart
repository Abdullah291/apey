import 'package:apey/screen/group/create_group_room_2.dart';
import 'package:apey/screen/group_chat/group_chat%20_head.dart';
import 'package:apey/screen/home_screen.dart';
import 'package:apey/screen/search_screen.dart';
import 'package:get/get.dart';
import 'package:apey/screen/group/group_list_and_user_profile.dart';


class BottomNavBarController extends GetxController{

  List li=[HomeScreen(),SearchScreen(),Create_Group_Room_2(),Group_Chat_Head(),Group_List_And_User_Profile_Screen()];

 int currentIndex=0;

 onSelected(int index){
   currentIndex=index;
   update();
 }

}