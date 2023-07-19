import 'package:flutter/material.dart';
import 'package:flapjack/flapjack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Flapjack(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

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
      floatingActionButton: const ActionButton(),
    );
  }

  @override
  HomeViewModel viewModel() {
    return HomeViewModel(HomeModel());
  }
}

class ActionButton extends FlapjackViewModelWidget<HomeViewModel> {
  const ActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return FloatingActionButton(
      onPressed: viewModel.increment,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

class HomeViewModel extends FlapjackViewModel<HomeModel> {
  HomeViewModel(super.model);

  int get counter => model.counter;

  void increment() {
    model.counter++;
    notifyListeners();
  }
}

class HomeModel extends FlapjackModel {
  int counter = 0;
}
