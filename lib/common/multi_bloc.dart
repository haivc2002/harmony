import 'package:harmony/view/home/bloc/home_bloc.dart';
import 'package:harmony/view/login/bloc/login_bloc.dart';

import '../base_project/package_widget.dart';
import '../view/tab_multi/bloc/tab_multi_bloc.dart';

class MultiBloc extends StatelessWidget {
  final Widget child;

  const MultiBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BaseBloc(), lazy: true),
        BlocProvider(create: (context) => WidgetBloc(), lazy: true),
        BlocProvider(create: (context) => LoginBloc(), lazy: true),
        BlocProvider(create: (context) => TabMultiBloc(), lazy: true),
        BlocProvider(create: (context) => HomeBloc(), lazy: true),
        BlocProvider(create: (context) => ToggleBlur(), lazy: true),
      ],
      child: child
    );
  }
}
