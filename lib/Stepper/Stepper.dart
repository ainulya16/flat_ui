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
  final Color activeBgColor;
  final Color inActiveBgColor;
  
  final Color activeTextColor;
  final Color inActiveTextColor;

  final Color activeTitleColor;
  final Color headerColor;
  final FUIStepperController controller;
  final Widget header;

  FUIStepper(
      {key: Key,
      this.onPageChanged,
      this.onFinished,
      this.activeBgColor = Colors.blue,
      this.inActiveBgColor = Colors.white,
      this.inActiveTextColor = Colors.black,
      this.activeTextColor = Colors.white,
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

  @override
  void initState() {
    super.initState();
    totalPage = widget.pages.length;
    FUIStepperController _controller = widget.controller;
    if (_controller != null) {
      _controller.next = next;
      _controller.prev = prev;
      _controller.setPage = setPage;
    }
  }

  next() {
    if(currentPage == widget.pages.length) {
      widget.onFinished != null && widget.onFinished();
      return;
    }
    setState(() {
      currentPage = currentPage + 1;
    });
    widget.onPageChanged != null && widget.onPageChanged(currentPage);
    if (currentPage == totalPage) {
      widget.onFinished != null && widget.onFinished();
    }
  }

  prev() {
    if(currentPage == 1) {
      return;
    }
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

  List<Widget> renderTitle() {
    return widget.pages.map((page) {
      var index = widget.pages.indexOf(page);
      var active = index == (currentPage - 1);
      var finished = index < (currentPage - 1);
      var baseWidth = MediaQuery.of(context).size.width - 20;
      return FUIStepperTitle(
        width: baseWidth,
              numberOfPages: widget.pages.length,
              finished: finished,
              active: active,
              title: page.title,
              activeTitleColor: widget.activeTitleColor,
              number: (index + 1).toString(),
              activeBgColor: widget.activeBgColor,
              inActiveBgColor: widget.inActiveBgColor,
              activeTextColor: widget.activeTextColor,
              inActiveTextColor: widget.inActiveTextColor,
            );
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
