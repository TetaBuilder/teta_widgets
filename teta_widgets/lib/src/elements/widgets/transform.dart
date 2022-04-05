// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WTransform extends StatelessWidget {
  /// Returns a tooltip widget in Teta
  const WTransform(
    final Key? key, {
    required this.node,
    required this.valueX,
    required this.valueY,
    required this.valueZ,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput valueX;
  final FTextTypeInput valueY;
  final FTextTypeInput valueZ;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(1, 1, 1)
          ..rotateX(
            double.tryParse(
                  valueX.get(params, states, dataset, forPlay, loop),
                ) ??
                0,
          )
          ..rotateY(
            double.tryParse(
                  valueY.get(params, states, dataset, forPlay, loop),
                ) ??
                0,
          )
          ..rotateZ(
            double.tryParse(
                  valueZ.get(params, states, dataset, forPlay, loop),
                ) ??
                0,
          ),
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
          name: NodeType.name(NType.tooltip),
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
