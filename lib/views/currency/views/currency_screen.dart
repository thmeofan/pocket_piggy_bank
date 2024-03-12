import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../../../util/currency_service.dart';

class CurrencyScreen extends StatefulWidget {
  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final CurrencyService _currencyService = CurrencyService();
  Map<String, dynamic> _conversionRates = {};
  String _baseCurrency = 'USD';
  String _targetCurrency = 'EUR';
  double _baseAmount = 1.0;
  final TextEditingController _baseCurrencyController =
      TextEditingController(text: '1');
  final TextEditingController _targetCurrencyController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadConversionRates(_baseCurrency);
  }

  void _loadConversionRates(String baseCurrency) async {
    try {
      var rates = await _currencyService.getConversionRates(baseCurrency);
      setState(() {
        _conversionRates = rates['rates'];
        _baseCurrency = baseCurrency;
        _updateConvertedAmount();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _updateConvertedAmount() {
    double rate = _conversionRates[_targetCurrency] ?? 0.0;
    double convertedAmount = _baseAmount * rate;
    _targetCurrencyController.text =
        NumberFormat.currency(symbol: '', decimalDigits: 2)
            .format(convertedAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton<String>(
                    value: _baseCurrency,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _baseCurrency = newValue!;
                        _loadConversionRates(_baseCurrency);
                        _baseCurrencyController.text = '1';
                        _baseAmount = 1.0;
                        _updateConvertedAmount();
                      });
                    },
                    items: <String>['USD', 'EUR', 'GBP', 'CNY', 'JPY', 'RUB']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _baseCurrencyController,
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _baseAmount = double.tryParse(value) ?? 0.0;
                        _updateConvertedAmount();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton<String>(
                    value: _targetCurrency,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _targetCurrency = newValue!;
                        _updateConvertedAmount();
                      });
                    },
                    items: <String>['USD', 'EUR', 'GBP', 'CNY', 'JPY', 'RUB']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _targetCurrencyController,
                    decoration: InputDecoration(labelText: 'Converted'),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Expanded(
                        flex: 2,
                        child: Text('Currency', textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Buying', textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Selling', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  Divider(),
                  ...['CNY', 'RUB', 'USD']
                      .map((currency) => _currencyDataRow(
                          currency, _conversionRates[currency]))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _currencyDataRow(String currency, dynamic rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(currency, textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text(rate != null ? rate.toStringAsFixed(2) : 'N/A',
              textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text(rate != null ? (rate * 1.02).toStringAsFixed(2) : 'N/A',
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
