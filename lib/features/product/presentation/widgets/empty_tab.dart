import 'package:flutter/material.dart';

class EmptyTab extends StatelessWidget {
  final String tabName;
  const EmptyTab({Key? key, required this.tabName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Экран $tabName в разработке"));
  }
}
