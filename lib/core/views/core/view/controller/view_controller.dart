
import 'package:base_project/core/providers/network_provider.dart';
import 'package:base_project/core/providers/router/core/router.dart';
import 'package:base_project/core/views/core/view/controller/view_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'view_states.dart';

abstract class IViewController<
    Event extends IViewEvent,
    State extends IViewState,
    Repository extends IRepository> extends Bloc<Event, State> {
  final Repository repository;
  final IRouter router;
  final String pageId = "";

  IViewController(
    super.initialState, {
    required this.router,
    required this.repository,
  });

  @override
  void add(Event event) {
    if (!isClosed) {
      super.add(event);
    }
  }
}

abstract class IRepository {
  final INetworkAssistant networkAssistant;

  IRepository({
    required this.networkAssistant,
  });
}
