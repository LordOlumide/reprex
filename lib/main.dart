import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/home',
        routes: [
          ShellRoute(
            navigatorKey: _homeNavKey,
            builder: (context, state, child) => Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: child,
                ),
                // Bottom nav bar
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(height: 60, color: Colors.red),
                ),
              ],
            ),
            routes: [
              GoRoute(
                path: '/home',
                parentNavigatorKey: _homeNavKey,
                builder: (context, state) => const MainView(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Text('Open drawer'),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => onOpenDialogPressed(context),
            child: const Text('Open dialog'),
          ),
        ],
      ),
    );
  }

  Future<void> onOpenDialogPressed(BuildContext context) async {
    late final bool? value;

    if (context.mounted) {
      value = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => context.pop(false),
                  child: const Text('Pop with "false"'),
                ),
                ElevatedButton(
                  onPressed: () => context.pop(true),
                  child: const Text('Pop with "true"'),
                ),
              ],
            ),
          );
        },
      );
    }
    print('Value is: $value');
    if (value == null) {
      return;
    }

    if (context.mounted) {
      print("Run more async functions");
    }
  }
}
