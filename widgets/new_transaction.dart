import 'package:expense_planner/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('constructor new transactionwidget');
  }

  @override
  _NewTransactionState createState() {
    print('create state new transaction widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  _NewTransactionState() {
    print('constructor new transactionwidget');
  }
  @override //override means there is similiar function in
//parent class and we are calling our own
  void initState() {
    super.initState(); //parent class initState is called from my initState
    print('initstate new transaction');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didupdatewidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');

    super.dispose();
  }

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount); //widget.add.... allows property
    //from the widget class means the above class
    Navigator.of(context)
        .pop(); //used to close a topmost screen //used to automatically close the
    //data entering sheet
  }

  DateTime _selectedDate;
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (val) => titleInput = val,
                controller: _titleController,
                onSubmitted: (_) =>
                    submitData(), //the anonymous function can be
                // be avoided if the  submit() function is written as
                // submitData(String val) because on submitted gives you
                //the value entered thus far and something need to react to it
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (val) => amountInput = val,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      //takes all space it needs so it pushes the button
                      //to only necessary space
                      child: Text(
                        _selectedDate == null
                            ? 'no date choosen'
                            : 'picked date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('choose date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text('Add Transaction'),
                color: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
