import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/route_generator.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/language/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/leave_bloc.dart';
import 'src/appLocalizations.dart';
import 'src/feature/landing/landing_page.dart';
import 'dart:io';

///Receive message when app is in background solution for on message
// GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
enum Env { Production, Developement }
final Env env = Env.Production;
void main() async {
   HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: getServerEnvAssetPath(env));
  // await Firebase.initializeApp();
  // // await Firebase.
  // SystemChrome.setEnabledSystemUIMode();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  //   // change status bar color
  // ));

  // await LocalNotificationService().initialize();

  runApp(MyApp());
}

String getServerEnvAssetPath(Env env) {
  late final String path;
  switch (env) {
    case Env.Developement:
      path = '';
      break;
    case Env.Production:
      path = 'assets/.env';
      break;
  }
  return path;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // auth need initalize event because need to check auth for open the app
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc()..add(CheckingAuthenticationStarted())),

        BlocProvider<LanguageBloc>(
            create: (BuildContext context) =>
                LanguageBloc()..add(LanguageLoadStarted())),

        BlocProvider<CheckInOutBloc>(
            create: (BuildContext context) => CheckInOutBloc()),
        BlocProvider<PayslipBloc>(
            create: (BuildContext context) => PayslipBloc()),
        BlocProvider<EmployeeBloc>(
            create: (BuildContext context) =>
                EmployeeBloc()..add(FetchAllEmployeeStarted())),
        // BlocProvider<LeaveBloc>(create: (BuildContext context) => LeaveBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale,
            onGenerateRoute: RouteGenerator.generateRoute,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('km', 'KH'),
              // Locale('zh', 'CN'),
            ],
            debugShowCheckedModeBanner: false,
            title: 'Attendance Admin',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LandingPage(),
            builder: EasyLoading.init(),
            // routes: ,
            // initialRoute: '/',
            // routes: {
            //   '/': (context) => LandingPage(),
            //   '/push': (context) => PushCategoryNotificatin(),

            // },
          );
        },
      ),
    );
  }
}
