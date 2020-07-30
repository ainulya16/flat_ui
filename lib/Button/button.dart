import 'package:flat_ui/bounce/bounce.dart';
import 'package:flutter/material.dart';

enum FlatUIButtonSize {
  small,  // height 35
  medium, // height 50
  large   // height 65
}
class FlatUIButton extends StatelessWidget {
  final Widget child;
  final String text;
  final Color color;
  final Function onPress;
  final FlatUIButtonSize size;
  final double width, height, borderRadius;
  final bool disabled, shadow;
  
  FlatUIButton({
    key: Key,
    this.child,
    @required this.text,
    this.color,
    this.shadow,
    this.onPress,
    this.size,
    this.height,
    this.width,
    this.borderRadius,
    this.disabled}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: disabled ? null : onPress,
      key: key,
      child: Container(
        height: size == FlatUIButtonSize.small ? 35 : (size == FlatUIButtonSize.medium ? 50 : (size== FlatUIButtonSize.large ? 65 :(height == null ? 50 : height))),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: shadow ? [
            BoxShadow(
                color: Color(0x80000000),
                blurRadius: 30.0,
                offset: Offset(0.0, 5.0),
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