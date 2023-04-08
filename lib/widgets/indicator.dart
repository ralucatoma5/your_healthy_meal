import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:hackathon/const.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  Indicator(this.isActive);
  final horizonalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? horizonalBlock * 5 : horizonalBlock * 2.5,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? blue : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
