import 'package:flat_ui/flat_ui.dart';
import 'package:flutter/material.dart';

class FUIDropdownList extends StatefulWidget {
  final bool disabled;
  final Function onChange;

  FUIDropdownList({this.disabled, this.onChange});
  
  @override
  _FUIDropdownListState createState() => _FUIDropdownListState();
}

class _FUIDropdownListState extends State<FUIDropdownList>{
  bool isOpened = false;
  OverlayEntry _overlayEntry;
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

  _overlayEntryBuilder() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (ctx) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 0.5,
        width: size.width,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [boxShadow]
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (buildCtx, index) {
              return FlatButton(onPressed:closeMenu,child: Text('test'));
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
        onTap: !isOpened ? openMenu : closeMenu,
              child: FUITextField(
              label: 'Email',
              allowNextFocus: false,
              borderType: FUIFieldBorderType.bordered,
              prefix: Icon(Icons.mail_outline, color: HexColor('#2980b9'),),
              hintText: 'john@doe.com',
              borderRadius: 4,
              borderColor: '#bdc3c7',
              focusedBorderColor: '2980b9',
              enabled: false,
            ),
    );
  }
  
}