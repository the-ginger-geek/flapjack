import 'package:flapjack/flapjack.dart';
import 'package:flutter/material.dart';

import 'home_view_model.dart';

class ActionButton extends FlapjackViewModelWidget<HomeViewModel> {
  const ActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return viewModel.isLoading
        ? const CircularProgressIndicator()
        : FloatingActionButton(
      onPressed: () => viewModel.increment(2),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}