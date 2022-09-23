import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:easy_finance/shared/constants.dart';

import 'package:easy_finance/services/database.dart';
import 'package:easy_finance/models/expense.dart';
import 'package:easy_finance/models/user.dart';

class AddExpenseForm extends StatefulWidget {
  Expense expense;

  AddExpenseForm(
    [this.expense]
  );

  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _frequencys = ['monatlich', 'vierteljährlich', 'halbjährlich', 'jährlich'];
  
  // form values
  String _expenseName;
  String _expenseFrequency = 'monatlich';
  double _expenseValue;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Füge eine Ausgabe hinzu',
            style: TextStyle(
              fontSize: 18.0,
            )
          ),
          SizedBox(
            height: 10.0
          ),
          TextFormField(
            initialValue: (widget.expense != null) ? widget.expense.name : '',
            decoration: textInputDecoration.copyWith(
              hintText: 'Name der Ausgabe',
              labelText: 'Name'
            ),
            validator: (value) => value.isEmpty ? 'Bitte füge einen Namen hinzu' : null,
            onChanged: (value) => setState(() => _expenseName = value),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            initialValue: (widget.expense != null) ? widget.expense.value.toString() : '',
            decoration: textInputDecoration.copyWith(
              hintText: 'Höhe der Ausgabe in €',
              labelText: 'Ausgabe'
            ),
            validator: (value) {
              if(value.isEmpty || double.tryParse(value) == null)
              {
                return 'Bitte füge eine Ausgabe hinzu';
              }
              else
              {
                return null;
              }
            }, 
            onChanged: (value) => setState(() => _expenseValue = double.parse(value.replaceAll(',', '.'))),
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButtonFormField(
            value: (widget.expense != null) ? widget.expense.frequency : 'monatlich',
            decoration: textInputDecoration,
            items: _frequencys.map((frequency) {
              return DropdownMenuItem(
                value: frequency,
                child: Text('$frequency'),
              );
            }).toList(),
            onChanged: (value) => setState(() => _expenseFrequency = value),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            color: thirdColor,
            shape: buttonStyle,
            child: Text(
              'speichern',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if(_formKey.currentState.validate())
              {
                if(widget.expense != null)
                {
                  await DatabaseService(uid: user.uid).updateExpense(
                    _expenseName ?? widget.expense.name, 
                    _expenseValue ?? widget.expense.value, 
                    _expenseFrequency ?? widget.expense.frequency,
                    widget.expense != null ? widget.expense.uid : ''
                  );
                }
                else
                {
                  await DatabaseService(uid: user.uid).addExpense(
                    _expenseName ?? widget.expense.name, 
                    _expenseValue ?? widget.expense.value, 
                    _expenseFrequency ?? widget.expense.frequency,
                  );
                }
                
                Navigator.pop(context);
              }
            }
          ),
          SizedBox(
            height: 10.0
          )
        ]
      )
    );
  }
}