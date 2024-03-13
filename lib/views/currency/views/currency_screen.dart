import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl/intl.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/synopsis_text_style.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blackColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          'Currency',
          style: SynopsisTextStyle.appbar,
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        color: AppColors.blackColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: size.width * 0.25,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                        color: AppColors.darkGreyColor),
                    child: Center(
                      child: DropdownButton<String>(
                        value: _baseCurrency,
                        icon: SvgPicture.asset('assets/icons/down.svg'),
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _baseCurrency = newValue!;
                            _loadConversionRates(_baseCurrency);
                            _baseCurrencyController.text = '1';
                            _baseAmount = 1.0;
                            _updateConvertedAmount();
                          });
                        },
                        items: <String>[
                          'USD',
                          'EUR',
                          'GBP',
                          'CNY',
                          'JPY',
                          'RUB'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Currency quantity'),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkGreyColor,
                            borderRadius: BorderRadius.circular(
                                10.0), // Rounded corners// Remove input borders
                          ),
                          child: TextField(
                            controller: _baseCurrencyController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                            ),
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
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: size.width * 0.25,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                        color: AppColors.darkGreyColor),
                    child: Center(
                      child: DropdownButton<String>(
                        icon: SvgPicture.asset('assets/icons/up.svg'),
                        value: _targetCurrency,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _targetCurrency = newValue!;
                            _updateConvertedAmount();
                          });
                        },
                        items: <String>[
                          'USD',
                          'EUR',
                          'GBP',
                          'CNY',
                          'JPY',
                          'RUB'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Currency quantity'),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkGreyColor,
                            borderRadius: BorderRadius.circular(
                                10.0), // Rounded corners// Remove input borders
                          ),
                          child: TextField(
                            controller: _targetCurrencyController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            readOnly: true,
                          ),
                        ),
                      ],
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
                      children: [
                        SizedBox(
                          width: size.width * 0.13,
                        ),
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
      ),
    );
  }

  Widget _currencyDataRow(String currency, dynamic rate) {
    double? doubleRate;
    if (rate is double) {
      doubleRate = rate;
    } else if (rate is int) {
      doubleRate = rate.toDouble();
    }
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            radius: size.width * 0.065,
            backgroundColor: _getCircleColor(currency),
          ),
          Expanded(
            flex: 2,
            child: Text(currency, textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text(
                doubleRate != null ? doubleRate.toStringAsFixed(2) : 'N/A',
                textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text(
                doubleRate != null
                    ? (doubleRate * 1.02).toStringAsFixed(2)
                    : 'N/A',
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Color _getCircleColor(String currency) {
    switch (currency) {
      case 'CNY':
        return AppColors.pinkColor;
      case 'RUB':
        return AppColors.greenColor;
      case 'USD':
        return AppColors.blueColor;
      default:
        return Colors.grey;
    }
  }
}
