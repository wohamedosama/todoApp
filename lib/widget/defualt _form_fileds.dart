import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextFormFields extends StatelessWidget {
  const DefaultTextFormFields({
    Key? key,
    @required this.onTap,
    required this.textEditingController,
    required this.type,
    required this.prefix,
    required this.label,
    this.isClickable = true,
  });

  final TextEditingController textEditingController;
  final TextInputType type;
  final Icon prefix;
  final String label;
  final void Function()? onTap;
  final bool? isClickable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: textEditingController,
      keyboardType: type,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required';
        } else {
          return null;
        }
      },
      enabled: isClickable!,
      decoration: InputDecoration(
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
          prefixIcon: prefix,
          label: Text(label),
          border: buildBorder()),
    );
  }
}

OutlineInputBorder buildBorder({Color? color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(color: color ?? Colors.black),
  );
}
