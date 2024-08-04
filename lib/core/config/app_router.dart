import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

const String homeRoute = '/';
const String loginRoute = '/login';
const String forgotPasswordRoute = '/forgot-password';
const String dashboardRoute = '/dashboard';
const String stockRoute = '/stock';
const String transactionsRoute = '/transactions';
const String employeesRoute = '/employees';

GoRouter appRouter<T>(ProviderRef<T> ref) {
  return GoRouter(
    initialLocation: dashboardRoute,
    routes: [
      GoRoute(
        path: homeRoute,
        redirect: (context, state) => dashboardRoute,
      ),
      ShellRoute(
          builder: (context, state, child) => Material(
                key: state.pageKey,
                child: DialogOverlay(child: child),
              ),
          routes: [
            ShellRoute(
              pageBuilder: (context, state, child) => WindowPage(
                key: state.pageKey,
                child: HomeShell(
                  child: child,
                ),
              ),
              routes: [
                GoRoute(
                  path: dashboardRoute,
                  pageBuilder: (context, state) => WindowPage(
                    key: state.pageKey,
                    child: const DashboardPage(),
                  ),
                ),
                GoRoute(
                  path: stockRoute,
                  pageBuilder: (context, state) => WindowPage(
                    key: state.pageKey,
                    child: const StockPage(),
                  ),
                ),
                GoRoute(
                  path: transactionsRoute,
                  pageBuilder: (context, state) => WindowPage(
                    key: state.pageKey,
                    child: const TransactionsPage(),
                  ),
                ),
                GoRoute(
                  path: employeesRoute,
                  pageBuilder: (context, state) => WindowPage(
                    key: state.pageKey,
                    child: const EmployeesPage(),
                  ),
                ),
              ],
              redirect: (context, state) async {
                final auth = ref.read(authProvider);
                if (auth.isAuthenticated) return null;
                return loginRoute;
              },
            ),
            GoRoute(
              path: loginRoute,
              pageBuilder: (context, state) => WindowPage(
                key: state.pageKey,
                child: const LoginPage(),
              ),
            ),
            GoRoute(
              path: forgotPasswordRoute,
              pageBuilder: (context, state) => WindowPage(
                key: state.pageKey,
                child: const ForgotPasswordPage(),
              ),
            ),
          ])
    ],
  );
}
