import 'package:flutter/services.dart';
import 'package:zau_layer_first/app/theme/colors.dart';
import 'package:zau_layer_first/modules/feature/home/home_bloc.dart';
import 'package:zau_layer_first/modules/feature/home/home_state.dart';
import 'package:zau_layer_first/shared/utils/helper.dart';
import 'package:zau_layer_first/shared/widgets/inputs/custom_elevated_button.dart';
import 'package:zau_layer_first/shared/widgets/inputs/custom_text_input.dart';
import 'package:zau_layer_first/shared/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late HomeBloc _bloc;
  final inputController = TextEditingController();
  final inputFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  bool isValid = true;
  bool obscurePin = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bloc = HomeBloc()..getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeErrorState) {
                showTopSnackBar(
                  Overlay.of(context),
                  AppToast(message: state.result.message, isSuccess: true),
                );
              }
              if (state is HomeLoadedState) {}
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            backgroundColor: AppColor.colorPrimary,
            shadowColor: AppColor.colorDark,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                current is HomeLoadingState || current is HomeLoadedState,
            builder: (context, state) {
              if (state is HomeLoadedState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    Future.sync(() => _bloc.getData());
                  },

                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Welcome to Home Screen',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        CustomTextInput(
                          key: const Key('inputPrimary'),
                          inputLabel: 'Enter your number',
                          inputHint: 'Enter your number',
                          textEditingController: inputController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.send,
                          focusNode: inputFocusNode,
                          isRequired: true,
                          inputFormatter: [
                            filterEmoji,
                            FilteringTextInputFormatter.deny(" "),
                            // allow float number and negative number
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[-0-9.,]'),
                            ),
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
                            if (value == null || value!.isEmpty) {
                              return 'Enter your number, it`s should not be empty';
                            }
                            if (!isValid) {
                              return 'Enter your number, it`s not valid';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomElevatedButton(
                          buttonTitle: 'Submit',
                          textColor: Colors.white,
                          onPressed: () {
                            _bloc.validateNumber(inputController.text);
                          },
                        ),
                        const SizedBox(height: 16),
                        if (state.numberTests != null) ...[
                          Text(
                            'Reverse: ${state.numberTests!.reverse}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Difference: ${state.numberTests!.difference}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
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
