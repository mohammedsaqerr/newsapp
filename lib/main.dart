import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_layout/cubit/states.dart';
import 'package:newsapp/layout/news_layout/news_layout_screen.dart';
import 'package:newsapp/shared/network/remote/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
import 'package:newsapp/shared/style/cubit_them.dart';

import 'layout/news_layout/cubit/cubit.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

   bool? isDark = CacheHelper.getBoll(key: 'isDark');
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final  isDark;
   MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return

      MultiBlocProvider(
        providers: [
          BlocProvider(  create: (context)=>CubitThem()..changTheme(fromShared: isDark),),
          BlocProvider(  create: (BuildContext context) => NewsCubit()..getBusiness(),),

        ],
        child: BlocConsumer<CubitThem,NewsStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.orange,
                primarySwatch: Colors.orange,

                  appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      elevation: 0.0,
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.orange,
                    elevation: 20.0,
                  )

              ),
              darkTheme: ThemeData(
                  primaryColor: Colors.orange,
                  primarySwatch: Colors.orange,
                scaffoldBackgroundColor: const Color(0xff333739),
                appBarTheme: const AppBarTheme(
                    color: Color(0xff333739),
                    elevation: 0.0,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color(0xff333739),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color(0xff333739),
                  selectedItemColor: Colors.orange,
                  unselectedItemColor: Colors.grey
                )
              ),
              themeMode: CubitThem().get(context).isDarkThem?ThemeMode.light:ThemeMode.dark,

              home:  const NewsLayoutScreen(),
            );
          },
        ),
      );
  }
}
// flutter run -d chrome --web-renderer html  لتشغيل الصور