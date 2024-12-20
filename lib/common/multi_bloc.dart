import 'package:harmony/view/login/bloc/login_bloc.dart';

import '../base_project/package_widget.dart';

class MultiBloc extends StatelessWidget {
  final Widget child;

  const MultiBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BaseBloc(), lazy: true),
        BlocProvider(create: (context) => LoginBloc(), lazy: true),
      ],
      child: child
    );
  }
}
