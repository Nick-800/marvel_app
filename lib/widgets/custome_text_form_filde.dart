import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/constants.dart';

class CustomeTextFormFiled extends StatefulWidget {
  const CustomeTextFormFiled(
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
  State<CustomeTextFormFiled> createState() => _CustomeTextFormFiledState();
}

class _CustomeTextFormFiledState extends State<CustomeTextFormFiled> {
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
