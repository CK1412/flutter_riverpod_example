import 'package:flutter/material.dart';

import '../screens/modifiers/user.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        CircleAvatar(
          radius: screenSize.width * .15,
          backgroundImage: NetworkImage(user.urlAvater),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(width: screenSize.width * .15),
            buildTitle('Username: '),
            buildContent(user.name),
          ],
        ),
        Row(
          children: [
            SizedBox(width: screenSize.width * .15),
            buildTitle('Age: '),
            buildContent(user.age.toString()),
          ],
        ),
        Row(
          children: [
            SizedBox(width: screenSize.width * .15),
            buildTitle('Gender: '),
            buildContent(user.gender.name),
          ],
        ),
      ],
    );
  }

  Widget buildContent(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
    );
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
