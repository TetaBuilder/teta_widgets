// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for ListView.builder widget
///
/// Returns:
/// ```dart
/// Builder(
///   builder: (context) {
///     final children = <Widget>[]; // node's children
///     return ListView.builder(
///       scrollDirection: Axis.vertical,
///       itemCount: children.length,
///       itemBuilder: (context, index) {
///         return children[index];
///       },
///     );
///   },
/// );
/// ```

class StripeCartItemsBuilderTemplate {
  static String toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) {
    final _scrollDirection =
        !(body.attributes[DBKeys.isVertical] as bool? ?? false)
            ? 'scrollDirection: Axis.horizontal,'
            : '';
    final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;

    var childCode = 'const SizedBox();';
    if (child != null) {
      childCode = child.toCode(context);
    }
    return '''
   FutureBuilder<TetaProductsResponse>(
      future: TetaCMS.instance.store.getCartProducts(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final r = snapshot.data?.data;
          if(r != null) {
          this.datasets['cart'] = r.map((final e) => e.toJson()).toList(growable: true);
          return ListView.builder(
            $_scrollDirection
            shrinkWrap: $shrinkWrap,
            itemCount: this.datasets['cart'].length,
            itemBuilder: (context, index) {
              return $childCode;
            },
          );
          } else {
          return Container();
        }
      }
      }
      ),
    )
    ''';
  }
}
