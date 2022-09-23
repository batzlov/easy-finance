import 'package:easy_finance/screens/home/expenses/expenses_tab.dart';
import 'package:flutter/material.dart';
import 'package:easy_finance/screens/home/expenses/expense_tile.dart';
import 'package:easy_finance/models/expense.dart';
import 'package:provider/provider.dart';

import 'package:easy_finance/screens/home/shared/types.dart';

class ExpenseList extends StatefulWidget {
  ExpenseType expenseTypeToShow;

  ExpenseList({
    this.expenseTypeToShow
  });

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  double _expensePerMonth(Expense expense) 
  {
    if(widget.expenseTypeToShow != ExpenseType.all)
    {
      return expense.value;
    }

    if(expense.frequency == 'jährlich')
    {
      return expense.value / 12;
    }
    else if(expense.frequency == 'halbjährlich')
    {
      return expense.value / 2;
    }
    else if(expense.frequency == 'vierteljährlich')
    {
      return expense.value / 4;
    }
    else
    {
      return expense.value;
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    final expenses = Provider.of<List<Expense>>(context) ?? [];
    List<Expense> expensesToShow = [];

    if(widget.expenseTypeToShow != ExpenseType.all) 
    {
      Iterable<Expense> iterable = expenses.where((expense) {
        if(widget.expenseTypeToShow == ExpenseType.yearly)
        {
          return expense.frequency == 'jährlich';
        }
        else if(widget.expenseTypeToShow == ExpenseType.quarterly)
        {
          return expense.frequency == 'vierteljährlich';
        }
        else if(widget.expenseTypeToShow == ExpenseType.monthly)
        {
          return expense.frequency == 'monatlich';
        }
        else
        {
          return expense.frequency == 'halbjährlich';
        }
      });

      expensesToShow = iterable.toList();
    }
    else 
    {
      expensesToShow = expenses;
    }

    if(expensesToShow.length > 0)
    {
      return ListView.builder(
        itemCount: expensesToShow.length,
        itemBuilder: (context, index) {
          return ExpenseTile(
            expense: expensesToShow[index]
          );
        },
      );
    }
    else
    {
      return Center(
        child: Text(
          'Füge weitere Ausgaben hinzu! :)'
        )
      );
    }
  }
}
