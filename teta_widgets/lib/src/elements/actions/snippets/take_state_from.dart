// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/variable.dart';

VariableObject? takeStateFrom(final PageObject page, final String condition) {
  return page.states.firstWhereOrNull(
    (final element) => element.name.toLowerCase() == condition.toLowerCase(),
  );
}
