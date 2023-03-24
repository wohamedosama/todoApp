import 'package:bloc/bloc.dart';

class MyCubitObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange is $change');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);

    print('onClose is $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate is $bloc');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    print('onTransition is $transition');
  }
}
