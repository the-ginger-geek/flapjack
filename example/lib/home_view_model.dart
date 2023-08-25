import 'package:flapjack/flapjack.dart';

import 'home_model.dart';

class HomeViewModel extends FlapjackViewModel<HomeModel> {
  HomeViewModel(super.model);

  int get counter => model.counter;

  Future<void> increment(int amount) async => await asyncExecutable(
        loadKey: 'increment',
        executable: () async {
          await Future.delayed(const Duration(milliseconds: 360));
          model.counter += amount;
        },
      );

  Future<void> decrement(int amount) async => await asyncExecutable(
        loadKey: 'decrement',
        executable: () async {
          await Future.delayed(const Duration(milliseconds: 360));
          model.counter -= amount;
        },
      );
}
