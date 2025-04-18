import 'package:al_amine_store/bindings/initialbinding.dart';
import 'package:al_amine_store/routes/routes.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/localaization/changelang.dart';
import 'package:al_amine_store/utlis/localaization/translation.dart';
import 'package:al_amine_store/utlis/services/services.dart';
import 'package:al_amine_store/utlis/theme/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());

    return GetMaterialApp(
      themeMode: ThemeMode.system, // set thteme mode to system
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      getPages: routes,
      initialRoute:
          AppRoute.splashPage, // Set splash screen as the initial route
      translations: MyTranslation(),
      locale: controller.langauge,
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(),
      // home: TestPage());
    );
  }
}
