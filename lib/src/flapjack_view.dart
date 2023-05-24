// Abstract View
import 'package:flutter/material.dart';

import '../flapjack.dart';

abstract class FlapjackView<M extends FlapjackViewModel> extends StatefulWidget {
  const FlapjackView({Key? key}) : super(key: key);

  M viewModel();

  Widget build(BuildContext context, M viewModel);

  @override
  FlapjackViewState<M> createState() => FlapjackViewState<M>();
}

final class FlapjackViewState<M extends FlapjackViewModel> extends State<FlapjackView<M>> {
  late M viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel..registerViewModelLocator(Flapjack.of(context)?.locator),
      builder: (context, child) {
        return widget.build(context, viewModel);
      },
    );
  }
}