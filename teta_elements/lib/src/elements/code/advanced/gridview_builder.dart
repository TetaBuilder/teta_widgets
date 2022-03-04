// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/features/dataset.dart';
import 'package:teta_core/src/elements/features/text_type_input.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Generates the code for ListView widget
///
/// Returns:
/// ```dart
/// ListView(
///   scrollDirection: Axis.horizontal, // isVertical (vertical is dedundant)
///   children: [], // node's children
/// );
/// ```
String gridViewBuilderCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  final primary = body.attributes[DBKeys.isPrimary] as bool;
  final _scrollDirection =
      !(body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';

  final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;
  final valueMainAxisSpacing =
      (body.attributes[DBKeys.mainAxisSpacing] as FTextTypeInput).toCode(loop);
  final mainAxisSpacing = double.tryParse(valueMainAxisSpacing) != null &&
          (double.tryParse(valueMainAxisSpacing) ?? 0) > 0.1
      ? double.parse(valueMainAxisSpacing)
      : 2;

  final valueCrossAxisCount =
      (body.attributes[DBKeys.crossAxisCount] as FTextTypeInput).toCode(loop);
  final crossAxisCount = int.tryParse(valueCrossAxisCount) != null &&
          (int.tryParse(valueCrossAxisCount) ?? 0) > 0.1
      ? int.parse(valueCrossAxisCount)
      : 2;

  final valueCrossAxisSpacing =
      (body.attributes[DBKeys.crossAxisSpacing] as FTextTypeInput).toCode(loop);
  final crossAxisSpacing = double.tryParse(valueCrossAxisSpacing) != null &&
          (double.tryParse(valueCrossAxisSpacing) ?? 0) > 0.1
      ? double.parse(valueCrossAxisSpacing)
      : 2;

  final valueChildAspectRatio =
      (body.attributes[DBKeys.childAspectRatio] as FTextTypeInput).toCode(loop);
  final childAspectRatio = double.tryParse(valueChildAspectRatio) != null &&
          (double.tryParse(valueChildAspectRatio) ?? 0) > 0.1
      ? double.parse(valueChildAspectRatio)
      : 1;

  final childString = child != null ? child.toCode(context) : '';
  final dataset =
      (body.attributes[DBKeys.datasetInput] as FDataset).datasetName;

  return '''
    GridView.builder(
      shrinkWrap: $shrinkWrap,
      primary: $primary,
       $_scrollDirection
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: $mainAxisSpacing,
        crossAxisCount: $crossAxisCount,
        crossAxisSpacing: $crossAxisSpacing,
        childAspectRatio: $childAspectRatio,
      ),
      itemCount: ${dataset != null ? """
          datasets.keys.contains('$dataset') ? (datasets['$dataset'] as List<dynamic>).length : 0
          """ : "0"},
      itemBuilder: (context, index) {
            return $childString;
          },
    )
  ''';
}
