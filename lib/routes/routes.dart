import 'package:anonymous_world/models/router_state.dart';
import 'package:anonymous_world/screen/home.dart';
import 'package:anonymous_world/screen/login.dart';
import 'package:anonymous_world/screen/splash.dart';
import 'package:anonymous_world/state/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

RouterState routerState = RouterState();

GoRouter routerConfig = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
  refreshListenable: routerState,
  redirect: (context, state) {
    if (routerState.redir != null) {
      return routerState.redir;
    }

    AuthState authState = routerState.authState;

    if (authState is AuthStateUninitialized) {
      if (state.fullPath != "/splash") {
        return "/splash";
      }
      return null;
    } else if (authState is AuthStateLogout) {
      if (state.fullPath != "/login") {
        return "/login";
      }
      return null;
    } else if (authState is AuthStateAuthenticated) {
      if (state.fullPath != "/") {
        return "/";
      }
      return null;
    }

    return null;
  },
);
