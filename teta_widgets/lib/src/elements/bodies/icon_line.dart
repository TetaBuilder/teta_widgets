// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/icon_line.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/icon_line.dart';

const _globalType = NType.lineIcon;

/// Intrinsic States of featherIcon node
final lineIconIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.icon,
  nodeVideo: '',
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['line', 'icons', 'lineicons', 'icon', 'font'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: 'Line Icon',
  type: _globalType,
  category: NodeCategories.icon,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [pLineIcons],
);

/// Feather Icon's body
class LineIconBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.lineIcon: 'plus',
    DBKeys.width: FSize(size: '24', unit: SizeUnit.pixel),
    DBKeys.fill: FFill(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.lineIcon,
          key: DBKeys.lineIcon,
          value: attributes[DBKeys.lineIcon],
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.width,
          title: 'Size',
          isWidth: true,
          value: attributes[DBKeys.width] as FSize,
        ),
        FillControlObject(
          title: '',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
          isStyled: false,
        ),
      ];

  @override
  Widget toWidget({
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WLineIcon(
        ValueKey(
          '''
      ${node.nid}
      $loop
      ${(attributes[DBKeys.width] as FSize).toJson()}
      ${attributes[DBKeys.lineIcon]}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ''',
        ),
        node: node,
        width: attributes[DBKeys.width] as FSize,
        icon: attributes[DBKeys.lineIcon] as String? ?? 'plus',
        fill: attributes[DBKeys.fill] as FFill,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      iconLineCodeTemplate(context, this, node, child, loop);
}
