// Flutter imports:

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WPdfViewer extends StatefulWidget {
  const WPdfViewer(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.value,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput value;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WPdfViewer> createState() => _WPdfViewerState();
}

class _WPdfViewerState extends State<WPdfViewer> {
  bool isLoading = false;
  PDFDocument doc = PDFDocument();

  @override
  void initState() {
    super.initState();
    docInitializer();
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: isLoading
          ? const CircularProgressIndicator()
          : const ColoredBox(color: Colors.red),
    );
  }

  Future<void> docInitializer() async {
    try {
      // Logger.printMessage('start');
      setState(() {
        isLoading = true;
      });

      final imageData = await NetworkAssetBundle(
        Uri.parse(
          'https://oysternext.com/wp-content/uploads/2022/04/Oyster_AudioPanel_CP_Installazione_in_controsoffitti_in_fibra_minerale.pdf',
        ),
      ).load('');

      Logger.printMessage(imageData.buffer.lengthInBytes.toString());

      setState(() {
        isLoading = false;
      });

      // Logger.printMessage('end');
      
    } catch (e, s) {
      Logger.printError('$e ---------- $s');
    }
  }
}
