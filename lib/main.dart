import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:flutter_defualt_project/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';



import 'data/local/service/hive_service.dart';
import 'data/local/storage_repository/storage_repository.dart';
import 'data/models/default_model.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await StorageRepository.getInstance();

  await Hive.initFlutter();
  Hive.registerAdapter(DefaultModelAdapter());
  await HiveService.openBox();


  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'EN'),
        Locale('uz', 'UZ'),
        Locale('ru', 'RU'),
      ],
      fallbackLocale: const Locale('en', 'EN'),
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}