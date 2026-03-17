import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/feature/placeholder/placeholder_model.dart';

class PlaceholderProvider extends StateNotifier<List<PlaceholderModel>> {
  // ignore: use_super_parameters
  PlaceholderProvider([List<PlaceholderModel> initialItems = const []])
      : super(initialItems);

  Future<void> addItem() async {
    final id = state.isNotEmpty ? state.last.id + 1 : 0;

    final color = ([
      Colors.red,
      Colors.blue,
      Colors.pink,
      Colors.yellow,
      Colors.green,
      Colors.purple,
    ]..shuffle())
        .first;

    state = [...state, PlaceholderModel(id: id, color: color)];
  }

  Future<void> remove(PlaceholderModel target) async {
    state = state.where((item) => item.id != target.id).toList();
  }
}

final placeholderProvider =
    StateNotifierProvider<PlaceholderProvider, List<PlaceholderModel>>(
  (ref) => PlaceholderProvider(),
);
