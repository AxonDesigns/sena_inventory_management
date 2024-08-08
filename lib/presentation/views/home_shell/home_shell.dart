import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/models/models.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeShell> {
  int _selected = 0;
  final _navRailSize = 45.0;
  final _navRailGap = 5.0;
  User? _user;
  final _routes = [dashboardRoute, productsRoute, stockRoute, transactionsRoute, employeesRoute];

  @override
  void initState() {
    super.initState();
    final router = ref.read(appRouterProvider);
    final currentPath = router.currentPath;
    ref.read(authProvider).user.then((value) {
      setState(() {
        _user = value;
      });
    });
    setState(() {
      _selected = _routes.indexOf(currentPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(left: _navRailSize + (_navRailGap * 4), child: widget.child),
          Positioned(
            top: 0.0,
            bottom: 0.0,
            left: 0.0,
            child: NavRail(
              gap: _navRailGap,
              size: _navRailSize,
              maxWidth: _navRailSize * 5,
              selected: _selected,
              onItemSelected: (index) {
                setState(() => _selected = index);
                ref.read(appRouterProvider).go(_routes[index]);
              },
              items: const [
                NavRailItem(
                  title: "Dashboard",
                  icon: FluentIcons.data_bar_vertical_20_filled,
                ),
                NavRailItem(
                  title: "Products",
                  icon: FluentIcons.box_16_filled,
                ),
                NavRailItem(
                  title: "Stock",
                  icon: FluentIcons.box_16_filled,
                ),
                NavRailItem(
                  title: "Transactions",
                  icon: FluentIcons.shopping_bag_16_filled,
                ),
                NavRailItem(
                  title: "Employees",
                  icon: FluentIcons.person_16_filled,
                ),
              ],
              header: (minSize, maxSize, gap, isOpen) {
                return NavRailWidget(
                  minSize: minSize,
                  maxSize: maxSize,
                  gap: gap,
                  icon: Image.asset(
                    'assets/images/sena_logo.png',
                    color: context.colorScheme.onSurface,
                    isAntiAlias: true,
                    filterQuality: FilterQuality.high,
                    width: 32.0,
                  ),
                  content: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Inventory Management",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Satoshi',
                        height: 1.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
              footer: (minSize, maxSize, gap, isOpen) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: isOpen ? 1.0 : 0.0),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  builder: (context, value, child) => NavRailWidget(
                    height: value.lerp(1.0, 2.0),
                    padding: const EdgeInsets.only(right: 4.0, top: 8.0, bottom: 8.0),
                    crossAxisAlignment: CrossAxisAlignment.end,
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            "assets/images/user_img.jpg",
                            fit: BoxFit.cover,
                            color: Colors.white,
                            colorBlendMode: BlendMode.hue,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: context.colorScheme.primary.withOpacity(value.lerp(1.0, 0.65)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainerHighest,
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: const [0.0, 1.0],
                              colors: [
                                context.colorScheme.surfaceContainerHighest,
                                context.colorScheme.surfaceContainerHighest.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    icon: const Icon(FluentIcons.person_16_filled, size: 16.0),
                    content: child!,
                    minSize: minSize,
                    maxSize: maxSize,
                    gap: gap,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user?.fullName ?? "<unknown>",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              _user?.role.name ?? "<unknown>",
                              style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w300, letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      Button.ghost(
                        onPressed: () {
                          ref.read(authProvider).signOut();
                          ref.read(appRouterProvider).go(loginRoute);
                        },
                        tooltip: "Sign Out",
                        children: const [Icon(FluentIcons.arrow_exit_20_filled)],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
