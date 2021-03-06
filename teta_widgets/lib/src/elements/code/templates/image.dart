// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Image Template
String imageCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.image] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final borderRadius = CS.borderRadius(context, body);
  return '''
    ${borderRadius != '' ? 'ClipRRect( ${CS.borderRadius(context, body)} child:' : ''} 
        Image.network(
          ${abstract.type == FTextTypeEnum.text || abstract.type == FTextTypeEnum.asset ? "r$value" : value},
          ${CS.size(context, body, isWidth: true)}
          ${CS.size(context, body, isWidth: false)}
          ${CS.boxFit(context, body)}
        )
    ${borderRadius != '' ? ',)' : ''}
  ''';
}
