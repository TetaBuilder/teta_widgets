// Package imports:
// ignore_for_file: overridden_fields

import 'package:nanoid/nanoid.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/templates/template.dart';

//ignore: must_be_immutable
class TempHeaderWTitleCTA extends CTemplate {
  TempHeaderWTitleCTA({
    this.id,
    this.name,
    this.type,
  }) {
    id = nanoid(12);
  }

  String? id;

  @override
  final String? name;
  @override
  final String? type;
  @override
  String toString() => 'Default Template { }';

  @override
  List<Object> get props => [name!, type!];

  @override
  List<NType> listNodes() => [NType.container, NType.column, NType.text];
}
