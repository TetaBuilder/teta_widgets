// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/off_stage.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/off_stage.dart';

const _globalType = NType.offStage;

/// IS
final offStageIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.stack,
  nodeVideo: 'c1xLMaTUWCY',
  nodeDescription: '''
      ''',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.container),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['offStage'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Set of funcs to use Container widget
class OffStageBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.flag: false,
  };

  @override
  List<ControlModel> get controls => [
        FlagControlObject(
          title: 'OffStage',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description:
              'If true, the child is laid out as if it was in the tree, but without painting anything, if false, the child is included in the tree as normal.',
        )
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
  }) {
    return WOffStage(
      key: ValueKey(
        '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${attributes[DBKeys.flag] as bool}
      ''',
      ),
      node: node,
      child: child,
      forPlay: forPlay,
      offStage: attributes[DBKeys.flag] as bool,
      loop: loop,
      params: params,
      states: states,
      dataset: dataset,
    );
  }

  @override
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      offStageCodeTemplate(context, this, child, loop);
}
