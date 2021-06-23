import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print("Create: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print("Close: $bloc");
    super.onClose(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    print("Event: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("Transition: $transition");
    super.onTransition(bloc, transition);
  }
}
