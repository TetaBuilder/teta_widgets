import 'package:enum_to_string/enum_to_string.dart';

enum TType {
  header_w_title_cta,
  sec_l_image_r_title_description,
  sec_three_cols,
  sec_two_cols_l_image_r_title_description,
  sec_two_cols,
}

extension TemplateType on TType {
  ///Get template's type from TType enum value
  static String type(final TType type) => EnumToString.convertToString(type);

  ///Get template's display name from TType enum value
  static String name(final TType type) =>
      EnumToString.convertToString(type, camelCase: true);

  ///Get TType enum value from string
  static TType fromString(final String x) =>
      EnumToString.fromString(TType.values, x) ?? TType.nil;

  static TType fromStringCamelCase(final String x) =>
      EnumToString.fromString(TType.values, x, camelCase: true) ?? TType.nil;
}