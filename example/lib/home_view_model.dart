import 'package:flapjack/flapjack.dart';

import 'home_model.dart';

part 'home_view_model.flapjack.dart';

class HomeViewModel extends FlapjackViewModel<HomeModel> {
  HomeViewModel(super.model);

  int get counter => model.counter;

  @AsyncLoader()
  Future _$increment(int amount) async {
    await Future.delayed(const Duration(milliseconds: 360));
    model.counter+=amount;
  }
  @AsyncLoader()
  Future _$decrement(int amount) async {
    await Future.delayed(const Duration(milliseconds: 360));
    model.counter-=amount;
  }
}