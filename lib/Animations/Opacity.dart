import 'package:flutter/material.dart';

class FUIAnimationOpacity extends StatefulWidget {
  final Widget child;
  final bool disabled;
  
  FUIAnimationOpacity({ @required this.child, this.disabled=false});
  @override
  _FUIAnimationOpacityState createState() => _FUIAnimationOpacityState();
}

class _FUIAnimationOpacityState extends State<FUIAnimationOpacity> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() { 
      setState(() {});
    });
    super.initState();
  }

  @override
  void setState(fn) {
    if(mounted)
      super.setState(fn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapCancel: () => !widget.disabled ? _controller.reverse() : null,
      onTapDown: (TapDownDetails detail) =>!widget.disabled ? _controller.forward() : null,
      onTapUp: (TapUpDetails detail) => !widget.disabled ? _controller.reverse() : null,
      child:  AnimatedOpacity(
          opacity: _scale,
          duration: Duration(milliseconds: 200),
          child: widget.child
      )
    );
  }
}