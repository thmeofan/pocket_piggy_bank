import 'package:flutter/material.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/operation_text_style.dart';
import '../../../consts/app_text_styles/synopsis_text_style.dart';
import '../../app/widgets/chosen_action_button_widget.dart';

class ConstructorScreen extends StatefulWidget {
  @override
  _ConstructorScreenState createState() => _ConstructorScreenState();
}

class _ConstructorScreenState extends State<ConstructorScreen> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _operationType = 'Доходы';

  void _saveOperation() {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text);

    if (description.isEmpty || amount == null) {
      return;
    }

    final operation = {
      'description': description,
      'amount': amount,
      'type': _operationType,
    };

    Navigator.of(context).pop(operation);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мои операции',
          style: SynopsisTextStyle.appbar,
        ),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double width90Percent = constraints.maxWidth * 0.95;

              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: width90Percent,
                  child: Stack(
                    children: [
                      Positioned(
                        left:
                            _operationType == 'Доходы' ? 0 : width90Percent / 2,
                        top: 0,
                        bottom: 0,
                        width: width90Percent / 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: _operationType == 'Доходы'
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                  )
                                : const BorderRadius.only(
                                    topRight: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        left:
                            _operationType == 'Доходы' ? width90Percent / 2 : 0,
                        top: 0,
                        bottom: 0,
                        width: width90Percent / 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkGreyColor,
                            borderRadius: _operationType == 'Доходы'
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  )
                                : const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                  ),
                          ),
                        ),
                      ),
                      Center(
                        child: ToggleButtons(
                          isSelected: _operationType == 'Доходы'
                              ? [true, false]
                              : [false, true],
                          onPressed: (int index) {
                            setState(() {
                              _operationType =
                                  index == 0 ? 'Доходы' : 'Расходы';
                            });
                          },
                          selectedBorderColor: Colors.transparent,
                          color: AppColors.darkGreyColor,
                          selectedColor: Colors.white,
                          fillColor: Colors.transparent,
                          borderColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.0),
                              child: Text(
                                'Доходы',
                                style: OperationTextStyle.switchStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.0),
                              child: Text(
                                'Расходы',
                                style: OperationTextStyle.switchStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                _operationType,
                style: OperationTextStyle.type,
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              const Text(
                'Описание',
                style: OperationTextStyle.description,
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Например продукты',
                  labelStyle: OperationTextStyle.hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              const Text(
                'Сумма',
                style: OperationTextStyle.description,
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: '₽ 0,00',
                  labelStyle: OperationTextStyle.hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              ChosenActionButton(
                text: 'Продолжить',
                onTap: _saveOperation,
              )
            ]),
          )
        ],
      ),
    );
  }
}
