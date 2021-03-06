// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Code Template of Text Node
String textCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final valueMaxLines =
      (body.attributes[DBKeys.maxLines] as FTextTypeInput).toCode(loop);
  final maxLines =
      int.tryParse(valueMaxLines) != null ? int.parse(valueMaxLines) : '';
  return '''
    Text(
      ${abstract.type == FTextTypeEnum.text ? "r$value" : value},
      ${CS.textStyle(context, body, DBKeys.textStyle)}
      ${maxLines != '' ? 'maxLines: $maxLines' : ''}
    )
  ''';
}
