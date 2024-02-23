import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/app_router.dart';
import 'core/config/application_theme.dart';
import 'core/config/page_route_names.dart';
import 'core/di/di.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce',
          theme: ApplicationTheme.applicationTheme,
          themeMode: ThemeMode.light,
          navigatorKey: navigatorKey,
          initialRoute: PageRouteNames.initial,
          onGenerateRoute: AppRouter.onGeneratedRoute,
        );
      },
    );
  }
}
