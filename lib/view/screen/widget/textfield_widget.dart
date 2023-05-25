import 'package:next/utils/decoration.dart';
import 'package:next/utils/import.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.obscureText,
    this.onSuffixIxonTap,
    this.contentPadding,
    this.minLines,
    this.maxLines,
    this.errorText,
    this.textInputAction,
    this.enabled,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final VoidCallback? onSuffixIxonTap;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines ?? 1,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      cursorColor: kPrimaryColor,
      onEditingComplete: onEditingComplete,
      validator: validator,
      obscureText: obscureText != null ? obscureText! : false,
      decoration: InputDecoration(
        hintText: label,
        errorMaxLines: 2,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.normal,
        ),
        errorStyle: const TextStyle(
          color: kRedColor,
          fontWeight: FontWeight.normal,
        ),
        prefixIcon: prefixIcon == null
            ? null
            : Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.only(left: 6),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(textFeildRadius),
                    bottomLeft: Radius.circular(textFeildRadius),
                  ),
                ),
                child: Icon(
                  prefixIcon,
                  size: 20,
                  color: kWhiteColor,
                ),
              ),
        suffixIcon: suffixIcon == null
            ? null
            : GestureDetector(
                onTap: onSuffixIxonTap,
                child: Container(
                  color: Colors.transparent,
                  child: Icon(
                    suffixIcon,
                    size: 20,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ),
        contentPadding: contentPadding ?? EdgeInsets.zero,
        border: CustomDecoration.kInputBorder,
        enabledBorder: CustomDecoration.kInputBorder,
        focusedBorder: CustomDecoration.kInputBorder,
        errorBorder: CustomDecoration.kErrorInputBorder,
        disabledBorder: CustomDecoration.kInputBorder,
        focusedErrorBorder: CustomDecoration.kInputBorder,
      ),
    );
  }
}
