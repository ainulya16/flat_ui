import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/material.dart';

enum ButtonSize {
  small,  // height 35
  medium, // height 50
  large,  // height 65
  block,  // 50
  full,   // infinity
}

class Button extends StatelessWidget {
  final Widget child;
  final String text, color, textColor;
  final Function onPress;
  final ButtonSize size;
  final double width, height, borderRadius;
  final bool disabled, shadow;
  
  Button({
    this.child,
    @required this.text,
    this.color='#FFFFFF',
    this.textColor='#FFFFFF',
    this.shadow=false,
    this.onPress,
    this.size=ButtonSize.block,
    this.height,
    this.width,
    this.borderRadius=7,
    this.disabled=false});


  @override
  Widget build(BuildContext context) {
    double paddingHorizontal, paddingVertical, defaultFontSize;
    switch (size) {
      case ButtonSize.small:
        paddingVertical = 10;
        paddingHorizontal = 17;
        defaultFontSize = 15;
        break;
      case ButtonSize.medium:
        paddingVertical = 13;
        paddingHorizontal = 20;
        defaultFontSize = 18;
        break;
      case ButtonSize.large:
        paddingVertical = 16;
        paddingHorizontal = 23;
        defaultFontSize = 21;
        break;
      case ButtonSize.block:
        paddingVertical = 0;
        paddingHorizontal = 0;
        defaultFontSize = 18;
        break;
      case ButtonSize.full:
        paddingVertical = 0;
        paddingHorizontal = 0;
        defaultFontSize = 18;
        break;
      default:
        paddingVertical = 13;
        paddingHorizontal = 23;
        defaultFontSize = 18;
        break;
    }
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: disabled ? 0.6 : 1.0,
      child: Bounce(
        useOpacity: true,
        disabled: disabled,
        onTap: onPress,
        child:Container(
          margin: size == ButtonSize.full ? EdgeInsets.all(0) : EdgeInsets.fromLTRB(10,20,10,20),
          height: (size == ButtonSize.block || size == ButtonSize.full) ? 55 : height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
          decoration: BoxDecoration(
            color: HexColor(color),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: shadow ? [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20.0,
                  offset: Offset(0.0, 10.0,),
                  spreadRadius: -10
                ),
            ] : null,
          ),
          child: (size == ButtonSize.block || size == ButtonSize.full) ? Center(
            child: child != null ? child : Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: defaultFontSize, color: HexColor(textColor))),
          ) :
          Container(
            child: child != null ? child : Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: defaultFontSize, color: HexColor(textColor))),
          ),
        ),
      ),
    );
  }

}