// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for GridView widget
///
/// Returns:
/// ```dart
/// GridView(
///       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
///         mainAxisSpacing: 2,
///         crossAxisCount: 2,
///         crossAxisSpacing: 2,
///         childAspectRatio: 1,
///      ),
///       shrinkWrap: false,
///       primary: false,
///       <$_scrollDirection>
///       <${CS.children(context, children)}>
//     )
/// ```
String gridViewCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
  final int? loop,
) {
  final primary = body.attributes[DBKeys.isPrimary] as bool;
  final _scrollDirection =
      !(body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';

  final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;
  final valueMainAxisSpacing =
      (body.attributes[DBKeys.mainAxisSpacing] as FTextTypeInput).toCode(loop);
  final mainAxisSpacing = double.tryParse(valueMainAxisSpacing) ?? 2;

  final valueCrossAxisCount =
      (body.attributes[DBKeys.crossAxisCount] as FTextTypeInput).toCode(loop);
  final crossAxisCount = int.tryParse(valueCrossAxisCount) ?? 2;

  final valueCrossAxisSpacing =
      (body.attributes[DBKeys.crossAxisSpacing] as FTextTypeInput).toCode(loop);
  final crossAxisSpacing = double.tryParse(valueCrossAxisSpacing) ?? 2;

  final valueChildAspectRatio =
      (body.attributes[DBKeys.childAspectRatio] as FTextTypeInput).toCode(loop);
  final childAspectRatio = double.tryParse(valueChildAspectRatio) ?? 1;

  return '''
    GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: $mainAxisSpacing,
        crossAxisCount: $crossAxisCount,
        crossAxisSpacing: $crossAxisSpacing,
        childAspectRatio: $childAspectRatio, 
      ),
      shrinkWrap: $shrinkWrap,
      primary: $primary,
      $_scrollDirection
      ${CS.children(context, children)}
    )
  ''';
}
