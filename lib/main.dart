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
        initialLocation: '/',
        redirect: (context, state) {
          return null;
        },
        routes: [
          ShellRoute(
            navigatorKey: _homeNavKey,
            builder: (context, state, child) => child,
            routes: [
              GoRoute(
                path: '/',
                parentNavigatorKey: _homeNavKey,
                builder: (context, state) => const HomeView(),
              ),
              GoRoute(
                path: '/screen1',
                parentNavigatorKey: _homeNavKey,
                onExit: (context) {
                  print('================= Exiting ========================');
                  context.go('/');
                  return true;
                },
                builder: (context, state) => const Screen1(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/screen1'),
          child: const Text('Go forward'),
        ),
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('============ onWillPop triggered ================');
        context.go('/');
        return false;
      },
      child: const Scaffold(
        backgroundColor: Colors.green,
      ),
    );
  }
}
