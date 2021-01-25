import 'package:flat_ui/flat_ui.dart';
import 'package:flat_ui/types/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FUISearchField extends StatefulWidget {
  final bool autofocus, enabled, readOnly, clearable;
  final String initialValue;
  final List<TextInputFormatter> inputFormatters;
  final Function onChanged;
  final String backgroundColor, label;
  final String borderColor;
  final String errorBorderColor;
  final String focusedBorderColor;
  final String disabledBorderColor;
  final FUIFieldBorderType borderType;
  final TextInputType keyboardType;
  final double borderRadius;
  final dynamic prefix;
  final Function onTap;
  FUISearchField({
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.clearable = true,
    this.initialValue,
    this.inputFormatters,
    this.label,
    this.borderType = FUIFieldBorderType.none,
    this.borderRadius = 10,
    this.borderColor = '#3498db',
    this.errorBorderColor = '#e74c3c',
    this.focusedBorderColor = '#3498db',
    this.disabledBorderColor = '#bdc3c7',
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.backgroundColor,
    this.prefix,
    this.onTap,
  });

  @override
  _FUISearchFieldState createState() => _FUISearchFieldState();
}

class _FUISearchFieldState extends State<FUISearchField>{
  TextEditingController controller = TextEditingController();
  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener((){
      print(_focusNode.hasFocus.toString());
    });
  }

  onClear() {
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FUITextField(
      label: widget.label,
      allowNextFocus: false,
      borderType: FUIFieldBorderType.bordered,
      prefix: widget.prefix,
      borderRadius: widget.borderRadius,
      borderColor: widget.borderColor,
      focusedBorderColor: widget.focusedBorderColor,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      onChanged: widget.onChanged,
      controller: controller,
      keyboardType: widget.keyboardType,
      suffixIcon: widget.clearable && controller.text.isNotEmpty ? FUIButtonBase(
        onPress: onClear,
        child: Icon(Icons.close, color: Colors.black,),
      ) : null,
      onTap: widget.onTap,
      focusNode: _focusNode,
      initialValue: widget.initialValue,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
    );
  }
}
