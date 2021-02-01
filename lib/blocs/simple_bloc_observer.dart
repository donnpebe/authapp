import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    print(error);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print("event $event");
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print(change);
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    print(cubit);
  }
}
