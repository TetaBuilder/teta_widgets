// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';

/// It displays the name of a CNode
/// ATTENTION: Use this only inside a ChildConditionBuilder
/// /builder/child_condition.dart
class PlaceholderChildBuilder extends StatelessWidget {
  /// Constructor
  const PlaceholderChildBuilder({
    required this.name,
    final Key? key,
  }) : super(key: key);

  /// Name of the node
  final String name;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: THeadline3(
        name,
      ),
    );
  }
}
