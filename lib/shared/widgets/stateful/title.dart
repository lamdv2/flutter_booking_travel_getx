import 'package:flutter/material.dart';

import '../../constants/app_style.dart';

class TitleHome extends StatefulWidget {
  const TitleHome({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TitleHome> createState() => _TitleHomeState();
}

class _TitleHomeState extends State<TitleHome> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: AppStyles.black000Size20Fw500FfMont,
    );
  }
}
