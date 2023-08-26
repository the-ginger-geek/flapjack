import 'package:flapjack/flapjack.dart';
import 'package:flutter/cupertino.dart';

class HomeModel extends FlapjackModel {
  final counter = ValueNotifier<int>(0);
}

class HomeViewModel extends FlapjackViewModel<HomeModel> {
  HomeViewModel(super.model);

  void incrementBasic(int amount) => model.counter.value += amount;
  void decrementBasic(int amount) => model.counter.value -= amount;

  Future<void> incrementFuture(int amount) async => await asyncExecutable(
        loadKey: 'increment',
        executable: () async {
          await Future.delayed(const Duration(milliseconds: 360));
          model.counter.value += amount;
        },
      );

  Future<void> decrementFuture(int amount) async => await asyncExecutable(
        loadKey: 'decrement',
        executable: () async {
          await Future.delayed(const Duration(milliseconds: 360));
          model.counter.value -= amount;
        },
      );
}
