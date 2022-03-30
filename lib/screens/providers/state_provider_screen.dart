import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/widgets/custom_button_widget.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';

final stateProvider = StateProvider<int>((ref) => 0);

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(stateProvider);

    // Listening to Provider State Changes
    ref.listen(
      stateProvider,
      (previous, next) {
        // note: this callback executes when the provider value changes,
        // not when the build method is called
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.toString())),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextWidget(counter.toString()),
            const SizedBox(
              height: 20,
            ),
            CustomButtonWidget(
              text: '+1',
              onPressed: () {
                // We're updating the state from the previous value
                ref.read(stateProvider.notifier).update((state) => state + 1);
              },
            ),
            CustomButtonWidget(
              text: '-1',
              onPressed: () {
                // other way
                ref.read(stateProvider.notifier).state--;
              },
            ),
          ],
        ),
      ),
    );
  }
}
