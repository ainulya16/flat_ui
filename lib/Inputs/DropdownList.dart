import 'package:flat_ui/flat_ui.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class OptionItem {
  final String label;
  final dynamic value;
  OptionItem({this.label, this.value});
}

class FUIDropdownList extends StatefulWidget {
  final bool disabled, searchable;
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
    this.disabled = false,
    this.searchable = false,
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
    this.borderType = FUIFieldBorderType.none,
    this.borderRadius = 10,
    this.borderColor = '#3498db',
    this.errorBorderColor = '#e74c3c',
    this.focusedBorderColor = '#3498db',
    this.disabledBorderColor = '#bdc3c7',
  });

  @override
  _FUIDropdownListState createState() => _FUIDropdownListState();
}

class _FUIDropdownListState extends State<FUIDropdownList> {
  TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  openMenu() {
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: true,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 2,
                  sigmaY: 2,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: Colors.white,
                            boxShadow: [boxShadow]),
                        child: FUITextField(
                          label: 'Search',
                          allowNextFocus: false,
                          borderType: FUIFieldBorderType.bordered,
                          prefix: Icon(
                            Icons.search,
                            color: HexColor('#2980b9'),
                          ),
                          borderRadius: 4,
                          borderColor: '#bdc3c7',
                          focusedBorderColor: '2980b9',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                      Container(height: 30),
                      Container(
                        height: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: Colors.white,
                            boxShadow: [boxShadow]),
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          shrinkWrap: true,
                          itemCount: widget.options.length,
                          separatorBuilder: (ctx, i) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              height: 1,
                            ),
                          ),
                          itemBuilder: (buildCtx, index) {
                            var item = widget.options[index];
                            return FUIButton(
                              size: ButtonSize.full,
                              buttonFullHeight: 50,
                              text: item.label,
                              textColor: '#000000',
                              borderRadius: 0,
                              textStyle: TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                              onPress: () => onSelect(item.value),
                            );
                            // return FlatButton(onPressed:()=>onSelect(item.value), child: Text(item.label,style: TextStyle(fontSize: 18, fontFamily: 'OpenSans'),));
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }

  closeMenu() {
    Navigator.pop(context);
  }

  onSelect(value) {
    closeMenu();
    _controller.text = value.toString();
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      onTap: openMenu,
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
