import 'dart:collection';

import 'package:base_project/core/providers/router/core/states.dart';
import 'package:base_project/core/views/core/view/view.dart';
import 'package:base_project/pages/create_new_password_page/create_new_password_view.dart';
import 'package:base_project/pages/forgot_password_page/forgot_password_view.dart';
import 'package:base_project/pages/login_page/login_view.dart';
import 'package:base_project/pages/otp_verification_page/otp_verification_view.dart';
import 'package:base_project/pages/password_change_status_page/password_change_view.dart';
import 'package:base_project/pages/registration_page/registration_view.dart';
import 'package:base_project/pages/splash_page/splash_view.dart';
import 'package:flutter/material.dart';

class LinkParameters {
  final List<String> pathParameters;
  final Map<String, String> queryParameters;

  const LinkParameters({
    this.pathParameters = const [],
    this.queryParameters = const {},
  });

  const LinkParameters.empty()
      : pathParameters = const [],
        queryParameters = const {};
}

typedef ViewParametersBuilder<P extends IViewParameters> = P Function(
    LinkParameters);
typedef ViewBuilder<V extends IView, P extends IViewParameters> = V Function(P);

class IRoute<V extends IView, P extends IViewParameters>  {
  final String path;
  final ViewParametersBuilder<P> viewParametersBuilder;
  final ViewBuilder<V, P> viewBuilder;
  final bool isInitialRoute;

  IRoute({
    required String path,
    required this.viewParametersBuilder,
    required this.viewBuilder,
    this.isInitialRoute = false,
  }) : path = path.sanitised;


  IndPage pageFromLink({
    required LinkParameters parameters,
  }) =>
      IndPage(
        key: ValueKey(path),
        name: path,
        child: viewBuilder(viewParametersBuilder(parameters)),
      );

  IRoute<V, P> copyWith({
    String? path,
    ViewParametersBuilder<P>? viewParametersBuilder,
    ViewBuilder<V, P>? viewBuilder,
    bool? isInitialRoute,
  }) {
    final route = IRoute<V, P>(
      path: path ?? this.path,
      viewParametersBuilder:
          viewParametersBuilder ?? this.viewParametersBuilder,
      viewBuilder: viewBuilder ?? this.viewBuilder,
      isInitialRoute: isInitialRoute ?? this.isInitialRoute,
    );

    return route;
  }
}

abstract class IRouteRegistry {
  UnmodifiableSetView<IRoute> get routes;

  bool isRouteAvailableToSatisfyLink(String link) {
    final route = routeWhichCanSatisfyLink(link);

    return route != null;
  }

  bool isRouteAvailableToSatisfyPath(String path) {
    final route = routeWhichCanSatisfyPath(path);

    return route != null;
  }

  IRoute? routeWhichCanSatisfyLink(String link) {
    IRoute? longestMatchedRoute;

    for (final route in routes) {
      final registeredPath = route.path;
      final isRouteMatched =
          registeredPath.isNotEmpty && link.contains(registeredPath);

      if (isRouteMatched) {
        final longestPathLengthSoFar = longestMatchedRoute?.path.length ?? 0;

        if (registeredPath.length > longestPathLengthSoFar) {
          longestMatchedRoute = route;
        }
      }
    }

    return longestMatchedRoute;
  }

  IRoute? routeWhichCanSatisfyPath(String path) {
    IRoute? longestMatchedRoute;

    for (final route in routes) {
      final registeredPath = route.path;
      final isRouteMatched =
          registeredPath.isNotEmpty && path.contains(registeredPath);

      if (isRouteMatched) {
        final longestPathLengthSoFar = longestMatchedRoute?.path.length ?? 0;

        if (registeredPath.length > longestPathLengthSoFar) {
          longestMatchedRoute = route;
        }
      }
    }

    return longestMatchedRoute;
  }
}

extension SanitisedPathX on String {
  String get sanitised {
    final pathSegments = split('/');

    final pathSegmentsWithOutForwardSlashes = pathSegments.where(
      (pathSegment) =>
          pathSegment.trim().isNotEmpty && pathSegment.trim() != '/',
    );

    final sanitisedPath = pathSegmentsWithOutForwardSlashes.join('/');

    return sanitisedPath;
  }
}


class MainRouteRegistry extends IRouteRegistry {
  final Set<IRoute> _routes = {
    IRoute<SplashView, SplashViewParameters>(
      path: SharedPathRegistry.splashPage,
      viewParametersBuilder: (parameters) => SplashViewParameters.from(parameters),
      viewBuilder: (parameters) => SplashView(
        parameters: parameters,
      ),
      isInitialRoute: true,
    ),


    IRoute<LoginView, LoginViewParameters>(
      path: SharedPathRegistry.loginPage,
      viewParametersBuilder: (parameters) => LoginViewParameters.from(parameters),
      viewBuilder: (parameters) => LoginView(
        parameters: parameters,
      ),
      isInitialRoute: false,
    ),


    IRoute<RegistrationView, RegistrationViewParameters>(
      path: SharedPathRegistry.registrationPage,
      viewParametersBuilder: (parameters) => RegistrationViewParameters.from(parameters),
      viewBuilder: (parameters) => RegistrationView(
        parameters: parameters,
      ),
      isInitialRoute: false,
    ),


    IRoute<ForgotPasswordView, ForgotPasswordViewParameters>(
      path: SharedPathRegistry.forgotPasswordPage,
      viewParametersBuilder: (parameters) => ForgotPasswordViewParameters.from(parameters),
      viewBuilder: (parameters) => ForgotPasswordView(
        parameters: parameters,
      ),
      isInitialRoute: false,
    ),

    IRoute<CreateNewPasswordView, CreateNewPasswordViewParameters>(
      path: SharedPathRegistry.newPasswordPage,
      viewParametersBuilder: (parameters) => CreateNewPasswordViewParameters.from(parameters),
      viewBuilder: (parameters) => CreateNewPasswordView(
        parameters: parameters,
      ),
      isInitialRoute: false,
    ),

    IRoute<OtpVerificationView, OtpVerificationViewParameters>(
      path: SharedPathRegistry.otpVerificationPage,
      viewParametersBuilder: (parameters) => OtpVerificationViewParameters.from(parameters),
      viewBuilder: (parameters) => OtpVerificationView(
        parameters: parameters,
      ),
      isInitialRoute: false,
    ),

    IRoute<PasswordChangeView, PasswordChangeViewParameters>(
      path: SharedPathRegistry.passwordChangeSuccessPage,
      viewParametersBuilder: (parameters) => PasswordChangeViewParameters.from(parameters),
      viewBuilder: (parameters) => PasswordChangeView(
        parameters: parameters,
      ),
      isInitialRoute: false,
    ),
  };

  @override
  UnmodifiableSetView<IRoute> get routes => UnmodifiableSetView<IRoute>(_routes);

  MainRouteRegistry({
    required List<IRouteRegistry> registries,
  }) {
    for (final registry in registries) {
      _routes.addAll(registry.routes);
    }
  }
}

class SharedPathRegistry {

  static const splashPage = '/splash';
  static const loginPage = '/login';
  static const registrationPage = '/registration';
  static const forgotPasswordPage = '/forgot-password';
  static const newPasswordPage = '/new-password';
  static const otpVerificationPage = '/otp-verification';
  static const passwordChangeSuccessPage = '/password-success';

}