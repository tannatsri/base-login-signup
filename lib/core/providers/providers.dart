import 'package:base_project/core/providers/router/core/registry.dart';
import 'package:base_project/core/providers/router/core/router.dart';
import 'package:base_project/core/providers/router/registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


abstract class IAssistant {
  void prepare();
}


class RouterProvider extends BlocProvider<IRouter> {
  RouterProvider({Key? key})
      : super(
    key: key,
    create: (context) => MainRouter(
      registry: MainRouteRegistry(
        registries: [
          CoreRegistry(),
        ],
      ),
    ),
    lazy: false,
  );
}
