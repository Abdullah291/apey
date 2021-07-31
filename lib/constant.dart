import 'package:flutter/material.dart';

const kprimary= Color(0xff677bff);
const kprimarycolor=Color(0xffffc72f);
const Ksecoudrycolor=Color(0xffffffff);
const Kthirdcolor=Color(0xffe9e8ee);
const kforhtcolor=Color(0xff085df7);
const kfourth=Colors.grey;
const Kfivthcolor=Color(0xff47af58);




const KPrimaryColor=Color(0xffffffff);
const KSecondaryColor=Color(0xfffafafa);
const KTertiatColor=Color(0xff154360);
const KClipperColor=Color(0xffffb94a);
const KLightBlueBorderColor=Colors.blueAccent;
const KBlueColor=Color(0xff015efb);
const KLightBlueColor=Color(0xffEBF5FB);
const KYellowColor=Color(0xffF4D03F);
const KGreyColor=Colors.grey;

const kprimarycolor2=Color(0xffeda850);
const Ksecoudrycolor2=Color(0xffffffff);
const Kthirdcolor2=Color(0xffe9e8ee);
const kforhtcolor2=Color(0xff085df7);
const Kfivthcolor2=Color(0xff47af58);



class decorate{

  static Decoration LogInSignUp = BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      ),
      border: Border.all(
        color: Colors.white,
      ));


  static Decoration LogInSignUp2=  BoxDecoration(
    color: Colors.white.withOpacity(0.9),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50),
      bottomLeft: Radius.circular(50),
    ),
    border: Border.all(
      color: Colors.white,
    ),
  );


  static TextStyle textfieldstyle=TextStyle(fontWeight: FontWeight.bold,fontSize: 14);

  static TextStyle lablestyle=TextStyle(color: Colors.grey,fontSize: 14);

  static TextStyle hintstyle=TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14);


  static UnderlineInputBorder EIB= UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
  );

  static UnderlineInputBorder FIB= UnderlineInputBorder(
      borderSide: BorderSide(color:  Colors.black,),
  );
}

final BoxDecoration box=BoxDecoration(
  color: Ksecoudrycolor,
  borderRadius: BorderRadius.circular(5),
);

final TextStyle textStyle=TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 14,
);


