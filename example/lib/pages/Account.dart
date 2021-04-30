import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class Account extends StatefulWidget {
  Account({Key key, this.stepperController}) : super(key: key);

  final FUIStepperController stepperController;

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int _counter = 0;
  List<OptionItem> options = [
    OptionItem(label: 'Label text 1', value: 1),
    OptionItem(label: 'dasds', value: 2),
    OptionItem(label: 'Label text 3', value: 3),
    OptionItem(label: 'Label text 4', value: 4),
    OptionItem(label: 'Label text 5', value: 5),
    OptionItem(label: 'Label text 12', value: 11),
    OptionItem(label: 'dasdssadasd', value: 22),
    OptionItem(label: 'Label text 33', value: 31),
    OptionItem(label: 'Label text 43', value: 41),
    OptionItem(label: 'Label text 53', value: 51),
    OptionItem(label: 'Label text 14', value: 12),
    OptionItem(label: 'dasdszxczxc', value: 23),
    OptionItem(label: 'Label text 34', value: 33),
    OptionItem(label: 'Label text 45', value: 43),
    OptionItem(label: 'Label text 56', value: 53),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                borderType: FUIFieldBorderType.bordered,
                prefix: Icon(Icons.mail_outline, color: TinyColor.fromString('#2980b9').color,),
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
                borderType: FUIFieldBorderType.bordered,
                prefix: Icon(Icons.lock_outline, color: TinyColor.fromString('#2980b9').color,),
                borderRadius: 4,
                obsecureText: true,
                borderColor: '#bdc3c7',
                focusedBorderColor: '2980b9',
                floatingLabelBehavior: FloatingLabelBehavior.never,
              )
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 10),
              child: FUIDateTimePicker(
                label: 'Date of Birth',
                borderType: FUIFieldBorderType.bordered,
                prefix: Icon(Icons.lock_outline, color: TinyColor.fromString('#2980b9').color,),
                borderRadius: 4,
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
                onPress: () => widget.stepperController.next(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
