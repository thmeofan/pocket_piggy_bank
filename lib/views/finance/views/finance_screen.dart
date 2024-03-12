import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  double get _totalForYear {
    // Add incomes and subtract spendings
    double total = 0;
    operations.forEach((op) {
      if (op['type'] == 'Income') {
        total += op['amount'];
      } else {
        total -= op['amount'];
      }
    });
    return total;
  }

  double get _totalIncome {
    // Sum only incomes
    return operations
        .where((op) => op['type'] == 'Income')
        .fold(0, (prev, op) => prev + op['amount']);
  }

  double get _totalSpendings {
    // Sum only spendings
    return operations
        .where((op) => op['type'] == 'Spendings')
        .fold(0, (prev, op) => prev + op['amount']);
  }

  Map<String, List<Map<String, dynamic>>> _groupOperationsByDate() {
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var operation in operations) {
      String date = operation['date'];
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(operation);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedOperations = _groupOperationsByDate();
    final sortedDates = groupedOperations.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мои операции',
          style: SynopsisTextStyle.appbar,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: AppColors.darkGreyColor,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.black,
                  width: double.infinity,
                  child: Text(
                    'Total this year: $_totalForYear ₽',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: Colors.black,
                        child: Text(
                          'Incomes: $_totalIncome ₽',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: Colors.black,
                        child: Text(
                          'Spendings: $_totalSpendings ₽',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (ctx, index) {
                String date = sortedDates[index];
                List<Map<String, dynamic>> dailyOperations =
                    groupedOperations[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('MMMM d, yyyy')
                            .format(DateFormat('yyyy-MM-dd').parse(date)),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...dailyOperations.map((op) {
                      bool isIncome = op['type'] == 'Income';
                      return ListTile(
                        title: Text(
                          '${op['description']} - ${isIncome ? "+" : "-"}${op['amount']}₽',
                          style: TextStyle(
                              color: isIncome ? Colors.green : Colors.white),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkGreyColor,
        child: Icon(Icons.add, color: Colors.white),
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
