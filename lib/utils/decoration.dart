import 'package:next/utils/import.dart';

class CustomDecoration {
  static InputBorder kInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(textFeildRadius),
    borderSide: const BorderSide(
      color: kPrimaryColor,
      width: 1.0,
    ),
  );
  static InputBorder kErrorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(textFeildRadius),
    borderSide: const BorderSide(
      color: kRedColor,
      width: 1.0,
    ),
  );
}
