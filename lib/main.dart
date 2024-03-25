import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:u_connect/core/route/routes.dart';
import 'package:u_connect/core/theme/app_theme.dart';
import 'package:u_connect/features/auth/controller/bloc/auth_bloc.dart';
import 'package:u_connect/features/auth/controller/repository/auth_repository_impl.dart';
import 'package:u_connect/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on Exception {
    runApp(MyApp());
    return;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final goRouter = AppRouter().router;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        ScreenUtil.init(context, designSize: const Size(360, 801));
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (BuildContext context) =>
                  AuthBloc(authRepo: AuthRepositoryImpl()),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'UConnect',
            theme: AppTheme().themeData,
            routerConfig: AppRouter().router,
          ),
        );
      },
    );
  }
}
