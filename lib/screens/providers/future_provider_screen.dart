import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';

Future<String> _fetchData() async {
  await Future.delayed(
    const Duration(seconds: 1),
  );
  return 'Data loaded successfully';
}

final futureProvider = FutureProvider<String>((ref) async => _fetchData());

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(futureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: Center(
        child: data.when(
          data: (data) => CustomTextWidget(data),
          error: (error, stack) => CustomTextWidget(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
