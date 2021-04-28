import 'package:flat_ui/flat_ui.dart';
import 'package:flat_ui/types/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class FUITextField extends StatelessWidget {
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final String initialValue;
  final List<TextInputFormatter> inputFormatters;
  final bool obsecureText;
  final TextEditingController controller;
  final dynamic onChanged;
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
  final bool allowNextFocus;
  final FUIFieldBorderType borderType;
  final TextInputType keyboardType;
  final double borderRadius;
  final dynamic prefix;
  final Widget suffixIcon;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Function onTap;
  final FocusNode focusNode;
  FUITextField({
      this.autofocus=false,
      this.enabled=true,
      this.readOnly=false,
      this.initialValue,
      this.inputFormatters,
      this.obsecureText=false,
      this.borderType=FUIFieldBorderType.none,
      this.borderRadius=10,
      this.borderColor='#3498db',
      this.errorBorderColor='#e74c3c',
      this.focusedBorderColor='#3498db',
      this.disabledBorderColor='#bdc3c7',
      this.controller,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.backgroundColor,
      this.errorMessage,
      this.label,
      this.suffixText,
      this.hintText,
      this.helperText,
      this.prefix,
      this.suffixIcon,
      this.floatingLabelBehavior,
      this.onTap,
      this.focusNode,
      this.allowNextFocus = false});

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = InputBorder.none;
    BorderSide borderSide = BorderSide(color:HexColor(borderColor));
    BorderSide errorBorderSide = BorderSide(color: HexColor(errorBorderColor));
    BorderSide focusedBorderSide = BorderSide(color: HexColor(focusedBorderColor));
    BorderSide disabledBorderSide = BorderSide(color: HexColor(disabledBorderColor));
    Widget prefixIcon;
    switch (borderType) {
      case FUIFieldBorderType.underline:
        inputBorder = UnderlineInputBorder(
          borderSide: borderSide
        );
        break;
      case FUIFieldBorderType.bordered:
        inputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: borderSide
        );
        break;
      default:
    }
    if(prefix is Widget) {
      prefixIcon = prefix;
    } else if (prefix is String) {
      prefixIcon = SizedBox(child: Center(child: Text(prefix, style: TextStyle(fontSize: 18),),),);
    }
    return TextFormField(
      onTap: onTap,
      autofocus: autofocus,
      enabled: enabled,
      readOnly: readOnly,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      obscureText: obsecureText,
      style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'OpenSans', package: 'flat_ui', fontWeight: FontWeight.w600),
      controller: controller,
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => allowNextFocus ? FocusScope.of(context).nextFocus() : FocusScope.of(context).unfocus() ,
      validator: (value) => value.isEmpty ? errorMessage : null,
      decoration: InputDecoration(
          focusedBorder: inputBorder.copyWith(borderSide: focusedBorderSide),
          border: inputBorder,
          enabledBorder: inputBorder,
          errorBorder: inputBorder.copyWith(borderSide: errorBorderSide),
          disabledBorder: inputBorder.copyWith(borderSide: disabledBorderSide),
          prefixIconConstraints: BoxConstraints(maxWidth: 100, minWidth: 45),
          filled: backgroundColor != null,
          fillColor: backgroundColor != null ? HexColor(backgroundColor) : Colors.transparent,
          contentPadding: EdgeInsets.all(10),
          labelText: label,
          labelStyle: TextStyle(fontFamily: 'OpenSans', package: 'flat_ui', fontWeight: FontWeight.w600),
          prefixIcon: prefixIcon,
          prefixStyle: TextStyle(color: Colors.black),
          suffixIcon: suffixIcon,
          hintText: hintText,
          helperText: helperText,
          helperStyle: TextStyle(fontFamily: 'OpenSans', package: 'flat_ui'),
          floatingLabelBehavior: floatingLabelBehavior
      ),
    );
  }
}
