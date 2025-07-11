import '../../base/export_view.dart';

/// Usually an app design has 2 main buttons.

/// Main button of the app.
/// Has fill color and white text.
class PrimaryButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const PrimaryButton(this.title, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 44.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: VColor.primary,
        ),
        child: VText(
          title,
          color: VColor.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Secondary button of the app.
/// Has white fill color, has outline and the text color is the same with outline color.
class SecondaryButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const SecondaryButton(this.title, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 44.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: const LinearGradient(
            colors: [
              VColor.primary,
              VColor.accent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: VColor.white,
          ),
          alignment: Alignment.center,
          child: VText(
            title,
            color: VColor.primary,
          ),
        ),
      ),
    );
  }
}
