import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/widgets/custom_button_widget.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';

class Car extends ChangeNotifier {
  int _speed = 100;
  int get speed => _speed;

  increase() {
    _speed += 5;
    notifyListeners();
  }

  hitBreak() {
    _speed = max(0, _speed - 30);
    notifyListeners();
  }
}

final carProvider = ChangeNotifierProvider<Car>((ref) => Car());

class ChangeNotifierProviderScreen extends ConsumerWidget {
  const ChangeNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.watch(carProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextWidget('Speed: ${car.speed}'),
            CustomButtonWidget(
              text: 'Increase: + 5',
              onPressed: () => car.increase(),
            ),
            CustomButtonWidget(
              text: 'Hit break: - 30',
              onPressed: () => car.hitBreak(),
            ),
          ],
        ),
      ),
    );
  }
}
