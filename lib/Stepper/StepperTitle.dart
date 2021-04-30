import 'package:flutter/material.dart';

class FUIStepperTitle extends StatefulWidget {
  final int numberOfPages;
  final bool  active, finished;
  final String title, number;
  final Color activeTitleColor, 
  activeTextColor, 
  inActiveTextColor, 
  activeBgColor, 
  inActiveBgColor;
  final double width;

  FUIStepperTitle(
      {key: Key,
      @required this.width,
      this.title,
      this.numberOfPages,
      this.activeTitleColor,
      this.active,
      this.number,
      this.finished,
      this.activeTextColor,
      this.inActiveTextColor,
      this.activeBgColor,
      this.inActiveBgColor
      });

  @override
  _FUIStepperTitleState createState() => _FUIStepperTitleState();
}

class _FUIStepperTitleState extends State<FUIStepperTitle> with TickerProviderStateMixin {
  AnimationController _titleAnimationController;
  Animation _sizeAnimation, _textSizeAnimation;

  @override
  void initState() {
    super.initState();
    _titleAnimationController = AnimationController(duration: new Duration(milliseconds: 400), vsync: this);
    _sizeAnimation = Tween(begin: 0.0, end: widget.width - (widget.numberOfPages * 40)).animate(CurvedAnimation(curve: Curves.linear, parent: _titleAnimationController));
    _textSizeAnimation = Tween(begin: 0.0, end: 18.0).animate(CurvedAnimation(curve: Curves.linear, parent: _titleAnimationController));
    toggle();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  toggle() {
    this.widget.active ? this._titleAnimationController.forward() : this._titleAnimationController.reverse();
  }

  @override
  void didUpdateWidget(FUIStepperTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != this.widget.active) {
      this.toggle();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleAnimationController?.dispose();
  }


  Widget number() {
    Widget icon = Icon(Icons.check, size: 17, color: Colors.white);

    Color textColor = widget.finished || widget.active ? widget.activeTextColor : widget.inActiveTextColor;
    Color bgColor = widget.finished || widget.active ? widget.activeBgColor : widget.inActiveBgColor;
    
    Widget text = Text('${widget.number}',
        style: TextStyle(
            fontSize: 17,
            height: 1,
            fontFamily: 'OpenSans',
            color: textColor));
    return Container(
      width: 40,
          child: Center(
            child: Container(
        height: 25,
        width: 25,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2.0,
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                  spreadRadius: -1)
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(200),
            ),
            color: bgColor
        ),
        child: Center(child: widget.finished ? icon : text),
      ),
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        number(),
        AnimatedBuilder(
          animation: _titleAnimationController,
          builder: (context, index) {
            return Container(
              width: _sizeAnimation.value,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(
                  '${widget.title}',
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: widget.activeTitleColor, fontSize: _textSizeAnimation.value, fontWeight: FontWeight.w500),
                )],
              ),
            );
          },
        )
      ],),
    );
  }
}
