// Flutter imports:
// ignore_for_file: avoid_dynamic_calls

// Package imports:
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_project/index.dart';
import 'package:teta_core/src/models/page.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Component Template
String componentCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
  final int pageId,
) {
  ///1)reperire codice da
  String toReturn = 'is not loaded';
  final projectLoaded =
      BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
  if (body.attributes[DBKeys.componentName] == null ||
      (projectLoaded.prj.pages ?? <PageObject>[]).indexWhere(
            (final element) =>
                element.name == body.attributes[DBKeys.componentName],
          ) ==
          -1) return '';
  final compWidget = projectLoaded.prj.pages!.firstWhere(
    (final element) => element.name == body.attributes[DBKeys.componentName],
  );
  debugPrint('---->$compWidget');
  //used to prepare parmas in uri for loading url in webview
  prepareParamsForUi(compWidget, body);

  if (compWidget.isHardCoded) {
    //here we stay in a custom code component
    toReturn = '''
WebViewX(
    width: double.maxFinite,
    height: double.maxFinite,
    onWebViewCreated: (final controller) {
      WebViewXController webViewController = controller;
      webViewController.loadContent('${compWidget.runUrl}', SourceType.url,);
      },
    )
''';
  } else {
    //here we stay in a visual  component
    final target = projectLoaded.prj.pages!.firstWhere(
      (final element) => element.id == compWidget.id,
    );

    if (target.flatList == null) {
      toReturn = 'Target was not found';
    } else {
      final finalCode = StringBuffer()..write('');
      for (final item in target.flatList!) {
          finalCode.write(item.toCode(context) + ',');
        }
      toReturn = finalCode.toString();
    }

  }

  return toReturn;

  // final temp = removeDiacritics(
  //   page.name
  //       .replaceFirst('0', 'A0')
  //       .replaceFirst('1', 'A1')
  //       .replaceFirst('2', 'A2')
  //       .replaceFirst('3', 'A3')
  //       .replaceFirst('4', 'A4')
  //       .replaceFirst('5', 'A5')
  //       .replaceFirst('6', 'A6')
  //       .replaceFirst('7', 'A7')
  //       .replaceFirst('8', 'A8')
  //       .replaceFirst('9', 'A9')
  //       .replaceAll(' ', '')
  //       .replaceAll("'", '')
  //       .replaceAll('"', ''),
  // );
  // final pageNameRC = ReCase(temp);
  // final realPageName = 'Component${pageNameRC.camelCase}';

  // return '''
  //   $realPageName(
  //     ${stringParamsToSend.toString()}
  //   )
  //   ''';
}

void prepareParamsForUi(final PageObject page, final NodeBody body) {
  final stringParamsToSend = StringBuffer()..write('');
  for (final param in page.params) {
    final valueToSend = (body.attributes[DBKeys.paramsToSend] ??
            <String, dynamic>{})[param.id]?['label'] as String? ??
        'null';
    if (valueToSend != 'null') {
      final name = ReCase(param.name);
      stringParamsToSend.write('${name.camelCase}: ');
      if (body.attributes[DBKeys.paramsToSend][param.id]?['dataset']
                  as String ==
              'States' ||
          body.attributes[DBKeys.paramsToSend][param.id]?['dataset']
                  as String ==
              'Params') {
        final rc = ReCase(valueToSend);
        stringParamsToSend.write('${rc.camelCase}, ');
      } else if (body.attributes[DBKeys.paramsToSend][param.id]?['dataset']
              as String ==
          'Text') {
        final rc = ReCase(valueToSend);
        stringParamsToSend.write("'${rc.camelCase}', ");
      } else {
        final rc = ReCase(valueToSend);
        stringParamsToSend.write("datasets['${rc.camelCase}'], ");
      }
    }
  }
}

//todo: in the code export make a check if(page.isHardcoded) call this method instead of tocode
String toComponentCode(){

  return '';
}
