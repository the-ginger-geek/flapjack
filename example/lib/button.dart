import 'package:flapjack/flapjack.dart';
import 'package:flutter/material.dart';

import 'home_view_model.dart';

class IncrementButton extends FlapjackViewModelWidget<HomeViewModel> {
  const IncrementButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return FlapjackLoader<HomeViewModel>(
      loadingKey: 'increment',
      child: FloatingActionButton(
        onPressed: () => viewModel.increment(2),
        tooltip: 'Increment',
        child: const Icon(Icons.exposure_plus_2_rounded),
      ),
    );
  }
}

class DecrementButton extends FlapjackViewModelWidget<HomeViewModel> {
  const DecrementButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return FlapjackLoader<HomeViewModel>(
      loadingKey: 'decrement',
      child: FloatingActionButton(
        onPressed: () => viewModel.decrement(2),
        tooltip: 'Decrement',
        child: const Icon(Icons.exposure_minus_2),
      ),
    );
  }
}