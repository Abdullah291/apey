import 'dart:io';

import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:apey/screen/bottomNavBar_screen.dart';
import 'package:apey/screen/login_screen.dart';
import 'package:apey/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';
import 'package:apey/controller/editProfile_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';


class EditProfileScreen extends StatefulWidget {

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  File _image;

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
    ref = storage.ref().child("user/profileImages/${DateTime.now().toString()}");
    UploadTask uploadTask=ref.putFile(files);
    TaskSnapshot taskSnapshot=await uploadTask;
    String downloadImageUrl=await taskSnapshot.ref.getDownloadURL();
    fileUrl=downloadImageUrl.toString();
    return fileUrl;
  }


  final EditProfileController editController= Get.put(EditProfileController());

  TextEditingController firstname= TextEditingController();
  TextEditingController lastname= TextEditingController();

  TextEditingController newPassword= TextEditingController();

  bool change=false;

  ProgressDialog Pd;
  @override
  Widget build(BuildContext context) {
    Pd= new ProgressDialog(context,type: ProgressDialogType.Normal);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40),
                  color: Ksecoudrycolor,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: context.responsiveValue(mobile: 20,tablet: 50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 22, bottom: 12),
                          child: GestureDetector(
                            onTap: (){
                              selectImage();
                            },
                            child: _image!=null? Container(
                                child: Container(
                                  height: 125,
                                  width: 125,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(_image,fit: BoxFit.cover,alignment: Alignment.center,),
                                  ),
                                )): Container(

                              child: Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 125,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image(
                                          image: NetworkImage(UserSingleton.userData.imageUrl.toString()),
                                          fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: -10,
                                      right: 10,
                                      child: Image.asset("assets/edit_iphone@3x.png",height: 40,)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            height: 120,
                            child: Image.asset(
                              "assets/Bg2.png",
                              fit: BoxFit.fill,
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 85,
                          left: context.responsiveValue(mobile: 20,tablet: 50),
                          right: context.responsiveValue(mobile: 20,tablet: 50)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: firstname,
                            decoration: InputDecoration(
                                hintText: UserSingleton.userData.firstName,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                                labelText: "First name",
                                focusedBorder: decorate.FIB,
                                enabledBorder: decorate.EIB,
                                labelStyle: TextStyle(
                                    fontSize: 14, color: KGreyColor),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: kforhtcolor,
                                  size: 20,
                                )),
                          ),
                          TextFormField(
                            controller: lastname,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintText: UserSingleton.userData.lastName,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                                labelText: "Last name",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: KGreyColor),
                                focusedBorder: decorate.FIB,
                                enabledBorder: decorate.EIB,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: kforhtcolor,
                                  size: 20,
                                )),
                          ),

                          GestureDetector(
                            onTap: (){
                              setState(() {
                                 change=!change;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 25),
                              height: 50,
                              decoration: box,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  change==false? Expanded(
                                    child: Container(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text(
                                          "Change Password",
                                          style: TextStyle(
                                              color: kforhtcolor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ):Container(
                                    width: Get.width*0.7,
                                    child: TextFormField(
                                      controller: newPassword,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          hintText: "Enter new password",
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          labelStyle: TextStyle(
                                              fontSize: 14, color: KGreyColor),
                                          focusedBorder: decorate.FIB,
                                          enabledBorder: decorate.EIB,

                                      ),
                                    ),
                                  ),
                                change==false? Container(
                                    width: 45,
                                    child: Container(
                                      height: 28,
                                      child: Image.asset(
                                          "assets/Lock_iphone@3x.png"),
                                    ),
                                  ):GestureDetector(
                                  onTap: (){
                                    _changePassword(newPassword.text.trim().toString());
                                    FirebaseAuth.instance.signOut().whenComplete(() => Get.offAll(LoginScreen()));
                                    setState(() {
                                      change=!change;
                                    });
                                  },
                                    child: Container(
                                    width: 45,
                                    child: Container(
                                      height: 28,
                                      child: Image.asset(
                                          "assets/select_iphone@3x.png"),
                                    ),
                                ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                              margin: EdgeInsets.only(top: 15,bottom: 10),
                              child: Text(
                                "Interest",
                                style: TextStyle(color: KGreyColor),
                              )),
                          GetX<EditProfileController>(
                              init: EditProfileController(),
                              builder: (controller) {
                                return Container(
                                  child: GridView.builder(
                                    controller: new ScrollController(
                                        keepScrollOffset: false),
                                    shrinkWrap: true,
                                    itemCount: controller.GetInterest3.length,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 12,
                                      crossAxisCount: context.responsiveValue(
                                          mobile: 3, tablet: 4),
                                      mainAxisSpacing: 4,
                                      childAspectRatio: w / (h / 3.5),
                                    ),
                                    itemBuilder: getdata3,
                                  ),
                                );
                              }),

                          Container(
                              margin: EdgeInsets.only(top: 15,bottom: 10),
                              child: Text(
                                "Language",
                                style: TextStyle(color: KGreyColor),
                              )),
                          Card(
                            elevation: 0,
                            margin: EdgeInsets.all(0),
                            child: GetX<EditProfileController>(
                                init:EditProfileController(),
                                builder: (controller) {
                                  return DropdownSearch(
                                    mode: Mode.MENU,
                                    showSelectedItem: true,
                                    items: controller.languagelist,
                                    onChanged: (value){
                                      controller.selectedlanguage.value=value;
                                    },
                                    selectedItem: controller.selectedlanguage.value,
                                    autoFocusSearchBox: false,
                                    dropDownButton: Image.asset("assets/language_iphone@3x.png"),
                                  );
                                }
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              onPressed: () async{
                                Pd.show();
                                String image=  _image!=null? await uploadFile(_image): null ;
                                Collection.signUp.doc(UserSingleton.userData.userEmail.toLowerCase()).update({
                                   // ignore: deprecated_member_use
                                   'Image': image==null ? UserSingleton.userData.imageUrl: image.toString(),
                                   'name':  firstname.text.isEmpty ? UserSingleton.userData.firstName:firstname.text.toString(),
                                   'surName' :lastname.text.isEmpty ? UserSingleton.userData.lastName:lastname.text.toString(),
                                   'interest': editController.store2.length==0 ? UserSingleton.userData.interest:editController.store2,
                                   'language': editController.selectedlanguage.value.toString(),
                                }).whenComplete(() => {
                                  image= null,
                                  firstname.clear(),
                                  lastname.clear(),
                                  editController.store2.clear(),
                                }).whenComplete(() => getCurrentUsers()).whenComplete(() => Pd.hide().whenComplete(() => Get.offAll(BottomnavbarScreen())));
                              },
                              color: kforhtcolor,
                              child: FittedBox(
                                  child: Text(
                                    "Save Change",
                                    style: TextStyle(
                                        color: Ksecoudrycolor, fontSize: 14),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _changePassword(String password) async{
  FirebaseAuth.instance.currentUser.updatePassword(password).then((_){
    print("Successfully changed password");
  }).catchError((error){
    print("Password can't be changed" + error.toString());
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });
}


Widget getdata3(BuildContext context, int index) {
  return Container(
    child: GetBuilder<EditProfileController>(
        init: EditProfileController(),
        builder: (controller) {
          InterestItem3 II = controller.Interest3[index];
          return GestureDetector(
            onTap: () {
              controller.selectedInterest(II.id,II.data);
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
                    color: II.isSelected == false
                        ? Colors.white
                        : kprimary.withOpacity(0.3),
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    child: Center(
                        child: Text(
                          II.data.toString(),
                          style: TextStyle(
                            color: kfourth,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                ),
                Visibility(
                  visible: II.isSelected,
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
