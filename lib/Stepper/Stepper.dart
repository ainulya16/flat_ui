import 'package:flat_ui/ProgressBar/LinearProgressBar.dart';
import 'package:flat_ui/Stepper/StepperController.dart';
import 'package:flat_ui/Stepper/StepperItem.type.dart';
import 'package:flat_ui/Stepper/StepperTitle.dart';
import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FUIStepper extends StatefulWidget {
  final Function onPageChanged;
  final Function onFinished;
  final List<StepperItem> pages;
  final Color inActiveColor;
  final Color activeColor;
  final Color activeTitleColor;
  final Color inActiveNumberColor;
  final Color activeNumberColor;
  final Color headerColor;
  final StepperController controller;
  final Widget header;

  FUIStepper(
      {key: Key,
      this.onPageChanged,
      this.onFinished,
      this.inActiveColor = Colors.white,
      this.activeColor = Colors.blue,
      this.inActiveNumberColor = Colors.black,
      this.activeNumberColor = Colors.white,
      this.activeTitleColor = Colors.black,
      this.headerColor = Colors.white,
      this.controller,
      this.header,
      @required this.pages});

  @override
  _FUIStepperState createState() => _FUIStepperState();
}

class _FUIStepperState extends State<FUIStepper> with TickerProviderStateMixin {
  int totalPage;
  int currentPage = 1;
  AnimationController _titleAnimationController;

  @override
  void initState() {
    super.initState();
    totalPage = widget.pages.length;
    StepperController _controller = widget.controller;
    if (_controller != null) {
      _controller.next = next;
      _controller.prev = prev;
      _controller.setPage = setPage;
    }
  }

  next() {
    setState(() {
      currentPage = currentPage + 1;
    });
    widget.onPageChanged != null && widget.onPageChanged(currentPage);
    if (currentPage == totalPage) {
      widget.onFinished != null && widget.onFinished();
    }
  }

  prev() {
    setState(() {
      currentPage = currentPage - 1;
    });
    widget.onPageChanged != null && widget.onPageChanged(currentPage);
  }

  setPage(int value) {
    setState(() {
      currentPage = value;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget number(int value, bool active) {
    Widget icon = Icon(Icons.check, size: 17, color: Colors.white);
    Widget text = Text('$value',
        style: TextStyle(
            fontSize: 17,
            color: active
                ? widget.activeNumberColor
                : widget.inActiveNumberColor));
    bool finished = value < currentPage;
    return Container(
      height: 25,
      width: 25,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
        color: active ? widget.activeColor : widget.inActiveColor,
      ),
      child: Center(child: finished ? icon : text),
    );
  }

  List<Widget> renderTitle() {
    return widget.pages.map((page) {
      var index = widget.pages.indexOf(page);
      final x = 40 * widget.pages.length;
      var width = MediaQuery.of(context).size.width - x;
      var active = index == (currentPage -1);
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            number(index + 1, index <= currentPage - 1),
            FUIStepperTitle(
              expanded: active,
              width: width,
              title: page.title,
              activeTitleColor: widget.activeTitleColor,
            ),
          ]);
    }).toList();
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: widget.headerColor,
      child: Row(
        children: renderTitle(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.header != null ? widget.header : header(),
        FUILinearProgressBar(
          useGradient: true,
          strokeWidth: 4,
          foregroundColor: Colors.blue,
          backgroundColor: Colors.grey.shade400,
          value: currentPage / totalPage,
        ),
        Expanded(child: widget.pages[currentPage - 1].page),
      ],
    );
  }
}
