import 'package:flutter/material.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/operation_text_style.dart';
import '../../../consts/app_text_styles/synopsis_text_style.dart';
import '../../../util/shared_pref_service.dart';
import 'constructor_screen.dart';

class FinanceScreen extends StatefulWidget {
  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  List<Map<String, dynamic>> operations = [];
  String _operationType = 'Доходы';

  @override
  void initState() {
    super.initState();
    _loadOperations();
  }

  void _loadOperations() async {
    operations = await SharedPreferencesService.loadOperations();
    setState(() {});
  }

  void _addOperation(Map<String, dynamic> operation) async {
    setState(() {
      operations.add(operation);
    });
    await SharedPreferencesService.saveOperations(operations);
  }

  List<Map<String, dynamic>> get _filteredOperations {
    return operations.where((op) => op['type'] == _operationType).toList();
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: _filteredOperations.isEmpty
                ? Center(child: Text('Вы ещё не ввели свои $_operationType '))
                : ListView.builder(
                    itemCount: _filteredOperations.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          tileColor: AppColors.darkGreyColor,
                          title: Text(
                            '${_filteredOperations[index]['description']} ₽ ',
                            style: OperationTextStyle.tileSum,
                          ),
                          subtitle: Text(
                            _filteredOperations[index]['amount'].toString(),
                            style: OperationTextStyle.tileSubtitle,
                          ),
                          trailing: Text(
                            DateTime.now().toString().substring(0, 10),
                            style: OperationTextStyle.date,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkGreyColor,
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: AppColors.darkGreyColor,
        ),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConstructorScreen()),
          );

          if (result != null) {
            _addOperation(result);
          }
        },
      ),
    );
  }
}
