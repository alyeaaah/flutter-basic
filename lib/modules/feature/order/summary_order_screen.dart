import 'package:zau_layer_first/core/context_extension.dart';
import 'package:zau_layer_first/modules/feature/order/summary_order_bloc.dart';
import 'package:zau_layer_first/modules/feature/order/summary_order_state.dart';

import 'package:zau_layer_first/shared/widgets/app_toast.dart';
import 'package:zau_layer_first/shared/widgets/inputs/custom_elevated_button.dart';
import 'package:zau_layer_first/shared/widgets/inputs/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zau_layer_first/app/theme/colors.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SummaryOrderScreen extends StatefulWidget {
  static const routeName = '/order';
  const SummaryOrderScreen({super.key});

  @override
  SummaryOrderScreenState createState() => SummaryOrderScreenState();
}

class SummaryOrderScreenState extends State<SummaryOrderScreen>
    with WidgetsBindingObserver {
  late SummaryOrderBloc _bloc;
  final TextEditingController _orderNumberController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bloc = SummaryOrderBloc()..fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SummaryOrderBloc>(
      create: (context) => _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<SummaryOrderBloc, SummaryOrderState>(
            listener: (context, state) {
              if (state is SummaryOrderErrorState) {
                showTopSnackBar(
                  Overlay.of(context),
                  AppToast(message: state.result.message, isSuccess: true),
                );
              }
              if (state is SummaryOrderLoadedState) {}
            },
          ),
        ],
        child: Scaffold(
          body: BlocBuilder<SummaryOrderBloc, SummaryOrderState>(
            buildWhen: (previous, current) =>
                current is SummaryOrderLoadingState ||
                current is SummaryOrderLoadedState,
            builder: (context, state) {
              if (state is SummaryOrderLoadedState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    Future.sync(() => _bloc.fetchOrder());
                  },
                  child: Scaffold(
                    // physics: const BouncingScrollPhysics(),
                    body: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.colorDark),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const Expanded(child: SizedBox()),
                          Text(
                            "Find Your Order",
                            style: context.textTheme.titleLarge?.copyWith(
                              color: AppColor.colorDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Enter your order number to find your order",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColor.colorDark,
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextInput(
                            inputLabel: "Order Number",
                            inputHint: "Enter your order number",
                            textEditingController: _orderNumberController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            focusNode: focusNode,
                            fieldSubmit: () {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Order number is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomElevatedButton(
                            buttonTitle: "Find Order",
                            onPressed: () {
                              // route to order detail
                            },
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
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
