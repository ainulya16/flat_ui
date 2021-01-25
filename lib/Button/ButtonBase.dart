import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/material.dart';


class FUIButtonBase extends StatelessWidget {
  final Widget child;
  final Function onPress;
  final bool disabled;
  
  FUIButtonBase({
    this.child,
    this.onPress,
    this.disabled=false
  });


  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: disabled ? 0.6 : 1.0,
      child: FUIAnimationBounce(
        useOpacity: true,
        disabled: disabled,
        child: GestureDetector(
          onTap: onPress,
          child: child
        ),
      )
    );
  }

}