// Dart imports:
// ignore_for_file: public_member_api_docs

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class Margins extends StatefulWidget {
  const Margins({
    required this.node,
    required this.title,
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final String title;
  final FMargins value;
  final Function(List<String>, List<String>) callBack;

  @override
  MarginsState createState() => MarginsState();
}

class MarginsState extends State<Margins> {
  int? nodeId;
  bool? isUpdated;
  List<String>? margins;
  List<TextEditingController> controllers = [];
  bool isLinked = true;
  Timer? searchOnStoppedTyping;

  @override
  void initState() {
    nodeId = widget.node.nid;
    margins = widget.value.getList(context);
    for (var i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
    }
    for (var i = 0; i < 4; i++) {
      controllers[i].text = margins![i];
    }
    var flag = false;
    var lastValue = '';
    for (final element in margins ?? const <String>[]) {
      if (lastValue == '') lastValue = element;
      if (element != lastValue) {
        flag = true;
      }
    }
    isLinked = !flag;
    super.initState();
  }

  void onChangeHandler(final FMargins value, final FMargins old) {
    setValue(value, old);
  }

  void setValue(final FMargins value, final FMargins old) {
    final clone = [...margins!];
    final temp =
        FMargins.fromJson(value.update(value: clone, context: context));
    widget.callBack(
      temp.toJson(),
      old.toJson(),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            if (mounted) {
              nodeId = state.first.nid;
              margins = widget.value.getList(context);
              for (var i = 0; i < 4; i++) {
                controllers[i].text = margins![i];
              }
              var flag = false;
              var lastValue = '';
              for (final element in margins ?? const <String>[]) {
                if (lastValue == '') lastValue = element;
                if (element != lastValue) {
                  flag = true;
                }
              }
              isLinked = !flag;
            }
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  THeadline3(
                    widget.title,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLinked = !isLinked;
                      });
                    },
                    child: HoverWidget(
                      hoverChild: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Icon(
                          isLinked ? Icons.link : Icons.link_off,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onHover: (final e) {},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Icon(
                          isLinked ? Icons.link : Icons.link_off,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CMiniTextField(
                    title: (!isLinked) ? 'LEFT' : 'ALL',
                    controller: controllers[0],
                    text: widget.value.getList(context)[0],
                    hpadding: 4,
                    withSwipe: true,
                    callBack: (final text) {
                      final finalText = text.replaceAll('-', '');
                      margins![0] = finalText;
                      if (isLinked) {
                        margins![1] = finalText;
                        controllers[1].text = finalText;
                        margins![2] = finalText;
                        controllers[2].text = finalText;
                        margins![3] = finalText;
                        controllers[3].text = finalText;
                      }
                      final old = FMargins.fromJson(widget.value.toJson());
                      final temp = FMargins.fromJson(widget.value.toJson());
                      onChangeHandler(temp, old);
                    },
                  ),
                ),
                if (!isLinked)
                  Expanded(
                    child: CMiniTextField(
                      title: 'TOP',
                      controller: controllers[1],
                      text: widget.value.getList(context)[1],
                      hpadding: 4,
                      withSwipe: true,
                      callBack: (final text) {
                        final finalText = text.replaceAll('-', '');
                        margins![1] = finalText;
                        final old = FMargins.fromJson(widget.value.toJson());
                        final temp = FMargins.fromJson(widget.value.toJson());
                        onChangeHandler(temp, old);
                      },
                    ),
                  ),
                if (!isLinked)
                  Expanded(
                    child: CMiniTextField(
                      title: 'RIGHT',
                      controller: controllers[2],
                      text: widget.value.getList(context)[2],
                      hpadding: 4,
                      withSwipe: true,
                      callBack: (final text) {
                        final finalText = text.replaceAll('-', '');
                        margins![2] = finalText;
                        final old = FMargins.fromJson(widget.value.toJson());
                        final temp = FMargins.fromJson(widget.value.toJson());
                        onChangeHandler(temp, old);
                      },
                    ),
                  ),
                if (!isLinked)
                  Expanded(
                    child: CMiniTextField(
                      title: 'BOTTOM',
                      controller: controllers[3],
                      text: widget.value.getList(context)[3],
                      hpadding: 4,
                      withSwipe: true,
                      callBack: (final text) {
                        final finalText = text.replaceAll('-', '');
                        margins![3] = finalText;
                        final old = FMargins.fromJson(widget.value.toJson());
                        final temp = FMargins.fromJson(widget.value.toJson());
                        onChangeHandler(temp, old);
                      },
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
