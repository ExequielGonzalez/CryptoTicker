import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String coinAPIKey = '5860C8D8-658F-436E-8A08-47FC89ACB961';

class NetworkHelper {
  String activeCurrency;
  String activeCrypto;
  var lastResponse;

  dynamic getConversionData(String crypto, String currency) async {
    if (currency != activeCurrency || crypto != activeCrypto) {
      var url =
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$coinAPIKey';

      var response = await http.get(url);
      if (response.statusCode == 200) {
        lastResponse = convert.jsonDecode(response.body);
        activeCurrency = currency;
        activeCrypto = crypto;
        return lastResponse;
      } else {
        return {'rate': 0};
      }
    } else {
      print('no se actualiza, se usa la ultima actualización');
      return lastResponse;
    }
  }
}
