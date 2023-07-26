import 'package:flapjack/flapjack.dart';

void main() {

}

class TestClass {

  @AsyncLoader()
  Future someFutureMethod() async {
    Future.delayed(300.ms, () => print('my async print'));
  }
}

extension Tests on int {
  Duration get ms => Duration(milliseconds: this);
}