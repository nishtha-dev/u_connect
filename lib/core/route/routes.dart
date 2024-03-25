import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_connect/core/route/route_utils.dart';
import 'package:u_connect/features/auth/controller/bloc/auth_bloc.dart';
import 'package:u_connect/features/home/view/home.dart';

import '../../features/auth/view/screens/screens.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey = kNavigatorKey;

  GoRouter get router => _goRouter;

  final GoRouter _goRouter = GoRouter(
      navigatorKey: kNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: RouteEnum.landingPage.toPath,
      redirect: (ctx, state) {
        final authState = ctx.read<AuthBloc>().state;
        if (authState.isAuthenticated) {
          return RouteEnum.homePage.toPath;
        } else if (state.fullPath == RouteEnum.landingPage.toPath ||
            state.fullPath == RouteEnum.loginPage.toPath ||
            state.fullPath == RouteEnum.signUpPage.toPath ||
            state.fullPath == RouteEnum.forgotPasswordPage.toPath) {
          print('hell0');
          return null;
        } else {
          return RouteEnum.landingPage.toPath;
        }
      },
      routes: [
        GoRoute(
          name: RouteEnum.loginPage.toName,
          path: RouteEnum.loginPage.toPath,
          builder: ((context, state) => const LoginPage()),
        ),
        GoRoute(
          name: RouteEnum.signUpPage.toName,
          path: RouteEnum.signUpPage.toPath,
          builder: ((context, state) => const SignUpPage()),
        ),
        GoRoute(
          name: RouteEnum.forgotPasswordPage.toName,
          path: RouteEnum.forgotPasswordPage.toPath,
          builder: ((context, state) => const ForgotPasswordPage()),
        ),
        GoRoute(
          name: RouteEnum.landingPage.toName,
          path: RouteEnum.landingPage.toPath,
          builder: ((context, state) => const LandingPage()),
        ),
        GoRoute(
          name: RouteEnum.homePage.toName,
          path: RouteEnum.homePage.toPath,
          builder: ((context, state) => const HomePage()),
        )
      ]);
}
