import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  String btcRate = '?';
  String ethRate = '?';
  String ltcRate = '?';

  CoinData coinData = CoinData();

  void updateUI(String currency) async {
    String bRate = await coinData.getBTCRate(currency);
    String eRate = await coinData.getETHRate(currency);
    String lRate = await coinData.getLTCRate(currency);

    setState(() {
      btcRate = bRate;
      ethRate = eRate;
      ltcRate = lRate;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    // loop through currencies to create drop down item for each currency
    for (String currency in currenciesList) {
      DropdownMenuItem<String> item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateUI(value);
        });
      },
    );
  } //end androidDropdown

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      children: pickerItems,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          updateUI(currenciesList[selectedIndex]);
        });
      },
    );
  } //end iOSPicker

/*
  void getCryptoData(String currency) async {
    try {
      for (String crypto in cryptoList) {
        CoinData coinData = CoinData();
        var cryptoCoinData = await coinData.getCryptoCoinData(crypto, currency);
        print(cryptoCoinData);
        if (cryptoCoinData == null) {
          continue;
        } else if (crypto == 'BTC') {
          double r = cryptoCoinData['rate'];
          btcRate = r.toStringAsFixed(2);
        } else if (crypto == 'ETH') {
          double r = cryptoCoinData['rate'];
          ethRate = r.toStringAsFixed(2);
        } else if (crypto == 'LTC') {
          double r = cryptoCoinData['rate'];
          ltcRate = r.toStringAsFixed(2);
        }
      } //end for loop
    } catch (e) {
      print(e);
    }
  } // end getCryptoData
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
