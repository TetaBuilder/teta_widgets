import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/cubits/refresh/cubit.dart';

/// Refreshes the changes rebuild the scaffold
void update(BuildContext context) {
  BlocProvider.of<RefreshCubit>(context).change();
}