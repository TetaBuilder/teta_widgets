// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/code/templates/cupertino_appbar.dart';
import 'package:teta_elements/src/elements/controls/control_model.dart';
import 'package:teta_elements/src/elements/controls/key_constants.dart';
import 'package:teta_elements/src/elements/features/fill.dart';
import 'package:teta_elements/src/elements/intrinsic_states/class.dart';
import 'package:teta_elements/src/elements/nodes/categories.dart';
import 'package:teta_elements/src/elements/nodes/children_enum.dart';
import 'package:teta_elements/src/elements/nodes/enum.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:teta_elements/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/widgets/cupertino_appbar.dart';

const _globalType = NType.cupertinoAppBar;

/// Instrict State of Cupertino AppBar
final cupertinoAppBarIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.box,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(NType.cupertinoAppBar), 'navigation', 'navbar'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 3,
  canHave: ChildrenEnum.children,
  addChildLabels: [
    'Add Leading',
    'Add Title',
    'Add Trailing',
  ],
  gestures: [],
);

/// ```dart
/// CupertinoNavigationBar({
/// Key? key,
///  Widget? leading,
/// bool automaticallyImplyLeading,
///  bool automaticallyImplyMiddle,
/// String? previousPageTitle,
/// Widget? middle,
/// Widget? trailing,
/// Border? border,
/// Color? backgroundColor,
/// Brightness? brightness,
/// EdgeInsetsDirectional? padding,
/// bool transitionBetweenRoutes,
///  Object heroTag
/// })
/// ```
class CupertinoAppBarBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.fill: FFill(levels: [FFillElement(color: 'ffffff', stop: 0)]),
  };

  @override
  List<ControlModel> get controls => [
        FillControlObject(
          title: '',
          key: 'Background Color',
          value: attributes[DBKeys.fill] as FFill,
          isStyled: false,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
        ),
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
    required CNode node,
    CNode? child,
    List<CNode>? children,
  }) =>
      WCupertinoAppBar(
        key: ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ''',
        ),
        children: children ?? [],
        node: node,
        fill: attributes[DBKeys.fill] as FFill,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      cupertinoAppBarCodeTemplate(context, this);
}
