import 'package:flutter/material.dart';

class FUIStepperTitle extends StatefulWidget {
  final double width;
  final bool expanded;
  final String title;
  final Color activeTitleColor;

  FUIStepperTitle(
      {key: Key,
      @required this.width,
      @required this.expanded,
      this.title,
      this.activeTitleColor
      });

  @override
  _FUIStepperTitleState createState() => _FUIStepperTitleState();
}

class _FUIStepperTitleState extends State<FUIStepperTitle> with TickerProviderStateMixin {
  AnimationController _titleAnimationController;
  Animation _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _titleAnimationController = AnimationController(duration: new Duration(milliseconds: 400), vsync: this);
    _sizeAnimation = Tween(begin: 0.0, end: widget.width).animate(CurvedAnimation(curve: Curves.linear, parent: _titleAnimationController));
    toggle();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  toggle() {
    this.widget.expanded ? this._titleAnimationController.forward() : this._titleAnimationController.reverse();
  }

  @override
  void didUpdateWidget(FUIStepperTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded != this.widget.expanded) {
      this.toggle();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleAnimationController?.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _titleAnimationController,
      builder: (context, index) {
        return Container(
          width: _sizeAnimation.value,
          child: Text(
            '${widget.title}',
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyle(color: widget.activeTitleColor, fontSize: 17, ),
          ),
        );
      },
    );
  }
}
