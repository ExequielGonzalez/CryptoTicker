import 'package:bitcoin_ticker/card_widget.dart';
import 'package:bitcoin_ticker/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/picker.dart';

import 'package:bitcoin_ticker/constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  NetworkHelper networkHelper;
  List<CoinData> dataCrypto = [];
  String selectedCurrency = 'ARS';

  void initState() {
    super.initState();
    networkHelper = NetworkHelper();
    for (int i = 0; i < cryptoList.length; i++) {
      dataCrypto.add(CoinData(cryptoCurrency: cryptoList[i], currency: 'ARS'));
    }
    getConversionRatio(dataCrypto);
  }

  void getConversionRatio(List<CoinData> dataCryptoCurrency) async {
    for (CoinData crypto in dataCryptoCurrency) {
      var data = await networkHelper.getConversionData(
          crypto.cryptoCurrency, crypto.currency);
      setState(() {
        crypto.conversionRatio = data['rate'];
      });
    }
  }

  List<Widget> cardWidgetList() {
    List<CardWidget> cardWidgets = [];
    for (int i = 0; i < cryptoList.length; i++) {
      cardWidgets.add(CardWidget(
          cryptoCurrency: dataCrypto[i].cryptoCurrency,
          conversionRatio: dataCrypto[i].conversionRatio,
          selectedCurrency: dataCrypto[i].currency));
    }
    return cardWidgets;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
        centerTitle: true,
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cardWidgetList(),
        ),
        Expanded(
          child: Container(
            child: null,
          ),
        ),
        Container(
          height: 75.0,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 15.0),
          color: kWidgetBackgroundColor,
          child: Picker(
            onPressed: (var newValue) async {
              setState(() {
                selectedCurrency = newValue.toString();
              });
              for (CoinData crypto in dataCrypto) {
                setState(() {
                  crypto.currency = selectedCurrency;
                });
              }
              getConversionRatio(dataCrypto);
            },
            currency: selectedCurrency,
          ),
        ),
      ]),
    );
  }
}
