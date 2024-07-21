
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../core/providers/network_provider.dart';
import '../core/providers/providers.dart';
import 'base_home_app.dart';

class BaseMainApp extends StatelessWidget {
  const BaseMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RouterProvider(),
      ],
      child: MultiProvider(
        providers: [
          NetworkAssistantProvider(),
        ],
        child: const BaseHomeApp(),
      ),
    );
  }
}
