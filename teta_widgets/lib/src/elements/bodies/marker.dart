// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/marker.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/marker.dart';

const _globalType = NType.marker;

/// Intrinsic States of Marker
final markerIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.marker,
  nodeVideo: '7oIAs-0G4mw', //Check
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.image),
    NodeType.name(NType.icon),
  ],
  blockedTypes: [],
  synonymous: ['marker', 'map', 'icon'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.map,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Body of Marker
class MarkerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.icon: 'plus',
    DBKeys.width: FSize(size: '24', unit: SizeUnit.pixel),
    DBKeys.fill: FFill(),
    DBKeys.latitude: FTextTypeInput(value: '41.90'),
    DBKeys.longitude: FTextTypeInput(value: '12.49'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Latitude',
          type: ControlType.value,
          key: DBKeys.latitude,
          value: attributes[DBKeys.latitude],
        ),
        ControlObject(
          title: 'Longitude',
          type: ControlType.value,
          key: DBKeys.longitude,
          value: attributes[DBKeys.longitude],
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
      WMarker(
        key: ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${attributes[DBKeys.icon]}
      ${(attributes[DBKeys.width] as FSize).toJson()}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ${(attributes[DBKeys.latitude] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.longitude] as FTextTypeInput).toJson()}
      ''',
        ),
        node: node,
        child: child,
        width: attributes[DBKeys.width] as FSize,
        icon: attributes[DBKeys.icon] as String? ?? 'plus',
        fill: attributes[DBKeys.fill] as FFill,
        latitude: attributes[DBKeys.latitude] as FTextTypeInput,
        longitude: attributes[DBKeys.longitude] as FTextTypeInput,
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
      markerCodeTemplate(context, this, node, child, loop);
}
