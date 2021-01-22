import 'package:flutter/material.dart';

class BuildDropdown extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String defaultValue, selectedValue, dropdownHint;
  final List<String> itemsList;

  BuildDropdown(
      {Key key,
      this.itemsList,
      this.selectedValue,
      this.defaultValue,
      this.dropdownHint,
      this.onChanged})
      : super(key: key);

  @override
  _BuildDropdownState createState() => _BuildDropdownState();
}

class _BuildDropdownState extends State<BuildDropdown> {
  String _value;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: Colors.white,
      child: DropdownButton<String>(
        items: widget.itemsList
            .map((String value) =>
                DropdownMenuItem<String>(child: Text(value), value: value))
            .toList(),
        value: _value == null ? widget.defaultValue : _value,
        isExpanded: true,
        onChanged: (String value) {
          setState(() {
            _value = value;
          });
          widget.onChanged(value);
        },
        hint: Text(widget.dropdownHint),
        style: TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
        iconEnabledColor: Colors.red,
        iconSize: 14,
        underline: Container(),
      ),
    );
  }
}
