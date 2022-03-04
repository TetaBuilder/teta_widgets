// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Container Template
String containerCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
) {
  return '''
    Container(
      ${CS.margin(context, body, isMargin: true)}
      ${CS.margin(context, body, isMargin: false)}
      ${CS.size(context, body, isWidth: true)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.boxDecoration(context, body, DBKeys.fill)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
