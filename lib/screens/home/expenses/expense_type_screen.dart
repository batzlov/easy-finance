import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:easy_finance/services/helper.dart';

import 'package:easy_finance/models/expense.dart';

import 'package:easy_finance/shared/constants.dart';

import 'package:easy_finance/screens/home/expenses/expense_list.dart';
import 'package:easy_finance/screens/home/expenses/add_expense_form.dart';

import 'package:easy_finance/screens/home/shared/types.dart';

class ExpenseTypeScreen extends StatefulWidget {
  ExpenseType expenseType;

  ExpenseTypeScreen({
    this.expenseType
  });
  
  @override
  _ExpenseTypeScreenState createState() => _ExpenseTypeScreenState();
}

class _ExpenseTypeScreenState extends State<ExpenseTypeScreen> {
  HelperService _helper = new HelperService();

  void _showAddExpenseBottomSheet()
  {
    showModalBottomSheet(
      backgroundColor: lightGreyBackground,
      context: context,
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
            child: AddExpenseForm()
          )
        );
      }
    );
  }
  
  String _getSummedUpString(List<Expense> expenses)
  {
    if(widget.expenseType == ExpenseType.all) 
    {
      return _helper.calcMonthlyExpenses(expenses);
    }
    else
    {
      return _helper.calcExpensePerType(expenses, widget.expenseType);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _expenses = Provider.of<List<Expense>>(context) ?? [];

    String _summedUp = _getSummedUpString(_expenses); 

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
              'Gesamt: ${_summedUp}',
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
                _showAddExpenseBottomSheet();
              }
            ),
            ]
          ),
        ),
        Expanded(
          child: ExpenseList(
            expenseTypeToShow: widget.expenseType
          )
        ),
        SizedBox(
          height: 10.0
        )
      ],
    );
  }
}