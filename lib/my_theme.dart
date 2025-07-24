import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme{
  static Color primarylight=Color(0xff5D9CEC);
  static Color backgroundlight=Color(0xffDFECDB);
  static Color backgrounddark=Color(0xff60E1E);
  static Color greenlight=Color(0xff61E757);
  static Color blackcolor=Color(0xff383838);
  static Color whiteColor=Color(0xffFFFFFF);
  static Color greyColor=Color(0xffC8C9CB);
  static Color redColor=Color(0xffEC4B4B);
  static Color darkblackcolor=Color(0xff141922);
  static Color titlecolor=Color(0xff060E1E);
  static Color botextcolor=Color(0xfff6f2f2);

  static  ThemeData lightTheme=ThemeData(
    primaryColor: primarylight,
  scaffoldBackgroundColor: backgroundlight,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: primarylight,
    unselectedItemColor: blackcolor,
    showUnselectedLabels: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primarylight
  ),
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
  ),
  textTheme: TextTheme(
    titleLarge:TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: whiteColor,
    ),
     titleMedium: TextStyle(
       fontSize: 20,
       fontWeight: FontWeight.w700,
       color: blackcolor,
  ),
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: blackcolor,
    )
  ),


  );
  static  ThemeData darkTheme=ThemeData(
    primaryColor: titlecolor,
    scaffoldBackgroundColor: titlecolor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primarylight,
      unselectedItemColor: greyColor,
      showUnselectedLabels: false,
      backgroundColor: darkblackcolor,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primarylight
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
        backgroundColor:darkblackcolor ,
    ),


    textTheme: TextTheme(
        titleLarge:TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: titlecolor,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: whiteColor,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: whiteColor,
        )
    ),


  );
}