// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class FATetaCMSDelete {
  static Future action(
    final String? collectionId,
    final FTextTypeInput? documentId,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final eqValue = documentId?.get(params, states, dataset, true, loop);
    if (collectionId != null && eqValue != null) {
      await TetaCMS.instance.client.deleteDocument(collectionId, eqValue);
    }
  }

  static String toCode(
    final String? collectionId,
    final FTextTypeInput? documentId,
    final int? loop,
  ) {
    final eqValue = documentId?.toCode(loop);
    return "await TetaCMS.instance.client.deleteDocument('$collectionId', $eqValue);";
  }
}
