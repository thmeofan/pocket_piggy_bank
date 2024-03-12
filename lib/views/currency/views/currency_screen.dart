import 'package:flutter/material.dart';
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
  final TextEditingController _controller = TextEditingController(text: '1');

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
      });
    } catch (e) {
      // Handle errors or show an alert
      print(e.toString());
    }
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
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Amount in $_baseCurrency',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _baseAmount = double.tryParse(value) ?? 0;
                  });
                },
              ),
              DropdownButton<String>(
                value: _baseCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _baseCurrency = newValue!;
                    _loadConversionRates(_baseCurrency);
                    _controller.text = '1';
                    _baseAmount = 1.0;
                  });
                },
                items: <String>['USD', 'EUR', 'GBP', 'CNY', 'JPY']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Conversion:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$_baseAmount $_baseCurrency = ${_formatConvertedAmount()} $_targetCurrency',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ));
  }

  String _formatConvertedAmount() {
    double rate = _conversionRates[_targetCurrency] ?? 0.0;
    double convertedAmount = _baseAmount * rate;
    return NumberFormat.currency(symbol: '', decimalDigits: 2)
        .format(convertedAmount);
  }
}
