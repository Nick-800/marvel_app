import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      this.hint,
      required this.textEditingController,
      required this.validate,
      this.isEn = true});
  final String? label;
  final String? hint;
  final TextEditingController textEditingController;
  final FormFieldValidator<String?> validate;
  final bool isEn;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        value = widget.textEditingController.text;
      },
      controller: widget.textEditingController,
      validator: widget.validate,
      enabled: widget.isEn,
      decoration: InputDecoration(
        hintText: widget.hint,
        label: widget.label == null ? null : Text(widget.label!),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusColor: mainColor,
      ),
    );
  }
}
