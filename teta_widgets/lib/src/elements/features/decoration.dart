// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/design_system/hex_color.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/border.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/shadow.dart';

/// Class made to facilitate the creation of BoxDecoration for widgets
class TetaBoxDecoration {
  /// Get a [BoxDecoration]
  static BoxDecoration get({
    required final BuildContext context,
    required final FFill fill,
    final FBorderRadius? borderRadius,
    final FShadow? shadow,
    final FBorder? borders,
    final FFill? borderFill,
  }) {
    if (fill.type == FFillType.solid) {
      return BoxDecoration(
        color: HexColor(fill.levels!.first.color)
            .withOpacity(fill.levels!.first.opacity ?? 1),
        borderRadius: borderRadius?.get,
        boxShadow: const [
          //shadows.get(context),
        ],
        border: borders?.get(context, forPlay: true),
      );
    } else if (fill.type == FFillType.linearGradient) {
      return BoxDecoration(
        gradient: LinearGradient(
          colors: fill.levels!
              .map(
                (final e) => HexColor(e.color).withOpacity(e.opacity ?? 1),
              )
              .toList(),
          begin: fill.begin!,
          end: fill.end!,
          stops: fill.levels!.map((final e) => e.stop).toList(),
        ),
        borderRadius: borderRadius?.get,
        boxShadow: const [
          //shadows.get(context),
        ],
        border: borders?.get(context, forPlay: true),
      );
    } else if (fill.paletteStyle != null) {
      return BoxDecoration(
        color: HexColor(fill.get(context).getHexColor(context)),
        borderRadius: borderRadius?.get,
        boxShadow: const [
          //shadows.get(context),
        ],
        border: borders?.get(context, forPlay: true),
      );
    } else if (fill.type == FFillType.radialGradient) {
      return BoxDecoration(
        gradient: RadialGradient(
          colors: fill.levels!
              .map((final e) => HexColor(e.color).withOpacity(e.opacity ?? 1))
              .toList(),
          center: fill.center!,
          radius: fill.radius!,
          stops: fill.levels!.map((final e) => e.stop).toList(),
        ),
        borderRadius: borderRadius?.get,
        boxShadow: const [
          //shadows.get(context),
        ],
        border: borders?.get(context, forPlay: true),
      );
    }
    //fill.type -> none
    else {
      return BoxDecoration(
        borderRadius: borderRadius?.get,
        boxShadow: const [
          //shadows.get(context),
        ],
        border: borders?.get(context, forPlay: true),
      );
    }
  }
}

class TetaShapeCard {
  /// Get a [BoxDecoration]
  static RoundedRectangleBorder get({
    required final BuildContext context,
    final FBorderRadius? borderRadius,
  }) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius != null ? borderRadius.get : BorderRadius.zero,
    );
  }
}
