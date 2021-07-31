import 'dart:io';
import 'package:apey/controller/signUp_controller.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/screen/splash_screen.dart';
import 'package:apey/validation/signup_validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apey/constant.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:date_format/date_format.dart';
// import 'package:images_picker/images_picker.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

import 'bottomNavBar_screen.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {


  ProgressDialog Pd;
  File _image;



  FirebaseAuth _auth=FirebaseAuth.instance;

  TextEditingController name=TextEditingController();
  TextEditingController surName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();


  final GlobalKey<FormState> _register=GlobalKey<FormState>();

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





  SignUpController SUcontroller=Get.put(SignUpController());

  SignUp_Validation validate;

  DateTime selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  DateTime picked=null;

  var dob;


  Future<Null> _selectDate(BuildContext context) async {

     picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dob = formatDate(selectedDate, [dd, '/', mm, '/', yyyy,]);
      });
  }

  @override
  Widget build(BuildContext context) {
    Pd= new ProgressDialog(context,type: ProgressDialogType.Normal);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/yellowbg_iphone@3x.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: context.responsiveValue(
                              mobile: Get.width * 0.22, tablet: Get.width * 0.16),
                          padding: EdgeInsets.only(left: 25),
                          child: Image.asset("assets/Bee_iphone@3x.png"),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.only(top: 70),
                            child: Image.asset("assets/Dotline_iphone@3x.png"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Get.to(Login());
                          },
                          child: Container(
                            child: Stack(
                              children: [
                                Container(
                                  width: context.responsiveValue(
                                      mobile: 125),
                                  height: 43,
                                  padding: EdgeInsets.only(left: 30),
                                  alignment: Alignment.centerLeft,
                                  decoration: decorate.LogInSignUp,
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                      color: KTertiatColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 43,
                                      width: context.responsiveValue(
                                          mobile: 50),
                                      decoration: decorate.LogInSignUp2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Transform.rotate(
                                            angle: 3.1,
                                            child: Image.asset(
                                              'assets/back_iphone@3x.png',
                                              width: 20,
                                            ),
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
                      ],
                    ),
                  ),

                  Form(
                    key: _register,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              context.responsiveValue(mobile: 25, tablet: 50)),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/registerbg_iphone@3x.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 22, bottom: 12),
                            child: GestureDetector(
                              onTap: (){
                                selectImage();
                              },
                              child: _image!=null? Container(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(_image,fit: BoxFit.cover,alignment: Alignment.center,),
                                    ),
                                  )): Container(

                                child: Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Image(
                                        image: AssetImage('assets/profile.png'),
                                        height: 100
                                    ),
                                    Positioned(
                                      bottom: -5,
                                      right: 10,
                                        child: Image.asset("assets/add.png")
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),


                          SizedBox(
                            height: 15,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  controller: name,
                                  validator: SignUp_Validation().nameValidator,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: KTertiatColor),
                                  decoration: InputDecoration(
                                    enabledBorder: decorate.EIB,
                                    focusedBorder: decorate.FIB,
                                    labelText: "Name",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    hintText: "Master",
                                    hintStyle: decorate.hintstyle,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  controller: surName,
                                  validator: SignUp_Validation().surNameValidator,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: KTertiatColor),
                                  decoration: InputDecoration(
                                    focusedBorder: decorate.FIB,
                                    enabledBorder: decorate.EIB,
                                    labelText: "Surname",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    hintText: "Creationz",
                                    hintStyle: decorate.hintstyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              controller: email,
                              validator: SignUp_Validation().emailValidator,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: KTertiatColor),
                              decoration: InputDecoration(
                                focusedBorder: decorate.FIB,
                                enabledBorder: decorate.EIB,
                                labelText: "Email or Username",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                hintText: "MasterCreationz@gmail.com",
                                hintStyle: decorate.hintstyle,
                                suffixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/profile_iphone@3x.png',
                                      width: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                             controller: password,
                              validator: SignUp_Validation().passValidator,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: KTertiatColor),
                              decoration: InputDecoration(
                                focusedBorder: decorate.FIB,
                                enabledBorder: decorate.EIB,
                                labelText: "Password",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                hintText: "*********",
                                hintStyle: decorate.hintstyle,
                                suffixIcon: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/Lock_iphone@3x.png',
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: (){
                              _selectDate(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey.withOpacity(0.8)),
                                ),
                              ),
                              margin: EdgeInsets.only(right: 12,top:15),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text(picked==null?"Date of Birth":dob.toString(),style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: KGreyColor,
                                    fontSize: 16,
                                  ),),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/calender_iphone@3x.png',
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ],
                              )





                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Select Gender",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                                SUcontroller.Gender(gender.male);
                                            },
                                            child: Container(
                                              width: context.responsiveValue(
                                                  mobile: Get.width * 0.4),
                                              height: context.responsiveValue(
                                                mobile: 130,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blueAccent.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GetBuilder<SignUpController>(
                                                    init: SignUpController(),
                                                    builder: (controller) {
                                                      return Stack(
                                                        children: [
                                                          Image(
                                                            image: AssetImage('assets/male.png'),
                                                            height: 58,
                                                          ),
                                                          Positioned(
                                                            bottom:0,
                                                            right:0,
                                                            child: Visibility(
                                                                visible: controller.selected=="male"?controller.visible:false,
                                                                child: Image.asset("assets/select_iphone@3x.png",height: 25,)),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "Male",
                                                    style: TextStyle(
                                                        fontSize: 13, color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              SUcontroller.Gender(gender.female);
                                            },
                                            child: Container(
                                              width: context.responsiveValue(
                                                  mobile: Get.width * 0.4),
                                              height: context.responsiveValue(
                                                mobile: 130,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blueAccent.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GetBuilder<SignUpController>(
                                                    init: SignUpController(),
                                                    builder: (controller) {
                                                      return Stack(
                                                        children: [
                                                          Image(
                                                            image: AssetImage('assets/female.png'),
                                                            height: 58,
                                                          ),
                                                        Positioned(
                                                          bottom:0,
                                                          right:0,
                                                          child: Visibility(
                                                              visible: controller.selected=="female"?controller.visible:false,
                                                              child: Image.asset("assets/select_iphone@3x.png",height: 25,)),
                                                        ),
                                                        ],
                                                      );
                                                    }
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "Female",
                                                    style: TextStyle(
                                                        fontSize: 13, color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),

                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 15, left: 5),
                              child: Text(
                                "Interest",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          GetX<SignUpController>(
                              init: SignUpController(),
                              builder: (controller) {
                                return Container(
                                  child: GridView.builder(
                                    controller: new ScrollController(
                                        keepScrollOffset: false),
                                    shrinkWrap: true,
                                    itemCount: controller.GetInterest.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 12,
                                      crossAxisCount: context.responsiveValue(
                                          mobile: 3, tablet: 4),
                                      mainAxisSpacing: 4,
                                      childAspectRatio: w / (h / 3.5),
                                    ),
                                    itemBuilder: getdata,
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "See more",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              Pd.show();
                              if (_register.currentState.validate()) {
                                String image= await  uploadFile(_image);
                                String UserID;
                                var emailArray;
                                emailArray=email.text.split("@");
                                UserID=emailArray[0];
                                  try {
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email.text.trim(),
                                        password: password.text.trim())
                                        .then((currentUser) =>
                                    // ignore: deprecated_member_use
                                    Collection.signUp.doc(currentUser.user.email)
                                        .set({
                                      'name': name.text,
                                      'surName': surName.text,
                                      'email': email.text,
                                      'UserID': "@"+UserID.toString(),
                                      'dob':    dob.toString(),
                                      'gender': SUcontroller.selected=='male'?'male':SUcontroller.selected=='female'??null,
                                      'interest': SUcontroller.store,
                                      'Image' :   image,
                                    }).whenComplete(() => getCurrentUsers())
                                 .whenComplete(() => Get.off(BottomnavbarScreen())).whenComplete(() => Pd.hide())
                                        .whenComplete(() =>
                                    {
                                      name.clear(),
                                      surName.clear(),
                                      email.clear(),
                                      password.clear(),
                                      dob=null,
                                      SUcontroller.selected=null,
                                      SUcontroller.store.clear(),
                                      // _image=null,
                                    })
                              );

                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print('The password provided is too weak.');
                                    } else if (e.code == 'email-already-in-use') {
                                      print('The account already exists for that email.');
                                    }
                                  }
                                  catch(e){
                                    showDialog(context: context,
                                        builder: (BuildContext context) {return AlertDialog(
                                            title: Text("Error",style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                            content: Text(
                                                "Email Already exist"),
                                            actions: [
                                              // ignore: deprecated_member_use
                                              FlatButton(onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                                child: Text("Close"),
                                              )
                                            ],
                                          );}
                                    );
                                  }
                                }
                            },

                            child: Container(
                              margin: EdgeInsets.only(top: 100),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image:
                                    AssetImage('assets/bluepentagon_iphone@3x.png'),
                              )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('assets/arrow_iphone@3x.png'),
                                    width: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
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

Widget getdata(BuildContext context, int index) {
  return Container(
    child: GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          InterestItem II = controller.Interest[index];
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



// InteractiveViewer(
//
// child: Container(
// height: 130,
// child: ClipPolygon(
// sides: 5,
// borderRadius: 10.0,     // Defaults to 0.0 degrees
// boxShadows: [
// PolygonBoxShadow(color: Colors.black, elevation: 1.0),
// PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
// ],
// child: Container(
// child: Image.file(_image,fit: BoxFit.fill
// ,alignment: Alignment.center,),
// ),
// ),),
// )