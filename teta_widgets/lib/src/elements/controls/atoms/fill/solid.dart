// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class SolidFillControl extends StatefulWidget {
  const SolidFillControl({
    required this.title,
    required this.fill,
    required this.node,
    required this.isStyled,
    required this.callBack,
    this.color,
    this.opacity = 1,
    final Key? key,
  }) : super(key: key);

  final FFill? fill;
  final String title;
  final String? color;
  final double? opacity;
  final CNode node;
  final bool isStyled;
  final Function(FFill, bool, FFill) callBack;

  @override
  SolidFillControlState createState() => SolidFillControlState();
}

class SolidFillControlState extends State<SolidFillControl> {
  int? nodeId;
  bool? isUpdated;
  String? value;
  bool isVisible = true;
  TextEditingController controller = TextEditingController();
  TextEditingController opacityController = TextEditingController();
  FFill? tempFill;
  String? tempColor;

  @override
  void initState() {
    try {
      nodeId = widget.node.nid;
      if (widget.color != null) {
        controller.text = widget.color ?? '';
        opacityController.text = '${widget.opacity}';
        tempColor = widget.color;
      } else {
        controller.text = widget.fill!.get(context).levels!.first.color;
        opacityController.text =
            '${widget.fill!.get(context).levels!.first.opacity}';
        tempColor = widget.fill!.get(context).levels!.first.color;
      }
    } catch (_) {}
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    /*if (tempColor != widget.color) {
      controller.text = widget.color;
      tempFill = widget.fill;
    }
    if (isUpdated) {
      controller.text = tempColor;
      isUpdated = false;
    }*/
    return Column(
      children: [
        BlocListener<FocusBloc, List<CNode>>(
          listener: (final context, final state) {
            if (state.isNotEmpty) {
              if (state.first.nid != nodeId) {
                setState(() {
                  isUpdated = true;
                  if (widget.color != null) {
                    controller.text = widget.color ?? '';
                    controller.text = '${widget.opacity}';
                    tempColor = widget.color;
                  } else {
                    controller.text =
                        widget.fill!.get(context).levels!.first.color;
                    opacityController.text =
                        '${widget.fill!.get(context).levels!.first.opacity}';
                    tempColor = widget.fill!.get(context).levels!.first.color;
                  }
                });
                nodeId = state.first.nid;
              }
            }
          },
          child: BlocBuilder<FocusBloc, List<CNode>>(
            builder: (final context, final state) {
              return TContainer(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Palette.bgTertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: GestureDetector(
                        onTap: () {
                          showPicker(context);
                        },
                        child: HoverWidget(
                          hoverChild: TContainer(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: HexColor(
                                widget.color != null
                                    ? widget.color!
                                    : widget.fill!.levels!.first.color,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white),
                            ),
                          ),
                          onHover: (final e) {},
                          child: TContainer(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: HexColor(
                                widget.color != null
                                    ? widget.color!
                                    : widget.fill!.levels!.first.color,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Palette.bgGrey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CMiniTextField(
                        controller: controller,
                        placeholder: tempColor,
                        hpadding: 4,
                        onSubmitted: (final text) {
                          final hexCode = text.replaceAll('#', '');
                          if (hexCode.length == 3) {
                            final hexColor =
                                RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                            if (hexColor.hasMatch(hexCode)) {
                              final old =
                                  FFill().fromJson(widget.fill!.toJson());
                              widget.fill!.levels!.first.color =
                                  '$hexCode$hexCode';
                              widget.callBack(widget.fill!, false, old);
                            }
                          }
                          if (hexCode.length == 6) {
                            final hexColor =
                                RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                            if (hexColor.hasMatch(hexCode)) {
                              final old =
                                  FFill().fromJson(widget.fill!.toJson());
                              widget.fill!.levels!.first.color = hexCode;
                              widget.callBack(widget.fill!, false, old);
                            }
                          }
                        },
                        callBack: (final text) {
                          final hexCode = text.replaceAll('#', '');
                          if (hexCode.length == 3) {
                            final hexColor =
                                RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                            if (hexColor.hasMatch(hexCode)) {
                              final old =
                                  FFill().fromJson(widget.fill!.toJson());
                              widget.fill!.levels!.first.color =
                                  '$hexCode$hexCode';
                              widget.callBack(widget.fill!, false, old);
                            }
                          }
                          if (hexCode.length == 6) {
                            final hexColor =
                                RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                            if (hexColor.hasMatch(hexCode)) {
                              final old =
                                  FFill().fromJson(widget.fill!.toJson());
                              widget.fill!.levels!.first.color = hexCode;
                              widget.callBack(widget.fill!, false, old);
                            }
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: CMiniTextField(
                        controller: opacityController,
                        placeholder: '1',
                        hpadding: 4,
                        onSubmitted: (final text) {
                          final old = FFill().fromJson(widget.fill!.toJson());
                          widget.fill!.levels!.first.opacity =
                              double.tryParse(text) ?? 1;
                          widget.callBack(widget.fill!, false, old);
                        },
                        callBack: (final text) {
                          final old = FFill().fromJson(widget.fill!.toJson());
                          widget.fill!.levels!.first.opacity =
                              double.tryParse(text) ?? 1;
                          widget.callBack(widget.fill!, false, old);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Future updateState(final CNode node) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        tempColor = widget.fill!.levels!.first.color;
      });
    } else {
      await updateState(node);
    }
  }

  void updateColor(final Color color) {
    final old = FFill().fromJson(widget.fill!.toJson());
    setState(() {
      tempColor = color.value.toRadixString(16).substring(2, 8);
      isUpdated = true;
    });
    widget.fill!.levels!.first.color =
        color.value.toRadixString(16).substring(2, 8);
    controller.text = color.value.toRadixString(16).substring(2, 8);
    widget.callBack(widget.fill!, widget.isStyled, old);
  }

  void showPicker(final BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (final context) {
        return ColorPickerDialog(
          context: context,
          color: tempColor!,
          callback: updateColor,
        );
      },
    );
  }
}
