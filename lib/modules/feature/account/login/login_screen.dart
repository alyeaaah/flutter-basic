import 'package:zau_layer_first/core/context_extension.dart';
import 'package:zau_layer_first/modules/domain/usecases/get_user_login_usecase.dart';
import 'package:zau_layer_first/modules/feature/account/login/login_bloc.dart';
import 'package:zau_layer_first/modules/feature/account/login/login_state.dart';
import 'package:zau_layer_first/modules/feature/home/home_screen.dart';
import 'package:zau_layer_first/shared/utils/helper.dart';
import 'package:zau_layer_first/shared/widgets/app_toast.dart';
import 'package:zau_layer_first/shared/widgets/inputs/custom_elevated_button.dart';
import 'package:zau_layer_first/shared/widgets/inputs/custom_pass_input.dart';
import 'package:zau_layer_first/shared/widgets/inputs/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zau_layer_first/app/theme/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/account';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  late LoginBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  bool isValid = true;
  bool obscurePin = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bloc = LoginBloc(loginUseCase: GetUserLoginUseCase());
    _bloc.validateView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                showTopSnackBar(
                  Overlay.of(context),
                  AppToast(message: state.result.message, isSuccess: true),
                );
              }
              if (state is LoginLoadedState) {
                if (state.username != null) {
                  showTopSnackBar(
                    Overlay.of(context),
                    AppToast(message: "Login berhasil", isSuccess: true),
                  );
                  GoRouter.of(context).go(HomeScreen.routeName);
                }
              }
            },
          ),
        ],
        child: Scaffold(
          body: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                current is LoginLoadingState || current is LoginLoadedState,
            builder: (context, state) {
              if (state is LoginLoadedState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _bloc.validateView();
                  },
                  child: Scaffold(
                    body: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            // Forces the inner container to take up at least the full height of the screen
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 32),
                                      Text(
                                        'Login',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Enter your username and password to login.',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                      const SizedBox(height: 28),
                                      CustomTextInput(
                                        key: const Key('username'),
                                        inputLabel: 'Username',
                                        inputHint: 'Username',
                                        textEditingController:
                                            usernameController,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        focusNode: usernameFocusNode,
                                        isRequired: true,
                                        inputFormatter: [
                                          filterEmoji,
                                          FilteringTextInputFormatter.deny(" "),
                                          LengthLimitingTextInputFormatter(32),
                                        ],
                                        fieldSubmit: () {
                                          passwordFocusNode.requestFocus();
                                        },
                                        onChanged: (_) {
                                          if (isValid == false) {
                                            setState(() {
                                              isValid = true;
                                            });
                                          }
                                        },
                                        validator: (value) {
                                          appLog('value => $value');

                                          if (value == null || value!.isEmpty) {
                                            return 'Username should not be empty';
                                          }
                                          if (!isValid) {
                                            return 'Username is not valid';
                                          }

                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      CustomPassInput(
                                        inputLabel: "Password",
                                        inputHint: 'Password',
                                        textEditingController:
                                            passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        textInputAction: TextInputAction.next,
                                        obscureText: obscurePin,
                                        alwaysFloatLabel: true,
                                        isRequired: true,
                                        inputFormatters: [
                                          filterEmoji,
                                          FilteringTextInputFormatter.deny(" "),
                                          LengthLimitingTextInputFormatter(32),
                                        ],
                                        focusNode: passwordFocusNode,
                                        onSuffixIconPressed: () => setState(() {
                                          obscurePin = !obscurePin;
                                        }),
                                        onChanged: (_) {
                                          _bloc.validateView();
                                        },
                                        fieldSubmit: () {},
                                        validator: (value) {
                                          if (value.toString().isNotEmpty &&
                                              value.toString().length < 6) {
                                            return "Password length should be at least 6 characters";
                                          }

                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      CustomElevatedButton(
                                        buttonTitle: 'Login',
                                        textColor: Colors.white,
                                        onPressed: () {
                                          _bloc.login(
                                            usernameController.text,
                                            passwordController.text,
                                          );
                                        },
                                      ),

                                      // This Spacer pushes everything below it to the absolute bottom
                                      // of the viewport if there is extra room.
                                      const Spacer(),

                                      const SizedBox(height: 16),
                                      Center(
                                        child: Text(
                                          "Versi 0.1",
                                          style: context.textTheme.labelSmall
                                              ?.copyWith(
                                                color: AppColor.colorDark,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
