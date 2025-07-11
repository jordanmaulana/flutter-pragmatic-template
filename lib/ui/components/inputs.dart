import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/colors.dart';
import 'texts.dart';

/// Used for custom textformfield.
class VFormInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final double radius;
  final bool obscure;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final TextEditingController? controller;
  final bool enabled;
  final void Function(String?)? onChanged;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Color? borderColor;
  final void Function(String?)? onSubmit;
  final void Function()? onTap;
  final bool autoFocus;
  final Iterable<String>? autoFill;
  final int? maxLength;
  final bool? dense;
  final String? initialValue;

  const VFormInput({
    this.label,
    this.hint,
    this.radius = 8.0,
    this.obscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.fillColor = VColor.fieldFillColor,
    this.controller,
    this.enabled = true,
    this.onChanged,
    this.maxLines,
    this.keyboardType,
    this.borderColor = VColor.fieldFillColor,
    this.onSubmit,
    this.onTap,
    this.textCapitalization = TextCapitalization.sentences,
    this.autoFocus = false,
    this.maxLength,
    this.autoFill,
    this.dense,
    this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autoFill,
      maxLength: maxLength,
      autofocus: autoFocus,
      onTap: onTap,
      // style: TextStyle(),
      enabled: enabled,
      controller: controller,
      obscureText: obscure,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      maxLines: obscure ? 1 : maxLines,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onSubmit,
      initialValue: initialValue,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: VText(label),
        isDense: dense,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        fillColor: fillColor,
        filled: fillColor != null,
        hintStyle: GoogleFonts.interTight(),
        focusedBorder: _border(color: VColor.primary, radius: radius),
        enabledBorder:
            _border(color: borderColor ?? VColor.border, radius: radius),
        errorBorder: _border(color: Colors.red, radius: radius),
        disabledBorder: _border(color: VColor.border, radius: radius),
        focusedErrorBorder: _border(color: VColor.primary, radius: radius),
        // counterStyle: GoogleFonts.inter(
        //   color: VColor.hint,
        //   fontSize: 14.0,
        // ),
      ),
    );
  }

  OutlineInputBorder _border({required Color color, required double radius}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}
