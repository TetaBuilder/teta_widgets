// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

class FFontStyle {
  /// Set of funcs to use FontStyle in Teta
  FFontStyle({
    final FontStyle style = FontStyle.normal,
  }) : _style = style;

  FontStyle _style;

  FontStyle get get => _style;

  // ignore: use_setters_to_change_properties
  void set(final FontStyle value) => _style = value;

  FFontStyle fromJson(final String json) {
    if (json == 'n') {
      return FFontStyle();
    } else {
      return FFontStyle(style: FontStyle.italic);
    }
  }

  String toJson() => (_style == FontStyle.normal) ? 'n' : 'i';

  static String _convertValueToJson(final FontStyle? style) =>
      (style == FontStyle.normal) ? 'FontStyle.normal' : 'FontStyle.italic';

  String toCode() => _convertValueToJson(_style);
}
