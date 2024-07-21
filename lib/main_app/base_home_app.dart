import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:base_project/core/providers/router/core/router.dart';
import 'package:base_project/core/providers/router/core/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseHomeApp extends StatefulWidget {
  const BaseHomeApp({super.key});

  @override
  State<BaseHomeApp> createState() => _BaseHomeAppState();
}

class _BaseHomeAppState extends State<BaseHomeApp> {
  @override
  void initState() {
    BackButtonInterceptor.add(_backButtonInterceptor);
    BackButtonInterceptor.errorProcessing = (Object error) {

    };
    super.initState();
  }

  bool _backButtonInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.read<IRouter>().pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalKey<NavigatorState>(),
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          },
        ),
        useMaterial3: false,
      ),
      home: Column(
        children: [
          Expanded(
            child: BlocConsumer<IRouter, IRouterState>(
              listener: (context, state) {},
              builder: (context, state) => Navigator(
                onPopPage: (route, result) {
                  final isRoutePopped = route.didPop(result);
                  if (isRoutePopped) {
                    context.read<IRouter>().pop();
                  }
                  return isRoutePopped;
                },
                pages: state.pages,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
