import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:easy_finance/models/earning.dart';

import 'package:easy_finance/services/helper.dart';

import 'package:easy_finance/shared/constants.dart';

import 'package:easy_finance/screens/home/shared/types.dart';
import 'package:easy_finance/screens/home/earnings/earning_list.dart';
import 'package:easy_finance/screens/home/earnings/add_earning_form.dart';

class EarningsTypeScreen extends StatefulWidget {
  EarningType earningsType;
  
  EarningsTypeScreen({
    this.earningsType
  });

  @override
  _EarningsTypeScreenState createState() => _EarningsTypeScreenState();
}

class _EarningsTypeScreenState extends State<EarningsTypeScreen> {
  HelperService _helper = new HelperService();

  void _showAddEarningBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: lightGreyBackground,
      isScrollControlled: true, 
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, 
              top: 20.0,
              left: 10.0,
              right: 10.0
            ),
            child: AddEarningForm()
          )
        );
      }
    );
  }

  String _getSummedUpString(List<Earning> earnings)
  {
    if(widget.earningsType == EarningType.all) 
    {
      return _helper.calcMonthlyEarnings(earnings);
    }
    else
    {
      return _helper.calcEarningPerType(earnings, widget.earningsType);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final _earnings = Provider.of<List<Earning>>(context) ?? [];

    String summedUp = _getSummedUpString(_earnings);

    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 22.0
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Gesamt ${summedUp}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              )
            ),
            RaisedButton(
              color: thirdColor,
              shape: buttonStyle,
              child: Text(
                'hinzufügen',
                style: TextStyle(
                    color: Colors.white
                )
              ),
              onPressed: () async {
                _showAddEarningBottomSheet();
              }
            ),
            ]
          ),
        ),
        Expanded(
          child: EarningList(
            earningTypeToShow: widget.earningsType,
          )
        ),
        SizedBox(
          height: 10.0
        )
      ],
    );
  }
}