// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WSafeArea extends StatelessWidget {
  /// Constructor
  const WSafeArea(
    Key? key, {
    required CNode node,
    required bool left,
    required bool top,
    required bool right,
    required bool bottom,
    required bool forPlay,
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    CNode? child,
    int? loop,
  })  : _child = child,
        _node = node,
        _left = left,
        _top = top,
        _right = right,
        _bottom = bottom,
        _forPlay = forPlay,
        _loop = loop,
        _params = params,
        _states = states,
        _dataset = dataset,
        super(key: key);

  final CNode _node;
  final CNode? _child;
  final bool _left;
  final bool _top;
  final bool _right;
  final bool _bottom;
  final bool _forPlay;
  final int? _loop;

  final List<VariableObject> _params;
  final List<VariableObject> _states;
  final List<DatasetObject> _dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: _node,
      forPlay: _forPlay,
      child: Container(
        padding: EdgeInsets.only(
          top: _top ? 44 : 0,
          bottom: _bottom ? 34 : 0,
          left: _left ? 0 : 0,
          right: _right ? 0 : 0,
        ),
        child: ChildConditionBuilder(
          ValueKey('${_node.nid} $_loop'),
          name: _node.intrinsicState.displayName,
          child: _child,
          params: _params,
          states: _states,
          dataset: _dataset,
          forPlay: _forPlay,
          loop: _loop,
        ),
      ),
    );
  }
}
