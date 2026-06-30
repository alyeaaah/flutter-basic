import 'package:zau_layer_first/core/context_extension.dart';
import 'package:zau_layer_first/modules/domain/usecases/get_user_name_usecase.dart';
import 'package:zau_layer_first/modules/feature/account/profile/profile_bloc.dart';
import 'package:zau_layer_first/modules/feature/account/profile/profile_state.dart';
import 'package:zau_layer_first/shared/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zau_layer_first/app/theme/colors.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  late ProfileBloc _bloc;
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
    _bloc = ProfileBloc(getUserByUsernameUseCase: GetUserByUsernameUseCase());
    _bloc.validateView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileErrorState) {
                showTopSnackBar(
                  Overlay.of(context),
                  AppToast(message: state.result.message, isSuccess: true),
                );
              }
              if (state is ProfileLoadedState) {}
            },
          ),
        ],
        child: Scaffold(
          body: BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) =>
                current is ProfileLoadingState || current is ProfileLoadedState,
            builder: (context, state) {
              if (state is ProfileLoadedState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    Future.sync(() => _bloc.validateView());
                  },
                  child: Scaffold(
                    // physics: const BouncingScrollPhysics(),
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 32),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    'Profile',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Hi ${_bloc.username.isNotEmpty ? _bloc.username : " User"}.',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 28),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            "Versi 0.1",
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColor.colorDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
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
