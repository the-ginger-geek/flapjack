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
      child: Card(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        elevation: 4,
        child: InkWell(
          onLongPress: () => viewModel.incrementFuture(2),
          onTap: () => viewModel.incrementBasic(2),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.exposure_plus_2,
              color:
              Theme.of(context).floatingActionButtonTheme.foregroundColor,
            ),
          ),
        ),
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
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        elevation: 4,
        child: InkWell(
          onLongPress: () => viewModel.decrementFuture(2),
          onTap: () => viewModel.decrementBasic(2),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.exposure_minus_2,
              color:
                  Theme.of(context).floatingActionButtonTheme.foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
