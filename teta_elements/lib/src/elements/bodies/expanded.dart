// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/code/templates/expanded.dart';
import 'package:teta_elements/src/elements/controls/control_model.dart';
import 'package:teta_elements/src/elements/intrinsic_states/class.dart';
import 'package:teta_elements/src/elements/nodes/categories.dart';
import 'package:teta_elements/src/elements/nodes/children_enum.dart';
import 'package:teta_elements/src/elements/nodes/enum.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:teta_elements/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/widgets/expanded.dart';

const _globalType = NType.expanded;

/// Instrict State of Expanded
final expandedIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.expanded,
  nodeVideo: '_rnZaagadyo',
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.image),
    NodeType.name(NType.center),
    NodeType.name(NType.column),
  ],
  blockedTypes: [],
  synonymous: ['expanded', 'auto', 'space', 'flex'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Expanded's body
class ExpandedBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{};

  @override
  List<ControlModel> get controls => [];

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
      WExpanded(
        key: ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ''',
        ),
        node: node,
        child: child,
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
      expandedCodeTemplate(context, this, child, loop);
}
