// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/fill/image.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill/linear.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill/radial.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill/solid.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill/style.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

enum FillTypeControlType {
  onlySolid,
  all,
}

class FillControl extends StatefulWidget {
  const FillControl({
    required this.node,
    required this.callBack,
    required this.fill,
    required this.isImageEnabled,
    required this.isNoneEnabled,
    this.title,
    this.color,
    this.type,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final String? title;
  final String? color;
  final FFill fill;
  final bool isImageEnabled;
  final bool isNoneEnabled;
  final FillTypeControlType? type;
  final Function(FFill, bool, FFill) callBack;

  @override
  FillControlState createState() => FillControlState();
}

class FillControlState extends State<FillControl> {
  List<String> list = [];

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: BlocBuilder<PaletteBloc, List<PaletteModel>>(
        builder: (final context, final state) {
          list = BlocProvider.of<PaletteBloc>(context).state.isNotEmpty
              ? widget.isImageEnabled
                  ? widget.isNoneEnabled
                      ? <String>[
                          'solid',
                          'linear',
                          'radial',
                          'image',
                          'styles',
                          'none'
                        ]
                      : <String>['solid', 'linear', 'radial', 'image', 'styles']
                  : widget.isNoneEnabled
                      ? <String>['solid', 'linear', 'radial', 'styles', 'none']
                      : <String>['solid', 'linear', 'radial', 'styles']
              : widget.isImageEnabled
                  ? widget.isNoneEnabled
                      ? <String>['solid', 'linear', 'radial', 'image', 'none']
                      : <String>['solid', 'linear', 'radial', 'styles']
                  : widget.isNoneEnabled
                      ? <String>['solid', 'linear', 'radial', 'none']
                      : <String>['solid', 'linear', 'radial'];
          if (widget.type == FillTypeControlType.onlySolid) {
            list = ['solid', 'styles'];
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  THeadline3(
                    widget.title ?? 'Fill',
                  ),
                  CDropdownForType(
                    value: (widget.fill.paletteStyle != null)
                        ? 'styles'
                        : (widget.fill.type == FFillType.solid)
                            ? 'solid'
                            : (widget.fill.type == FFillType.linearGradient &&
                                    widget.type == FillTypeControlType.all)
                                ? 'linear'
                                : (widget.fill.type ==
                                            FFillType.radialGradient &&
                                        widget.type == FillTypeControlType.all)
                                    ? 'radial'
                                    : (widget.fill.type == FFillType.image)
                                        ? 'image'
                                        : widget.type ==
                                                FillTypeControlType.onlySolid
                                            ? 'solid'
                                            : 'none',
                    items: list,
                    onChange: (final value) {
                      if (value == 'solid') {
                        widget.callBack(
                          FFill().ready(FFillType.solid),
                          false,
                          widget.fill,
                        );
                      }
                      if (value == 'linear' &&
                          widget.fill.type != FFillType.linearGradient) {
                        widget.callBack(
                          FFill().ready(FFillType.linearGradient),
                          false,
                          widget.fill,
                        );
                      }
                      if (value == 'radial' &&
                          widget.fill.type != FFillType.radialGradient) {
                        widget.callBack(
                          FFill().ready(FFillType.radialGradient),
                          false,
                          widget.fill,
                        );
                      }
                      if (value == 'image' &&
                          widget.fill.type != FFillType.image) {
                        widget.callBack(
                          FFill().ready(FFillType.image),
                          false,
                          widget.fill,
                        );
                      }
                      if (value == 'none' &&
                          widget.fill.type != FFillType.none) {
                        widget.callBack(
                          FFill().ready(FFillType.none),
                          false,
                          widget.fill,
                        );
                      }
                      if (value == 'styles') {
                        try {
                          final model =
                              BlocProvider.of<PaletteBloc>(context).state.first;
                          final palette = widget.fill..paletteStyle = model.id;
                          widget.callBack(palette, false, widget.fill);
                        } catch (_) {}
                      }
                    },
                  ),
                ],
              ),
              control(context)
            ],
          );
        },
      ),
    );
  }

  Widget control(final BuildContext context) {
    return BlocBuilder<PaletteBloc, List<PaletteModel>>(
      builder: (final context, final state) {
        PaletteModel? model;
        if (widget.fill.paletteStyle != null) {
          BlocProvider.of<PaletteBloc>(context).state.forEach((final element) {
            if (element.id == widget.fill.paletteStyle) model = element;
          });
        }
        return model != null
            ? StyleFillControl(
                onlySolid: widget.type == FillTypeControlType.onlySolid,
                model: model!,
                node: widget.node,
                callBack: widget.callBack,
                fill: widget.fill,
              )
            : (widget.type == FillTypeControlType.onlySolid ||
                    widget.fill.type == FFillType.solid)
                ? SolidFillControl(
                    title: widget.title ?? 'Fill',
                    fill: widget.fill,
                    color: widget.color,
                    node: widget.node,
                    isStyled: false,
                    callBack: widget.callBack,
                  )
                : (widget.fill.type == FFillType.linearGradient)
                    ? LinearFillControl(
                        title: widget.title ?? 'Fill',
                        fill: widget.fill,
                        node: widget.node,
                        isStyled: false,
                        callBack: widget.callBack,
                      )
                    : (widget.fill.type == FFillType.radialGradient)
                        ? RadialFillControl(
                            title: widget.title ?? 'Fill',
                            fill: widget.fill,
                            node: widget.node,
                            isStyled: false,
                            callBack: widget.callBack,
                          )
                        : (widget.fill.type == FFillType.image)
                            ? ImageFillControl(
                                title: widget.title ?? 'Fill',
                                fill: widget.fill,
                                node: widget.node,
                                isStyled: false,
                                callBack: widget.callBack,
                              )
                            : const SizedBox();
      },
    );
  }
}
