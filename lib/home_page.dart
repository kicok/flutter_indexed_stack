import 'package:flutter/material.dart';
import 'package:flutter_indexed_stack/first_step.dart';
import 'package:flutter_indexed_stack/input_data.dart';
import 'package:flutter_indexed_stack/second_step.dart';
import 'package:flutter_indexed_stack/step_button.dart';
import 'package:flutter_indexed_stack/third_step.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedStack = 0;
  final _fkey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();

  void _submit() async {
//
    setState(() {});

    if (!_fkey.currentState.validate()) {
      return;
    }

    _fkey.currentState.save();

    final inputData = Provider.of<InputData>(context, listen: false);

    //
    //
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Your Input'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.grey[100],
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('name: : ${inputData.name}'),
                    Text('email : ${inputData.email}'),
                    Text('gender : ${inputData.gender}'),
                    Text('birthday : ${inputData.dateOfBirth}'),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                color: Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'You got 100',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                inputData.name = '';
                inputData.email = '';
                inputData.gender = 'Male';
                inputData.dateOfBirth = '';
                inputData.password = '';

                Navigator.of(context).pop(true);
              },
              child: Text('OK'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('CANCEL'),
            )
          ],
        );
      },
    );

    if (result) {
      _fkey.currentState.reset();
      dateController.text = '';
      // 날짜는 다이렉트로 입력한것이 아니라 datepicker 에서 받은것을 강제로 써놓은 것이기 때문에 별도로 지워야 함.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indexed Stack'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.green[200],
              width: double.infinity,
              height: 60,
              child: Align(
                child: Text(
                  'Check Your Luck',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Form(
              key: _fkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Expanded(
                child: IndexedStack(
                  index: selectedStack,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: FirstStep(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SecondStep(dateController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ThirdStep(submit: _submit),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.indigo,
              width: double.infinity,
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StepButton(
                    selected: selectedStack == 0,
                    step: '1',
                    onPressed: () {
                      setState(() {
                        selectedStack = 0;
                      });
                    },
                  ),
                  StepButton(
                    selected: selectedStack == 1,
                    step: '2',
                    onPressed: () {
                      setState(() {
                        selectedStack = 1;
                      });
                    },
                  ),
                  StepButton(
                    selected: selectedStack == 2,
                    step: '3',
                    onPressed: () {
                      setState(() {
                        selectedStack = 2;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
