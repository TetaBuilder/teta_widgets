import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/actions/condition.dart';
import 'package:teta_widgets/src/elements/actions/delay.dart';
import 'package:teta_widgets/src/elements/actions/loop.dart';
import 'package:teta_widgets/src/elements/index.dart';

class AS {
  static Future action() async {}

  static String toCode(
    final String func, {
    required final BuildContext context,
    required final FTextTypeInput? condition,
    required final FTextTypeInput? valueOfCondition,
    required final FTextTypeInput? everyMilliseconds,
    required final FTextTypeInput? delay,
    required final bool? withCondition,
    required final bool? withLoop,
  }) {
    return FCondition.toCode(
          context,
          condition,
          valueOfCondition,
          withCondition: withCondition ?? false,
        ) +
        FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
        FLoop.toCode(
          int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
          func,
          withLoop: withLoop ?? false,
        );
  }
}
