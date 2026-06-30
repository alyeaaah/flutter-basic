import 'package:zau_layer_first/app/theme/colors.dart';
import 'package:zau_layer_first/modules/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zau_layer_first/app/main_widget.dart';
import 'package:zau_layer_first/modules/feature/account/splash/splash_screen.dart';
import 'package:zau_layer_first/modules/feature/account/login/login_screen.dart';

class AppRouter {
  static const root = '/';

  static final GoRouter _router = GoRouter(
    errorBuilder: ((context, state) => const MainWidget(child: OnNotFound())),
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainWidget(child: SplashScreen()),
      ),

      GoRoute(
        path: LoginScreen.routeName,
        name: LoginScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: MainWidget(child: LoginScreen()),
            barrierDismissible: true,
            barrierColor: Colors.black38,
            opaque: false,
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder:
                (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) {
                  return FadeTransition(opacity: animation, child: child);
                },
          );
        },
      ),

      GoRoute(
        path: '/:location(home|order|profile)',
        name: '/:location(home|order|profile)',
        pageBuilder: (context, state) {
          final String location = state.pathParameters['location'].toString();
          return NoTransitionPage(
            child: MainWidget(child: MainScreen(location: location)),
          );
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}

class OnNotFound extends StatelessWidget {
  const OnNotFound({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    GoRouter.of(context).pushReplacement('/home');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // block default back
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _onWillPop(context); // your custom logic
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Oops! Page Not Found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'We are sorry, but the page you are looking for does not exist.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.colorPrimary,
                ),
                onPressed: () => GoRouter.of(context).pushReplacement('/home'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Back to Home',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
