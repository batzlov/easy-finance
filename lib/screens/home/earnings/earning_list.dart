import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:easy_finance/models/earning.dart';

import 'package:easy_finance/screens/home/earnings/earning_tile.dart';
import 'package:easy_finance/screens/home/shared/types.dart';

class EarningList extends StatefulWidget {
  EarningType earningTypeToShow;

  EarningList({
    this.earningTypeToShow
  });
  
  @override
  _EarningListState createState() => _EarningListState();
}

class _EarningListState extends State<EarningList> {
  double _earningPerMonth(Earning earning) {
    if(widget.earningTypeToShow != EarningType.all)
    {
      return earning.value;
    }

    if(earning.frequency == 'jährlich')
    {
      return earning.value / 12;
    }
    else if(earning.frequency == 'halbjährlich')
    {
      return earning.value / 2;
    }
    else if(earning.frequency == 'vierteljährlich')
    {
      return earning.value / 4;
    }
    else
    {
      return earning.value;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final earnings = Provider.of<List<Earning>>(context) ?? [];
    List<Earning> earningsToShow = [];

    if(widget.earningTypeToShow != EarningType.all) {
      Iterable<Earning> iterable = earnings.where((expense) {
        if(widget.earningTypeToShow == EarningType.yearly)
        {
          return expense.frequency == 'jährlich';
        }
        else if(widget.earningTypeToShow == EarningType.quarterly)
        {
          return expense.frequency == 'vierteljährlich';
        }
        else if(widget.earningTypeToShow == EarningType.monthly)
        {
          return expense.frequency == 'monatlich';
        }
        else
        {
          return expense.frequency == 'halbjährlich';
        }
      });

      earningsToShow = iterable.toList();
    }
    else {
      earningsToShow = earnings;
    }

    if(earningsToShow.length > 0) 
    {
      return ListView.builder(
        itemCount: earningsToShow.length,
        itemBuilder: (context, index) {
          return EarningTile(
            earning: earningsToShow[index]
          );
        }
      );
    }
    else 
    {
      return Center(
        child: Text(
          'Füge weitere Einnahmen hinzu!'
        )
      );
    }
  }
}