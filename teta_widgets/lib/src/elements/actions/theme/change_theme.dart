// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:

class FActionChangeTheme {
  static Future action(
    final BuildContext context,
  ) async {
    var val = BlocProvider.of<PaletteDarkLightCubit>(context).state;
    val = !val;
    await BlocProvider.of<PaletteDarkLightCubit>(context).switchVal(val);
  }

  static String toCode(
    final BuildContext context,
  ) {
    return '''
    var val = BlocProvider.of<ThemeCubit>(context).state;
    val = !val;
    await BlocProvider.of<ThemeCubit>(context).changeVal(val);
    ''';
  }
}
