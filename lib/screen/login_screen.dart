import 'package:apey/screen/signUp_screen.dart';
import 'package:apey/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apey/constant.dart';
import 'package:get/get.dart';
import 'package:apey/screen/bottomNavBar_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool changeView=false;

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  FirebaseAuth _auth=FirebaseAuth.instance;

  TextEditingController resetEmail=TextEditingController();

  String _warning;


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog Pd;

  @override
  Widget build(BuildContext context) {
    Pd= new ProgressDialog(context,type: ProgressDialogType.Normal);

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30),
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
                            width: context.responsiveValue(mobile:  Get.width*0.22,tablet: Get.width*0.16),
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
                            onTap: (){
                              Get.to(SignUpScreen());
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 170,
                                    height: 45,
                                    padding: EdgeInsets.only(left: 20),
                                    alignment: Alignment.centerLeft,
                                    decoration: decorate.LogInSignUp,
                                    child: Text(
                                      "Create account",
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
                                        width:50,
                                        decoration:decorate.LogInSignUp2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage('assets/back_iphone@3x.png'),
                                              width: 20,
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
                    Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Form(
                                key: _globalKey,
                                child: Container(
                                  margin:EdgeInsets.only(left:context.responsiveValue(mobile:0,tablet: 160)),
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: context.responsiveValue(mobile: Get.height*0.76,tablet: 700),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/whitepentagon_iphone@3x.png'),
                                        fit: context.responsiveValue(mobile: BoxFit.fill,tablet:BoxFit.fill),
                                      )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: context.responsiveValue(mobile: 4,tablet: 6),
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: context.responsiveValue(mobile: 5,tablet: 6),
                                            child: Container(
                                              child: Text(
                                               changeView==false?"Welcome Back":"Reset Password",overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: KTertiatColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        changeView==false?Expanded(
                                            flex: 8,
                                            child: Container(
                                              child: TextFormField(
                                                controller: email,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: KTertiatColor,),
                                                decoration: InputDecoration(
                                                  focusedBorder: decorate.FIB,
                                                  enabledBorder: decorate.EIB,
                                                  labelText: "Email",
                                                  labelStyle: TextStyle(color: Colors.grey,),
                                                  hintText: "MasterCreationz@gmail.com",
                                                  hintStyle: decorate.hintstyle,
                                                  suffixIcon: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [Image.asset('assets/profile_iphone@3x.png', width: 25,),],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ):Expanded(
                                          flex: 8,
                                          child: Container(
                                            child: TextFormField(
                                              controller: resetEmail,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: KTertiatColor,),
                                              decoration: InputDecoration(
                                                focusedBorder: decorate.FIB,
                                                enabledBorder: decorate.EIB,
                                                labelText: "Email",
                                                labelStyle: TextStyle(color: Colors.grey,),
                                                hintText: "MasterCreationz@gmail.com",
                                                hintStyle: decorate.hintstyle,
                                                suffixIcon: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [Image.asset('assets/profile_iphone@3x.png', width: 25,),],
                                                ),
                                              ),
                                            ),
                                           ),
                                         ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        changeView==false? Expanded(
                                            flex: 8,
                                            child: Container(
                                              child: TextFormField(
                                                controller: password,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: KTertiatColor,),
                                                decoration: InputDecoration(
                                                  focusedBorder: decorate.FIB,
                                                  enabledBorder: decorate.EIB,
                                                  labelText: "Password",
                                                  labelStyle: TextStyle(color: Colors.grey,),
                                                  hintText: "*******",
                                                  hintStyle:decorate.hintstyle,
                                                  suffixIcon: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset('assets/Lock_iphone@3x.png',width: 25,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ):Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: 150,
                                          height: 45,
                                          child: RaisedButton(
                                            color: Color(0xffF6F7F5),
                                            elevation: 0,
                                            highlightElevation: 0,
                                            shape: StadiumBorder(),
                                            onPressed: () {
                                              setState(() {
                                                changeView=!changeView;
                                              });
                                            },
                                            child: Text(
                                              "Forgot Password?",overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12, color: KTertiatColor,fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             changeView==false? Positioned(
                                bottom: 38,
                                left: context.responsiveValue(mobile: 65,tablet: 320),
                                child: GestureDetector(

                                  onTap: () async{
                                    if (_globalKey.currentState.validate()) {
                                      Pd.show();
                                      try {
                                        await _auth
                                            .signInWithEmailAndPassword(
                                            email: email.text.trim(),
                                            password: password.text.trim()).
                                        then((value) => getCurrentUsers())
                                        .then((value) => Get.offAll(BottomnavbarScreen())
                                            .whenComplete(() => Pd.hide()).then((value) => {
                                              email.clear(),
                                              password.clear(),
                                        }));
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          Pd.hide();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text("No user found for that email."),
                                                  actions: [
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("Close")),
                                                  ],
                                                );
                                              });
                                        } else if (e.code == 'wrong-password') {
                                          Pd.hide();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text(
                                                      "Wrong password provided for that user."),
                                                  actions: [
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("Close")),
                                                  ],
                                                );
                                              });
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/bluepentagon_iphone@3x.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/arrow_iphone@3x.png',
                                          height: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ):
                             Positioned(
                               bottom: 38,
                               left: context.responsiveValue(mobile: 65,tablet: 320),
                               child: GestureDetector(

                                 onTap: () async{
                                  await FirebaseAuth.instance.sendPasswordResetEmail(email: resetEmail.text.trim().toString()).whenComplete(() =>
                                      setState(() {
                                        changeView=!changeView;
                                      })
                                  // ignore: deprecated_member_use
                                  ).whenComplete(() => scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Text("Password reset Check your email",
                                      style: TextStyle(fontSize: 14,color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      ),
                                      duration: Duration(seconds: 3),
                                    ),
                                  ));

                                 },
                                 child: Container(
                                   width: 70,
                                   height: 70,
                                   decoration: BoxDecoration(
                                     image: DecorationImage(
                                       image: AssetImage(
                                           'assets/bluepentagon_iphone@3x.png'),
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Image.asset(
                                         'assets/arrow_iphone@3x.png',
                                         height: 25,
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),



                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                _warning,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
  }
}
