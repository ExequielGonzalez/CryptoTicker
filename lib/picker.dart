import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';

class Picker extends StatefulWidget {
  final Function onPressed;
  final dynamic currency;
  Picker({@required this.onPressed, @required this.currency});
  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context) {
    return getPicker(widget.onPressed, widget.currency);
  }
}

Widget getPicker(Function onPressed, dynamic currency) {
  if (Platform.isIOS)
    return getIOSPicker(onPressed, currency);
  else
    return getDropdownButton(onPressed, currency);
}

DropdownButton<String> getDropdownButton(
    Function onPressed, String selectedCurrency) {
  List<DropdownMenuItem<String>> currencies = [];
  for (String currency in currenciesList) {
    var item = DropdownMenuItem<String>(
      value: currency,
      child: Text(currency),
    );
    currencies.add(item);
  }
  return DropdownButton<String>(
    value: selectedCurrency.toString(),
    onChanged: onPressed,
    items: currencies,
  );
}

CupertinoPicker getIOSPicker(Function onPressed, String selectedCurrency) {
  List<Text> currencies = [];
  for (String currency in currenciesList) {
    var text = Text(currency);
    currencies.add(text);
  }
  return CupertinoPicker(
    backgroundColor: Colors.lightBlue,
    itemExtent: 32,
    onSelectedItemChanged: onPressed,
    children: currencies,
  );
}
