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
  StepperController controller = new StepperController();

  @override
  Widget build(BuildContext context) {
    StepperItem page1 = new StepperItem(
      title: "Pasien",
      page: Container(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text("Previous"),
                    onPressed: () {
                      controller.next();
                    },
                  ),
                ],
              ),
            ),
          )
      ,
        )
    );
    StepperItem page2 = new StepperItem(page: Container(color: Colors.red,), title: 'Data 1');
    StepperItem page3 = new StepperItem(page: Container(color: Colors.red,), title: 'Data 2');
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: FUIStepper(
          controller: controller,
          headerColor: Colors.grey.shade200,
          pages: [page1, page2, page3],
          inActiveColor: Colors.grey.shade100,
          inActiveNumberColor: Colors.grey.shade700,
          key: 'FUIStepper',
        ),
      ),
    );
  }
}
