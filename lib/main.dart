import 'package:flutter/material.dart';
import 'package:flutter_indexed_stack/home_page.dart';
import 'package:flutter_indexed_stack/input_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InputData(),
      child: MaterialApp(
        title: 'IndexedStack',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
