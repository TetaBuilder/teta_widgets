// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Positioned Template
String positionedCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
) {
  final left = body.attributes[DBKeys.left] as bool;
  final top = body.attributes[DBKeys.top] as bool;
  final right = body.attributes[DBKeys.right] as bool;
  final bottom = body.attributes[DBKeys.bottom] as bool;
  return '''
    Positioned(
      left: $left,
      top: $top,
      right: $right,
      bottom: $bottom,
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
