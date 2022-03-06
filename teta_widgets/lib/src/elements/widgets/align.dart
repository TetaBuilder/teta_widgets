// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

// ignore_for_file: public_member_api_docs

class WAlign extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WAlign(
    Key? key, {
    required this.node,
    required this.align,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FAlign align;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Align(
        alignment: align.align!,
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
          name: NodeType.name(NType.align),
          child: child,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
          loop: loop,
        ),
      ),
    );
  }
}