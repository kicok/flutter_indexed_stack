import 'package:flutter/material.dart';
import 'package:flutter_indexed_stack/input_data.dart';
import 'package:provider/provider.dart';

class ThirdStep extends StatelessWidget {
  final Function submit;

  ThirdStep({this.submit});

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final inputData = Provider.of<InputData>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextFormField(
            style: TextStyle(fontSize: 18.0),
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                hintText: 'Enter your password'),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Need your password';
              }
              if (val.length < 6) {
                return 'Password too short';
              }
              return null;
            },
            onSaved: (val) {
              inputData.password = val;
            },
          ),
          SizedBox(height: 30.0),
          TextFormField(
            style: TextStyle(fontSize: 18.0),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Need your password';
              }

              if (controller.text != val) {
                return 'Password not match';
              }
              return null;
            },
          ),
          SizedBox(height: 30.0),
          MaterialButton(
            padding: EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 12.0,
            ),
            color: Colors.indigo,
            textColor: Colors.white,
            child: Text('SUBMIT'),
            onPressed: submit,
          ),
        ],
      ),
    );
  }
}
