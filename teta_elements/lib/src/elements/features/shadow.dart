// Project imports:
// ignore_for_file: public_member_api_docs

import 'package:teta_elements/src/elements/features/fill.dart';
import 'package:teta_elements/src/elements/features/sizes.dart';
import 'package:teta_elements/src/elements/features/text_type_input.dart';

class FShadow {
  /// Set of funcs to use Shadow property in Teta
  FShadow({
    FTextTypeInput? x,
    FTextTypeInput? y,
    FTextTypeInput? spread,
    FTextTypeInput? blur,
    FFill? fill,
    FSize? opacity,
  })  : _x = x,
        _y = y,
        _spread = spread,
        _blur = blur,
        _fill = fill,
        _opacity = opacity;

  final FTextTypeInput? _x, _y;
  final FTextTypeInput? _spread, _blur;
  final FFill? _fill;
  final FSize? _opacity;

  FShadow ready() => FShadow(
        x: FTextTypeInput(value: '0'),
        y: FTextTypeInput(value: '0'),
        spread: FTextTypeInput(value: '0'),
        blur: FTextTypeInput(value: '16'),
        fill: FFill(
          levels: [
            FFillElement(
              color: '000000',
              stop: 0,
            )
          ],
        ),
        opacity: FSize(size: '0'),
      );

  static FShadow fromJson(Map<String, dynamic> json) {
    try {
      return FShadow(
        x: FTextTypeInput.fromJson(json['x'] as Map<String, dynamic>?),
        y: FTextTypeInput.fromJson(json['y'] as Map<String, dynamic>?),
        spread: FTextTypeInput.fromJson(json['s'] as Map<String, dynamic>?),
        blur: FTextTypeInput.fromJson(json['b'] as Map<String, dynamic>?),
        fill: FFill().fromJson(json['f'] as Map<String, dynamic>),
        opacity: FSize.fromJson(json['o'] as Map<String, dynamic>),
      );
    } catch (e) {
      return FShadow();
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'x': _x != null ? _x!.toJson() : FSize().toJson(),
        'y': _y != null ? _y!.toJson() : FSize().toJson(),
        's': _spread != null ? _spread!.toJson() : FSize().toJson(),
        'b': _blur != null ? _blur!.toJson() : FSize().toJson(),
        'f': _fill != null ? _fill!.toJson() : FFill().toJson(),
        'o': _opacity != null ? _opacity!.toJson() : FSize().toJson(),
      }..removeWhere((String key, dynamic value) => value == null);
}
