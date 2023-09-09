import 'package:flutter/cupertino.dart';

class ConditionalWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final bool condition;
  const ConditionalWidget({super.key, required this.widget1, required this.widget2, required this.condition});

  @override
  Widget build(BuildContext context) {
    return condition ? widget1 : widget2;
  }
}
