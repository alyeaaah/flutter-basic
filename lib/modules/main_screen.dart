import 'package:zau_layer_first/modules/domain/usecases/get_user_name_usecase.dart';
import 'package:zau_layer_first/modules/feature/account/profile/profile_bloc.dart';
import 'package:zau_layer_first/modules/feature/account/profile/profile_screen.dart';
import 'package:zau_layer_first/modules/feature/order/summary_order_screen.dart';
import 'package:zau_layer_first/modules/feature/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zau_layer_first/app/theme/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.location});

  final String location;

  static List<Widget> bottomNavPages = [
    const HomeScreen(),
    const SummaryOrderScreen(),
    const ProfileScreen(),
  ];
  static List<NavBarItem> tabs = [
    NavBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home_outlined),
      label: 'Home',
      initialLocation: 'home',
    ),
    NavBarItem(
      icon: Icon(Icons.shopping_cart),
      activeIcon: Icon(Icons.shopping_cart_outlined),
      label: 'Order',
      initialLocation: 'order',
    ),
    NavBarItem(
      icon: Icon(Icons.person),
      activeIcon: Icon(Icons.person_outlined),
      label: 'Profile',
      initialLocation: 'profile',
    ),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<ProfileBloc>(
        create: (context) =>
            ProfileBloc(getUserByUsernameUseCase: GetUserByUsernameUseCase()),
        child: Scaffold(
          body: IndexedStack(
            //change indexed stack
            index: widget.location == 'home'
                ? 0
                : widget.location == 'order'
                ? 1
                : widget.location == 'profile'
                ? 2
                : 3,
            children: MainScreen.bottomNavPages,
          ),
          bottomNavigationBar: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            height: 64,
            child: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(
                color: AppColor.colorPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                color: AppColor.colorGrey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              showUnselectedLabels: true,
              iconSize: 24,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                _goOtherTab(context, index);
              },
              currentIndex: widget.location == 'home'
                  ? 0
                  : widget.location == 'order'
                  ? 1
                  : widget.location == 'profile'
                  ? 2
                  : 3,
              items: MainScreen.tabs,
            ),
          ),
        ),
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (MainScreen.tabs[index].initialLocation == widget.location) return;
    GoRouter router = GoRouter.of(context);
    String newLocation = MainScreen.tabs[index].initialLocation;

    router.go("/$newLocation");
  }
}

class NavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const NavBarItem({
    super.key,
    required this.initialLocation,
    required super.icon,
    required super.label,
    Widget? activeIcon,
  }) : super(activeIcon: activeIcon ?? icon);
}
