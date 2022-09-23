import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff163840);
const Color secondaryColor = Color(0xff346773);
const Color thirdColor = Color(0xff5B98A6);
const Color fourthColor = Color(0xff50BF80);

const Color lightGreyBackground = Color(0xffEEEEEE);
const Color darkGreyLabel = Color(0xff4B4B4B);
const Color darkGrey = Color(0xff424242);
const Color grey = Color(0xff616161);

const Color lightRed = Color(0xffe57373);
const Color lightGreen = Color(0xff81C784);
const Color lightBlue = Color(0xff64B5F6);

//const Color appBarColor = Color(0xff5A5474);
const Color appBarColor = Color(0xff163840);

const double tileElevation = 2.0;
const double cardElevation = 2.0;

final buttonStyle = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(5.0),
);

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  labelStyle: TextStyle(
    color: darkGreyLabel
  ),
  hintStyle: TextStyle(
    color: darkGreyLabel
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 0.0,
    )
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    )
  )
);