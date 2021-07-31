

import 'package:apey/controller/bottomNavbar_controller.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:apey/controller/createGroup_controller.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'add_group_Member2.dart';

class Create_Group_Room_2 extends StatefulWidget {
  @override
  _Create_Group_Room_2State createState() => _Create_Group_Room_2State();
}

class _Create_Group_Room_2State extends State<Create_Group_Room_2> {

  final GlobalKey<ScaffoldState> _scaffoldkey4=GlobalKey<ScaffoldState>();

  File _image;

  TextEditingController groupName= TextEditingController();
  TextEditingController groupLocation= TextEditingController();
  TextEditingController addmember= TextEditingController();


  TextEditingController aboutGroup=TextEditingController();


  CreateGroupController  controller=Get.put(CreateGroupController());

  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  ProgressDialog Pd;

  BottomNavBarController  BNcontroller=Get.put(BottomNavBarController());


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



  @override
  void initState() {
    // TODO: implement initState
    controller.Members2.clear();
    controller.store3.clear();
    super.initState();
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
        key: _scaffoldkey4,
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Form(
                key: _globalKey,
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
                          height: 270,
                          child: Container(
                            margin: EdgeInsets.only(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .stretch,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Text("Create a Group",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,)),
                                Container(
                                  alignment: Alignment.center,
                                  height: 135,
                                  margin: EdgeInsets.only(
                                      right: 10, left: 10),
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 12),
                                        child: GestureDetector(
                                          onTap: () {
                                            selectImage();
                                          },
                                          child: _image != null ? Container(
                                              child: Stack(
                                                overflow: Overflow.visible,
                                                children: [
                                                  Container(
                                                    height: 110,
                                                    width: 110,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(100),
                                                      child: Image.file(_image,
                                                        fit: BoxFit.cover,
                                                        alignment: Alignment
                                                            .center,),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: -10,
                                                      right: 5,
                                                      child: Container(
                                                        height: 35,
                                                        child: Image.asset(
                                                            "assets/camera_iphone@3x.png"),
                                                      )
                                                  ),
                                                ],
                                              )) : Container(

                                            child: Stack(
                                              overflow: Overflow.visible,
                                              children: [
                                                Container(
                                                  height: 110,
                                                  width: 110,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .circular(100),
                                                    child: Image(
                                                      image: AssetImage("assets/groupchatIcon.png"),
                                                      alignment: Alignment.center,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    bottom: -10,
                                                    right: 5,
                                                    child: Container(
                                                      height: 35,
                                                      child: Image.asset(
                                                          "assets/camera_iphone@3x.png"),
                                                    )
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
                                    margin: EdgeInsets.only(top: 200,
                                        left: context.responsiveValue(
                                            mobile: 25, tablet: 50),
                                        right: context.responsiveValue(
                                            mobile: 25, tablet: 50)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .stretch,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          color: Kthirdcolor2,
                                          child: TextFormField(
                                            controller: groupName,
                                            decoration: InputDecoration(
                                              labelText: "Group Name",
                                              labelStyle: TextStyle(
                                                fontWeight: FontWeight
                                                    .bold,
                                                color: KGreyColor,
                                                fontSize: 16,
                                              ),
                                              hintText: 'Enter group Name',
                                              hintStyle: decorate.hintstyle,
                                              suffixIcon: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Image.asset(
                                                    "assets/profile_iphone@3x.png",
                                                    width: 30,),
                                                ],),
                                              enabledBorder: decorate.EIB,
                                            ),
                                          ),
                                        ),
                                        CountryListPick(
                                            appBar: AppBar(
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Transform.rotate(
                                                          angle: 3.1,
                                                          child: Image
                                                              .asset(
                                                            "assets/arrow_iphone@3x.png",
                                                            width: 25,
                                                            height: 24,
                                                            color: Colors
                                                                .black,)),
                                                    ],
                                                  ),
                                                ),
                                                backgroundColor: Kthirdcolor2,
                                                title: Text(
                                                  'Select Country',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 18,
                                                      color: Colors.black),)

                                            ),

                                            // if you need custome picker use this
                                            pickerBuilder: (context,
                                                CountryCode countryCode) {
                                              selectedLocation =
                                                  countryCode.name;
                                              return Container(
                                                  padding: EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 12,
                                                      left: 0),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.8)),
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      top: 15, left: 0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(location==null?"Location":countryCode.name,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: KGreyColor,
                                                          fontSize: 16,
                                                        ),),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/location_iphone@3x.png",
                                                            height: 28,),
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
                                              location = code.name;
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
                                          margin: EdgeInsets.only(top: 20,left: 8,bottom: 10),
                                          child: Text("About this group",
                                            style:  TextStyle(
                                                fontWeight: FontWeight
                                                    .w500,
                                                color: KGreyColor,
                                                fontSize: 16,
                                                fontFamily: ""
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: context.responsiveValue(
                                                  mobile: 5, tablet: 10)),

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: KBlueColor,
                                            ),
                                          ),
                                          child: Card(
                                            color: KGreyColor.withOpacity(0.1),
                                            margin: EdgeInsets.all(0),
                                            elevation: 0,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  flex: 8,
                                                  child: TextFormField(
                                                    minLines: 3,
                                                    maxLines: 8,
                                                    controller: aboutGroup,
                                                    decoration: InputDecoration(
                                                      hintText: "Write something on your feed...",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.only(
                                                          left: 15,bottom: 10,top: 15),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),


                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 15, left: 5),
                                            child: Text("Interest",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),)),


                                        GetX<CreateGroupController>(
                                            init: CreateGroupController(),
                                            builder: (controller) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    top: 10),
                                                child: GridView.builder(
                                                  physics: ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: controller.GetInterest3.length,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisSpacing: context
                                                        .responsiveValue(
                                                        mobile: 8,
                                                        tablet: 16),
                                                    crossAxisCount: context
                                                        .responsiveValue(
                                                        mobile: 3,
                                                        tablet: 4),
                                                    mainAxisSpacing: context
                                                        .responsiveValue(
                                                        mobile: 4,
                                                        tablet: 20),
                                                    childAspectRatio: w /
                                                        (h / 3.6),
                                                  ),
                                                  itemBuilder: getdata3,
                                                ),
                                              );
                                            }
                                        ),
                                        SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end,
                                          children: [
                                            Text("See more",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 10),),
                                          ],
                                        ),


                                          GestureDetector(
                                          onTap: () async{
                                            await controller.Members2.add(UserSingleton.userData.userEmail);
                                            Get.to(Add_Group_Memeber_2());
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 10),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(5),
                                              color: Ksecoudrycolor2,
                                            ),
                                            child: Card(
                                                margin: EdgeInsets.all(0),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(5)),
                                                child: Center(child: Text(
                                                  "Add Member",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: KBlueColor
                                                  ),

                                                ))
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                   GestureDetector(

                                          onTap: () async {
                                            if (_globalKey.currentState
                                                .validate()) {
                                              Pd.show();
                                              String image = await uploadFile(_image==null?"assets/profile.png" as Path:_image);
                                              var id = Timestamp
                                                  .now()
                                                  .millisecondsSinceEpoch
                                                  .toString();
                                              await Collection.groupRoom
                                                  .doc(id)
                                                  .set({
                                                'createdAt': DateTime.now(),
                                                'groupName': groupName.text
                                                    .trim(),
                                                'groupImage': image,
                                                'location': selectedLocation
                                                    .toString(),
                                                'createdBy': UserSingleton
                                                    .userData.userEmail,
                                                "about": aboutGroup.text.trim().toString(),
                                                'roomId': id,
                                                'isGroup': true,
                                                'interest': controller
                                                    .store3,
                                                'members': controller.Members2,
                                              }).whenComplete((){
                                                controller.Members2.forEach((element) async{
                                                  var key = DateTime.now().millisecondsSinceEpoch.toString();
                                                  await Collection.blockGroupUser
                                                      .doc(key)
                                                      .set({
                                                    "room_id": id,
                                                    "id": key,
                                                    "user": element,
                                                    "status": true,
                                                  });
                                                });

                                              }).whenComplete(() =>
                                              {
                                                setState(() {
                                                  _image = null;
                                                  location = null;
                                                  groupName.clear();
                                                  aboutGroup.clear();
                                                  controller.Members2.clear();
                                                  controller.store3.clear();
                                                }
                                                )}
                                              ).whenComplete(() => Pd.hide().whenComplete(() => {
                                                setState((){
                                                  controller.Interest3.forEach((element) {
                                                    element.isSelected=false;
                                                  });

                                                  BNcontroller.onSelected(4);

                                                })
                                                }
                                              ),
                                             );
                                            }
                                            },

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/bluepentagon_iphone@3x.png"),
                                                    )
                                                ),
                                                height: 50,
                                                width: 50,
                                                child: Center(child: Text(
                                                  "OK", style: TextStyle(
                                                    color: Ksecoudrycolor2,
                                                    fontWeight: FontWeight
                                                        .bold),)),
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
          )
        ),

      ),
    );
  }
  Widget getdata3(BuildContext context, int index) {
    return Container(
      child: GetBuilder<CreateGroupController>(
          init: CreateGroupController(),
          builder: (controller) {
            InterestItem3 II3 = controller.Interest3[index];
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

}



