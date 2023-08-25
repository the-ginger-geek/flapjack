import 'package:flapjack/flapjack.dart';
import 'package:flutter/material.dart';

import 'button.dart';
import 'home_view_model.dart';

class Home extends FlapjackView<HomeViewModel> {
  final String title;

  const Home({super.key, this.title = ''});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${viewModel.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecrementButton(),
          SizedBox(width: 8.0),
          IncrementButton(),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModel() => HomeViewModel(HomeModel());
}