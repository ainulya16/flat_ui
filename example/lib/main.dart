import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 10),
              child: FUITextField(
                label: 'Email',
                allowNextFocus: true,
                borderType: FUITextFieldBorderType.bordered,
                prefix: Icon(Icons.mail_outline, color: HexColor('#2980b9'),),
                hintText: 'john@doe.com',
                borderRadius: 4,
                borderColor: '#bdc3c7',
                focusedBorderColor: '2980b9',
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 10),
              child: FUITextField(
                label: 'Password',
                allowNextFocus: false,
                borderType: FUITextFieldBorderType.bordered,
                prefix: Icon(Icons.lock_outline, color: HexColor('#2980b9'),),
                borderRadius: 4,
                obsecureText: true,
                borderColor: '#bdc3c7',
                focusedBorderColor: '2980b9',
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                FUIButtonText(text: 'Forgot Password?', textColor: '#34495e', fontSize: 16,fontWeight: FontWeight.bold,)
              ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: FUIButton(
                size: ButtonSize.block,
                color: '#3498db',
                text: 'LOGIN',
                borderRadius: 4,
                onPress: _incrementCounter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
