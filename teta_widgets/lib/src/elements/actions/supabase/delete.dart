// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/cubits/supabase.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/map_element.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FASupabaseDelete {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final MapElement supabaseEq,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;

    // Take status from states
    final status = takeStateFrom(page, 'status');

    changeState(status, context, 'Loading');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      dynamic eqValue;
      if (supabaseEq.key.toLowerCase() != 'id') {
        eqValue = supabaseEq.value.get(params, states, dataset, true, loop);
      } else {
        eqValue = int.tryParse(
          supabaseEq.value.get(params, states, dataset, true, loop),
        );
      }
      final response = await client
          .from(supabaseFrom?.get(params, states, dataset, true, loop) ?? '')
          .delete()
          .eq(supabaseEq.key, eqValue)
          .execute();
      if (response.error != null) changeState(status, context, 'Failed');
      changeState(status, context, 'Success');
    }
  }

  static String toCode(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
    final FTextTypeInput? supabaseFrom,
    final MapElement? supabaseEq,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final status = takeStateFrom(page, 'status');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      dynamic eqValue;
      if (supabaseEq?.key.toLowerCase() != 'id') {
        eqValue = supabaseEq?.value.toCode(0);
      } else {
        eqValue = int.tryParse(supabaseEq!.value.toCode(0));
      }
      return '''
        final response = await Supabase.instance.client
              .from('${supabaseFrom?.toCode(0) ?? ''}')
              .delete()
              .eq('${supabaseEq?.key}', '$eqValue')
              .execute();
        if (response.error != null) {
          ${status != null ? "setState(() { status = 'Failed'; });" : ''}
        } else {
          ${status != null ? "setState(() { status = 'Success'; });" : ''}
        }
      ''';
    } else {
      return '';
    }
  }
}
