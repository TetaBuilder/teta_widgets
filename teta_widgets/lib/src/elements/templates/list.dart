import 'package:teta_widgets/src/elements/templates/header_w_title_cta.dart';
import 'package:teta_widgets/src/elements/templates/template.dart';

class ListTemplates {
  static final _list = <CTemplate>[
    TempHeaderWTitleCTA(
      name: 'Header with Title & CTA',
      type: 'header',
    ),
  ];

  List<CTemplate> get list => _list;
}
