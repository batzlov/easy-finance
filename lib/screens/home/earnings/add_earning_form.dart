import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:easy_finance/shared/constants.dart';

import 'package:easy_finance/services/database.dart';

import 'package:easy_finance/models/user.dart';
import 'package:easy_finance/models/earning.dart';

class AddEarningForm extends StatefulWidget {
  Earning earning;

  AddEarningForm([
    this.earning
  ]);
  
  @override
  _AddEarningFormState createState() => _AddEarningFormState();
}

class _AddEarningFormState extends State<AddEarningForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _frequencys = ['monatlich', 'vierteljährlich', 'halbjährlich', 'jährlich'];
  
  // form values
  String _earningName;
  String _earningFrequency = 'monatlich';
  double _earningValue;
  
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
            initialValue: (widget.earning != null) ? widget.earning.name : '',
            decoration: textInputDecoration.copyWith(
              hintText: 'Name der Einnahme',
              labelText: 'Name'
            ),
            validator: (value) => value.isEmpty ? 'Bitte füge einen Namen hinzu' : null,
            onChanged: (value) => setState(() => _earningName = value),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            initialValue: (widget.earning != null) ? widget.earning.value.toString() : '',
            decoration: textInputDecoration.copyWith(
              hintText: 'Höhe der Einnahme in €',
              labelText: 'Höhe der Einnahme'
            ),
            validator: (value) {
              if(value.isEmpty || double.tryParse(value) == null)
              {
                return 'Bitte füge eine Einnahme hinzu';
              }
              else
              {
                return null;
              }
            }, 
            onChanged: (value) => setState(() => _earningValue = double.parse(value.replaceAll(',', '.'))),
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButtonFormField(
            value: (widget.earning != null) ? widget.earning.frequency : 'monatlich',
            decoration: textInputDecoration,
            items: _frequencys.map((frequency) {
              return DropdownMenuItem(
                value: frequency,
                child: Text('$frequency'),
              );
            }).toList(),
            onChanged: (value) => setState(() => _earningFrequency = value),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            shape: buttonStyle,
            color: thirdColor,
            child: Text(
              'speichern',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if(_formKey.currentState.validate())
              {
                if(widget.earning != null)
                {
                  await DatabaseService(uid: user.uid).updateEarning(
                    _earningName ?? widget.earning.name, 
                    _earningValue ?? widget.earning.value, 
                    _earningFrequency ?? widget.earning.frequency,
                    widget.earning != null ? widget.earning.uid : ''
                  );
                }
                else
                {
                  await DatabaseService(uid: user.uid).addEarning(
                    _earningName ?? widget.earning.name, 
                    _earningValue ?? widget.earning.value, 
                    _earningFrequency ?? widget.earning.frequency,
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