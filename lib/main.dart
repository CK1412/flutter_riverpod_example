import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/screens/modifiers/auto_dispose_modifier_screen.dart';
import 'package:riverpod_tutorial/screens/modifiers/family_primitive_modifier_screen.dart';
import 'package:riverpod_tutorial/screens/notifiers/change_notifier_provider_screen.dart';
import 'package:riverpod_tutorial/screens/providers/combining_provider_states_screen.dart';
import 'package:riverpod_tutorial/screens/providers/future_provider_screen.dart';
import 'package:riverpod_tutorial/screens/providers/provider_screen.dart';
import 'package:riverpod_tutorial/screens/providers/state_provider_screen.dart';
import 'package:riverpod_tutorial/widgets/custom_button_widget.dart';

import 'screens/modifiers/family_object_modifier_screen.dart';
import 'screens/notifiers/state_notifier_provider_screen.dart';
import 'screens/providers/stream_provider_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexScreen = 0;
  late List<Widget> screens;
  @override
  void initState() {
    super.initState();
    screens = [
      buildProvidersScreen(),
      buildModifiersScreen(),
      buildNotifiersScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod tutorial'),
      ),
      body: Center(child: screens[_indexScreen]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.cover,
              width: 30,
            ),
            label: 'Providers',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.cover,
              width: 30,
            ),
            label: 'Notifiers',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.cover,
              width: 30,
            ),
            label: 'Modifiers',
          ),
        ],
        currentIndex: _indexScreen,
        onTap: (newIndex) => setState(() {
          _indexScreen = newIndex;
        }),
      ),
    );
  }

  Widget buildProvidersScreen() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonWidget(
            text: 'Provider',
            onPressed: () => navigateTo(context, const ProviderScreen()),
          ),
          CustomButtonWidget(
            text: 'State Provider',
            onPressed: () => navigateTo(context, const StateProviderScreen()),
          ),
          CustomButtonWidget(
            text: 'Future Provider',
            onPressed: () => navigateTo(context, const FutureProviderScreen()),
          ),
          CustomButtonWidget(
            text: 'Stream Provider',
            onPressed: () => navigateTo(context, const StreamProviderScreen()),
          ),
          CustomButtonWidget(
            text: 'Combining Provider State',
            onPressed: () => navigateTo(
              context,
              const CombiningProviderStateScreen(),
            ),
          ),
        ],
      );

  Widget buildModifiersScreen() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonWidget(
            text: 'autoDispose',
            onPressed: () =>
                navigateTo(context, const AutoDisposeModifierScreen()),
          ),
          CustomButtonWidget(
            text: 'family primitive',
            onPressed: () =>
                navigateTo(context, const FamilyPrimitiveModifierScreen()),
          ),
          CustomButtonWidget(
            text: 'family object',
            onPressed: () =>
                navigateTo(context, const FamilyObjectModifierScreen()),
          ),
        ],
      );

  Widget buildNotifiersScreen() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonWidget(
            text: 'Change Notifier Provider',
            onPressed: () =>
                navigateTo(context, const ChangeNotifierProviderScreen()),
          ),
          CustomButtonWidget(
            text: 'State Notifier Provider',
            onPressed: () =>
                navigateTo(context, const StateNotifierProviderScreen()),
          ),
        ],
      );

  navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => screen,
    ));
  }
}
