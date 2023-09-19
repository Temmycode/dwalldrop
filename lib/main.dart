import 'package:dwalldrop/app/providers/controllers/loading/loading_screen.dart';
import 'package:dwalldrop/app/screens/home_page.dart';
import 'package:dwalldrop/app/widgets/app_snack_bar.dart';
import 'package:dwalldrop/authentication/provider/auth_errors_provider.dart';
import 'package:dwalldrop/authentication/provider/is_loading_provider.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: DWallDrop()));
}

class DWallDrop extends ConsumerWidget {
  const DWallDrop({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.backgroundColor,
      ),
    );
    return MaterialApp(
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      title: 'DWallDrop',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Consumer(
        builder: (ctx, ref, child) {
          // SNACK BAR TO DISPLAY THE ERROR IN THE APPLICATION
          ref.listen(authErrorProvider, (previous, error) {
            if (error.isNotEmpty) {
              appSnackBar(context, error);
            } else {
              ScaffoldMessenger.of(context).clearSnackBars();
            }
          });

          // SHOW LOADING WIDGET IF THERE IS A LOAD IN THE SYSTEM
          ref.listen<bool>(isLoadingProvider, (previous, loading) {
            if (loading) {
              LoadingScreen.instance().show(context: ctx);
            } else {
              LoadingScreen.instance().hide();
            }
          });
          return const HomePage();
        },
      ),
    );
  }
}
