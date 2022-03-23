import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';

Future<String> fetchValue() async {
  await Future.delayed(const Duration(seconds: 1));

  return 'State will be dispose!';
}

// add autoDispose
final futureProvider =
    FutureProvider.autoDispose<String>((ref) async => fetchValue());

class AutoDisposeModifierScreen extends ConsumerWidget {
  const AutoDisposeModifierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(futureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('autoDispose Modifier'),
      ),
      body: Center(
        child: future.when(
          data: (data) => CustomTextWidget(data),
          error: (error, stack) => CustomTextWidget('Error: $error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
