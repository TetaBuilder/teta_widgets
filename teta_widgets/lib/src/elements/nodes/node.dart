// Flutter imports:
// Package imports:

// Package imports:
import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/features/children_ids.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// CNode is the mother of all sub node classes.
/// CNode = Custom Node.
/// Any node in Teta is a sub class of CNode
// ignore: must_be_immutable
abstract class CNode extends Equatable {
  /// Constructor
  CNode({
    required this.childrenIds,
    this.name,
    this.parent,
    this.nid = 0,
    this.child,
    this.children,
  });

  /// Type of the node
  final NType globalType = NType.nil;

  /// Intrinsic States of the node
  final IntrinsicStates intrinsicState = IntrinsicStates.basic;

  /// The body of the node, with all the attributes
  NodeBody body = NodeBody();

  /// The parent's id of the node
  int? parent;

  /// The id of the node (node-id)
  int nid;

  /// The position of the widget in the parent's childrenIds
  int? index;

  /// The child of the node, if it exists
  CNode? child;

  /// The name of each node
  String? name;

  /// The description of the node
  String? description;

  /// The children of the node, if they exists
  List<CNode>? children = [];

  /// It contains all the ids of the node's child / children
  FChildrenIds childrenIds;

  @override
  String toString() => 'Component: GlobalType: $globalType, Name: $name, Index: $index';

  /// Returns display name of any node
  static List<String> get nodes => NType.values.map(NodeType.type).toList();

  /// Returns display name of any node
  static List<String> get names => NType.values.map(NodeType.name).toList();

  /// Render a Widget from node
  Widget toWidget({
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    final int? loop,
  }) =>
      const SizedBox();

  @override
  List<Object?> get props => [
        parent,
        nid,
        child,
        children,
      ];

  /// Get all node controls.
  /// Controls are the widgets showed on right bar,
  /// used to change node's attributes.
  List<ControlModel> get controls => [];

  /// Transform json to node
  static CNode fromJson(
    final Map<String, dynamic> doc,
    final int pageId,
  ) {
    return NDynamic.fromJson(doc, pageId);
  }

  /// Transform members in json
  Map<String, dynamic> toJson() {
    return NDynamic(
      globalType: intrinsicState.type,
      body: body,
      childrenIds: FChildrenIds(),
      inSpawned: false,
    ).toJson();
  }

  /// toJson method of the body
  Map<String, dynamic> attributesToJson() => body.toJson();

  /// Render node to code string
  String toCode(final BuildContext context) {
    return NDynamic(
      globalType: intrinsicState.type,
      body: NDynamic.getBody(intrinsicState.type),
      childrenIds: FChildrenIds(),
      inSpawned: false,
    ).toCode(context);
  }

  /// Instantiate new node by display name
  static CNode toNodeFromName(
    final String displayName,
    final BuildContext context,
  ) {
    final enumType = NodeType.fromStringCamelCase(displayName);
    return NDynamic(
      globalType: enumType,
      body: NDynamic.getBody(enumType),
      childrenIds: FChildrenIds(),
      inSpawned: false,
    );
  }
}
