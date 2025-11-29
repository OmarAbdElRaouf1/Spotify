import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, this.showBackButton = true});
  final bool? showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        color: Colors.red,
        onPressed: () {
          if (showBackButton!) {
            Navigator.pop(context);
          }
        },
        icon: SvgPicture.asset('assets/vectors/back_button.svg'),
      ),
    );
  }
}
