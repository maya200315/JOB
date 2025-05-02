import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Controller/ListProvider.dart';
import 'package:job_finder_app/View/Splash/Controller/SplashController.dart';
import 'package:job_finder_app/View/Splash/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: listproviders, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Job Finder',
          theme: ThemeData(
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.basic,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStateColor.resolveWith(
                  (states) => AppColors.primary,
                ),
              ),
            ),
            iconTheme: IconThemeData(color: AppColors.active),
            appBarTheme: AppBarTheme(backgroundColor: AppColors.primary),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.primary,
              displayColor: AppColors.primary,
            ),
            useMaterial3: false,
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.secondery,
            ).copyWith(surface: const Color.fromARGB(255, 103, 58, 183)),
          ),
          home: ChangeNotifierProvider(
            create: (context) => SplashController()..whenIslogin(context),
            builder: (context, child) => Splash(),
          ),
          builder: (context, child) {
            EasyLoading.instance
              ..displayDuration = const Duration(seconds: 3)
              ..indicatorType = EasyLoadingIndicatorType.fadingCircle
              ..loadingStyle = EasyLoadingStyle.custom
              ..indicatorSize = 45.0
              ..radius = 15.0
              ..maskType = EasyLoadingMaskType.black
              ..progressColor = AppColors.active
              ..backgroundColor = AppColors.basic
              ..indicatorColor = AppColors.active
              ..textColor = AppColors.active
              ..maskColor = Colors.black
              ..userInteractions = false
              ..animationStyle = EasyLoadingAnimationStyle.opacity
              ..dismissOnTap = false;
            return FlutterEasyLoading(child: child);
          },
        );
      },
    );
  }
}
