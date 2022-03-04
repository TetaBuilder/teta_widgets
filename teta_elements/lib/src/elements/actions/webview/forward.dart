// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/actions/snippets/take_state_from.dart';

class FActionWebViewForward {
  static Future action(
    BuildContext context,
    List<VariableObject> states,
    String? stateName,
  ) async {
    final variable =
        states.firstWhereOrNull((element) => element.name == stateName);
    if (variable?.webViewController != null) {
      final flag = await variable?.webViewController?.canGoForward();
      if (flag ?? false) {
        await variable?.webViewController?.goForward();
      }
    }
  }

  static String toCode(BuildContext context, String? stateName) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final variable = takeStateFrom(page, '$stateName');
    if (variable == null || stateName == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
    if ($varName != null) { 
      final flag = await $varName.canGoForward();
      if (flag ?? false) {
        $varName.goForward();
      }
    }''';
  }
}
