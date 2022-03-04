// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_core/src/elements/nodes/node.dart';

/// GitHub Login Template
String loginGitHubCodeTemplate(BuildContext context, CNode node, CNode? child) {
  return '''
  GithubAuthButton(
    ${CS.action(context, node, ActionGesture.onTap, 'onPressed: () async', null, isRequired: true)}
    ${CS.action(context, node, ActionGesture.onLongPress, 'onLongPress: () async', null, isRequired: false)}
  )
  ''';
}
