import 'package:flat_ui/ProgressBar/LinearProgressBar.dart';
import 'package:flat_ui/Stepper/StepperController.dart';
import 'package:flat_ui/Stepper/StepperItem.type.dart';
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

  FUIStepper({
    key: Key,
    this.onPageChanged,
    this.onFinished,
    this.inActiveColor = Colors.white,
    this.activeColor = Colors.blue,
    this.inActiveNumberColor = Colors.black,
    this.activeNumberColor = Colors.white,
    this.activeTitleColor = Colors.black,
    this.headerColor = Colors.white,
    this.controller,
    @required this.pages
  });
  
  @override
  _FUIStepperState createState() => _FUIStepperState();
}

class _FUIStepperState extends State<FUIStepper>{
  int totalPage;
  int currentPage = 1;
  
  
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
    if(mounted)
      super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget number(int value, bool active) {
    return Container(
        height: 25,
        width: 25,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black38,
                  blurRadius: 2.0,
                  offset: Offset(0.0, 2.0,),
                  spreadRadius: -1
          )],
          borderRadius: BorderRadius.all(
            Radius.circular(200),
          ),
          color: active ? widget.activeColor : widget.inActiveColor,
        ),
        child: Center(
          child: Text('$value',
            style: TextStyle(
              fontSize: 17,
              color: active ? widget.activeNumberColor : widget.inActiveNumberColor
            )
          )
        ),
    );
  }

  List<Widget> renderTitle() {
    return widget.pages.map((page) {
      var index = widget.pages.indexOf(page);
      if (index < (currentPage - 1)) {
        return number(index + 1, true);
      }
      if (index == (currentPage - 1)) {
        return Expanded(
          child: Row(
            children: [
              number(index + 1, true),
              Container(child: Text('${page.title}', style: TextStyle(color: widget.activeTitleColor, fontSize: 17),))
            ]
          ),
        );
      }
      return number(index + 1, false);
    }).toList();
  }
  


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: widget.headerColor,
          child: Row(
            children: renderTitle(),
          ),
        ),
        FUILinearProgressBar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.grey,
          value: currentPage / totalPage,
        ),
        Expanded(child: widget.pages[currentPage - 1].page),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  currentPage == 1
                      ? Container()
                      : FlatButton(
                    child: Text("Previous"),
                    onPressed: () {
                      setState(() {
                        currentPage = currentPage - 1;
                      });
                    },
                  ),
                  currentPage == totalPage
                      ? FlatButton(
                    child: Text("Submit"),
                    onPressed: widget.onFinished,
                  )
                      : FlatButton(
                    child: Text("Next"),
                    onPressed: () {
                      setState(() {
                        currentPage = currentPage + 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
  
}