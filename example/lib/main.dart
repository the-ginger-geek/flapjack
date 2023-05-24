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
            const OtherButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModel() {
    return HomeViewModel(HomeModel());
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

class OtherButton extends FlapjackView<OtherButtonViewModel> {
  const OtherButton({super.key});

  @override
  Widget build(BuildContext context, viewModel) {
    return FloatingActionButton(
      onPressed: viewModel.increment,
      tooltip: 'Increment',
      backgroundColor: Colors.amber,
      foregroundColor: Colors.white,
      child: const Icon(
        Icons.add,
      ),
    );
  }

  @override
  viewModel() {
    return OtherButtonViewModel(OtherButtonModel());
  }
}

class OtherButtonViewModel extends FlapjackViewModel<OtherButtonModel> {
  OtherButtonViewModel(super.model);

  void increment() {
    getViewModel<HomeViewModel>()?.increment();
  }
}

class OtherButtonModel extends FlapjackModel {}
