import 'package:bitcoin_ticker/utilities/networking.dart';

const List<String> currenciesList = [
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
];

const String apiKey = 'BA6C3F6A-05EF-46DF-8ECF-08C54E22B669';
const String apiURL = 'https://rest.coinapi.io/v1/exchangerate/';

class CoinData {
  Future<dynamic> getCryptoCoinData(String crypto, String currency) async {
    print('$apiURL$crypto/$currency?apikey=$apiKey');
    NetworkHelper networkHelper =
        NetworkHelper('$apiURL$crypto/$currency?apikey=$apiKey');
    var coinData = await networkHelper.getData();
    print(coinData);
    return coinData;
  }

  Future<String> getBTCRate(String currency) async {
    var data = await getCryptoCoinData('BTC', currency);
    if (data == null) {
      return '?';
    } else {
      var r = data['rate'];
      return r.toStringAsFixed(2);
    }
  }

  Future<String> getETHRate(String currency) async {
    var data = await getCryptoCoinData('ETH', currency);
    if (data == null) {
      return '?';
    } else {
      var r = data['rate'];
      return r.toStringAsFixed(2);
    }
  }

  Future<String> getLTCRate(String currency) async {
    var data = await getCryptoCoinData('LTC', currency);
    if (data == null) {
      return '?';
    } else {
      var r = data['rate'];
      return r.toStringAsFixed(2);
    }
  }
}
