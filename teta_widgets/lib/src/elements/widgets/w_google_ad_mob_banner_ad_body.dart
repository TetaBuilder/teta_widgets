// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WGoogleAdMobBannerAd extends StatelessWidget {
  /// Returns a  widget in Teta
  const WGoogleAdMobBannerAd(
    final Key? key, {
    required this.adMobAdIosUnitId,
    required this.adMobAdAndroidUnitId,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final FTextTypeInput adMobAdIosUnitId;
  final FTextTypeInput adMobAdAndroidUnitId;

  final CNode node;
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
      child: const SizedBox(
        width: double.maxFinite,
        child: Center(
          child: Text(
            'Here will be you ad.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
