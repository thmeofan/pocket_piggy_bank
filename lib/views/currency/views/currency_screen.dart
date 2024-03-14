import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl/intl.dart';
import 'package:pocket_piggy_bank/consts/app_text_styles/currency_text_style.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/synopsis_text_style.dart';
import '../../../util/app_routes.dart';
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
    double rate = (_conversionRates[_targetCurrency] ?? 0)
        .toDouble(); // Convert rate to double
    double convertedAmount = _baseAmount * rate;
    _targetCurrencyController.text =
        NumberFormat.currency(symbol: '', decimalDigits: 2)
            .format(convertedAmount);
  }

  bool _isLoading = false;

  void _handleBaseAmountChange(String value) {
    double? amount = double.tryParse(value);
    if (amount != null) {
      setState(() {
        _baseAmount = amount;
        _updateConvertedAmount();
      });
    }
  }

  void _handleBaseCurrencyChange(String newValue) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    // Create a list of available options
    final availableOptions = ['USD', 'EUR', 'GBP', 'CNY', 'JPY', 'RUB'];

    // Check if the new value is one of the available options
    if (availableOptions.contains(newValue)) {
      setState(() {
        _baseCurrency = newValue;
        _loadConversionRates(_baseCurrency);
        _baseCurrencyController.text = '1';
        _baseAmount = 1.0;
        _updateConvertedAmount();
        _isLoading = false;
      });
    } else {
      // Handle the case where the new value is not a valid option
      print('Invalid currency option: $newValue');
    }
  }

  void _handleTargetCurrencyChange(String newValue) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _targetCurrency = newValue;
      _updateConvertedAmount();
      _isLoading = false;
    });
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
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.profile);
            },
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
                children: [
                  Container(
                    width: size.width * 0.25,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                      color: AppColors.darkGreyColor,
                    ),
                    child: Center(
                      child: _isLoading
                          ? CupertinoActivityIndicator()
                          : DropdownButton<String>(
                              value: _baseCurrency,
                              dropdownColor: AppColors.darkGreyColor,
                              icon: SvgPicture.asset('assets/icons/down.svg'),
                              isExpanded: true,
                              underline: Container(),
                              onChanged: (String? newValue) {
                                _handleBaseCurrencyChange(newValue!);
                              },
                              items: ['USD', 'EUR', 'GBP', 'CNY', 'JPY', 'RUB']
                                  .map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  alignment: Alignment.center,
                                  child: Text(
                                    value,
                                    style: CurrencyTextStyle.rowDropDown,
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
                        Text(
                          'Currency quantity',
                          style: CurrencyTextStyle.rowTitle,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkGreyColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextField(
                            controller: _baseCurrencyController,
                            style: CurrencyTextStyle.rowInput,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            onChanged: (value) {
                              _handleBaseAmountChange(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.25,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                      color: AppColors.darkGreyColor,
                    ),
                    child: Center(
                      child: _isLoading
                          ? CupertinoActivityIndicator()
                          : DropdownButton<String>(
                              icon: SvgPicture.asset('assets/icons/up.svg'),
                              value: _targetCurrency,
                              dropdownColor: AppColors.darkGreyColor,
                              isExpanded: true,
                              underline: Container(),
                              onChanged: (String? newValue) {
                                _handleTargetCurrencyChange(newValue!);
                              },
                              items: ['USD', 'EUR', 'GBP', 'CNY', 'JPY', 'RUB']
                                  .map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  alignment: Alignment.center,
                                  child: Text(
                                    value,
                                    style: CurrencyTextStyle.rowDropDown,
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Currency quantity',
                          style: CurrencyTextStyle.rowTitle,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkGreyColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextField(
                            style: CurrencyTextStyle.rowInput,
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
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Currency',
                            textAlign: TextAlign.center,
                            style: CurrencyTextStyle.tableTitles,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Buying',
                            textAlign: TextAlign.center,
                            style: CurrencyTextStyle.tableTitles,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Selling',
                            textAlign: TextAlign.center,
                            style: CurrencyTextStyle.tableTitles,
                          ),
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
            child: _getCurrencyIcon(currency),
          ),
          Expanded(
            flex: 2,
            child: Text(
              currency,
              textAlign: TextAlign.center,
              style: CurrencyTextStyle.tableLine,
            ),
          ),
          Expanded(
            child: Text(
              doubleRate != null ? doubleRate.toStringAsFixed(2) : 'N/A',
              textAlign: TextAlign.center,
              style: CurrencyTextStyle.tableLine,
            ),
          ),
          Expanded(
            child: Text(
              doubleRate != null
                  ? (doubleRate * 1.02).toStringAsFixed(2)
                  : 'N/A',
              textAlign: TextAlign.center,
              style: CurrencyTextStyle.tableLine,
            ),
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

  Widget _getCurrencyIcon(String currency) {
    String assetPath = 'assets/icons/';
    switch (currency) {
      case 'CNY':
        return SvgPicture.asset(
          '${assetPath}cny.svg',
          color: AppColors.blackColor,
        );
      case 'RUB':
        return SvgPicture.asset(
          '${assetPath}rub.svg',
          color: AppColors.blackColor,
        );
      case 'USD':
        return SvgPicture.asset(
          '${assetPath}usd.svg',
          color: AppColors.blackColor,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
