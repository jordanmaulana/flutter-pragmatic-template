import 'package:google_fonts/google_fonts.dart';
import '../../base/export_view.dart';
export '../../extensions/my_string_extension.dart';

/// Standardize text style.
/// Also handles null string & number / money format.
class VText extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? align;
  final bool money;
  final bool number;
  final TextDecoration? decoration;
  final int? maxLines;
  final double? height;
  final Color? color;
  final FontStyle? fontStyle;

  const VText(
    this.title, {
    this.fontSize,
    this.fontWeight,
    this.overflow = TextOverflow.fade,
    this.money = false,
    this.number = false,
    this.decoration,
    this.maxLines,
    this.align,
    this.color, // = VColor.dark,
    this.fontStyle,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String text = title ?? '';
    if (number) text = title.withNumberSeparator;
    if (money) text = 'Rp. ${title.withNumberSeparator}';
    return Material(
      color: Colors.transparent,
      child: Text(
        text,
        style: GoogleFonts.interTight(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: decoration,
          fontStyle: fontStyle,
          height: height,
        ),
        overflow: overflow,
        textAlign: align,
        maxLines: maxLines,
      ),
    );
  }
}
