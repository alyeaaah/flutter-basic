import 'package:zau_layer_first/app/theme/colors.dart';
import 'package:zau_layer_first/shared/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'splash_bloc.dart';
import 'splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SplashBloc()..checkIfUserLoggedIn();

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashErrorState) {
                showTopSnackBar(
                  Overlay.of(context),
                  AppToast(message: state.result.message, isSuccess: false),
                );
              }
              if (state is SplashLoadedState) {
                context.go('/home');

                if (state.authKey != null) {
                  context.go('/home');
                } else {
                  // context.go(LoginScreen.routeName);
                }
              }
              if (state is SplashSaveDeviceState) {
                context.go('/home');
              }
            },
          ),
        ],
        child: Scaffold(
          key: const Key('splashScreen'),
          body: Container(
            color: AppColor.colorPrimary,

            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("zau", style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        ),
      ),
    );
  }
}
