// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key, required this.control, required this.divider})
      : super(key: key);

  final Widget control;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          control,
          if (divider)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Divider(height: 1, color: Colors.white38),
            ),
        ],
      ),
    );
  }
}
