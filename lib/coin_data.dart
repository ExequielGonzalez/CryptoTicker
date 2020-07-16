const List<String> currenciesList = [
  'ARS',
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'USDT',
];

class CoinData {
  String cryptoCurrency;
  String currency;
  double conversionRatio = 0;

  CoinData({this.cryptoCurrency, this.currency});

  double getConversionRatio() => conversionRatio;
}
