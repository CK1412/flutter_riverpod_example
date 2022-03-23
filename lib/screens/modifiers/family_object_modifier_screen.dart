import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/screens/modifiers/user.dart';
import 'package:riverpod_tutorial/widgets/custom_text_widget.dart';
import 'package:riverpod_tutorial/widgets/user_widget.dart';

class UserRequest {
  final bool isFemale;
  final int minAge;

  const UserRequest({
    required this.isFemale,
    required this.minAge,
  });

  // replace default comparison method
  // Support comparing 2 similar objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRequest &&
          runtimeType == other.runtimeType &&
          isFemale == other.isFemale &&
          minAge == other.minAge;

  // according to docs we override operator ==
  //! we SHOULD also override the hashCode method
  // it will help to work properly in any case
  @override
  int get hashCode => isFemale.hashCode ^ minAge.hashCode;
}

Future<User> _fetchUser(UserRequest userRequest) async {
  await Future.delayed(const Duration(seconds: 1));

  final gender = userRequest.isFemale ? Gender.female : Gender.male;

  return users.firstWhere(
    (user) => user.gender == gender && user.age >= userRequest.minAge,
  );
}

final userProvider = FutureProvider.family<User, UserRequest>(
  (ref, userRequest) async => _fetchUser(userRequest),
);

class FamilyObjectModifierScreen extends StatefulWidget {
  const FamilyObjectModifierScreen({Key? key}) : super(key: key);

  @override
  _FamilyObjectModifierScreenState createState() =>
      _FamilyObjectModifierScreenState();
}

class _FamilyObjectModifierScreenState
    extends State<FamilyObjectModifierScreen> {
  static final _ages = [16, 26, 35, 50];
  bool _isFemale = true;
  int _minAge = _ages.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Object Modifier'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
                alignment: Alignment.center,
                child: Consumer(
                  builder: (context, ref, child) {
                    final userRequest = UserRequest(
                      isFemale: _isFemale,
                      minAge: _minAge,
                    );

                    final user = ref.watch(userProvider(userRequest));

                    return user.when(
                      data: (data) => UserWidget(user: data),
                      error: (error, stack) =>
                          const CustomTextWidget('Not Found'),
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
              title: const Text('Female'),
              trailing: buildGenderSwitch(),
            ),
            ListTile(
              title: const Text('Age'),
              trailing: buildAgeDropdownButton(),
            )
          ],
        ),
      );
  Widget buildAgeDropdownButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isDense: true, //Reduce the button's height.
          value: _minAge,
          items: _ages
              .map(
                (age) => DropdownMenuItem<int>(
                  value: age,
                  child: Text(age.toString()),
                ),
              )
              .toList(),
          onChanged: (value) => setState(() {
            _minAge = value!;
          }),
        ),
      ),
    );
  }

  Widget buildGenderSwitch() => Switch(
        value: _isFemale,
        onChanged: (value) => setState(() {
          _isFemale = value;
        }),
      );
}
