import 'dart:io';
import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apey/controller/groupChat_controller/createGroup_chat_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'addGroudMember.dart';


class CreateGroupRoomScreen extends StatefulWidget {
  @override
  _CreateGroupRoomScreenState createState() => _CreateGroupRoomScreenState();
}

class _CreateGroupRoomScreenState extends State<CreateGroupRoomScreen> {

  ProgressDialog Pd;

  File _image;

  TextEditingController groupName= TextEditingController();
  TextEditingController groupLocation= TextEditingController();
  TextEditingController addmember= TextEditingController();


  CreateGroupChatController  controller=Get.put(CreateGroupChatController());

  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  Future selectImage() async{
    // ImagePicker imagePicker = ImagePicker();
    // final imageFile = await imagePicker.getImage(source: ImageSource.camera);
    PickedFile pickedFile=await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image =  File(pickedFile.path);
    });
  }


  Future<String> uploadFile(File files) async
  {
    String fileUrl;
    FirebaseStorage storage=FirebaseStorage.instance;
    Reference ref;
    ref = storage.ref().child("user/groupChatRoom/${DateTime.now().toString()}");
    UploadTask uploadTask=ref.putFile(files);
    TaskSnapshot taskSnapshot=await uploadTask;
    String downloadImageUrl=await taskSnapshot.ref.getDownloadURL();
    fileUrl=downloadImageUrl.toString();
    return fileUrl;
  }



  String location=null;

  String selectedLocation=null;

  @override
  Widget build(BuildContext context) {
    Pd= new ProgressDialog(context,type: ProgressDialogType.Normal);
    double h = Get.height;
    double w = Get.width;
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child:Form(
              key:_globalKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Kthirdcolor2,
                          image: DecorationImage(
                            image: AssetImage("assets/Bg.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        height: 250,
                        child: Container(
                          margin: EdgeInsets.only(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Text("Create a Group",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18 ),textAlign: TextAlign.center,)),
                              Container(
                                alignment: Alignment.center,
                                height: 135,
                                margin: EdgeInsets.only(right: 10,left: 10),
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 12),
                                      child: GestureDetector(
                                        onTap: (){
                                          selectImage();
                                        },
                                        child: _image!=null? Container(
                                            child: Container(
                                              height: 110,
                                              width: 110,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Image.file(_image,fit: BoxFit.cover,alignment: Alignment.center,),
                                              ),
                                            )): Container(

                                          child: Stack(
                                            overflow: Overflow.visible,
                                            children: [
                                              Image(
                                                  image: AssetImage('assets/groupchatIcon.png'),
                                                  height: 125
                                              ),
                                              Positioned(
                                                  bottom: -5,
                                                  right: 5,
                                                  child: Image.asset("assets/add.png")
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          Stack(
                            overflow: Overflow.visible,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                              ),
                              Positioned(
                                child: Container(
                                  margin: EdgeInsets.only(top: 200,left: context.responsiveValue(mobile: 25,tablet: 50),right: context.responsiveValue(mobile: 25,tablet: 50)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [

                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        color: Kthirdcolor2,
                                        child: TextFormField(
                                          controller: groupName,
                                          decoration: InputDecoration(
                                            labelText: 'Name',labelStyle: TextStyle(color: Colors.grey),
                                            hintText: 'Happy Try 2212 😍',hintStyle: decorate.hintstyle,
                                            suffixIcon: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:[ Image.asset("assets/profile_iphone@3x.png",width: 30,),],),
                                            enabledBorder: decorate.EIB,
                                          ),
                                        ),
                                      ),
                                      CountryListPick(
                                          appBar: AppBar(
                                              leading: GestureDetector(
                                                onTap: (){
                                                  Get.back();
                                                },
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Transform.rotate(angle: 3.1,child: Image.asset("assets/arrow_iphone@3x.png",width: 25,height: 24,color: Colors.black,)),
                                                  ],
                                                ),
                                              ),
                                              backgroundColor: Kthirdcolor2,
                                              title: Text('Select Country',
                                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),)

                                          ),

                                          // if you need custome picker use this
                                          pickerBuilder: (context, CountryCode countryCode){
                                            selectedLocation=countryCode.name;
                                            return Container(
                                                padding: EdgeInsets.only(top: 5,bottom: 12,left: 0),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(color: Colors.grey.withOpacity(0.8)),
                                                  ),
                                                ),
                                                margin: EdgeInsets.only(top:15,left: 0),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children:[
                                                    Text(location==null?"Location":countryCode.name,style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: KGreyColor,
                                                      fontSize: 16,
                                                    ),),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset("assets/location_iphone@3x.png",height: 28,),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            );

                                          },

                                          // To disable option set to false
                                          theme: CountryTheme(
                                            isShowFlag: true,
                                            isShowTitle: true,
                                            isShowCode: true,
                                            isDownIcon: true,
                                            showEnglishName: true,
                                          ),
                                          // Set default value
                                          initialSelection: '+62',
                                          // or
                                          // initialSelection: 'US'
                                          onChanged: (CountryCode code) {
                                            location=code.name;
                                            print(code.name);
                                            print(code.code);
                                            print(code.dialCode);
                                            print(code.flagUri);
                                          },
                                          // Whether to allow the widget to set a custom UI overlay
                                          useUiOverlay: true,
                                          // Whether the country list should be wrapped in a SafeArea
                                          useSafeArea: false
                                      ),

                                      Container(
                                          margin: EdgeInsets.only(top: 15,left: 5),
                                          child: Text("Interest",style: TextStyle(color: Colors.grey,fontSize: 12),)),


                                      GetX<CreateGroupChatController>(
                                          init: CreateGroupChatController(),
                                          builder: (controller) {
                                            return Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: GridView.builder(
                                                physics: ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller.GetInterest3.length,
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: context.responsiveValue(mobile: 8,tablet: 16),
                                                  crossAxisCount: context.responsiveValue(mobile: 3,tablet: 4),
                                                  mainAxisSpacing: context.responsiveValue(mobile: 4,tablet: 20),
                                                  childAspectRatio: w/ (h / 3.6),
                                                ),
                                                itemBuilder:getdata3,
                                              ),
                                            );
                                          }
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("See more",style: TextStyle(color: Colors.grey[600],fontSize: 10),),
                                        ],
                                      ),

                                      GestureDetector(
                                        onTap: (){
                                          Get.to(AddGroupMember());
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Ksecoudrycolor2,
                                          ),
                                          child: Card(
                                            margin: EdgeInsets.all(0),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                            child: Center(child: Text("Add Member",
                                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,
                                            color: KBlueColor
                                            ),

                                            ))
                                          ),
                                        ),
                                      ),
                                      // GetBuilder<CreateGroupController>(
                                      //   init: CreateGroupController(),
                                      //   builder: (controller) {
                                      //     return Container(
                                      //       margin: EdgeInsets.only(top:15,),
                                      //       child:GridView.builder(
                                      //         shrinkWrap: true,
                                      //         physics: ClampingScrollPhysics(),
                                      //         scrollDirection: Axis.vertical,
                                      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      //           crossAxisCount: context.responsiveValue(mobile: 3,tablet: 4),
                                      //           crossAxisSpacing: 1,
                                      //           mainAxisSpacing: 2,
                                      //         ),
                                      //         itemCount: controller.MembersGet2.length,
                                      //         itemBuilder: (context,index){
                                      //           // return  Container(
                                      //           //       child: Card(
                                      //           //         child: Column(
                                      //           //           mainAxisAlignment: MainAxisAlignment
                                      //           //               .spaceEvenly,
                                      //           //           children: [
                                      //           //             Image.asset(GM2.image,
                                      //           //               width: context.responsiveValue(mobile: Get.width *
                                      //           //                   0.15,tablet: Get.width*0.12)),
                                      //           //             Text(GM2.title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                                      //           //             Container(
                                      //           //               alignment: Alignment.centerRight,
                                      //           //               child: GestureDetector(
                                      //           //                   onTap: () {
                                      //           //                     controller.Removemember(index);
                                      //           //                   },
                                      //           //                   child: Image
                                      //           //                       .asset(
                                      //           //                     "assets/crossprofile_iphone@3x.png",
                                      //           //                     width: context.responsiveValue(mobile: 22,tablet: 30),
                                      //           //                     height: context.responsiveValue(mobile: 22,tablet: 30),)
                                      //           //               ),
                                      //           //             )
                                      //           //           ],
                                      //           //         ),
                                      //           //       ),
                                      //           //
                                      //           //     );
                                      //
                                      //         },
                                      //       )
                                      //     );
                                      //   }
                                      // ),
                                      SizedBox(height: 15,),
                                      GestureDetector(
                                        onTap: () async{
                                          Pd.show();
                                          if(_globalKey.currentState.validate()) {
                                            String image= await  uploadFile(_image);
                                            print(controller.selectedID.toList());
                                            var id = Timestamp.now().millisecondsSinceEpoch.toString();
                                            await Collection.groupChatRoom.doc(id)
                                                .set({
                                              'createdAt': DateTime.now(),
                                              'groupImage':image,
                                              'groupName': groupName.text.trim(),
                                              'location':  selectedLocation.toString(),
                                              'createdBy': UserSingleton.userData.userEmail,
                                              'interest':  controller.store10,
                                              'roomId':    id,
                                              'isGroup':   true,
                                              'members':   controller.addGroupMember,
                                            }).then((value) {
                                              print("final");
                                              print(controller.addGroupMember);

                                              for(int i=0;i<controller.addGroupMember.length;i++){
                                                var key = DateTime.now().millisecondsSinceEpoch.toString();
                                                 Collection.blockGroupChatUser
                                                    .doc(key)
                                                    .set({
                                                  "room_id": id,
                                                  "id": key,
                                                  "user": controller.addGroupMember[i],
                                                  "status": true,
                                                });
                                              }


                                            })
                                              .whenComplete(() => {
                                              _image=null,
                                              location=null,
                                              groupName.clear(),
                                              controller.addGroupMember.clear(),
                                              controller.store10.clear(),
                                            }
                                            ).whenComplete(() => Pd.hide().whenComplete(() => Get.back()));
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/bluepentagon_iphone@3x.png"),
                                                  )
                                              ),
                                              height: 50,
                                              width: 50,
                                              child: Center(child: Text("OK",style: TextStyle(color: Ksecoudrycolor2,fontWeight: FontWeight.bold),)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}




Widget getdata3(BuildContext context, int index) {
  return Container(
    child: GetBuilder<CreateGroupChatController>(
        init: CreateGroupChatController(),
        builder: (controller) {
          InterestItem10 II3 = controller.Interest10[index];
          return GestureDetector(
            onTap: () {
              controller.selectedInterest(II3.id,II3.data);
            },
            child: Stack(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: kprimary, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    color: II3.isSelected == false
                        ? Colors.white
                        : kprimary.withOpacity(0.3),
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    child: Center(
                        child: Text(
                          II3.data.toString(),
                          style: TextStyle(
                            color: kfourth,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                ),
                Visibility(
                  visible: II3.isSelected,
                  child: Positioned(
                    bottom: 5,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kprimary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
  );
}





