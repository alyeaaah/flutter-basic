import 'package:zau_layer_first/app/app_state.dart';
import 'package:zau_layer_first/modules/domain/usecases/get_user_login_usecase.dart';
import 'package:zau_layer_first/modules/feature/account/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';
import 'package:zau_layer_first/app/routes/app_router.dart';
import 'theme/theme.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _message = '';

  @override
  void initState() {
    super.initState();
  }

  void setMessage(String message) {
    setState(() {
      _message = message;
      debugPrint("AppState message $_message");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (context) =>
                  LoginBloc(loginUseCase: GetUserLoginUseCase()),
            ),
          ],
          child: AppState(
            setMessage: setMessage,
            child: OverlaySupport.global(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Created by Zau',
                theme: appTheme,
                routerConfig: AppRouter.router,
              ),
            ),
          ),
        );
      },
    );
  }
}
