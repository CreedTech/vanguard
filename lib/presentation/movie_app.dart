import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vanguard/components/components.dart';
import '../helpers/helper_routes.dart';
import '../helpers/helper_utils.dart';
import 'blocs/theme/theme_cubit.dart';

import '../common/constants/languages.dart';
import '../common/constants/route_constants.dart';
import '../common/screenutil/screenutil.dart';
import '../di/get_it.dart';
import 'app_localizations.dart';
import 'blocs/language/language_cubit.dart';
import 'blocs/loading/loading_cubit.dart';
import 'blocs/login/login_cubit.dart';
import 'journeys/loading/loading_screen.dart';
import 'themes/theme_color.dart';
import 'themes/theme_text.dart';

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageCubit _languageCubit;
  late LoginCubit _loginBloc;
  late LoadingCubit _loadingCubit;
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();
    _loginBloc = getItInstance<LoginCubit>();
    _loadingCubit = getItInstance<LoadingCubit>();
    _themeCubit = getItInstance<ThemeCubit>();
    _themeCubit.loadPreferredTheme();
  }

  @override
  void dispose() {
    _languageCubit.close();
    _loginBloc.close();
    _loadingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenutil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
        BlocProvider<LoginCubit>.value(value: _loginBloc),
        BlocProvider<LoadingCubit>.value(value: _loadingCubit),
        BlocProvider<ThemeCubit>.value(value: _themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        builder: (context, theme) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(

                debugShowCheckedModeBanner: false,
                title: 'Vanguard',
                theme: ThemeData(
                  unselectedWidgetColor: AppColor.primaryColor,
                  primaryColor:
                      theme == Themes.dark ? AppColor.darkColor : Colors.white,
                  accentColor: AppColor.royalBlue,
                  scaffoldBackgroundColor:
                      theme == Themes.dark ? AppColor.darkColor : Colors.white,
                  brightness:
                      theme == Themes.dark ? Brightness.dark : Brightness.light,
                  cardTheme: CardTheme(
                    color:
                        theme == Themes.dark ? Colors.white : AppColor.darkColor,
                  ),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: theme == Themes.dark
                      ? ThemeText.getTextTheme()
                      : ThemeText.getLightTextTheme(),
                  appBarTheme: const AppBarTheme(elevation: 0),
                  inputDecorationTheme: InputDecorationTheme(
                    hintStyle: Theme.of(context).textTheme.greySubtitle1,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: theme == Themes.dark
                            ? Colors.white
                            : AppColor.darkColor,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                supportedLocales:
                    Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                builder: (context, child) {
                  setUpScreenUtils(context);
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: LoadingScreen(
                        screen: child!,
                      ),
                    ),
                  );
                },
                navigatorKey: getItInstance<NavigatorHelper>().kNavKey,
                scaffoldMessengerKey: getItInstance<NavigatorHelper>().kscaffoldMessengerKey,
                initialRoute: RouteList.initial,
                onGenerateRoute: getItInstance<RouterGenerator>().generate,

              );
            },
          );
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
      return LoadingScreen(
        screen: child,
      );
  }
}