import 'package:flapjack/flapjack.dart';

import 'home_model.dart';

class HomeViewModel extends FlapjackViewModel<HomeModel> {
  HomeViewModel(super.model);

  int get counter => model.counter;

  Future increment(int amount) async {
    await Future.delayed(const Duration(milliseconds: 360));
    model.counter+=amount;
  }

  Future decrement(int amount) async {
    await Future.delayed(const Duration(milliseconds: 360));
    model.counter-=amount;
  }
}