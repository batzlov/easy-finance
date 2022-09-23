import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:easy_finance/shared/constants.dart';

class Loading extends StatelessWidget 
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      color: lightGreyBackground,
      child: Center(
        child: SpinKitChasingDots(
          color: primaryColor,
          size: 50.0,
        )
      )
    );
  }
}