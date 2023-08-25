import 'package:flapjack/flapjack.dart';
import 'package:flutter/material.dart';

class FlapjackLoader<T extends FlapjackViewModel>
    extends FlapjackViewModelWidget<T> {
  const FlapjackLoader({
    super.key,
    required this.child,
    this.loadingKey,
    this.progressIndicator,
    this.crossFadeDuration,
  });

  final Widget child;
  final Widget? progressIndicator;
  final String? loadingKey;
  final int? crossFadeDuration;

  @override
  Widget build(BuildContext context, T viewModel) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: crossFadeDuration ?? 300),
      child: (loadingKey?.isNotEmpty ?? false
          ? viewModel.isWidgetLoading(loadingKey!)
          : viewModel.isLoading) ? progressIndicator ??
          const CircularProgressIndicator() : child,
    );
  }
}
