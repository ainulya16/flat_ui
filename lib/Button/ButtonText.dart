import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/material.dart';

class FUIButtonText extends StatelessWidget {
  final Widget child;
  final String text, textColor;
  final Function onPress;
  final double fontSize;
  final FontWeight fontWeight;
  final bool disabled, shadow;

  FUIButtonText(
      {this.fontSize = 18,
      this.fontWeight = FontWeight.normal,
      this.child,
      @required this.text,
      this.textColor = '#000000',
      this.shadow = false,
      this.onPress,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return FUIButtonBase(
      disabled: disabled,
      onPress: onPress,
      child: Text(text,
          style: TextStyle(
              shadows: shadow ? [boxShadow] : null,
              fontSize: fontSize,
              color: HexColor(textColor),
              fontWeight: fontWeight,
              fontFamily: 'OpenSans',
              package: 'flat_ui')),
    );
  }
}
