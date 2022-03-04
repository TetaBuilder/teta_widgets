// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/code/templates/apple.dart';
import 'package:teta_elements/src/elements/controls/control_model.dart';
import 'package:teta_elements/src/elements/controls/key_constants.dart';
import 'package:teta_elements/src/elements/controls/type.dart';
import 'package:teta_elements/src/elements/features/action.dart';
import 'package:teta_elements/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_elements/src/elements/features/page_transition.dart';
import 'package:teta_elements/src/elements/features/sizes.dart';
import 'package:teta_elements/src/elements/intrinsic_states/class.dart';
import 'package:teta_elements/src/elements/nodes/categories.dart';
import 'package:teta_elements/src/elements/nodes/children_enum.dart';
import 'package:teta_elements/src/elements/nodes/enum.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:teta_elements/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/widgets/cta/apple.dart';

const _globalType = NType.loginWithApple;

/// Instrict State of Login Apple
final loginAppleIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.button,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['apple', 'login', 'cta', 'button'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.input,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: <ActionGesture>[ActionGesture.onTap, ActionGesture.onLongPress],
);

/// Login Apple's body
class LoginWithAppleBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
    DBKeys.pageTransition: FPageTransition(),
    DBKeys.width: FSize(size: 'max', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: '42', unit: SizeUnit.pixel),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        SizesControlObject(
          keys: const [DBKeys.width, DBKeys.height],
          values: <FSize>[
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize,
          ],
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
      WLoginWithApple(
        node: node,
        child: child,
        forPlay: forPlay,
        loop: loop,
        action: attributes[DBKeys.action] as FAction,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
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
      loginAppleCodeTemplate(context, node, child);
}
