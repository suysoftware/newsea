import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

class LineWidget extends StatelessWidget {
  final double paddingValue;
  final Color? lineColor;
  final double? width;
  const LineWidget({super.key, required this.paddingValue, this.lineColor,this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingValue),
      child: Container(
        height: 1.0,
        width:width?? 5.w,
        color: lineColor ?? AppColors.grey.withOpacity(0.45),
      ),
    );
  }
}
