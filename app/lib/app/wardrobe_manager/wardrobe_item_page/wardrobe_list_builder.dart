import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/auth/auth_widget.dart';

//List - Item - Builder
typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class WardrobeListItemsBuilder<T> extends StatelessWidget {
  const WardrobeListItemsBuilder({
    Key? key,
    required this.data,
    required this.itemBuilder,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (items) =>
          items.isNotEmpty ? _buildList(items) : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, e) {
        return EmptyContent(title: 'Something went wrong', message: '');
      },
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => const Divider(height: 0.5),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container(); // zero height: not visible
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}
