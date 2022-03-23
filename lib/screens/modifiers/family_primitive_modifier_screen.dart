import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/screens/modifiers/user.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';
import 'package:riverpod_tutorial/widgets/user_widget.dart';

Future<User> _fetchUser(String username) async {
  await Future.delayed(const Duration(seconds: 1));
  return users.firstWhere((element) => element.name == username);
}

final userProvider = FutureProvider.family<User, String>((ref, username) async {
  return _fetchUser(username);
});

class FamilyPrimitiveModifierScreen extends StatefulWidget {
  const FamilyPrimitiveModifierScreen({Key? key}) : super(key: key);

  @override
  _FamilyPrimitiveModifierScreenState createState() =>
      _FamilyPrimitiveModifierScreenState();
}

class _FamilyPrimitiveModifierScreenState
    extends State<FamilyPrimitiveModifierScreen> {
  String _username = users.first.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family primitive modifier'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
                alignment: Alignment.center,
                child: Consumer(
                  builder: (context, ref, child) {
                    final future = ref.watch(userProvider(_username));
                    return future.when(
                      data: (data) => UserWidget(user: data),
                      error: (error, stack) =>
                          CustomTextWidget('Error: $error'),
                      loading: () => const CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              buildFilter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilter() => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidget('Filter'),
            ListTile(
              title: const Text('Username'),
              trailing: buildDropdownButton(),
            )
          ],
        ),
      );

  Widget buildDropdownButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true, //Reduce the button's height.
          value: _username,
          items: users
              .map(
                (user) => DropdownMenuItem<String>(
                  value: user.name,
                  child: Text(user.name),
                ),
              )
              .toList(),
          onChanged: (value) => setState(() {
            _username = value.toString();
          }),
        ),
      ),
    );
  }
}
