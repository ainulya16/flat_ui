import 'package:example/pages/Account.dart';
import 'package:example/pages/Payment.dart';
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
    StepperItem account2 = new StepperItem(
        title: "Account",
        page: Account(stepperController: controller,));
    StepperItem account = new StepperItem(
        title: "Account",
        page: Account(stepperController: controller,));
    StepperItem payment = new StepperItem(
        title: "Payment Detail",
        page: Payment(stepperController: controller,));
    StepperItem shipment = new StepperItem(
        title: "Shipment Detail",
        page: Payment(stepperController: controller,));
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: FUIStepper(
          controller: controller,
          headerColor: Colors.grey.shade200,
          pages: [account, payment, shipment, account2],
          inActiveBgColor: Colors.grey.shade100,
          inActiveTextColor: Colors.grey.shade700,
          key: 'FUIStepper',
        ),
      ),
    );
  }
}
