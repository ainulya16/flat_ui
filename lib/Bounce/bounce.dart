import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  final Widget child;
  final Function onTap;
  
  Bounce({ @required this.child, this.onTap});
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
      onTap: widget.onTap,
      onTapCancel: () => _controller.reverse(),
      onTapDown: (TapDownDetails detail) => _controller.forward(),
      onTapUp: (TapUpDetails detail) => _controller.reverse(),
      child: Transform.scale(scale: _scale, child: widget.child,)
    );
  }
}