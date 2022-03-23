import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';

Future fetchWeather({required String city}) async {
  await Future.delayed(const Duration(seconds: 1));

  return city == "London" ? 'London: 25°C' : '$city: 20°C';
}

final cityProvider = Provider((ref) => 'Rio');

final weatherProvider = FutureProvider((ref) async {
  final city = ref.watch(cityProvider);

  return fetchWeather(city: city);
});

class CombiningProviderStateScreen extends ConsumerWidget {
  const CombiningProviderStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Combining Provider State'),
      ),
      body: Center(
        child: weather.when(
          data: (data) => CustomTextWidget(data.toString()),
          error: (error, stack) => CustomTextWidget('Error: $error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
