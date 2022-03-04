// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WGridViewBuilder extends StatefulWidget {
  /// Returns a StaggeredGridView (children: [ ]) in Teta
  const WGridViewBuilder({
    Key? key,
    this.nid,
    this.child,
    required this.node,
    required this.forPlay,
    required this.value,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    this.loop,
    required this.isVertical,
    required this.params,
    required this.states,
    required this.dataset,
    required this.primary,
    required this.shrinkWrap,
    required this.childAspectRatio,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FDataset value;
  final bool isVertical;
  final bool primary;
  final bool shrinkWrap;
  final FTextTypeInput crossAxisCount;
  final FTextTypeInput mainAxisSpacing;
  final FTextTypeInput crossAxisSpacing;
  final FTextTypeInput childAspectRatio;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WGridViewBuilder> createState() => _WGridViewState();
}

class _WGridViewState extends State<WGridViewBuilder> {
  DatasetObject map = DatasetObject.empty;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: _body(context),
    );
  }

  /// Returns a MouseRegion to disable the zoom on editor screen
  /// and provides a StaggeredGridView
  Widget _body(BuildContext context) {
    final crossAxisCountString = widget.crossAxisCount.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final mainAxisSpacingString = widget.mainAxisSpacing.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final crossAxisSpacingString = widget.crossAxisSpacing.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final childAspectRatioString = widget.childAspectRatio.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    _setDataset();
    final index = widget.value.datasetName != null
        ? widget.dataset.indexWhere(
            (element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db = index != -1 ? widget.dataset[index] : DatasetObject.empty;
    return MouseRegion(
      onEnter: (v) {
        BlocProvider.of<ZoomableCubit>(context)
            .changeZoomableFlag(value: false);
      },
      onExit: (v) {
        BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(value: true);
      },
      child: GridView.builder(
        shrinkWrap: widget.shrinkWrap,
        primary: widget.primary,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: int.tryParse(crossAxisCountString) != null &&
                  (int.tryParse(crossAxisCountString) ?? 0) > 0.1
              ? int.parse(crossAxisCountString)
              : 2,
          mainAxisSpacing: double.tryParse(mainAxisSpacingString) != null &&
                  (double.tryParse(mainAxisSpacingString) ?? 0) > 0.1
              ? double.parse(mainAxisSpacingString)
              : 2,
          crossAxisSpacing: double.tryParse(crossAxisSpacingString) != null &&
                  (double.tryParse(crossAxisSpacingString) ?? 0) > 0.1
              ? double.parse(crossAxisSpacingString)
              : 2,
          childAspectRatio: double.tryParse(childAspectRatioString) != null &&
                  (double.tryParse(childAspectRatioString) ?? 0) > 0.1
              ? double.parse(childAspectRatioString)
              : 1,
        ),
        itemCount: db.getMap.length,
        itemBuilder: (context, index) => widget.child != null
            ? widget.child!.toWidget(
                forPlay: widget.forPlay,
                params: [...widget.params, ...widget.params],
                states: widget.states,
                dataset: widget.dataset,
                loop: index,
              )
            : PlaceholderChildBuilder(
                name: widget.node.intrinsicState.displayName,
              ),
      ),
    );
  }

  void _setDataset() {
    try {
      final index = widget.dataset
          .indexWhere((element) => element.getName == widget.value.datasetName);
      final db = index != -1 ? widget.dataset[index] : DatasetObject.empty;
      if (mounted) {
        if (db.getName != '') {
          setState(() {
            map = db;
          });
        }
      }
    } catch (_) {}
  }
}
