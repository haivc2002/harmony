import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/common/multi_bloc.dart';
import 'package:harmony/router/app_router.dart';
import 'package:harmony/view/login/login_screen.dart';

import 'base_project/monitor_router_page.dart';
import 'common/firebase_option.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: "AIzaSyCZgDYLKRFoSvmdfkrMMYv5iQtpOM7zxb8",
    //   appId: "1:186321810718:android:ad661dc08a7f3fc2fe850f",
    //   messagingSenderId: "186321810718",
    //   projectId: "dating-d6a6b"
    // )
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotification();
  await Global.load();
  runApp(const MultiBloc(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const LoginScreen(),
      builder: (_, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          navigatorObservers: [MonitorRouterPage()],
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          home: child
        );
      }
    );
  }
}
