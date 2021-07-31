import 'package:apey/database/collection.dart';
import 'package:apey/screen/groupActivityDetail_screen.dart';
import 'package:apey/screen/homeFeed_screen.dart';
import 'package:apey/screen/splash_screen.dart';
import 'package:apey/screen/bottomNavBar_screen.dart';
import 'package:apey/screen/groupProfileDetail.dart';
import 'package:apey/screen/home_screen.dart';
import 'package:apey/screen/login_screen.dart';
import 'package:apey/screen/search_screen.dart';
import 'package:apey/screen/signUp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constant.dart';
import 'screen/groupActivity_screen.dart';
import 'screen/groupList_screen.dart';




Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,),);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  var user = FirebaseAuth.instance.currentUser;
  @override

  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.paused == state) {
      if (user != null) {
        print(user.email);
        await Collection.signUp
            .doc(user.email)
            .update({"presence": false, "last_seen": Timestamp.now()});
      }
      print("this is pause");
    }
    if (AppLifecycleState.inactive == state) {
      if (user != null) {
        print(user.email);
        await Collection.signUp
            .doc(user.email)
            .update({"presence": false, "last_seen": Timestamp.now()});
      }
      print("this is inactive");
    }
    if (AppLifecycleState.resumed == state) {
      if (user != null) {
        print(user.email);
        await Collection.signUp
            .doc(user.email)
            .update({"presence": true, "last_seen": Timestamp.now()});
      }
      print("this is resume");
    }
    if (AppLifecycleState.detached == state) {
      if (user != null) {
        print(user.email);
        await Collection.signUp
            .doc(user.email)
            .update({"presence": false, "last_seen": Timestamp.now()});
      }
      print("this is resume");
    }
  }
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: "APEY",
      color: KClipperColor,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),

        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),

        accentColor: Colors.white,
        accentColorBrightness: Brightness.light,
        scaffoldBackgroundColor: Kthirdcolor2,

      ),

      getPages:[
        GetPage(name: "/splash_screen", page:()=> SplashScreen()),
        GetPage(name: '/sign_Up_screen', page: ()=>SignUpScreen()),
        GetPage(name: '/login_screen', page: ()=>LoginScreen()),
        GetPage(name: '/search_screen', page: ()=>SearchScreen()),
        GetPage(name: "/bottomNavBar_screen", page: ()=>BottomnavbarScreen()),
        GetPage(name: "/home_screen", page: ()=>HomeScreen()),
        GetPage(name:"/groupProfileDetail_screen",page:()=>GroupProfileDetailScreen()),
        GetPage(name: "/groupList_screen",page: ()=>GroupListScreen()),
        GetPage(name: "/groupActivity_screen",page:()=>GroupActivityScreen()),
        GetPage(name: "/groupActivityDetail_screen", page:()=>GroupActivityDetailScreen()),
        GetPage(name: "/homefeed", page:() =>HomeFeedScreen()),


      ],
      initialRoute : "/splash_screen",
    );

  }
}

