import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/widgets/custom_button_widget.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';

class Car {
  // All properties should be `final` on our class.
  final int speed;
  final int doors;

  Car({
    this.speed = 30,
    this.doors = 4,
  });

  // Since Car is immutable, we implement a method that allows cloning the
  // Car with slightly different content.
  Car copy({int? speed, int? doors}) => Car(
        speed: speed ?? this.speed,
        doors: doors ?? this.doors,
      );
}

class CarNotifier extends StateNotifier<Car> {
  // We initialize the car to Car(30, 4)
  CarNotifier() : super(Car());

  setDoors(int doors) {
    // Again, our state is immutable. So we're making a new car instead of
    // changing the existing car.
    final newState = state.copy(doors: doors);
    state = newState;
  }

  increaseSpeed() {
    final speed = state.speed + 5;
    final newState = state.copy(speed: speed);
    state = newState;
  }

  hitBreak() {
    final speed = max(0, state.speed - 30);
    final newState = state.copy(speed: speed);
    state = newState;
  }
}

final stateNotifierProvider =
    StateNotifierProvider<CarNotifier, Car>((ref) => CarNotifier());

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.watch(stateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextWidget('Speed: ${car.speed}'),
            const SizedBox(
              height: 10,
            ),
            CustomTextWidget('Doors: ${car.doors}'),
            CustomButtonWidget(
              text: 'Increase: + 5',
              onPressed: () =>
                  ref.read(stateNotifierProvider.notifier).increaseSpeed(),
            ),
            CustomButtonWidget(
              text: 'Hit break: - 30',
              onPressed: () =>
                  ref.read(stateNotifierProvider.notifier).hitBreak(),
            ),
            Slider(
              value: car.doors.toDouble(),
              onChanged: (value) =>
                  ref.read(stateNotifierProvider.notifier).setDoors(
                        value.toInt(),
                      ),
              max: 5,
            )
          ],
        ),
      ),
    );
  }
}
