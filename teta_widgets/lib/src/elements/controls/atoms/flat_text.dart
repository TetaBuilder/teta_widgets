// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/index.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FlatTextControl extends StatefulWidget {
  const FlatTextControl({
    required this.node,
    required this.value,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final CNode node;
  final String value;
  final Function(String, String) callBack;

  @override
  FlatTextControlState createState() => FlatTextControlState();
}

class FlatTextControlState extends State<FlatTextControl> {
  int? nodeId;
  bool? isUpdated;
  String? name;
  TextEditingController? controller;

  @override
  void initState() {
    nodeId = widget.node.nid;
    name = widget.value;
    controller = TextEditingController();
    controller!.text = name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              controller!.text = widget.value;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CText(
            'Flat Text',
            color: Palette.white,
          ),
          CTextField(
            controller: controller!,
            placeholder: widget.value,
            hpadding: 4,
            callBack: (text) {
              final old = widget.value;
              name = text;
              widget.callBack(text, old);
            },
          ),
        ],
      ),
    );
  }
}