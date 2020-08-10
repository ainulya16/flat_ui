import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class FUIDateTimePicker extends StatefulWidget {
  final String dateFormat;
  final bool disabled;
  final DateTime initialValue;
  final Function onChanged;
  final String errorMessage;
  final String label;
  final String hintText;
  final String suffixText;
  final String helperText;
  final String backgroundColor;
  final String borderColor;
  final String errorBorderColor;
  final String focusedBorderColor;
  final String disabledBorderColor;
  final FUIFieldBorderType borderType;
  final double borderRadius;
  final dynamic prefix;
  final Widget suffixIcon;
  final FloatingLabelBehavior floatingLabelBehavior;

  FUIDateTimePicker({
    this.dateFormat='dd MMM yyyy',
    this.disabled=false,
    this.onChanged,
    this.floatingLabelBehavior,
    this.suffixIcon,
    this.prefix,
    this.backgroundColor,
    this.helperText,
    this.suffixText,
    this.hintText,
    this.label,
    this.errorMessage,
    this.initialValue,
    this.borderType=FUIFieldBorderType.none,
    this.borderRadius=10,
    this.borderColor='#3498db',
    this.errorBorderColor='#e74c3c',
    this.focusedBorderColor='#3498db',
    this.disabledBorderColor='#bdc3c7',
  });
  
  @override
  _FUIDateTimePickerState createState() => _FUIDateTimePickerState();
}

class _FUIDateTimePickerState extends State<FUIDateTimePicker>{
  bool isOpened = false;
  OverlayEntry _overlayEntry;
  TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
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
  }
  

  openMenu() {
    setState(() {
      _overlayEntry = _overlayEntryBuilder();
      isOpened = !isOpened;
    });
    Overlay.of(context).insert(_overlayEntry);
  }

  closeMenu() {
    _overlayEntry.remove();
    setState(() {
      isOpened = !isOpened;
    });
  }

  onSelect(value) {
    closeMenu();
    _controller.text = value.toString();
    widget.onChanged(value);
  }

  _overlayEntryBuilder() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (ctx) => Positioned(
            left: offset.dx,
            top: offset.dy + size.height,
            width: size.width,
            child: Container(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDateTime) {
                  widget.onChanged != null && widget.onChanged(newDateTime);
                  _controller.text = DateFormat(widget.dateFormat).format(newDateTime);
                },
                backgroundColor: Colors.white,
                use24hFormat: false,
                minuteInterval: 1,
              ),
            ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        onTap: (!widget.disabled && !isOpened) ? openMenu : closeMenu,
            child: FUITextField(
              label: widget.label,
              allowNextFocus: false,
              borderType: widget.borderType,
              prefix: widget.prefix,
              hintText: widget.hintText,
              borderRadius: widget.borderRadius,
              borderColor: widget.borderColor,
              focusedBorderColor: widget.focusedBorderColor,
              errorBorderColor: widget.errorBorderColor,
              disabledBorderColor: widget.disabledBorderColor,
              suffixIcon: widget.suffixIcon,
              suffixText: widget.suffixText,
              controller: _controller,
              initialValue: widget.initialValue != null ? DateFormat(widget.dateFormat).format(widget.initialValue) : null,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              helperText: widget.helperText,
              enabled: false,
            ),
    );
  }
  
}