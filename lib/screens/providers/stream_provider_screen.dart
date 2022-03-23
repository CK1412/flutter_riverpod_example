import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';

// StreamProvider.autoDispose: destroys state if no-longer listened
final streamProvider = StreamProvider<String>((ref) => Stream.periodic(
      const Duration(milliseconds: 500),
      (count) => '$count',
    ));

class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stream Provider'),
        ),
        body: Center(
          //* use "Consumer" instead of "extends ConsumerWidget". It's also good
          child: Consumer(
            builder: (context, ref, child) {
              final stream = ref.watch(streamProvider);
              return stream.when(
                data: (data) => CustomTextWidget(data),
                error: (error, stack) => CustomTextWidget(error.toString()),
                loading: () => const CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
