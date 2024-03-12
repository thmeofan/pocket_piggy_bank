import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final _dateController = TextEditingController();
  final _commentController = TextEditingController();
  String _operationType = 'Income';
  List<bool> _isSelected = [true, false]; // 'Income' is selected by default.

  void _toggleOperationType(int index) {
    setState(() {
      // Toggle the operation type based on index
      if (index == 0) {
        _operationType = 'Income';
        _isSelected = [true, false];
      } else {
        _operationType = 'Spendings';
        _isSelected = [false, true];
      }
    });
  }

  void _saveOperation() {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text);
    final date = _dateController.text;
    final comment = _commentController.text;

    if (description.isEmpty || amount == null || date.isEmpty) {
      return; // Optionally, you could show an error message here.
    }

    final operation = {
      'description': description,
      'amount': amount,
      'type': _operationType,
      'date': date,
      'comment': comment,
    };

    // Assuming you pop the screen and pass the operation back
    Navigator.of(context).pop(operation);
  }

  // This function is how we would display the DatePicker
  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Entry'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ToggleButtons(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text('Income'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text('Spendings'),
                    ),
                  ],
                  isSelected: _isSelected,
                  onPressed: _toggleOperationType,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Operation Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date (tap to select)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveOperation,
                child: Text('Save Operation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
