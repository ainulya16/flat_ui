import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final bool useOpacity, disabled;
  
  Bounce({ @required this.child, this.onTap, this.useOpacity=false, this.disabled=false});
  @override
  _BounceState createState() => _BounceState();
}

class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
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
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTap: !widget.disabled ? widget.onTap : null,
      onTapCancel: () => !widget.disabled ? _controller.reverse() : null,
      onTapDown: (TapDownDetails detail) =>!widget.disabled ? _controller.forward() : null,
      onTapUp: (TapUpDetails detail) => !widget.disabled ? _controller.reverse() : null,
      child:  Transform.scale(
        scale: _scale,
        child: widget.useOpacity ? AnimatedOpacity(
          opacity: _controller.isAnimating || _controller.isCompleted ? 0.6 : 1.0,
          duration: Duration(milliseconds: 200),
          child: widget.child
        ) : widget.child
      )
    );
  }
}