import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('calendar'));
  }
}
