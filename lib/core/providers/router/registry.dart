import 'dart:collection';


import 'core/registry.dart';

class CoreRegistry extends IRouteRegistry {
  final Set<IRoute> _routes = {};

  @override
  UnmodifiableSetView<IRoute> get routes => UnmodifiableSetView(_routes);
}
