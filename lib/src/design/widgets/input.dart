import 'package:app/src/design/theme/theme_data.dart';
import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  final String? hint;
  final String? label;
  final TextEditingController? controller;

  const Field(this.controller, {Key? key, this.hint, this.label})
      : super(key: key);

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
      child: TextField(
        controller: controller,
        style: TextStyle(
            fontSize: 20, color: Colored.primary, fontFamily: 'Century'),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            hintText: widget.hint != null ? widget.hint : '',
            hintStyle: TextStyle(color: Colored.primary),
            labelText: widget.label != null ? widget.label : '',
            labelStyle: TextStyle(color: Colored.primary),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            )),
      ),
    );
  }
}
