import 'package:flat_ui/flat_ui.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

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
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black12,
      context: context,
      builder: (ctx ) => BlurDropdownDialog(focusedBorderColor: widget.focusedBorderColor, options: widget.options)); 
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


class BlurDropdownDialog extends StatefulWidget {
  final String focusedBorderColor;

  final List<OptionItem> options;
  const BlurDropdownDialog({ Key key, this.focusedBorderColor = '#3498db', this.options }) : super(key: key);

  @override
  _BlurDropdownDialogState createState() => _BlurDropdownDialogState();
}

class _BlurDropdownDialogState extends State<BlurDropdownDialog> with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  bool disableScroll = false;

  @override
  void initState() {
    super.initState();
    
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if(scrollController.offset == 0) {
        setState(() => disableScroll = true);
        Future.delayed(Duration(seconds: 1), () => setState(() => disableScroll = false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
            child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.white,
                            child: ListView.separated(
                              controller: scrollController,
                              physics: disableScroll ? NeverScrollableScrollPhysics() : ClampingScrollPhysics(),
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
                                  // onPress: () => onSelect(item.value),
                                );
                                // return FlatButton(onPressed:()=>onSelect(item.value), child: Text(item.label,style: TextStyle(fontSize: 18, fontFamily: 'OpenSans'),));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}


// Material(
//           type: MaterialType.transparency,
//           child: Center(
//             child: BackdropFilter(
//                 filter: ui.ImageFilter.blur(
//                   sigmaX: 2,
//                   sigmaY: 2,
//                 ),
//                 child: 
//                 ),
//           ),
//         ));