import 'package:flat_ui/bounce/bounce.dart';
import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/material.dart';

enum FlatUIButtonSize {
  small,  // height 35
  medium, // height 50
  large   // height 65
}

class FlatUIButton extends StatelessWidget {
  final Widget child;
  final String text, color;
  final Function onPress;
  final FlatUIButtonSize size;
  final double width, height, borderRadius;
  final bool disabled, shadow;
  
  FlatUIButton({
    this.child,
    @required this.text,
    this.color,
    this.shadow=true,
    this.onPress,
    this.size,
    this.height,
    this.width,
    this.borderRadius=30,
    this.disabled=false});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onPress,
      child:Container(
        margin: EdgeInsets.fromLTRB(10,20,10,20),
        height: size == FlatUIButtonSize.small ? 35 : (size == FlatUIButtonSize.medium ? 50 : (size== FlatUIButtonSize.large ? 65 :(height == null ? 50 : height))),
        padding: EdgeInsets.symmetric(horizontal: 15),
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
        child: Center(
          child: child != null ? child : Text(text, style: TextStyle()),
        ),
      ),
    );
  }

}