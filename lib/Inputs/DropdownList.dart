import 'package:flat_ui/Styles/TextStyle.dart';
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
        builder: (ctx) => BlurDropdownDialog(
            onSelect: onSelect,
            focusedBorderColor: widget.focusedBorderColor,
            options: widget.options));
  }

  onSelect(OptionItem item) {
    _controller.text = item.label.toString();
    if(widget.onChanged != null) widget.onChanged(item.value);
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
  final Function onSelect;
  const BlurDropdownDialog(
      {Key key, this.focusedBorderColor = '#3498db', this.options, this.onSelect})
      : super(key: key);

  @override
  _BlurDropdownDialogState createState() => _BlurDropdownDialogState();
}

class _BlurDropdownDialogState extends State<BlurDropdownDialog>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  bool disableScroll = false;

  @override
  void initState() {
    super.initState();

    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset == 0) {
        setState(() => disableScroll = true);
        Future.delayed(
            Duration(seconds: 1), () => setState(() => disableScroll = false));
      }
    });
  }

  void onSelect(OptionItem value) {
    if(value != null && widget.onSelect != null) widget.onSelect(value); 
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7), topRight: Radius.circular(7)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: TinyColor.fromString("#c4c4c4").color),
                          height: 4,
                          width: 30),
                    ),
                  ),
                  Flexible(
                    child: ListView.separated(
                      controller: scrollController,
                      physics: disableScroll
                          ? NeverScrollableScrollPhysics()
                          : ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 0),
                      shrinkWrap: true,
                      itemCount: widget.options.length,
                      separatorBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 0),
                        child: Container(
                          height: 1,
                          color: TinyColor.fromString("#c4c4c4").color,
                        ),
                      ),
                      itemBuilder: (buildCtx, index) {
                        var item = widget.options[index];
                        return InkWell(
                          onTap: () => onSelect(item),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 16),
                            child: Text(item.label, style: defaultTextStyle),
                          ),
                        );
                      },
                    ),
                  ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
