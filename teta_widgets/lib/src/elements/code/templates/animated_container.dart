// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Animated Container Template
String animatedContainerCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final duration = int.tryParse(value) != null ? int.parse(value) : '400';
  return '''
    AnimatedContainer(
      duration: const Duration(milliseconds: $duration),
      ${CS.margin(context, body, isMargin: true)}
      ${CS.margin(context, body, isMargin: false)}
      ${CS.size(context, body, isWidth: true)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.boxDecoration(context, body, DBKeys.fill)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
