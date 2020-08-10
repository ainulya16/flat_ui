import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/material.dart';

class OptionItem {
  final String label;
  final dynamic value;
  OptionItem({this.label, this.value});
}
class FUIDropdownList extends StatefulWidget {
  final bool disabled;
  final List<OptionItem> options;
  final String initialValue;
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

  FUIDropdownList({
    this.disabled,
    this.onChanged,
    @required this.options,
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
  _FUIDropdownListState createState() => _FUIDropdownListState();
}

class _FUIDropdownListState extends State<FUIDropdownList>{
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
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [boxShadow]
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (buildCtx, index) {
                  var item = widget.options[index];
                  return FlatButton(onPressed:()=>onSelect(item.value), child: Text(item.label,style: TextStyle(fontSize: 18, fontFamily: 'OpenSans'),));
                },
              ),
            )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        onTap: !isOpened ? openMenu : closeMenu,
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
              initialValue: widget.initialValue,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              helperText: widget.helperText,
              enabled: false,
            ),
    );
  }
  
}