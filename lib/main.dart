import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:marvel_app/helpers/constants.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/providers/base_provider.dart';
import 'package:marvel_app/providers/dark_mode_provider.dart';
import 'package:marvel_app/providers/movies_providers.dart';
import 'package:marvel_app/screens/auth_screens/login_screen.dart';
import 'package:marvel_app/screens/auth_screens/splash_screen.dart';
import 'package:marvel_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseProvider>(
          create: (_) => BaseProvider(),
        ),
        ChangeNotifierProvider<MoviesProviders>(
          create: (_) => MoviesProviders(),
        ),
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider()..initializeAuthProvider()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (_) => DarkModeProvider()..getMode())
      ],
      child: Consumer<DarkModeProvider>(builder: (context, dmc, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: dmc.isDark ? Colors.black38 : Colors.white,
            drawerTheme: DrawerThemeData(
              backgroundColor: dmc.isDark ? Colors.black : Colors.white,
            ),
            tabBarTheme: TabBarTheme(
                labelColor: dmc.isDark ? Colors.white : Colors.black),
            appBarTheme: AppBarTheme(
                backgroundColor: dmc.isDark ? Colors.white12 : Colors.white),
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initializeAuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, _) {
      return AnimatedSwitcher(
        duration: animationDuration,
        child: authConsumer.authenticated
            ? const HomeScreen()
            : const LoginScreen(),
      );
    });
  }
}
